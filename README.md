# emacs-batteries

`emacs-batteries` enables a curated set of built-in Emacs defaults without
adding external dependencies.

It targets Emacs 30.1 or newer.

This package is opinionated: it enables both low-risk safety defaults and a set
of quality-of-life defaults that many users add manually. The main opinionated
defaults are opt-out via Customize.

The main design goals are:

- keep startup-specific tuning lightweight
- enable useful built-in defaults without extra packages
- centralize state files under one directory
- make the more opinionated defaults easy to disable
- keep the package understandable: plain built-in Emacs variables and modes

## Usage

```elisp
(require 'emacs-batteries)
(emacs-batteries-setup)
```

If you want settings that only take effect from `early-init.el`, such as
`package-enable-at-startup`, the recommended setup is:

1. Put only the bootstrap loader in `~/.emacs.d/early-init.el`
2. Load `emacs-batteries.el` and call `emacs-batteries-setup` from your normal `init.el`

A bootstrap template is available at
[bootstrap/early-init.el](bootstrap/early-init.el). On normal startup, Emacs
just loads the cached helper file, so there is no network access and no
checksum calculation on the steady-state path.

For example:

```elisp
;; ~/.emacs.d/early-init.el
(load "/path/to/emacs-batteries/bootstrap/early-init.el" nil 'nomessage)
```

Checksum verification is only enabled when you set
`emacs-batteries-bootstrap-checksum` in
[bootstrap/early-init.el](bootstrap/early-init.el). Verification only runs
during download or refresh, so it does not affect the speed of normal startup.
Automatic refresh is disabled by default; set
`emacs-batteries-bootstrap-refresh-interval` if you want it.

## Early Init Defaults

`emacs-batteries-early-init.el` handles the settings that must run from
`early-init.el`:

- disable `package-enable-at-startup`
- inhibit loading `default.el`
- inhibit the startup screen
- hide the GUI menu bar, tool bar, and scroll bars from the first frame
- raise `read-process-output-max` to at least 1 MiB
- relax GC thresholds only during startup
- enable `frame-inhibit-implied-resize`
- temporarily remove TRAMP-related entries from `file-name-handler-alist` during startup and restore them afterwards

That last item is a conservative form of the usual
`file-name-handler-alist` optimization. It keeps handlers such as
`jka-compr` that may still matter during local startup, and only removes
TRAMP-related handlers temporarily.

## Enabled Defaults

`emacs-batteries-setup` currently enables the following defaults:

