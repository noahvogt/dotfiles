-- Jupyter notebooks in Neovim
--   jupytext.nvim: open .ipynb as py:percent (cells separated by "# %%"), so
--                  pyright/ruff/snippets work as in any python file
--   molten-nvim:   run code on a Jupyter kernel, show output below the cell
--   image.nvim:    render plots inline via the kitty graphics protocol
-- Markdown cells: after/queries/python/{injections,highlights}.scm + render-markdown

require("jupytext").setup({ style = "percent" })

local cell_marker = "^# %%%%"

local function is_notebook(bufnr)
  return vim.api.nvim_buf_get_name(bufnr):match("%.ipynb$") ~= nil
end

-- Rows (0-based) that belong to a "# %% [markdown]" cell, cached per changedtick
local markdown_rows_cache = {}

local function markdown_rows(bufnr)
  local tick = vim.api.nvim_buf_get_changedtick(bufnr)
  local cached = markdown_rows_cache[bufnr]
  if cached and cached.tick == tick then
    return cached.rows
  end
  local rows, in_markdown = {}, false
  for i, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
    if line:match(cell_marker) then
      in_markdown = line:match("^# %%%% %[markdown%]") ~= nil
    elseif in_markdown then
      rows[i - 1] = true
    end
  end
  markdown_rows_cache[bufnr] = { tick = tick, rows = rows }
  return rows
end

vim.treesitter.query.add_predicate("jupyter-markdown-cell?", function(match, _, source, pred)
  local nodes = match[pred[2]]
  local node = type(nodes) == "table" and nodes[1] or nodes
  if type(source) ~= "number" or not node or not is_notebook(source) then
    return false
  end
  return markdown_rows(source)[node:start()] == true
end, { force = true })

-- Injected range of a markdown-cell line: after the "# " prefix up to the start
-- of the next line, so the newline is part of the combined markdown document
vim.treesitter.query.add_directive("jupyter-markdown-range!", function(match, _, _, pred, metadata)
  local id = pred[2]
  local nodes = match[id]
  local node = type(nodes) == "table" and nodes[1] or nodes
  if not node then
    return
  end
  local row, col, _, end_col = node:range()
  local prefix = end_col - col >= 2 and 2 or 1 -- "# text" or a bare "#"
  metadata[id] = metadata[id] or {}
  metadata[id].range = { row, col + prefix, row + 1, 0 }
end, { force = true })

-- Render the injected markdown (conceal markup, headings, latex as unicode),
-- only in notebooks. Latex needs `latex2text` (python-pylatexenc).
require("render-markdown").setup({
  file_types = { "python" },
  ignore = function(bufnr)
    return not is_notebook(bufnr)
  end,
  latex = { converter = { vim.fn.stdpath("config") .. "/bin/jupyter-latex2text" } },
})

-- Hide the "# " prefix of markdown lines and the metadata of "# %%" headers
-- (shown again on the cursor line and in insert mode)
local conceal_ns = vim.api.nvim_create_namespace("jupyter_conceal")
vim.api.nvim_set_decoration_provider(conceal_ns, {
  on_win = function(_, _, bufnr)
    return is_notebook(bufnr)
  end,
  on_line = function(_, _, bufnr, row)
    local line = vim.api.nvim_buf_get_lines(bufnr, row, row + 1, false)[1]
    if not line then -- buffer still being read by jupytext
      return
    end
    local conceal_end, conceal_start = nil, 0
    if line:match(cell_marker) then
      conceal_start = #(line:match("^# %%%% %[markdown%]") or "# %%")
      conceal_end = #line
    elseif markdown_rows(bufnr)[row] and line:match("^#") then
      conceal_end = math.min(2, #line)
    end
    if conceal_end and conceal_end > conceal_start then
      vim.api.nvim_buf_set_extmark(bufnr, conceal_ns, row, conceal_start, {
        end_col = conceal_end,
        conceal = "",
        ephemeral = true,
      })
    end
  end,
})

-- IPython-style code trips these pylint checks in every notebook
local pylint_notebook_disable = table.concat({
  "line-too-long", -- markdown cells and cell metadata
  "wrong-import-position", -- imports in later cells
  "ungrouped-imports",
  "wrong-import-order",
  "pointless-statement", -- bare expression to display a value
  "expression-not-assigned",
  "missing-module-docstring",
  "invalid-name", -- X_train etc.
  "redefined-outer-name",
  "reimported",
}, ",")
table.insert(require("lint").linters.pylint.args, 1, function()
  return "--disable=" .. (is_notebook(0) and pylint_notebook_disable or "")
end)

-- image.nvim only works with the kitty graphics protocol (not foot)
local has_images = vim.env.TERM == "xterm-kitty"
if has_images then
  require("image").setup({
    backend = "kitty",
    processor = "magick_cli",
    -- only used for molten output, not for images in regular markdown files
    integrations = {
      markdown = { enabled = false },
      asciidoc = { enabled = false },
      typst = { enabled = false },
      neorg = { enabled = false },
      syslang = { enabled = false },
    },
    max_width_window_percentage = 100,
    max_height_window_percentage = 50,
    window_overlap_clear_enabled = true,
  })
end

vim.g.molten_image_provider = has_images and "image.nvim" or "none"
vim.g.molten_output_win_max_height = 20
vim.g.molten_auto_open_output = false
vim.g.molten_virt_text_output = true
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_wrap_output = true

-- Give kernel output its own color, markdown cells normal text color instead
-- of comment style (reapplied when the theme toggles)
local function output_highlights()
  local fg = vim.o.background == "light" and "#0184bc" or "#56b6c2"
  vim.api.nvim_set_hl(0, "MoltenVirtualText", { fg = fg })
  vim.api.nvim_set_hl(0, "MoltenOutputBorder", { fg = fg })
  vim.api.nvim_set_hl(0, "MoltenOutputWin", { fg = fg })
  local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
  vim.api.nvim_set_hl(0, "@jupyter.markdown", { fg = normal.fg, nocombine = true })
end
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("jupyter_highlights", { clear = true }),
  callback = output_highlights,
})

