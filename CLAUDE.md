# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Response Style

Reply to the user in Japanese, concisely and politely.

## Build and Test Commands

```sh
make compile          # Byte-compile emacs-batteries.el and emacs-batteries-early-init.el
make test             # Run all ERT tests in batch mode
EMACS=/path/to/emacs make test  # Override the Emacs binary
```

There is no single-test runner in the Makefile. To run one test:

```sh
emacs -Q --batch -L . -L test -l test/emacs-batteries-test.el \
  --eval '(ert-run-tests-batch-and-exit "TEST-NAME")'
```

## Architecture

The package provides conservative built-in Emacs defaults using only built-in features (no external packages). It targets Emacs 30.1+.

### Two-phase design

The package is split into two independently loadable files:

- **`emacs-batteries.el`** — Main library loaded from `init.el`. Entry point is `emacs-batteries-setup`, which delegates to `--configure-*` functions. Each `defcustom` controls one default; most opinionated features are opt-out. The configure functions are:
  - `--configure-startup-gc` — GC threshold during startup
  - `--configure-coding` — UTF-8 profiles per OS
  - `--configure-savehist` — minibuffer history persistence
  - `--configure-saveplace` — cursor position persistence
  - `--configure-minibuffer` — recursive minibuffers, prompt, depth indicator
  - `--configure-window-behavior` — winner-mode, help-window, split-width
  - `--configure-recentf` — recent files tracking
  - `--configure-file-safety` — backups, auto-save, lockfiles, trash, remote files
  - `--configure-copy` — clipboard, kill-ring, OSC 52
  - `--configure-auto-revert` — global-auto-revert-mode
  - `--configure-performance` — scrolling, bidi, jit-lock, pixel-scroll, native-comp, so-long
  - `--configure-editing` — delete-selection, repeat, electric-pair, completion, undo
  - `--configure-display` — column-number, uniquify, which-key, editorconfig, visual-wrap, eldoc, outline, tab-bar
  - `--configure-search` — isearch, xref, apropos, grep, find-library
  - `--configure-dired` — Dired defaults
  - `--configure-ediff` — Ediff window layout
  - `--configure-compilation` — compilation output and behavior
  - `--configure-security` — TLS, GPG, URL privacy
  - `--configure-eval` — eval-expression print limits
  - `--configure-prog-mode` — prog-mode hooks (trailing whitespace, goto-address, completion-preview, line-numbers, subword)
  - `--configure-shell` — comint, eshell, tramp
  - `--configure-diff` — diff-refine, kill-ring-deindent
  - `--enable-disabled-commands` — re-enable commonly disabled commands

- **`emacs-batteries-early-init.el`** — Startup optimizations that must run from `early-init.el` (before the normal init). Disables `package-enable-at-startup`, hides GUI chrome, raises GC threshold during startup, temporarily removes TRAMP file-name handlers. Calls `emacs-batteries-early-init-setup` at load time and self-provides.

Because either file may be loaded without the other, some definitions (GC restore function, saved-GC variables) are intentionally duplicated across both files. Keep these in sync.

### Bootstrap loader

`bootstrap/early-init.el` is a user-facing template. It downloads `emacs-batteries-early-init.el` from GitHub once, caches it locally, and loads the cache on subsequent startups (no network). Normal startup must never require network access.

### Test design

Tests in `test/emacs-batteries-test.el` mutate global state. The `emacs-batteries-test--with-sandbox` macro saves baseline values, disables all managed modes, runs the test body, then restores everything via `unwind-protect`. When adding tests that call `emacs-batteries-setup` or load the early-init file, always use this sandbox macro. If a new global variable is touched by setup, add it to `emacs-batteries-test--baseline-values`.

### Emacs 30 feature guards

Many Emacs 30-specific variables and functions use `boundp`/`fboundp` guards so the package degrades gracefully. For modes, use `fboundp` checks; for variables, use `boundp`.

## Change Policy

- No external dependencies. Built-in Emacs features only.
- All `.el` files use `lexical-binding: t`.
- Adding a `defcustom` requires updating the README in the same change.
- Changes to startup behavior or global state must be idempotent and restorable.
- Early-init changes must verify whether values need restoration after startup.
- Bootstrap changes must preserve the no-network-on-normal-startup design.
- Keep compatibility at Emacs 30.1+. Do not lower the minimum version.
- Prog-mode hooks use the `after-change-major-mode-hook` + helper function pattern (e.g. `--maybe-enable-*`). Follow this pattern for new prog-mode features.
- Opt-out features (modes, opinionated behavior) should use `defcustom` booleans. Non-opinionated "set and forget" variables do not need `defcustom`.