- always create numbered backups
- clean up old backups automatically
- centralize backups under `~/.emacs.d/var/emacs-batteries/backup/`
- create backups by copying instead of renaming
- centralize auto-save files under `~/.emacs.d/var/emacs-batteries/auto-save/`
- keep lockfiles enabled to avoid accidental concurrent edits
- move deleted files to trash
- prefer UTF-8 defaults when the environment is not already UTF-8 based
- relax GC thresholds only during startup and restore the original values afterwards
- enable `savehist-mode` and store its data under `~/.emacs.d/var/emacs-batteries/savehist.eld`
- disable the periodic `savehist` timer and save on exit instead
- enable `save-place-mode` and store its data under `~/.emacs.d/var/emacs-batteries/saveplace.eld`
- enable `recentf-mode` and store its data under `~/.emacs.d/var/emacs-batteries/recentf.eld`
- enable recursive minibuffers
- enable `minibuffer-depth-indicate-mode`
- enable `minibuffer-electric-default-mode`
- filter `M-x` candidates with `read-extended-command-predicate`
- ask for confirmation before killing Emacs, using `y-or-n-p` by default
- honor `display-buffer` actions in `switch-to-buffer`
- select help windows with `help-window-select` set to `other`
- enable `winner-mode`
- enable `global-auto-revert-mode`
- auto-revert Dired and other non-file buffers
- enable `global-so-long-mode`
- enable `fast-but-imprecise-scrolling`
- enable `redisplay-skip-fontification-on-input`
- enable `pixel-scroll-precision-mode`
- limit `vc-handled-backends` to `Git`
- disable the cursor in non-selected windows
- disable `blink-cursor-mode`
- silence the bell by setting `ring-bell-function` to `ignore`
- enable `show-paren-mode`
- enable `kill-whole-line`
- enable `delete-selection-mode`
- enable `repeat-mode`
- enable `electric-pair-local-mode` in `prog-mode` buffers
- make buffer completion case-insensitive
- make general completion case-insensitive
- set `tab-always-indent` to `complete`
- set `completion-cycle-threshold` to `3`
- remove duplicate history entries and raise history length to 1000
- avoid saving duplicate trailing entries in the `kill-ring`
- enable `select-enable-clipboard` for system clipboard integration
- restore the default clipboard paste reader when another setup had disabled it
- on macOS GUI Emacs, let plain `yank` paste Finder-copied files as local paths
- on macOS terminal Emacs, let plain `yank` fall back to `pbpaste`
- on macOS terminal Emacs, prefer OSC 52 copy and use synchronous `pbcopy` fallback
- avoid letting an unchanged macOS terminal clipboard override a newer Emacs kill
- save existing clipboard contents to the `kill-ring` before kill commands, with a default 1 MiB size limit
- prefer short yes/no answers by enabling `use-short-answers`
- disable dialog boxes by default and use the minibuffer instead
- enable OSC 52 clipboard copy and paste on xterm-like terminal Emacs sessions
- prefer loading newer `.el` files over stale `.elc` bytecode with `load-prefer-newer`
- preserve screen position when scrolling with `scroll-preserve-screen-position`
- enable `column-number-mode` in the mode line
- enable `uniquify` with `forward` style for distinctive buffer names (`dir/file` instead of `file<2>`)
- show match count during incremental search with `isearch-lazy-count`
- make file-name completion case-insensitive
- show extra annotations in the *Completions* buffer with `completions-detailed`
- add a final newline when saving files with `require-final-newline`
- prevent `find-file-at-point` from pinging hostnames with `ffap-machine-p-known`
- suppress native-compilation warning popups when native-comp is available
- set `sentence-end-double-space` to `nil` for modern sentence navigation
- enable `set-mark-command-repeat-pop` for easier mark ring traversal
- enable `window-resize-pixelwise` for precise window sizing
- highlight matching parens when point is inside or near them with `show-paren-when-point-inside-paren` and `show-paren-when-point-in-periphery`
- enable `which-key-mode` to show available key bindings in a popup
- enable `context-menu-mode` for right-click context menus
- use `xref-show-definitions-completing-read` for xref definitions
- enable `apropos-do-all` for more thorough apropos results
- silence auto-save messages with `auto-save-no-message`
- resolve symlinks when visiting files with `find-file-visit-truename`
- follow symlinks to version-controlled files with `vc-follow-symlinks`
- auto-save bookmarks on every modification with `bookmark-save-flag`
- set `dired-dwim-target` for convenient two-pane Dired operations
- allow recursive copies in Dired with `dired-recursive-copies`
- ask before recursive deletes in Dired with `dired-recursive-deletes` set to `top`
- ask before creating destination directories in Dired
- reuse Dired buffers when opening new directories
- use a plain frame layout for Ediff instead of a separate control frame
- split Ediff windows horizontally by default
- re-enable commonly disabled commands: `narrow-to-region`, `upcase-region`, `downcase-region`, `narrow-to-page`, `scroll-left`, `dired-find-alternate-file`, `erase-buffer`, `set-goal-column`, `list-timers`, `list-threads`
- yank at point instead of mouse click position with `mouse-yank-at-point`
- remove `show-paren-delay` for instant bracket matching feedback
- set `truncate-string-ellipsis` to `"…"` for cleaner display
- sort completion candidates by history with `completions-sort`
- set `tab-first-completion` to `word-or-paren-or-punct` for smarter TAB completion
- enable `comment-multi-line` to continue comments across lines
- enable `comment-empty-lines` to comment empty lines in region
- default to spaces for indentation with `indent-tabs-mode` nil
- enable word-wrapping at word boundaries with `word-wrap`
- disable automatic vertical scrolling with `auto-window-vscroll`
- enable `inhibit-compacting-font-caches` for CJK performance
- enable `frame-resize-pixelwise` for gap-free tiling
- inhibit bidirectional parenthesis algorithm with `bidi-inhibit-bpa` for LTR performance
- set `bidi-paragraph-direction` to `left-to-right` to skip bidirectional scanning
- conservative scrolling with `scroll-conservatively` set to 101
- enable `scroll-error-top-bottom` for smooth end-of-buffer behavior
- fine-tune horizontal scrolling with `hscroll-margin` and `hscroll-step`
- defer font-lock with `jit-lock-defer-time` for smoother scrolling in large files
- disable adaptive process read buffering for lower latency
- prevent frame resizing on text scale changes
- render underlines at descent line for cleaner display
- disable load average in mode line
- prevent `C-n` from adding newlines at end of buffer
- raise `recentf-max-saved-items` to 300
- show Dired file sizes in human-readable format with `-alh`
- auto-revert Dired buffers when revisited
- use `git mv` when renaming in Dired with `dired-vc-rename-file`
- follow file renames in `git log` with `vc-git-print-log-follow`
- disable truncation of `eval-expression` output
- scroll compilation output to first error
- auto-kill previous compilation process on recompile
- save buffers without asking before compilation
- verify TLS certificates strictly with `gnutls-verify-error`
- raise minimum DH prime bits to 3072
- use minibuffer for GPG passphrase with `epg-pinentry-mode`
- auto-rescan imenu index with `imenu-auto-rescan`
- only grow the minibuffer, never shrink with `resize-mini-windows`
- make the minibuffer prompt read-only and cursor-intangible
- include big deletions in auto-save with `auto-save-include-big-deletions`
- suppress same-file warnings for symlinks with `find-file-suppress-same-file-warnings`
- skip confirmation for new files with `confirm-nonexistent-file-or-buffer`
- save abbreviations silently with `save-abbrevs`
- delete auto-save files when killing buffers with `kill-buffer-delete-auto-save-files`
- redirect `custom-file` to a separate file and load it if present
- enable `editorconfig-mode` for project-level editor settings
- enable `display-line-numbers-mode` in `prog-mode` buffers
- enable `subword-mode` in `prog-mode` buffers for CamelCase navigation
- set `initial-major-mode` to `fundamental-mode` for faster scratch buffer
- clear `initial-scratch-message` for a clean scratch buffer
- auto-add execute permission to scripts with `#!` on save
- disable `blink-matching-paren` (redundant with `show-paren-mode`)
- kill the Custom buffer when done with `custom-buffer-done-kill`
- use histogram diff algorithm with `vc-git-diff-switches`
- use `y-or-n-p` for Dired deletion confirmation
- enable bounded cursor movement in Dired with `dired-movement-style`
- use `comint-prompt-read-only` to protect shell prompts
- append to eshell history with `eshell-history-append`
- reduce TRAMP verbosity with `tramp-verbose` set to 1
- inhibit moving remote files to trash with `remote-file-name-inhibit-delete-by-moving-to-trash`
- inhibit auto-saving remote files with `remote-file-name-inhibit-auto-save`
- enable `grep-use-headings` for file-grouped grep output
- show project name in the mode line with `project-mode-line`
- enable outline mode in help bindings with `describe-bindings-outline`
- flatten imenu with `imenu-flatten` set to `prefix`
- disable `text-mode-ispell-word-completion` to let TAB do completion
- persist `search-ring`, `regexp-search-ring`, and `compile-command` in savehist
- raise `undo-limit` to 160000 and `undo-strong-limit` to 240000
- prefer vertical splits on wide monitors with `split-width-threshold` set to 170
- enable `diff-refine` for word-level diff highlighting
- enable `global-visual-wrap-prefix-mode` for indented line wrapping
- enable `completion-preview-mode` in `prog-mode` buffers for inline completion preview
- enable `global-kill-ring-deindent-mode` for deindented kill-ring entries
- show trailing whitespace in `prog-mode` buffers
- enable `goto-address-prog-mode` in `prog-mode` buffers for clickable URLs
- remove *Completions* header with `completions-header-format` set to nil
- show Unicode character names with `what-cursor-show-names`
- raise `large-file-warning-threshold` to 50 MiB
- limit eldoc to one line with `eldoc-echo-area-use-multiline-p` set to nil
- enable horizontal tilt scrolling with `mouse-wheel-tilt-scroll`
- enable colored output in `proced` with `proced-enable-color-flag`
- disable `use-file-dialog` for consistency with `use-dialog-box`
- preserve hard links when backing up with `backup-by-copying-when-linked`
- display raw bytes in hex with `display-raw-bytes-as-hex`
- enable editing variable values from Help with `help-enable-variable-value-editing`
- disable compilation output line truncation with `compilation-max-output-line-length`
- enable register preview with `register-use-preview`
- keep focus in help window after following references with `help-window-keep-selected`
- only show tab bar when multiple tabs exist with `tab-bar-show` set to 1
- do not restore windows after minibuffer exit with `read-minibuffer-restore-windows`
- pop to another window from dedicated windows with `switch-to-buffer-in-dedicated-window`
- set `url-privacy-level` to `high` to suppress personal information in URL requests
- allow scrolling during incremental search with `isearch-allow-scroll`
- wrap search without pausing with `isearch-wrap-pause` set to `no`
- highlight all matches in the buffer with `lazy-highlight-buffer`
- auto-kill shell buffer on process exit with `shell-kill-buffer-on-exit`
- scroll shell to bottom on input with `comint-scroll-to-bottom-on-input`
- auto-prune old native compilation cache with `native-compile-prune-cache`
- use per-window xref history with `xref-history-storage`
- show only `.el` files in `find-library` with `find-library-include-other-files` set to nil
- enable TAB cycling for `outline-minor-mode` with `outline-minor-mode-cycle`
- clean up Ediff variant buffers on exit with `ediff-keep-variants` set to nil