-- Code cells: the lines after a "# %%" marker (not [markdown]) up to the next
-- marker, without trailing blank lines
local function code_cells()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local cells, current = {}, nil
  local function close(last)
    if current then
      while last > current.first and lines[last]:match("^%s*$") do
        last = last - 1
      end
      if last >= current.first and not lines[last]:match("^%s*$") then
        current.last = last
        table.insert(cells, current)
      end
      current = nil
    end
  end
  for i, line in ipairs(lines) do
    if line:match(cell_marker) then
      close(i - 1)
      if not line:match("^# %%%% %[markdown%]") then
        current = { marker = i, first = i + 1 }
      end
    end
  end
  close(#lines)
  return cells
end

local function eval(cell)
  vim.fn.MoltenEvaluateRange(cell.first, cell.last)
end

-- The code cell under the cursor, counting its marker line as part of it
local function current_cell()
  local cur = vim.fn.line(".")
  for _, cell in ipairs(code_cells()) do
    if cur >= cell.marker and cur <= cell.last then
      return cell
    end
  end
end

local function goto_cell(dir)
  local cur = vim.fn.line(".")
  local cells = code_cells()
  local target
  if dir > 0 then
    for _, cell in ipairs(cells) do
      if cell.marker > cur then
        target = cell
        break
      end
    end
  else
    for i = #cells, 1, -1 do
      if cells[i].last < cur then
        target = cells[i]
        break
      end
    end
  end
  if target then
    vim.fn.cursor(target.first, 1)
    vim.cmd("normal! zz")
  end
end

local function run_cell()
  local cell = current_cell()
  if cell then
    eval(cell)
  end
end

local function run_cell_and_next()
  run_cell()
  goto_cell(1)
end

local function run_all()
  for _, cell in ipairs(code_cells()) do
    eval(cell)
  end
end

local function run_above()
  local cur = vim.fn.line(".")
  for _, cell in ipairs(code_cells()) do
    if cell.last >= cur or cell.marker >= cur then
      break
    end
    eval(cell)
  end
end

-- Format only the current cell with ruff (formatting on save is off for
-- notebooks, so locked nbgrader cells are never touched)
local function format_cell()
  local cell = current_cell()
  if cell then
    vim.lsp.buf.format({
      name = "ruff",
      range = { start = { cell.first, 0 }, ["end"] = { cell.last, #vim.fn.getline(cell.last) } },
    })
  end
end

-- Buffer-local keymaps, only for notebooks
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("jupyter_keymaps", { clear = true }),
  pattern = "*.ipynb",
  callback = function(ev)
    if vim.b[ev.buf].jupyter_keymaps then
      return
    end
    vim.b[ev.buf].jupyter_keymaps = true

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    map("n", "<leader>ji", ":MoltenInit python3<CR>", "Start kernel")
    map("n", "<leader>jj", run_cell, "Run cell")
    map("n", "<leader>jn", run_cell_and_next, "Run cell, go to next")
    map("n", "<leader>ja", run_all, "Run all cells")
    map("n", "<leader>ju", run_above, "Run all cells above")
    map("n", "<leader>jl", ":MoltenEvaluateLine<CR>", "Run line")
    map("x", "<leader>jj", ":<C-u>MoltenEvaluateVisual<CR>gv<Esc>", "Run selection")
    map("n", "<leader>jr", ":MoltenReevaluateCell<CR>", "Rerun output cell")
    map("n", "<leader>jo", ":noautocmd MoltenEnterOutput<CR>", "Enter output window")
    map("n", "<leader>jh", ":MoltenHideOutput<CR>", "Hide output window")
    map("n", "<leader>jp", ":MoltenImagePopup<CR>", "Open plot in image viewer")
    map("n", "<leader>jd", ":MoltenDelete<CR>", "Delete output")
    map("n", "<leader>jx", ":MoltenInterrupt<CR>", "Interrupt kernel")
    map("n", "<leader>jR", ":MoltenRestart!<CR>", "Restart kernel, clear outputs")
    map("n", "<leader>je", ":MoltenExportOutput!<CR>", "Export outputs into .ipynb")
    map("n", "<leader>jf", format_cell, "Format cell (ruff)")
    map("n", "]j", function() goto_cell(1) end, "Next cell")
    map("n", "[j", function() goto_cell(-1) end, "Previous cell")
  end,
})
