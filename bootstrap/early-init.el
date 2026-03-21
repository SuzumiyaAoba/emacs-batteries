;;; early-init.el --- Bootstrap emacs-batteries early-init helper -*- lexical-binding: t; -*-

;; Copy this file to ~/.emacs.d/early-init.el and adjust variables below if
;; needed.  The cached helper is loaded locally on normal startups; download
;; and optional checksum verification only happen when the cache is missing or
;; when refresh is explicitly enabled.

;;; Code:

(defvar byte-compile-current-file)

(defvar emacs-batteries-bootstrap-cache-file
  (locate-user-emacs-file "bootstrap/emacs-batteries-early-init.el")
  "Cached local copy of `emacs-batteries-early-init.el'.")

(defvar emacs-batteries-bootstrap-remote-url
  "https://raw.githubusercontent.com/SuzumiyaAoba/emacs-batteries/main/emacs-batteries-early-init.el"
  "Raw URL used to download `emacs-batteries-early-init.el'.")

(defvar emacs-batteries-bootstrap-refresh-interval nil
  "Seconds after which the cached helper should be refreshed.

Nil means never refresh automatically."
  )

(defvar emacs-batteries-bootstrap-checksum nil
  "Optional expected checksum of the downloaded helper file.

Nil disables checksum verification.  Verification is only performed
after download or refresh, so cached startup remains fast."
  )

(defvar emacs-batteries-bootstrap-checksum-algorithm 'sha256
  "Hash algorithm used with `emacs-batteries-bootstrap-checksum'.")

(defvar emacs-batteries-bootstrap-fail-open t
  "Non-nil means keep using the cached helper if refresh fails.")

(defun emacs-batteries-bootstrap--refresh-due-p (file)
  "Return non-nil when FILE should be refreshed."
  (and emacs-batteries-bootstrap-refresh-interval
       (file-exists-p file)
       (let ((modified-at (file-attribute-modification-time
                           (file-attributes file))))
         (> (float-time (time-subtract (current-time) modified-at))
            emacs-batteries-bootstrap-refresh-interval))))

(defun emacs-batteries-bootstrap--verify-file (file)
  "Verify FILE against the configured checksum."
  (when emacs-batteries-bootstrap-checksum
    (let ((actual
           (secure-hash emacs-batteries-bootstrap-checksum-algorithm file)))
      (unless (string-equal actual emacs-batteries-bootstrap-checksum)
        (error "emacs-batteries bootstrap checksum mismatch for %s" file)))))

(defun emacs-batteries-bootstrap--download-into (destination)
  "Download the helper into DESTINATION."
  (require 'url-handlers)
  (url-copy-file emacs-batteries-bootstrap-remote-url destination t t))

(defun emacs-batteries-bootstrap--refresh-cache (cache-file)
  "Download and atomically replace CACHE-FILE."
  (let ((temporary-file (make-temp-file "emacs-batteries-early-init-" nil ".el")))
    (unwind-protect
        (progn
          (emacs-batteries-bootstrap--download-into temporary-file)
          (emacs-batteries-bootstrap--verify-file temporary-file)
          (make-directory (file-name-directory cache-file) t)
          (rename-file temporary-file cache-file t))
      (ignore-errors (delete-file temporary-file)))))

(defun emacs-batteries-bootstrap--ensure-cache ()
  "Ensure the helper exists locally and return its path."
  (let ((cache-file emacs-batteries-bootstrap-cache-file))
    (cond
     ((not (file-exists-p cache-file))
      (emacs-batteries-bootstrap--refresh-cache cache-file))
     ((emacs-batteries-bootstrap--refresh-due-p cache-file)
      (condition-case err
          (emacs-batteries-bootstrap--refresh-cache cache-file)
        (error
         (unless emacs-batteries-bootstrap-fail-open
           (signal (car err) (cdr err)))))))
    cache-file))

(defun emacs-batteries-bootstrap-load-early-init ()
  "Load the cached `emacs-batteries' early-init helper."
  (load (emacs-batteries-bootstrap--ensure-cache) nil 'nomessage))

(unless (bound-and-true-p byte-compile-current-file)
  (emacs-batteries-bootstrap-load-early-init))

;;; early-init.el ends here