## Performance Notes

Not all enabled defaults have the same runtime cost.

Usually negligible:

- `use-short-answers`
- `tab-always-indent`
- `completion-cycle-threshold`
- `switch-to-buffer-obey-display-actions`
- `help-window-select`
- `ring-bell-function`
- `confirm-kill-emacs`
- `minibuffer-depth-indicate-mode`
- `minibuffer-electric-default-mode`
- `column-number-mode`
- `isearch-lazy-count`
- `uniquify-buffer-name-style`
- `completions-detailed`
- `require-final-newline`
- `load-prefer-newer`
- `scroll-preserve-screen-position`
- `ffap-machine-p-known`
- `sentence-end-double-space`
- `set-mark-command-repeat-pop`
- `window-resize-pixelwise`
- `apropos-do-all`
- `find-file-visit-truename`
- `vc-follow-symlinks`
- `bookmark-save-flag`
- `dired-dwim-target`
- `dired-recursive-copies`
- `dired-recursive-deletes`
- `auto-save-no-message`
- `ediff-window-setup-function`
- `ediff-split-window-function`
- `mouse-yank-at-point`
- `show-paren-delay`
- `truncate-string-ellipsis`
- `comment-multi-line`
- `comment-empty-lines`
- `auto-window-vscroll`
- `inhibit-compacting-font-caches`
- `frame-resize-pixelwise`
- `scroll-conservatively`
- `hscroll-margin`
- `hscroll-step`
- `eval-expression-print-length`
- `eval-expression-print-level`
- `compilation-scroll-output`
- `compilation-always-kill`
- `compilation-ask-about-save`
- `epg-pinentry-mode`
- `resize-mini-windows`
- `save-abbrevs`
- `kill-buffer-delete-auto-save-files`
- `initial-major-mode`
- `initial-scratch-message`
- `dired-listing-switches`
- `dired-auto-revert-buffer`
- `dired-vc-rename-file`
- `vc-git-print-log-follow`
- `blink-matching-paren`
- `custom-buffer-done-kill`
- `vc-git-diff-switches`
- `dired-deletion-confirmer`
- `dired-movement-style`
- `comint-prompt-read-only`
- `eshell-history-append`
- `tramp-verbose`
- `remote-file-name-inhibit-delete-by-moving-to-trash`
- `remote-file-name-inhibit-auto-save`
- `grep-use-headings`
- `project-mode-line`
- `describe-bindings-outline`
- `imenu-flatten`
- `text-mode-ispell-word-completion`
- `undo-limit` / `undo-strong-limit`
- `split-width-threshold`
- `diff-refine`
- `completions-header-format`
- `what-cursor-show-names`
- `large-file-warning-threshold`
- `eldoc-echo-area-use-multiline-p`
- `mouse-wheel-tilt-scroll`
- `proced-enable-color-flag`
- `use-file-dialog`
- `backup-by-copying-when-linked`
- `display-raw-bytes-as-hex`
- `help-enable-variable-value-editing`
- `compilation-max-output-line-length`
- `register-use-preview`
- `help-window-keep-selected`
- `tab-bar-show`
- `read-minibuffer-restore-windows`
- `switch-to-buffer-in-dedicated-window`
- `url-privacy-level`
- `isearch-allow-scroll`
- `isearch-wrap-pause`
- `lazy-highlight-buffer`
- `shell-kill-buffer-on-exit`
- `comint-scroll-to-bottom-on-input`
- `native-compile-prune-cache`
- `xref-history-storage`
- `find-library-include-other-files`
- `outline-minor-mode-cycle`
- `ediff-keep-variants`

