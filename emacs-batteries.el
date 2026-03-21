;;; emacs-batteries.el --- Conservative built-in Emacs defaults -*- lexical-binding: t; -*-

;; Copyright (C) 2026 SuzumiyaAoba
;; Author: SuzumiyaAoba
;; Version: 0.1.0
;; Package-Requires: ((emacs "30.1"))
;; Keywords: convenience, files, maint
;; URL: https://github.com/SuzumiyaAoba/emacs-batteries
;; SPDX-License-Identifier: GPL-3.0-or-later

;;; Commentary:

;; `emacs-batteries-setup' enables a curated set of built-in defaults,
;; spanning conservative safety settings and common quality-of-life tweaks.

;;; Code:

(require 'cl-lib)

(defvar savehist-file)
(defvar savehist-autosave-interval)
(defvar savehist-timer)
(defvar save-place-file)
(defvar recentf-save-file)
(defvar recentf-max-saved-items)
(defvar tty-setup-hook)
(defvar after-change-major-mode-hook)
(defvar emacs-startup-hook)
(defvar enable-recursive-minibuffers)
(defvar confirm-kill-emacs)
(defvar read-extended-command-predicate)
(defvar locale-coding-system)
(defvar default-process-coding-system)
(defvar file-name-coding-system)
(defvar default-file-name-coding-system)
(defvar buffer-file-coding-system)
(defvar selection-coding-system)
(defvar vc-handled-backends)
(defvar tab-always-indent)
(defvar completion-cycle-threshold)
(defvar switch-to-buffer-obey-display-actions)
(defvar help-window-select)
(defvar blink-cursor-mode)
(defvar cursor-in-non-selected-windows)
(defvar after-init-time)
(defvar fast-but-imprecise-scrolling)
(defvar redisplay-skip-fontification-on-input)
(defvar ring-bell-function)
(defvar backup-by-copying)
(defvar save-interprogram-paste-before-kill)
(defvar global-auto-revert-non-file-buffers)
(defvar use-dialog-box)
(defvar use-short-answers)
(defvar repeat-mode)
(defvar recentf-mode)
(defvar global-auto-revert-mode)
(defvar pixel-scroll-precision-mode)
(defvar delete-selection-mode)
(defvar show-paren-mode)
(defvar show-paren-delay)
(defvar show-paren-when-point-inside-paren)
(defvar show-paren-when-point-in-periphery)
(defvar winner-mode)
(defvar minibuffer-depth-indicate-mode)
(defvar minibuffer-electric-default-mode)
(defvar uniquify-buffer-name-style)
(defvar isearch-lazy-count)
(defvar lazy-count-prefix-format)
(defvar lazy-count-suffix-format)
(defvar lazy-highlight-initial-delay)
(defvar ffap-machine-p-known)
(defvar column-number-mode)
(defvar ediff-window-setup-function)
(defvar ediff-split-window-function)
(defvar bookmark-save-flag)
(defvar dired-dwim-target)
(defvar dired-recursive-copies)
(defvar dired-recursive-deletes)
(defvar dired-create-destination-dirs)
(defvar dired-kill-when-opening-new-dired-buffer)
(defvar dired-listing-switches)
(defvar dired-auto-revert-buffer)
(defvar dired-vc-rename-file)
(defvar xref-show-definitions-function)
(defvar which-key-mode)
(defvar context-menu-mode)
(defvar set-mark-command-repeat-pop)
(defvar window-resize-pixelwise)
(defvar apropos-do-all)
(defvar mouse-yank-at-point)
(defvar auto-window-vscroll)
(defvar inhibit-compacting-font-caches)
(defvar frame-resize-pixelwise)
(defvar bidi-inhibit-bpa)
(defvar bidi-paragraph-direction)
(defvar scroll-conservatively)
(defvar scroll-error-top-bottom)
(defvar hscroll-margin)
(defvar hscroll-step)
(defvar vc-git-print-log-follow)
(defvar eval-expression-print-length)
(defvar eval-expression-print-level)
(defvar compilation-scroll-output)
(defvar compilation-always-kill)
(defvar compilation-ask-about-save)
(defvar save-abbrevs)
(defvar gnutls-verify-error)
(defvar gnutls-min-prime-bits)
(defvar imenu-auto-rescan)
(defvar resize-mini-windows)
(defvar comment-multi-line)
(defvar comment-empty-lines)
(defvar truncate-string-ellipsis)
(defvar completions-sort)
(defvar initial-scratch-message)
(defvar word-wrap)
(defvar tab-first-completion)
(defvar jit-lock-defer-time)
(defvar process-adaptive-read-buffering)
(defvar global-text-scale-adjust-resizes-frames)
(defvar x-underline-at-descent-line)
(defvar display-time-default-load-average)
(defvar epg-pinentry-mode)
(defvar next-line-add-newlines)
(defvar kill-buffer-delete-auto-save-files)
(defvar auto-save-include-big-deletions)
(defvar find-file-suppress-same-file-warnings)
(defvar confirm-nonexistent-file-or-buffer)
(defvar subword-mode)
(defvar display-line-numbers-mode)
(defvar custom-file)
(defvar minibuffer-setup-hook)
(defvar after-save-hook)
(defvar grep-use-headings)
(defvar project-mode-line)
(defvar describe-bindings-outline)
(defvar diff-refine)
(defvar kill-ring-deindent-mode)
(defvar remote-file-name-inhibit-delete-by-moving-to-trash)
(defvar remote-file-name-inhibit-auto-save)
(defvar vc-git-diff-switches)
(defvar blink-matching-paren)
(defvar custom-buffer-done-kill)
(defvar dired-movement-style)
(defvar dired-deletion-confirmer)
(defvar comint-prompt-read-only)
(defvar eshell-history-append)
(defvar imenu-flatten)
(defvar text-mode-ispell-word-completion)
(defvar savehist-additional-variables)
(defvar undo-limit)
(defvar undo-strong-limit)
(defvar split-width-threshold)
(defvar tramp-verbose)
(defvar completion-preview-mode)
(defvar visual-wrap-prefix-mode)
(defvar completions-header-format)
(defvar what-cursor-show-names)
(defvar large-file-warning-threshold)
(defvar eldoc-echo-area-use-multiline-p)
(defvar mouse-wheel-tilt-scroll)
(defvar proced-enable-color-flag)
(defvar use-file-dialog)
(defvar backup-by-copying-when-linked)
(defvar display-raw-bytes-as-hex)
(defvar help-enable-variable-value-editing)
(defvar compilation-max-output-line-length)
(defvar register-use-preview)
(defvar help-window-keep-selected)
(defvar tab-bar-show)
(defvar read-minibuffer-restore-windows)
(defvar switch-to-buffer-in-dedicated-window)
(defvar url-privacy-level)
(defvar isearch-allow-scroll)
(defvar isearch-wrap-pause)
(defvar lazy-highlight-buffer)
(defvar shell-kill-buffer-on-exit)
(defvar comint-scroll-to-bottom-on-input)
(defvar native-compile-prune-cache)
(defvar xref-history-storage)
(defvar find-library-include-other-files)
(defvar outline-minor-mode-cycle)
(defvar ediff-keep-variants)

(declare-function xterm--init-activate-set-selection "term/xterm" ())
(declare-function prefer-coding-system "mule" (coding-system))
(declare-function set-default-coding-systems "mule" (coding-system))
(declare-function set-selection-coding-system "mule-cmds" (coding-system))
(declare-function set-terminal-coding-system "mule-cmds"
                  (coding-system &optional terminal))
(declare-function set-keyboard-coding-system "mule-cmds"
                  (coding-system &optional terminal))
(declare-function recentf-mode "recentf" (&optional arg))
(declare-function global-auto-revert-mode "autorevert" (&optional arg))
(declare-function pixel-scroll-precision-mode "pixel-scroll" (&optional arg))
(declare-function repeat-mode "repeat" (&optional arg))
(declare-function delete-selection-mode "delsel" (&optional arg))
(declare-function show-paren-mode "paren" (&optional arg))
(declare-function electric-pair-local-mode "electric" (&optional arg))
(declare-function winner-mode "winner" (&optional arg))
(declare-function minibuffer-depth-indicate-mode "mb-depth" (&optional arg))
(declare-function minibuffer-electric-default-mode "minibuf-el" (&optional arg))
(declare-function command-completion-default-include-p "simple" (command))
(declare-function which-key-mode "which-key" (&optional arg))
(declare-function context-menu-mode "mouse" (&optional arg))
(declare-function xref-show-definitions-completing-read "xref"
                  (fetcher alist))
(declare-function ediff-setup-windows-plain "ediff-wind"
                  (buf-a buf-b buf-c control-buffer))
(declare-function editorconfig-mode "editorconfig" (&optional arg))
(declare-function cursor-intangible-mode "cursor-sensor" (&optional arg))
(declare-function display-line-numbers-mode "display-line-numbers"
                  (&optional arg))
(declare-function subword-mode "subword" (&optional arg))
(declare-function executable-make-buffer-file-executable-if-script-p
                  "executable" ())
(declare-function completion-preview-mode "completion-preview" (&optional arg))
(declare-function global-visual-wrap-prefix-mode "visual-wrap" (&optional arg))
(declare-function global-kill-ring-deindent-mode "kill-ring-deindent"
                  (&optional arg))
(declare-function goto-address-prog-mode "goto-addr" ())

(defgroup emacs-batteries nil
  "Conservative built-in defaults for Emacs."
  :group 'convenience
  :prefix "emacs-batteries-")

(defcustom emacs-batteries-state-directory
  (locate-user-emacs-file "var/emacs-batteries/")
  "Directory used for persistent state managed by `emacs-batteries-setup'."
  :type 'directory)

