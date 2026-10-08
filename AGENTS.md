# Working in this repository

Personal dotfiles: configs, scripts and data files for Arch Linux dev machines
(x86_64 and Asahi/Apple Silicon) running Hyprland, zsh, kitty and neovim.

## Sibling repo: norisa

All git source repos on these machines live in `~/dox/src`. The machine setup (IaC)
lives in **`~/dox/src/norisa`**: it installs Arch, installs every package, configures
system services, and then clones this repo to `~/dox/src/dotfiles` and runs
`apply-dotfiles`.

So the two repos depend on each other:

* A config or script here that needs a program, font, service or group membership
  usually needs a matching change in `norisa/norisa.sh` (package lists `MAIN_PKGS`,
  `AUR_PKGS`, `ARCH_PKGS`/`ARCH_AUR_PKGS`, or an `ensure_*` function). Say so, or make
  that change there too.
* System-level config (`/etc`, systemd system units, pacman, doas, zram, earlyoom)
  belongs in norisa; per-user config under `~` belongs here.

## Layout

The repo is applied with GNU stow (`--dotfiles`, so a `dot-` prefix becomes `.`):

| Directory     | Stowed to          |
| ------------- | ------------------ |
| `dot-config/` | `~/.config`        |
| `local-bin/`  | `~/.local/bin`     |
| `local-share/`| `~/.local/share`   |

Files are symlinked, so editing them here takes effect live on this machine. A new
file only shows up after `./apply-dotfiles` is re-run. Machine-specific settings go in
`~/.config/norisa.local` (gitignored; template `dot-config/norisa.local.default`),
never in tracked files.

## Conventions

* Scripts in `local-bin/` are POSIX `sh` unless they need more; keep them short and
  dependency-light. Check shell with `shellcheck` and format with `shfmt`.
* Never commit secrets, tokens, hostnames of private infra or personal data.

## Workflow

* **NEVER commit or push.** Leave all git history operations to the user.
* When a change is done, suggest a commit message following Conventional Commits,
  **unscoped** (`feat!: ... `, `feat: ...`, `fix: ...`, `chore: ...`, `doc: ...`, `refactor: ...`),
  lowercase, imperative, matching `git log`. If the change spans both repos, suggest
  one message per repo.