Low but persistent overhead:

- `editorconfig-mode`

- `recentf-mode`
- `winner-mode`
- `repeat-mode`
- `which-key-mode`
- `global-visual-wrap-prefix-mode`
- `completion-preview-mode`
- `global-kill-ring-deindent-mode`
- `goto-address-prog-mode`
- `show-trailing-whitespace` (prog-mode)

Potentially noticeable depending on workflow or platform:

- `global-auto-revert-mode`
- `global-auto-revert-non-file-buffers`
- `pixel-scroll-precision-mode`
- `bidi-inhibit-bpa` / `bidi-paragraph-direction` (may affect RTL text)
- `jit-lock-defer-time` (brief unhighlighted text while scrolling)
- `gnutls-verify-error` (may reject self-signed certificates)

If you want a lower-overhead setup, the most useful opt-outs are:

- `emacs-batteries-enable-auto-revert`
- `emacs-batteries-auto-revert-non-file-buffers`
- `emacs-batteries-enable-pixel-scroll-precision`
- `emacs-batteries-enable-winner-mode`
- `emacs-batteries-enable-recentf`
- `emacs-batteries-enable-which-key-mode`
- `emacs-batteries-enable-editorconfig`
- `emacs-batteries-enable-display-line-numbers-in-prog-mode`
- `emacs-batteries-enable-subword-in-prog-mode`
- `emacs-batteries-enable-completion-preview-in-prog-mode`
- `emacs-batteries-enable-visual-wrap-prefix`
- `emacs-batteries-enable-kill-ring-deindent`
- `emacs-batteries-show-trailing-whitespace-in-prog-mode`
- `emacs-batteries-enable-goto-address-in-prog-mode`

