local M = {}

function M.win_move(key)
  local curwin = vim.fn.winnr()
  vim.cmd("wincmd " .. key)
  if curwin == vim.fn.winnr() then
    if key:match("[jk]") then
      vim.cmd("wincmd v")
    else
      vim.cmd("wincmd s")
    end
    vim.cmd("wincmd " .. key)
  end
end

return M
