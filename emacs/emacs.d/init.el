;; Setup environment and package manager
;; found a lot of this configuration documented on
;; https://gitlab.com/buildfunthings/emacs-config/blob/master/loader.org

;; Environment
(setenv "PATH" (concat "/usr/local/bin:" (getenv "PATH")))
(push "/usr/local/bin" exec-path)

(require 'package)

;; https://emacs.stackexchange.com/questions/68288/error-retrieving-https-elpa-gnu-org-packages-archive-contents
(when (and (equal emacs-version "27.2")
           (eql system-type 'darwin))
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"))

(defvar gnu          '("gnu"          . "https://elpa.gnu.org/packages/"))
(defvar melpa        '("melpa"        . "https://melpa.org/packages/"))
(defvar melpa-stable '("melpa-stable" . "https://stable.melpa.org/packages/"))
(defvar org-elpa     '("org"          . "http://orgmode.org/elpa/"))


;; Add package repos
;; Default archive setting is http, so reset and then set to https
(setq package-archives nil)
(add-to-list 'package-archives melpa-stable t)
(add-to-list 'package-archives melpa        t)
(add-to-list 'package-archives gnu          t)
(add-to-list 'package-archives org-elpa     t)

(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(message "%s" "Ralph: Delete old config.el")

;; The function org-babel-load-file will create and load a new config.el
;; only when the config.org file is newer than the config.el file.
;; because I'm using dotfiles and creating a symlink to my config.org, the
;; symlink won't be updated when I change my original config.org!
;; Since I seldomly restart my emacs, this is the best solution for me:

(defvar-local config-file (concat user-emacs-directory "config.el"))
(when (file-exists-p config-file) (delete-file config-file))

(message "%s" "Ralph: Start loading config file.")

;;; Load the config to configure the rest of the packages
(org-babel-load-file (concat user-emacs-directory "config.org"))

(message "%s" "Ralph: End loading config file.")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" default))
 '(package-selected-packages
   '(exec-path-from-shell flycheck emmet-mode web-mode expand-region fireplace which-key yasnippet rainbow-delimiters highlight-parentheses paredit-everywhere paredit company markdown-mode magit engine-mode smex org-bullets solarized-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