## Opt-out

The main opinionated defaults managed through `emacs-batteries` can be disabled
or changed through Customize:

```elisp
(customize-group 'emacs-batteries)
```

The main opt-out variables are:

- `emacs-batteries-enable-recentf`
- `emacs-batteries-enable-auto-revert`
- `emacs-batteries-auto-revert-non-file-buffers`
- `emacs-batteries-enable-recursive-minibuffers`
- `emacs-batteries-enable-minibuffer-depth-indicate`
- `emacs-batteries-enable-minibuffer-electric-default`
- `emacs-batteries-enable-winner-mode`
- `emacs-batteries-read-extended-command-predicate`
- `emacs-batteries-confirm-kill-emacs`
- `emacs-batteries-switch-to-buffer-obey-display-actions`
- `emacs-batteries-help-window-select`
- `emacs-batteries-ring-bell-function`
- `emacs-batteries-enable-delete-selection`
- `emacs-batteries-enable-repeat-mode`
- `emacs-batteries-enable-show-paren`
- `emacs-batteries-enable-pixel-scroll-precision`
- `emacs-batteries-enable-electric-pair-in-prog-mode`
- `emacs-batteries-use-dialog-box`
- `emacs-batteries-use-short-answers`
- `emacs-batteries-tab-always-indent`
- `emacs-batteries-completion-cycle-threshold`
- `emacs-batteries-save-interprogram-paste-before-kill`
- `emacs-batteries-enable-terminal-clipboard-paste`
- `emacs-batteries-coding-system`
- `emacs-batteries-enable-column-number-mode`
- `emacs-batteries-enable-isearch-lazy-count`
- `emacs-batteries-enable-uniquify`
- `emacs-batteries-uniquify-buffer-name-style`
- `emacs-batteries-completions-detailed`
- `emacs-batteries-require-final-newline`
- `emacs-batteries-enable-which-key-mode`
- `emacs-batteries-enable-context-menu-mode`
- `emacs-batteries-sentence-end-double-space`
- `emacs-batteries-dired-dwim-target`
- `emacs-batteries-enable-editorconfig`
- `emacs-batteries-enable-display-line-numbers-in-prog-mode`
- `emacs-batteries-enable-subword-in-prog-mode`
- `emacs-batteries-indent-tabs-mode`
- `emacs-batteries-scroll-conservatively`
- `emacs-batteries-bidi-inhibit-bpa`
- `emacs-batteries-gnutls-verify-error`
- `emacs-batteries-initial-major-mode`
- `emacs-batteries-initial-scratch-message`
- `emacs-batteries-custom-file`
- `emacs-batteries-word-wrap`
- `emacs-batteries-recentf-max-saved-items`
- `emacs-batteries-enable-completion-preview-in-prog-mode`
- `emacs-batteries-enable-visual-wrap-prefix`
- `emacs-batteries-split-width-threshold`
- `emacs-batteries-enable-kill-ring-deindent`
- `emacs-batteries-show-trailing-whitespace-in-prog-mode`
- `emacs-batteries-enable-goto-address-in-prog-mode`
- `emacs-batteries-large-file-warning-threshold`
- `emacs-batteries-defer-setup`

