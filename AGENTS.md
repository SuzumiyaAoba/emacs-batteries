# AGENTS.md

Notes for agents working in this repository.

## Response Style

- Reply to the user in Japanese, concisely and politely.

## Repository Overview

- `emacs-batteries.el` is the main library. It enables conservative defaults using only built-in Emacs features and no external packages. Entry point is `emacs-batteries-setup`, which delegates to 23 `--configure-*` functions covering coding, persistence, minibuffer, windows, file safety, performance, editing, display, search, Dired, Ediff, compilation, security, prog-mode hooks, shell, and diff.
- `emacs-batteries-early-init.el` contains startup optimizations that must run from `early-init.el`.
- `bootstrap/early-init.el` is a bootstrap helper that downloads `emacs-batteries-early-init.el` once from GitHub Raw and then uses a local cache.
- `test/emacs-batteries-test.el` contains ERT tests. Because the code mutates global variables, follow the existing sandbox pattern when adding tests.

## Change Policy

- Do not add external dependencies. Keep the project implemented with built-in Emacs features only.
- Preserve the README policy: safe to keep enabled all the time, with minimal side effects and no heavy startup work.
- Avoid always-on timers, constant background monitoring, strong UI preferences, or opinionated keybinding changes.
- Only add new defaults when their performance cost and side effects are clearly defensible.
- Keep compatibility at Emacs 30.1 or newer. Do not lower the current compatibility level.
- Many Emacs 30 features use `boundp`/`fboundp` guards for graceful degradation. Follow this pattern.

## Implementation Notes

- Existing files assume `lexical-binding: t`. Keep that in any new `.el` files as well.
- If you add a `defcustom`, update the README documentation in the same change.
- For changes that affect startup behavior or global state, keep idempotency and restoration behavior in mind.
- For `early-init` changes, always verify whether any values must be restored after startup.
- For bootstrap changes, preserve the design where normal startup does not require network access.
- Prog-mode hooks use `after-change-major-mode-hook` with `--maybe-enable-*` helper functions. Follow this pattern for new prog-mode features.
- Opt-out features (modes, opinionated behavior) use `defcustom` booleans. Non-opinionated "set and forget" variables do not need `defcustom`.

## Intentionally Excluded Features

The following are intentionally NOT included and should not be added without discussion:

- `desktop-save-mode` — persists too much session state
- `flyspell`/`ispell` — depends on external programs (aspell/hunspell)
- `eglot`/`flymake` — language/project dependent
- `treesit` mode remapping — too opinionated
- `windmove` — changes keybindings
- `global-hl-line-mode` — can be slow, personal preference
- `delete-trailing-whitespace` on save — controversial with shared codebases
- `prettify-symbols-mode` — personal preference

## Verification Commands

- `make compile`
- `make test`
- If needed, override the Emacs binary with something like `EMACS=/path/to/emacs make test`.

## Documentation Sync

- If behavior changes, review the relevant sections in `README.md`, especially usage, enabled defaults, and intentionally excluded defaults.
- When a change affects users, update the README explanation and the tests in the same change set.
- Keep `CLAUDE.md` in sync with the configure function list when adding or renaming functions.