(defcustom emacs-batteries-history-length 1000
  "Maximum number of minibuffer history entries to keep."
  :type 'integer)

(defcustom emacs-batteries-kept-new-backups 10
  "Number of newest numbered backups to keep."
  :type 'integer)

(defcustom emacs-batteries-kept-old-backups 2
  "Number of oldest numbered backups to keep."
  :type 'integer)

(defcustom emacs-batteries-backup-by-copying t
  "Non-nil means always create backup files by copying."
  :type 'boolean)

(defcustom emacs-batteries-prefer-utf-8 t
  "Non-nil means prefer UTF-8 when the current defaults are not UTF-8 based.

This only adjusts the defaults in environments that are not already
using UTF-8.  Existing file-name coding defaults are preserved."
  :type 'boolean)

(defcustom emacs-batteries-coding-system 'utf-8
  "Coding system profile managed by `emacs-batteries'.

When nil, `emacs-batteries' keeps the conservative behavior controlled by
`emacs-batteries-prefer-utf-8'.  When set to `utf-8', Emacs applies an
OS-appropriate UTF-8 profile:

- macOS: use `utf-8-unix' for buffers and processes, and `utf-8-hfs-unix'
  for file names.
- Windows: use `utf-8-dos' for buffers and processes, and keep file-name
  coding on the system defaults, since modern Emacs uses Unicode file-name
  APIs there.
- Other systems: use `utf-8-unix'.

Any other coding system fixes the defaults to that coding system."
  :type '(choice (const :tag "Conservative auto" nil)
                 (const :tag "UTF-8 profile" utf-8)
                 coding-system))

(defcustom emacs-batteries-startup-gc-cons-threshold (* 64 1024 1024)
  "Temporary `gc-cons-threshold' used during startup.

This value is applied only while startup is still in progress, and the
original value is restored from `emacs-startup-hook'.  A nil value
disables this optimization."
  :type '(choice (const :tag "Disabled" nil)
                 integer))

(defcustom emacs-batteries-enable-so-long t
  "Non-nil means enable `global-so-long-mode'."
  :type 'boolean)

(defcustom emacs-batteries-fast-but-imprecise-scrolling t
  "Non-nil means enable `fast-but-imprecise-scrolling'."
  :type 'boolean)

(defcustom emacs-batteries-redisplay-skip-fontification-on-input t
  "Non-nil means enable `redisplay-skip-fontification-on-input'."
  :type 'boolean)

(defcustom emacs-batteries-save-interprogram-paste-before-kill
  (* 1024 1024)
  "How clipboard contents should be preserved before kill commands.

When non-nil, this value is assigned to
`save-interprogram-paste-before-kill'.  A numeric value limits the
clipboard text saved to the kill ring by character count."
  :type '(choice (const :tag "Disabled" nil)
                 (const :tag "Always save clipboard text" t)
                 integer))

(defcustom emacs-batteries-enable-recentf t
  "Non-nil means enable `recentf-mode'."
  :type 'boolean)

(defcustom emacs-batteries-recentf-max-saved-items 300
  "Maximum number of recent files to save."
  :type 'integer)

(defcustom emacs-batteries-enable-auto-revert t
  "Non-nil means enable `global-auto-revert-mode'."
  :type 'boolean)

(defcustom emacs-batteries-auto-revert-non-file-buffers t
  "Non-nil means auto-revert Dired and other non-file buffers."
  :type 'boolean)

(defcustom emacs-batteries-enable-delete-selection t
  "Non-nil means enable `delete-selection-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-repeat-mode t
  "Non-nil means enable `repeat-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-show-paren t
  "Non-nil means enable `show-paren-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-pixel-scroll-precision t
  "Non-nil means enable `pixel-scroll-precision-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-electric-pair-in-prog-mode t
  "Non-nil means enable `electric-pair-local-mode' in `prog-mode' buffers."
  :type 'boolean)

(defcustom emacs-batteries-use-dialog-box nil
  "Value assigned to `use-dialog-box'."
  :type 'boolean)

(defcustom emacs-batteries-use-short-answers t
  "Value assigned to `use-short-answers'."
  :type 'boolean)

(defcustom emacs-batteries-tab-always-indent 'complete
  "Value assigned to `tab-always-indent'."
  :type '(choice (const :tag "Indent only" t)
                 (const :tag "Indent or complete" complete)
                 (const :tag "Always complete" nil)))

(defcustom emacs-batteries-completion-cycle-threshold 3
  "Value assigned to `completion-cycle-threshold'."
  :type '(choice (const :tag "Disabled" nil)
                 integer))

(defcustom emacs-batteries-switch-to-buffer-obey-display-actions t
  "Value assigned to `switch-to-buffer-obey-display-actions'."
  :type 'boolean)

(defcustom emacs-batteries-help-window-select 'other
  "Value assigned to `help-window-select'."
  :type '(choice (const :tag "Do not select help windows" nil)
                 (const :tag "Always select help windows" t)
                 (const :tag "Select only another window" other)))

(defcustom emacs-batteries-ring-bell-function 'ignore
  "Value assigned to `ring-bell-function'."
  :type '(choice (const :tag "Use default bell" nil)
                 function))

(defcustom emacs-batteries-enable-recursive-minibuffers t
  "Non-nil means enable recursive minibuffers."
  :type 'boolean)

(defcustom emacs-batteries-enable-minibuffer-depth-indicate t
  "Non-nil means enable `minibuffer-depth-indicate-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-minibuffer-electric-default t
  "Non-nil means enable `minibuffer-electric-default-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-winner-mode t
  "Non-nil means enable `winner-mode'."
  :type 'boolean)

(defcustom emacs-batteries-read-extended-command-predicate
  'command-completion-default-include-p
  "Value assigned to `read-extended-command-predicate'."
  :type '(choice (const :tag "Disabled" nil)
                 function))

(defcustom emacs-batteries-confirm-kill-emacs nil
  "Value assigned to `confirm-kill-emacs'."
  :type '(choice (const :tag "Disabled" nil)
                 function))

(defcustom emacs-batteries-enable-column-number-mode t
  "Non-nil means enable `column-number-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-isearch-lazy-count t
  "Non-nil means show match count during incremental search."
  :type 'boolean)

(defcustom emacs-batteries-enable-uniquify t
  "Non-nil means enable `uniquify' for distinctive buffer names."
  :type 'boolean)

(defcustom emacs-batteries-uniquify-buffer-name-style 'forward
  "Value assigned to `uniquify-buffer-name-style'."
  :type '(choice (const :tag "Forward (dir/file)" forward)
                 (const :tag "Reverse (file\\dir)" reverse)
                 (const :tag "Post-forward (file|dir)" post-forward)
                 (const :tag "Post-forward with angle brackets" post-forward-angle-brackets)
                 (const :tag "Disabled" nil)))

(defcustom emacs-batteries-completions-detailed t
  "Non-nil means show extra annotations in the *Completions* buffer."
  :type 'boolean)

(defcustom emacs-batteries-require-final-newline t
  "Value assigned to `require-final-newline'.
Non-nil means add a newline at the end of files when saving."
  :type '(choice (const :tag "Disabled" nil)
                 (const :tag "Always add" t)
                 (const :tag "Visit" visit)
                 (const :tag "Ask" ask)))

(defcustom emacs-batteries-enable-which-key-mode t
  "Non-nil means enable `which-key-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-context-menu-mode t
  "Non-nil means enable `context-menu-mode'."
  :type 'boolean)

(defcustom emacs-batteries-sentence-end-double-space nil
  "Value assigned to `sentence-end-double-space'."
  :type 'boolean)

(defcustom emacs-batteries-dired-dwim-target t
  "Value assigned to `dired-dwim-target'."
  :type 'boolean)

(defcustom emacs-batteries-enable-editorconfig t
  "Non-nil means enable `editorconfig-mode'."
  :type 'boolean)

(defcustom emacs-batteries-enable-display-line-numbers-in-prog-mode t
  "Non-nil means enable `display-line-numbers-mode' in `prog-mode' buffers."
  :type 'boolean)

(defcustom emacs-batteries-enable-subword-in-prog-mode t
  "Non-nil means enable `subword-mode' in `prog-mode' buffers."
  :type 'boolean)

(defcustom emacs-batteries-indent-tabs-mode nil
  "Default value for `indent-tabs-mode'.
Non-nil means use tabs for indentation."
  :type 'boolean)

(defcustom emacs-batteries-scroll-conservatively 101
  "Value assigned to `scroll-conservatively'.
A value over 100 prevents recentering when point moves off screen."
  :type '(choice (const :tag "Use default scrolling" nil)
                 integer))

(defcustom emacs-batteries-bidi-inhibit-bpa t
  "Non-nil means inhibit the bidirectional parenthesis algorithm.
Improves display performance but may affect RTL text."
  :type 'boolean)

(defcustom emacs-batteries-gnutls-verify-error t
  "Non-nil means verify TLS certificates strictly.
May cause errors with self-signed certificates."
  :type 'boolean)

(defcustom emacs-batteries-initial-major-mode 'fundamental-mode
  "Major mode for the *scratch* buffer."
  :type 'function)

(defcustom emacs-batteries-initial-scratch-message nil
  "Initial message in the *scratch* buffer.
Nil means no message."
  :type '(choice (const :tag "No message" nil)
                 string))

(defcustom emacs-batteries-custom-file
  (locate-user-emacs-file "custom.el")
  "File for Customize-generated code.
When non-nil, redirect `custom-file' here and load it if readable.
Nil means leave `custom-file' unchanged."
  :type '(choice (const :tag "Disabled" nil)
                 file))

(defcustom emacs-batteries-word-wrap t
  "Non-nil means wrap lines at word boundaries."
  :type 'boolean)

(defcustom emacs-batteries-enable-completion-preview-in-prog-mode t
  "Non-nil means enable `completion-preview-mode' in `prog-mode' buffers."
  :type 'boolean)

(defcustom emacs-batteries-enable-visual-wrap-prefix t
  "Non-nil means enable `global-visual-wrap-prefix-mode'."
  :type 'boolean)

(defcustom emacs-batteries-split-width-threshold 170
  "Value assigned to `split-width-threshold'.
Higher values prefer vertical splits on wide monitors.
Nil means use the default."
  :type '(choice (const :tag "Use default" nil)
                 integer))

(defcustom emacs-batteries-enable-kill-ring-deindent t
  "Non-nil means enable `global-kill-ring-deindent-mode'."
  :type 'boolean)

(defcustom emacs-batteries-show-trailing-whitespace-in-prog-mode t
  "Non-nil means show trailing whitespace in `prog-mode' buffers."
  :type 'boolean)

(defcustom emacs-batteries-enable-goto-address-in-prog-mode t
  "Non-nil means enable `goto-address-prog-mode' in `prog-mode' buffers."
  :type 'boolean)

(defcustom emacs-batteries-large-file-warning-threshold (* 50 1024 1024)
  "Value assigned to `large-file-warning-threshold'.
Nil means never warn."
  :type '(choice (const :tag "Never warn" nil)
                 integer))

(defcustom emacs-batteries-defer-setup t
  "Non-nil means defer require-heavy setup to `emacs-startup-hook'.

When non-nil, functions that call `require' and enable global modes
\(savehist, saveplace, recentf, auto-revert, uniquify, which-key,
editorconfig) are deferred until after startup completes, and
feature-specific settings (dired, ediff, compile, comint, eshell,
tramp, diff-mode, gnutls, epg, url) are applied lazily via
`with-eval-after-load'.

When nil, all configuration runs synchronously inside
`emacs-batteries-setup'."
  :type 'boolean)

(defvar emacs-batteries--saved-gc-cons-threshold nil
  "Saved `gc-cons-threshold' before `emacs-batteries' startup tuning.")

(defvar emacs-batteries--saved-gc-cons-percentage nil
  "Saved `gc-cons-percentage' before `emacs-batteries' startup tuning.")

(defvar emacs-batteries--deferred-functions nil
  "List of functions deferred to `emacs-startup-hook'.")

(defun emacs-batteries--run-deferred ()
  "Run all deferred configure functions and clean up."
  (dolist (fn (nreverse emacs-batteries--deferred-functions))
    (funcall fn))
  (setq emacs-batteries--deferred-functions nil)
  (remove-hook 'emacs-startup-hook #'emacs-batteries--run-deferred))

(defun emacs-batteries--defer-or-run (function)
  "Defer FUNCTION to `emacs-startup-hook' or run it immediately.
When `emacs-batteries-defer-setup' is nil, or when startup has
already completed, FUNCTION runs immediately."
  (if (or (not emacs-batteries-defer-setup)
          after-init-time)
      (funcall function)
    (push function emacs-batteries--deferred-functions)
    (unless (memq #'emacs-batteries--run-deferred emacs-startup-hook)
      (add-hook 'emacs-startup-hook #'emacs-batteries--run-deferred))))

(defun emacs-batteries--configure-after-load (feature function)
  "Arrange to call FUNCTION after FEATURE is loaded.
If `emacs-batteries-defer-setup' is nil or FEATURE is already
loaded, call FUNCTION immediately."
  (if (or (not emacs-batteries-defer-setup)
          (featurep feature))
      (funcall function)
    (with-eval-after-load feature
      (funcall function))))

(defun emacs-batteries--state-path (path)
  "Expand PATH under `emacs-batteries-state-directory'."
  (expand-file-name path emacs-batteries-state-directory))

(defun emacs-batteries--ensure-directory (directory)
  "Create DIRECTORY when needed and return it."
  (make-directory directory t)
  directory)

(defun emacs-batteries--call-quietly (function arg)
  "Call FUNCTION with ARG while suppressing user-facing messages."
  (let ((inhibit-message t)
        (message-log-max nil))
    (funcall function arg)))

(defun emacs-batteries--ensure-auto-save-transform (autosave-directory)
  "Redirect local auto-save files into AUTOSAVE-DIRECTORY.
Existing remote-file transforms are preserved."
  (let ((entry `(".*" ,autosave-directory t)))
    (unless (member entry auto-save-file-name-transforms)
      (setq auto-save-file-name-transforms
            (append auto-save-file-name-transforms (list entry))))))

(defun emacs-batteries--set-backup-directory (backup-directory)
  "Redirect catch-all backups into BACKUP-DIRECTORY."
  (setq backup-directory-alist
        (append (assoc-delete-all "." backup-directory-alist #'equal)
                (list (cons "." backup-directory)))))

(defun emacs-batteries--utf-8-coding-system-p (coding-system)
  "Return non-nil when CODING-SYSTEM is UTF-8 based."
  (and (coding-system-p coding-system)
       (string-prefix-p "utf-8"
                        (symbol-name (coding-system-base coding-system)))))

(defun emacs-batteries--utf-8-process-coding-system-p (coding-systems)
  "Return non-nil when CODING-SYSTEMS uses UTF-8 for both process directions."
  (and (consp coding-systems)
       (emacs-batteries--utf-8-coding-system-p (car coding-systems))
       (emacs-batteries--utf-8-coding-system-p (cdr coding-systems))))

(defun emacs-batteries--apply-coding-defaults (coding-system)
  "Apply CODING-SYSTEM as the default for buffers, processes, and terminals."
  (prefer-coding-system coding-system)
  (set-default-coding-systems coding-system)
  (setq-default buffer-file-coding-system coding-system
                default-process-coding-system
                (cons coding-system coding-system))
  (unless (display-graphic-p)
    (set-terminal-coding-system coding-system)
    (set-keyboard-coding-system coding-system)))

(defun emacs-batteries--configure-coding ()
  "Prefer UTF-8 defaults when the current environment is not UTF-8 based."
  (pcase emacs-batteries-coding-system
    ('utf-8
     (let ((coding-system
            (pcase system-type
              ('windows-nt 'utf-8-dos)
              (_ 'utf-8-unix))))
       (emacs-batteries--apply-coding-defaults coding-system)
       (pcase system-type
         ('darwin
          (setq file-name-coding-system 'utf-8-hfs-unix
                default-file-name-coding-system 'utf-8-hfs-unix)
          (set-selection-coding-system 'utf-8))
         ('windows-nt
          ;; Modern Emacs on Windows already uses Unicode file-name APIs,
          ;; so keep file-name coding on the platform defaults.
          nil)
         (_
          (setq file-name-coding-system coding-system
                default-file-name-coding-system coding-system)
          (set-selection-coding-system 'utf-8)))))
    ((pred coding-system-p)
     (emacs-batteries--apply-coding-defaults emacs-batteries-coding-system)
     (setq file-name-coding-system emacs-batteries-coding-system
           default-file-name-coding-system emacs-batteries-coding-system)
     (set-selection-coding-system emacs-batteries-coding-system))
    (_
     (when emacs-batteries-prefer-utf-8
       (unless (and (emacs-batteries--utf-8-coding-system-p locale-coding-system)
                    (emacs-batteries--utf-8-process-coding-system-p
                     default-process-coding-system))
         (let ((original-file-name-coding-system file-name-coding-system)
               (original-default-file-name-coding-system
                default-file-name-coding-system))
           (prefer-coding-system 'utf-8-unix)
           (setq file-name-coding-system original-file-name-coding-system
                 default-file-name-coding-system
                 original-default-file-name-coding-system)))))))

(defun emacs-batteries--restore-startup-gc ()
  "Restore GC settings changed for startup."
  (when emacs-batteries--saved-gc-cons-threshold
    (setq gc-cons-threshold emacs-batteries--saved-gc-cons-threshold
          emacs-batteries--saved-gc-cons-threshold nil))
  (when emacs-batteries--saved-gc-cons-percentage
    (setq gc-cons-percentage emacs-batteries--saved-gc-cons-percentage
          emacs-batteries--saved-gc-cons-percentage nil))
  (remove-hook 'emacs-startup-hook #'emacs-batteries--restore-startup-gc)
  (garbage-collect))

(defun emacs-batteries--configure-startup-gc ()
  "Reduce GC frequency during startup, then restore the original values."
  (when (and emacs-batteries-startup-gc-cons-threshold
             (not after-init-time)
             (null emacs-batteries--saved-gc-cons-threshold))
    (setq emacs-batteries--saved-gc-cons-threshold gc-cons-threshold
          emacs-batteries--saved-gc-cons-percentage gc-cons-percentage
          gc-cons-threshold
          (max gc-cons-threshold emacs-batteries-startup-gc-cons-threshold))
    (add-hook 'emacs-startup-hook #'emacs-batteries--restore-startup-gc)))

(defun emacs-batteries--configure-savehist ()
  "Persist minibuffer history without a periodic timer."
  (require 'savehist)
  (setq history-length emacs-batteries-history-length
        history-delete-duplicates t
        savehist-file (emacs-batteries--state-path "savehist.eld")
        savehist-autosave-interval nil
        savehist-additional-variables
        (cl-union savehist-additional-variables
                  '(search-ring regexp-search-ring compile-command)))
  (when (timerp savehist-timer)
    (cancel-timer savehist-timer)
    (setq savehist-timer nil))
  (savehist-mode 1))

(defun emacs-batteries--configure-saveplace ()
  "Persist point positions in visited files."
  (require 'saveplace)
  (setq save-place-file (emacs-batteries--state-path "saveplace.eld"))
  (save-place-mode 1))

(defun emacs-batteries--configure-minibuffer ()
  "Enable conservative minibuffer and command-loop defaults."
  (setq enable-recursive-minibuffers
        emacs-batteries-enable-recursive-minibuffers
        read-extended-command-predicate
        emacs-batteries-read-extended-command-predicate
        confirm-kill-emacs
        emacs-batteries-confirm-kill-emacs
        resize-mini-windows 'grow-only)
  (when (boundp 'read-minibuffer-restore-windows)
    (setq read-minibuffer-restore-windows nil))
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)
  (emacs-batteries--call-quietly
   #'minibuffer-depth-indicate-mode
   (if emacs-batteries-enable-minibuffer-depth-indicate 1 -1))
  (emacs-batteries--call-quietly
   #'minibuffer-electric-default-mode
   (if emacs-batteries-enable-minibuffer-electric-default 1 -1)))

(defun emacs-batteries--configure-window-behavior ()
  "Enable conservative window and help display defaults."
  (setq switch-to-buffer-obey-display-actions
        emacs-batteries-switch-to-buffer-obey-display-actions
        help-window-select emacs-batteries-help-window-select)
  (when (boundp 'help-window-keep-selected)
    (setq help-window-keep-selected t))
  (when (boundp 'switch-to-buffer-in-dedicated-window)
    (setq switch-to-buffer-in-dedicated-window 'pop))
  (when emacs-batteries-split-width-threshold
    (setq split-width-threshold emacs-batteries-split-width-threshold))
  (emacs-batteries--call-quietly
   #'winner-mode
   (if emacs-batteries-enable-winner-mode 1 -1)))

(defun emacs-batteries--configure-recentf ()
  "Persist recently visited files."
  (if emacs-batteries-enable-recentf
      (progn
        (require 'recentf)
        (setq recentf-save-file (emacs-batteries--state-path "recentf.eld")
              recentf-max-saved-items emacs-batteries-recentf-max-saved-items)
        (emacs-batteries--call-quietly #'recentf-mode 1))
    (when (featurep 'recentf)
      (emacs-batteries--call-quietly #'recentf-mode -1))))

(defun emacs-batteries--configure-file-safety ()
  "Enable conservative backup and auto-save defaults."
  (let ((backup-directory
         (emacs-batteries--ensure-directory
          (emacs-batteries--state-path "backup/")))
        (autosave-directory
         (emacs-batteries--ensure-directory
          (emacs-batteries--state-path "auto-save/"))))
    (setq make-backup-files t
          version-control t
          delete-old-versions t
          kept-new-versions emacs-batteries-kept-new-backups
          kept-old-versions emacs-batteries-kept-old-backups
          backup-by-copying emacs-batteries-backup-by-copying
          backup-by-copying-when-linked t
          create-lockfiles t
          delete-by-moving-to-trash t
          auto-save-default t
          auto-save-no-message t
          auto-save-include-big-deletions t
          auto-save-list-file-prefix
          (expand-file-name ".saves-" autosave-directory)
          find-file-visit-truename t
          find-file-suppress-same-file-warnings t
          confirm-nonexistent-file-or-buffer nil
          vc-follow-symlinks t
          bookmark-save-flag 1
          save-abbrevs 'silently
          kill-buffer-delete-auto-save-files t)
    (emacs-batteries--set-backup-directory backup-directory)
    (emacs-batteries--ensure-auto-save-transform autosave-directory))
  (when (boundp 'remote-file-name-inhibit-delete-by-moving-to-trash)
    (setq remote-file-name-inhibit-delete-by-moving-to-trash t))
  (when (boundp 'remote-file-name-inhibit-auto-save)
    (setq remote-file-name-inhibit-auto-save t))
  (add-hook 'after-save-hook
            #'executable-make-buffer-file-executable-if-script-p)
  (when emacs-batteries-custom-file
    (setq custom-file emacs-batteries-custom-file)
    (when (file-readable-p custom-file)
      (load custom-file 'noerror 'nomessage))))

(defun emacs-batteries--xterm-like-terminal-p ()
  "Return non-nil when the current terminal supports xterm-style init."
  (memq (terminal-parameter nil 'terminal-initted)
        '(terminal-init-xterm terminal-init-screen terminal-init-tmux)))

(defun emacs-batteries--enable-terminal-clipboard-copy ()
  "Enable OSC 52 clipboard copy on supported text terminals.

This only enables kill/copy to the terminal's clipboard bridge.
Clipboard paste is intentionally left unchanged to avoid query timeouts."
  (when (and (not (display-graphic-p))
             (emacs-batteries--xterm-like-terminal-p))
    (require 'term/xterm)
    (xterm--init-activate-set-selection)))

(defun emacs-batteries--configure-copy ()
  "Enable conservative clipboard and kill-ring defaults."
  (setq kill-do-not-save-duplicates t
        save-interprogram-paste-before-kill
        emacs-batteries-save-interprogram-paste-before-kill)
  (add-hook 'tty-setup-hook #'emacs-batteries--enable-terminal-clipboard-copy)
  (emacs-batteries--enable-terminal-clipboard-copy))

(defun emacs-batteries--configure-auto-revert ()
  "Enable conservative auto-revert defaults."
  (if emacs-batteries-enable-auto-revert
      (progn
        (require 'autorevert)
        (setq global-auto-revert-non-file-buffers
              emacs-batteries-auto-revert-non-file-buffers)
        (global-auto-revert-mode 1))
    (when (featurep 'autorevert)
      (global-auto-revert-mode -1))))

(defun emacs-batteries--configure-performance ()
  "Enable conservative built-in performance defaults."
  (setq fast-but-imprecise-scrolling
        emacs-batteries-fast-but-imprecise-scrolling
        redisplay-skip-fontification-on-input
        emacs-batteries-redisplay-skip-fontification-on-input
        cursor-in-non-selected-windows nil
        vc-handled-backends '(Git)
        vc-git-print-log-follow t
        vc-git-diff-switches '("--histogram")
        use-dialog-box emacs-batteries-use-dialog-box
        use-file-dialog nil
        ring-bell-function emacs-batteries-ring-bell-function
        load-prefer-newer t
        scroll-preserve-screen-position t
        auto-window-vscroll nil
        inhibit-compacting-font-caches t
        window-resize-pixelwise t
        frame-resize-pixelwise t
        jit-lock-defer-time 0.25
        process-adaptive-read-buffering nil
        next-line-add-newlines nil
        blink-matching-paren nil
        mouse-wheel-tilt-scroll t)
  (when emacs-batteries-scroll-conservatively
    (setq scroll-conservatively emacs-batteries-scroll-conservatively
          scroll-error-top-bottom t
          hscroll-margin 2
          hscroll-step 1))
  (when emacs-batteries-bidi-inhibit-bpa
    (setq bidi-inhibit-bpa t)
    (setq-default bidi-paragraph-direction 'left-to-right))
  (when (boundp 'native-comp-async-report-warnings-errors)
    (setq native-comp-async-report-warnings-errors 'silent))
  (when (boundp 'native-compile-prune-cache)
    (setq native-compile-prune-cache t))
  (when (boundp 'global-text-scale-adjust-resizes-frames)
    (setq global-text-scale-adjust-resizes-frames nil))
  (when (boundp 'x-underline-at-descent-line)
    (setq x-underline-at-descent-line t))
  (when (boundp 'proced-enable-color-flag)
    (setq proced-enable-color-flag t))
  (blink-cursor-mode -1)
  (when emacs-batteries-enable-show-paren
    (setq show-paren-delay 0
          show-paren-when-point-inside-paren t
          show-paren-when-point-in-periphery t))
  (show-paren-mode (if emacs-batteries-enable-show-paren 1 -1))
  (if emacs-batteries-enable-so-long
      (global-so-long-mode 1)
    (when (featurep 'so-long)
      (global-so-long-mode -1)))
  (pixel-scroll-precision-mode
   (if emacs-batteries-enable-pixel-scroll-precision 1 -1)))

(defun emacs-batteries--maybe-enable-electric-pair ()
  "Enable `electric-pair-local-mode' in programming buffers when configured."
  (electric-pair-local-mode
   (if (and emacs-batteries-enable-electric-pair-in-prog-mode
            (derived-mode-p 'prog-mode))
       1
     -1)))

(defun emacs-batteries--maybe-enable-display-line-numbers ()
  "Enable `display-line-numbers-mode' in programming buffers when configured."
  (display-line-numbers-mode
   (if (and emacs-batteries-enable-display-line-numbers-in-prog-mode
            (derived-mode-p 'prog-mode))
       1
     -1)))

(defun emacs-batteries--maybe-enable-subword ()
  "Enable `subword-mode' in programming buffers when configured."
  (subword-mode
   (if (and emacs-batteries-enable-subword-in-prog-mode
            (derived-mode-p 'prog-mode))
       1
     -1)))

(defun emacs-batteries--configure-editing ()
  "Enable conservative editing defaults."
  (setq kill-whole-line t
        read-buffer-completion-ignore-case t
        read-file-name-completion-ignore-case t
        completion-ignore-case t
        completions-detailed emacs-batteries-completions-detailed
        tab-always-indent emacs-batteries-tab-always-indent
        tab-first-completion 'word-or-paren-or-punct
        completion-cycle-threshold
        emacs-batteries-completion-cycle-threshold
        require-final-newline emacs-batteries-require-final-newline
        use-short-answers emacs-batteries-use-short-answers
        sentence-end-double-space emacs-batteries-sentence-end-double-space
        set-mark-command-repeat-pop t
        mouse-yank-at-point t
        truncate-string-ellipsis "\u2026"
        comment-multi-line t
        comment-empty-lines t
        undo-limit 160000
        undo-strong-limit 240000)
  (when (boundp 'text-mode-ispell-word-completion)
    (setq text-mode-ispell-word-completion nil))
  (when (boundp 'completions-sort)
    (setq completions-sort 'historical))
  (setq-default indent-tabs-mode emacs-batteries-indent-tabs-mode
                word-wrap emacs-batteries-word-wrap)
  (delete-selection-mode (if emacs-batteries-enable-delete-selection 1 -1))
  (emacs-batteries--call-quietly
   #'repeat-mode
   (if emacs-batteries-enable-repeat-mode 1 -1))
  (if emacs-batteries-enable-electric-pair-in-prog-mode
      (progn
        (add-hook 'after-change-major-mode-hook
                  #'emacs-batteries--maybe-enable-electric-pair)
        (emacs-batteries--maybe-enable-electric-pair))
    (remove-hook 'after-change-major-mode-hook
                 #'emacs-batteries--maybe-enable-electric-pair)
    (emacs-batteries--maybe-enable-electric-pair)))

(defun emacs-batteries--configure-display ()
  "Enable conservative display defaults."
  (setq initial-major-mode emacs-batteries-initial-major-mode
        initial-scratch-message emacs-batteries-initial-scratch-message
        display-time-default-load-average nil
        imenu-auto-rescan t
        custom-buffer-done-kill t
        large-file-warning-threshold
        emacs-batteries-large-file-warning-threshold
        eldoc-echo-area-use-multiline-p nil
        display-raw-bytes-as-hex t)
  (when (boundp 'what-cursor-show-names)
    (setq what-cursor-show-names t))
  (when (boundp 'completions-header-format)
    (setq completions-header-format nil))
  (when (boundp 'help-enable-variable-value-editing)
    (setq help-enable-variable-value-editing t))
  (when (boundp 'register-use-preview)
    (setq register-use-preview t))
  (when (boundp 'tab-bar-show)
    (setq tab-bar-show 1))
  (when (boundp 'outline-minor-mode-cycle)
    (setq outline-minor-mode-cycle t))
  (when (boundp 'project-mode-line)
    (setq project-mode-line t))
  (when (boundp 'describe-bindings-outline)
    (setq describe-bindings-outline t))
  (when (boundp 'imenu-flatten)
    (setq imenu-flatten 'prefix))
  (if emacs-batteries-enable-visual-wrap-prefix
      (when (fboundp 'global-visual-wrap-prefix-mode)
        (global-visual-wrap-prefix-mode 1))
    (when (fboundp 'global-visual-wrap-prefix-mode)
      (global-visual-wrap-prefix-mode -1)))
  (column-number-mode (if emacs-batteries-enable-column-number-mode 1 -1))
  (context-menu-mode
   (if emacs-batteries-enable-context-menu-mode 1 -1))
  (emacs-batteries--defer-or-run
   #'emacs-batteries--configure-display-deferred))

(defun emacs-batteries--configure-display-deferred ()
  "Enable display features that require loading packages."
  (when emacs-batteries-enable-uniquify
    (require 'uniquify)
    (setq uniquify-buffer-name-style
          emacs-batteries-uniquify-buffer-name-style))
  (if emacs-batteries-enable-which-key-mode
      (progn
        (require 'which-key)
        (which-key-mode 1))
    (when (featurep 'which-key)
      (which-key-mode -1)))
  (if emacs-batteries-enable-editorconfig
      (progn
        (require 'editorconfig)
        (editorconfig-mode 1))
    (when (featurep 'editorconfig)
      (editorconfig-mode -1))))

(defun emacs-batteries--maybe-show-trailing-whitespace ()
  "Show trailing whitespace in programming buffers when configured."
  (setq show-trailing-whitespace
        (and emacs-batteries-show-trailing-whitespace-in-prog-mode
             (derived-mode-p 'prog-mode))))

(defun emacs-batteries--maybe-enable-goto-address ()
  "Enable `goto-address-prog-mode' in programming buffers when configured."
  (when (and emacs-batteries-enable-goto-address-in-prog-mode
             (derived-mode-p 'prog-mode))
    (goto-address-prog-mode)))

(defun emacs-batteries--maybe-enable-completion-preview ()
  "Enable `completion-preview-mode' in programming buffers when configured."
  (when (fboundp 'completion-preview-mode)
    (completion-preview-mode
     (if (and emacs-batteries-enable-completion-preview-in-prog-mode
              (derived-mode-p 'prog-mode))
         1
       -1))))

(defun emacs-batteries--configure-prog-mode ()
  "Enable prog-mode specific hooks."
  (if emacs-batteries-show-trailing-whitespace-in-prog-mode
      (progn
        (add-hook 'after-change-major-mode-hook
                  #'emacs-batteries--maybe-show-trailing-whitespace)
        (emacs-batteries--maybe-show-trailing-whitespace))
    (remove-hook 'after-change-major-mode-hook
                 #'emacs-batteries--maybe-show-trailing-whitespace)
    (emacs-batteries--maybe-show-trailing-whitespace))
  (if emacs-batteries-enable-goto-address-in-prog-mode
      (add-hook 'prog-mode-hook #'goto-address-prog-mode)
    (remove-hook 'prog-mode-hook #'goto-address-prog-mode))
  (if emacs-batteries-enable-completion-preview-in-prog-mode
      (progn
        (add-hook 'after-change-major-mode-hook
                  #'emacs-batteries--maybe-enable-completion-preview)
        (emacs-batteries--maybe-enable-completion-preview))
    (remove-hook 'after-change-major-mode-hook
                 #'emacs-batteries--maybe-enable-completion-preview)
    (emacs-batteries--maybe-enable-completion-preview))
  (if emacs-batteries-enable-display-line-numbers-in-prog-mode
      (progn
        (add-hook 'after-change-major-mode-hook
                  #'emacs-batteries--maybe-enable-display-line-numbers)
        (emacs-batteries--maybe-enable-display-line-numbers))
    (remove-hook 'after-change-major-mode-hook
                 #'emacs-batteries--maybe-enable-display-line-numbers)
    (emacs-batteries--maybe-enable-display-line-numbers))
  (if emacs-batteries-enable-subword-in-prog-mode
      (progn
        (add-hook 'after-change-major-mode-hook
                  #'emacs-batteries--maybe-enable-subword)
        (emacs-batteries--maybe-enable-subword))
    (remove-hook 'after-change-major-mode-hook
                 #'emacs-batteries--maybe-enable-subword)
    (emacs-batteries--maybe-enable-subword)))

(defun emacs-batteries--configure-search ()
  "Enable conservative search defaults."
  (setq isearch-lazy-count emacs-batteries-enable-isearch-lazy-count
        lazy-count-prefix-format "(%s/%s) "
        lazy-count-suffix-format nil
        lazy-highlight-initial-delay 0)
  (setq ffap-machine-p-known 'reject
        xref-show-definitions-function #'xref-show-definitions-completing-read
        apropos-do-all t)
  (when (boundp 'xref-history-storage)
    (setq xref-history-storage 'xref-window-local-history))
  (when (boundp 'find-library-include-other-files)
    (setq find-library-include-other-files nil))
  (setq isearch-allow-scroll t)
  (when (boundp 'isearch-wrap-pause)
    (setq isearch-wrap-pause 'no))
  (when (boundp 'lazy-highlight-buffer)
    (setq lazy-highlight-buffer t))
  (when (boundp 'grep-use-headings)
    (setq grep-use-headings t)))

(defun emacs-batteries--configure-dired ()
  "Enable conservative Dired defaults."
  (setq dired-dwim-target emacs-batteries-dired-dwim-target
        dired-recursive-copies 'always
        dired-recursive-deletes 'top
        dired-create-destination-dirs 'ask
        dired-kill-when-opening-new-dired-buffer t
        dired-listing-switches "-alh"
        dired-auto-revert-buffer t
        dired-deletion-confirmer #'y-or-n-p)
  (when (boundp 'dired-movement-style)
    (setq dired-movement-style 'bounded))
  (when (boundp 'dired-vc-rename-file)
    (setq dired-vc-rename-file t)))

(defun emacs-batteries--configure-ediff ()
  "Enable conservative Ediff defaults."
  (setq ediff-window-setup-function #'ediff-setup-windows-plain
        ediff-split-window-function #'split-window-horizontally
        ediff-keep-variants nil))

(defun emacs-batteries--configure-compilation ()
  "Enable conservative compilation defaults."
  (setq compilation-scroll-output 'first-error
        compilation-always-kill t
        compilation-ask-about-save nil)
  (when (boundp 'compilation-max-output-line-length)
    (setq compilation-max-output-line-length nil)))

(defun emacs-batteries--configure-security ()
  "Enable conservative TLS and security defaults."
  (when emacs-batteries-gnutls-verify-error
    (setq gnutls-verify-error t
          gnutls-min-prime-bits 3072))
  (setq epg-pinentry-mode 'loopback
        url-privacy-level 'high))

(defun emacs-batteries--configure-eval ()
  "Enable conservative eval-expression defaults."
  (setq eval-expression-print-length nil
        eval-expression-print-level nil))

(defun emacs-batteries--configure-shell ()
  "Enable conservative shell and comint defaults."
  (setq comint-prompt-read-only t
        comint-scroll-to-bottom-on-input 'this
        tramp-verbose 1)
  (when (boundp 'eshell-history-append)
    (setq eshell-history-append t))
  (when (boundp 'shell-kill-buffer-on-exit)
    (setq shell-kill-buffer-on-exit t)))

(defun emacs-batteries--configure-shell-comint ()
  "Configure comint defaults."
  (setq comint-prompt-read-only t
        comint-scroll-to-bottom-on-input 'this))

(defun emacs-batteries--configure-shell-eshell ()
  "Configure eshell defaults."
  (when (boundp 'eshell-history-append)
    (setq eshell-history-append t)))

(defun emacs-batteries--configure-shell-tramp ()
  "Configure tramp defaults."
  (setq tramp-verbose 1)
  (when (boundp 'shell-kill-buffer-on-exit)
    (setq shell-kill-buffer-on-exit t)))

(defun emacs-batteries--configure-security-gnutls ()
  "Configure GnuTLS defaults."
  (when emacs-batteries-gnutls-verify-error
    (setq gnutls-verify-error t
          gnutls-min-prime-bits 3072)))

(defun emacs-batteries--configure-security-epg ()
  "Configure EPG defaults."
  (setq epg-pinentry-mode 'loopback))

(defun emacs-batteries--configure-security-url ()
  "Configure URL privacy defaults."
  (setq url-privacy-level 'high))

(defun emacs-batteries--configure-diff ()
  "Enable conservative diff defaults."
  (setq diff-refine t)
  (if emacs-batteries-enable-kill-ring-deindent
      (when (fboundp 'global-kill-ring-deindent-mode)
        (global-kill-ring-deindent-mode 1))
    (when (fboundp 'global-kill-ring-deindent-mode)
      (global-kill-ring-deindent-mode -1))))

(defun emacs-batteries--configure-diff-variables ()
  "Configure diff-mode variables."
  (setq diff-refine t))

(defun emacs-batteries--configure-diff-global ()
  "Configure global kill-ring-deindent mode."
  (if emacs-batteries-enable-kill-ring-deindent
      (when (fboundp 'global-kill-ring-deindent-mode)
        (global-kill-ring-deindent-mode 1))
    (when (fboundp 'global-kill-ring-deindent-mode)
      (global-kill-ring-deindent-mode -1))))

(defun emacs-batteries--enable-disabled-commands ()
  "Re-enable commonly disabled commands."
  (dolist (cmd '(narrow-to-region upcase-region downcase-region
                 narrow-to-page scroll-left dired-find-alternate-file
                 erase-buffer set-goal-column list-timers list-threads))
    (put cmd 'disabled nil)))

;;;###autoload
(defun emacs-batteries-setup ()
  "Enable conservative built-in defaults.

Call this early from the init file.

When `emacs-batteries-defer-setup' is non-nil, require-heavy
configuration is deferred to `emacs-startup-hook' and
feature-specific settings are applied lazily via
`with-eval-after-load'."
  (interactive)
  ;; Reset deferred list for idempotency.
  (setq emacs-batteries--deferred-functions nil)

  ;; Phase 1: Immediate — no require, needed before first frame/input.
  (emacs-batteries--configure-startup-gc)
  (emacs-batteries--configure-coding)
  (emacs-batteries--configure-minibuffer)
  (emacs-batteries--configure-window-behavior)
  (emacs-batteries--configure-file-safety)
  (emacs-batteries--configure-performance)
  (emacs-batteries--configure-editing)
  (emacs-batteries--configure-copy)
  (emacs-batteries--configure-display)
  (emacs-batteries--configure-search)
  (emacs-batteries--configure-eval)
  (emacs-batteries--configure-prog-mode)
  (emacs-batteries--enable-disabled-commands)

  ;; Phase 2: Deferred — require + mode activation.
  (emacs-batteries--defer-or-run #'emacs-batteries--configure-savehist)
  (emacs-batteries--defer-or-run #'emacs-batteries--configure-saveplace)
  (emacs-batteries--defer-or-run #'emacs-batteries--configure-recentf)
  (emacs-batteries--defer-or-run #'emacs-batteries--configure-auto-revert)

  ;; Phase 3: After-load — feature-specific variable-only settings.
  (emacs-batteries--configure-after-load 'dired
    #'emacs-batteries--configure-dired)
  (emacs-batteries--configure-after-load 'ediff
    #'emacs-batteries--configure-ediff)
  (emacs-batteries--configure-after-load 'compile
    #'emacs-batteries--configure-compilation)
  (emacs-batteries--configure-after-load 'comint
    #'emacs-batteries--configure-shell-comint)
  (emacs-batteries--configure-after-load 'esh-mode
    #'emacs-batteries--configure-shell-eshell)
  (emacs-batteries--configure-after-load 'tramp
    #'emacs-batteries--configure-shell-tramp)
  (emacs-batteries--configure-after-load 'diff-mode
    #'emacs-batteries--configure-diff-variables)
  (emacs-batteries--configure-after-load 'gnutls
    #'emacs-batteries--configure-security-gnutls)
  (emacs-batteries--configure-after-load 'epg
    #'emacs-batteries--configure-security-epg)
  (emacs-batteries--configure-after-load 'url
    #'emacs-batteries--configure-security-url)
  ;; kill-ring-deindent is a global mode — keep immediate.
  (emacs-batteries--configure-diff-global))

(provide 'emacs-batteries)

;;; emacs-batteries.el ends here