## Deferred Loading

By default (`emacs-batteries-defer-setup` is `t`), `emacs-batteries-setup`
defers require-heavy configuration to `emacs-startup-hook` and applies
feature-specific settings lazily via `with-eval-after-load`:

- **Deferred to `emacs-startup-hook`**: savehist, saveplace, recentf,
  auto-revert, uniquify, which-key, editorconfig — these call `(require ...)`
  and enable global modes, so deferring them avoids file I/O during init.

- **Deferred via `with-eval-after-load`**: dired, ediff, compile, comint,
  eshell, tramp, diff-mode, gnutls, epg, url — these only set variables and
  are applied when the corresponding feature is first loaded.

Set `emacs-batteries-defer-setup` to `nil` to run all configuration
synchronously:

```elisp
(setq emacs-batteries-defer-setup nil)
(emacs-batteries-setup)
```

## Intentionally Excluded

The package intentionally does not enable the following features:

- **`desktop-save-mode`** — persists much more session state than this package
  aims to manage by default
- **`flyspell` / `ispell`** — depends on external programs (`aspell`, `hunspell`)
- **`eglot` / `flymake`** — language-server and linter configuration is
  project-specific and should be set up per-project
- **`treesit` mode remapping** — which tree-sitter modes to use depends on
  installed grammars and personal preference
- **`windmove` / `ibuffer` keybindings** — this package does not change any
  keybindings
- **`global-hl-line-mode`** — can introduce noticeable overhead in large files
  and is a strong visual preference
- **`delete-trailing-whitespace` on save** — can produce noisy diffs in shared
  codebases; `editorconfig-mode` already handles this per-project when
  configured
- **`prettify-symbols-mode`** — whether to render `lambda` as `λ` etc. is
  purely a matter of taste

## Coding Systems

The default `emacs-batteries-coding-system` is `utf-8`, which applies a
conservative UTF-8 profile per OS.

- On macOS it uses `utf-8-hfs-unix` for file names.
- On Windows it uses `utf-8-dos` for buffers and processes while leaving
  file-name coding on the platform defaults, since modern Emacs uses Unicode
  file-name APIs there.
- On other systems it uses `utf-8-unix`.

