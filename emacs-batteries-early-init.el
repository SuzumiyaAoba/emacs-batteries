;;; emacs-batteries-early-init.el --- Early-init defaults for emacs-batteries -*- lexical-binding: t; -*-

;; Copyright (C) 2026 SuzumiyaAoba
;; Author: SuzumiyaAoba
;; SPDX-License-Identifier: MIT

;;; Commentary:

;; Early-init specific defaults that must be applied before the regular init
;; file is read, such as disabling package.el auto-activation.

;;; Code:

(defvar package-enable-at-startup)
(defvar emacs-startup-hook)
(defvar after-init-time)
(defvar frame-inhibit-implied-resize)
(defvar file-name-handler-alist)
(defvar default-frame-alist)
(defvar initial-frame-alist)
(defvar inhibit-startup-screen)
(defvar inhibit-default-init)
(defvar read-process-output-max)

(defvar emacs-batteries-startup-gc-cons-threshold (* 64 1024 1024)
  "Temporary `gc-cons-threshold' used during startup.")

(defvar emacs-batteries-startup-frame-inhibit-implied-resize t
  "Non-nil means inhibit implicit frame resizing during startup and afterwards.")

(defvar emacs-batteries-startup-optimize-file-name-handlers t
  "Non-nil means temporarily disable TRAMP file-name handlers during startup.")

(defvar emacs-batteries-startup-hide-gui-chrome t
  "Non-nil means hide common GUI chrome from the first frame onward.")

(defvar emacs-batteries-startup-inhibit-startup-screen t
  "Non-nil means suppress the default startup screen.")

(defvar emacs-batteries-startup-inhibit-default-init t
  "Non-nil means suppress loading the default initialization library.")

(defvar emacs-batteries-startup-read-process-output-max (* 1024 1024)
  "Minimum `read-process-output-max' to use during startup and runtime.")

(defvar emacs-batteries--saved-gc-cons-threshold nil
  "Saved `gc-cons-threshold' before `emacs-batteries' startup tuning.")

(defvar emacs-batteries--saved-gc-cons-percentage nil
  "Saved `gc-cons-percentage' before `emacs-batteries' startup tuning.")

(defvar emacs-batteries--saved-file-name-handler-alist nil
  "Saved `file-name-handler-alist' before startup optimization.")

(defun emacs-batteries--tramp-handler-p (handler)
  "Return non-nil when HANDLER is TRAMP-related."
  (and (symbolp handler)
       (string-prefix-p "tramp" (symbol-name handler))))

(defun emacs-batteries--restore-startup-file-name-handlers ()
  "Restore file-name handlers changed for startup."
  (when emacs-batteries--saved-file-name-handler-alist
    (setq file-name-handler-alist emacs-batteries--saved-file-name-handler-alist
          emacs-batteries--saved-file-name-handler-alist nil))
  (remove-hook 'emacs-startup-hook
               #'emacs-batteries--restore-startup-file-name-handlers))

(defun emacs-batteries--configure-startup-file-name-handlers ()
  "Temporarily remove TRAMP-related file-name handlers during startup."
  (when (and emacs-batteries-startup-optimize-file-name-handlers
             (null emacs-batteries--saved-file-name-handler-alist))
    (setq emacs-batteries--saved-file-name-handler-alist
          file-name-handler-alist
          file-name-handler-alist
          (let (kept)
            (dolist (entry file-name-handler-alist (nreverse kept))
              (unless (emacs-batteries--tramp-handler-p (cdr entry))
                (push entry kept)))))
    (add-hook 'emacs-startup-hook
              #'emacs-batteries--restore-startup-file-name-handlers)))

(defun emacs-batteries--set-frame-parameter-default (parameter value)
  "Set frame PARAMETER default VALUE for initial and future frames."
  (setq default-frame-alist
        (cons (cons parameter value)
              (assq-delete-all parameter default-frame-alist))
        initial-frame-alist
        (cons (cons parameter value)
              (assq-delete-all parameter initial-frame-alist))))

(defun emacs-batteries--configure-startup-gui ()
  "Hide common GUI chrome before frames are created."
  (when emacs-batteries-startup-hide-gui-chrome
    (emacs-batteries--set-frame-parameter-default 'menu-bar-lines 0)
    (emacs-batteries--set-frame-parameter-default 'tool-bar-lines 0)
    (emacs-batteries--set-frame-parameter-default 'vertical-scroll-bars nil)
    (emacs-batteries--set-frame-parameter-default 'horizontal-scroll-bars nil)))

(defun emacs-batteries--configure-startup-io ()
  "Increase process read size when supported."
  (when (and (boundp 'read-process-output-max)
             emacs-batteries-startup-read-process-output-max)
    (setq read-process-output-max
          (max read-process-output-max
               emacs-batteries-startup-read-process-output-max))))

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

(defun emacs-batteries-early-init-setup ()
  "Enable `emacs-batteries' defaults that must run from early-init."
  (setq package-enable-at-startup nil)
  (when emacs-batteries-startup-inhibit-default-init
    (setq inhibit-default-init t))
  (when emacs-batteries-startup-inhibit-startup-screen
    (setq inhibit-startup-screen t))
  (emacs-batteries--configure-startup-gui)
  (emacs-batteries--configure-startup-io)
  (when emacs-batteries-startup-frame-inhibit-implied-resize
    (setq frame-inhibit-implied-resize t))
  (emacs-batteries--configure-startup-file-name-handlers)
  (when (and emacs-batteries-startup-gc-cons-threshold
             (not after-init-time)
             (null emacs-batteries--saved-gc-cons-threshold))
    (setq emacs-batteries--saved-gc-cons-threshold gc-cons-threshold
          emacs-batteries--saved-gc-cons-percentage gc-cons-percentage
          gc-cons-threshold
          (max gc-cons-threshold emacs-batteries-startup-gc-cons-threshold))
    (add-hook 'emacs-startup-hook #'emacs-batteries--restore-startup-gc)))

(emacs-batteries-early-init-setup)

(provide 'emacs-batteries-early-init)

;;; emacs-batteries-early-init.el ends here