If you set `emacs-batteries-coding-system` to `nil`, the package returns to the
more conservative behavior of only preferring UTF-8 when the current
environment is not already UTF-8 based.

## Clipboard on macOS and TTY Emacs

This library explicitly enables `select-enable-clipboard`, so GUI Emacs keeps
kill and yank integrated with the system clipboard on macOS and other window
systems. In Emacs 30.2 with `emacs -Q`, this is already `t` by default, but
setting it here keeps the behavior stable when another setup had disabled it.
It also restores the default `interprogram-paste-function` when another setup
had set it to `nil`, so plain `C-y` can still pull from the OS clipboard.

On macOS GUI Emacs, this library also makes plain `yank` fall back to Finder
file copies. When the clipboard currently contains local files copied in
Finder, `C-y` inserts their absolute paths separated by newlines, which makes
those copies usable in minibuffer file prompts and other text-oriented paste
targets inside Emacs.

In terminal Emacs, this library enables OSC 52 based clipboard copy and paste
on xterm-like terminals. This is applied both to the initial terminal and to
later tty `emacsclient` connections through `tty-setup-hook`.

In practice, the supported terminals are the ones initialized through
`term/xterm.el`, such as `xterm`, `screen`, and `tmux`. This keeps kill/copy
integrated with the OS clipboard bridge and also lets `yank` read from the
clipboard when the terminal answers OSC 52 selection queries.

On macOS terminal Emacs, this library also falls back to the system
`pbpaste` tool when OSC 52 clipboard queries are unavailable. This is mainly
useful for local terminal sessions such as WezTerm on macOS.

WezTerm's documentation says OSC 52 clipboard query requests are ignored, while
OSC 52 clipboard writes are supported. For that case, this library keeps
terminal copy on OSC 52 when available, and uses `pbpaste` for local macOS
terminal paste instead of waiting on ignored terminal clipboard queries.

If macOS terminal Emacs cannot use OSC 52 clipboard copy, this library falls
back to `pbcopy` synchronously. That closes stdin immediately and avoids
leaving a `pbcopy` subprocess behind waiting for more input.

When `pbpaste` still shows an older macOS clipboard entry after an Emacs kill
or copy command, this fallback does not override the newer Emacs kill-ring
entry until the macOS clipboard actually changes again. This avoids stale
clipboard text winning over a recent Emacs copy when the terminal copy bridge
is unavailable or misconfigured.

If clipboard queries make `yank` feel slow in your terminal or `tmux` setup,
set `emacs-batteries-enable-terminal-clipboard-paste` to `nil`. That opt-out
also disables the macOS `pbpaste` fallback above.

In addition, this library enables `save-interprogram-paste-before-kill` with a
size limit. That preserves existing clipboard contents in the `kill-ring`
before an Emacs kill command overwrites the clipboard. The default limit is
1 MiB.

If your outer terminal emulator or `tmux` blocks OSC 52, this setting alone may
not be enough to reach the system clipboard, and clipboard paste may need the
opt-out above.

## References

The implementation is intentionally based on GNU Emacs manuals and built-in
documentation from Emacs 30.2.

- Backup Files: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Backup.html>
- Saving Emacs Sessions: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html>
- Interlocking: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Interlocking.html>
- Customize Save: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Customize-Save.html>
- Clipboard: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Clipboard.html>
- Basic Minibuffer: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Basic-Minibuffer.html>
- M-x: <https://www.gnu.org/software/emacs/manual/html_node/emacs/M_002dx.html>
- Window Convenience: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Window-Convenience.html>
- Exiting: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Exiting.html>
- Auto Revert: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Auto-Revert.html>
- File Conveniences: <https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Conveniences.html>
- Matching: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Matching.html>
- Dialog Boxes: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Dialog-Boxes.html>
- Repeating: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Repeating.html>
- Help: <https://www.gnu.org/software/emacs/manual/html_node/emacs/Help.html>
- Switching Buffers: <https://www.gnu.org/software/emacs/manual/html_node/elisp/Switching-Buffers.html>
- Beeping: <https://www.gnu.org/software/emacs/manual/html_node/elisp/Beeping.html>

## Verification

```sh
make compile
make test
```
