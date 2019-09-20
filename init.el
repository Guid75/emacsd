(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'deeper-blue t)

; Enlève la barre de menu
(menu-bar-mode -1)
; Enlève la barre d'outil
(tool-bar-mode -1)
; Enlève la barre de défilement
(scroll-bar-mode -1)

; Mettre un titre aux fenêtres
(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

(setq-default c-basic-offset 4
              tab-width 4
			  indent-tabs-mode t)

(setq inhibit-startup-screen t)

(ido-mode t)
(require 'linum)
(global-linum-mode)

; Afficher le numéro de colonne
(column-number-mode 1)
(line-number-mode 1)

;; full screen toggle using command+[RET]
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen (if (frame-parameter nil 'fullscreen)
					   nil
					 'fullboth)))
(global-set-key [(meta return)] 'toggle-fullscreen)
(toggle-fullscreen)

(define-key global-map (kbd "RET") 'newline-and-indent)

(load-file "~/.emacs.d/highlight-chars.el")

; Molette de la souris
(defun up-slightly () (interactive) (scroll-up 5))
(defun down-slightly () (interactive) (scroll-down 5))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)
(defun up-one () (interactive) (scroll-up 1))
(defun down-one () (interactive) (scroll-down 1))
(global-set-key [S-mouse-4] 'down-one)
(global-set-key [S-mouse-5] 'up-one)
(defun up-a-lot () (interactive) (scroll-up))
(defun down-a-lot () (interactive) (scroll-down))
(global-set-key [C-mouse-4] 'down-a-lot)
(global-set-key [C-mouse-5] 'up-a-lot)


; ----------------------------------------------------------------------
; Edition

; Mettre quatre espaces pour l'indentation
(setq c-basic-offset 4)

; Supprime tous les espaces en fin de ligne
; http://www.splode.com/users/friedman/software/emacs-lisp/
(autoload 'nuke-trailing-whitespace "whitespace" nil t)

; Activer la coloration syntaxique
(global-font-lock-mode t)
; Mettre un maximu de couleurs
(setq font-lock-maximum-size nil)

; Mode texte en auto-fill par défaut
; (créé une nouvelle ligne à chaque fois que vous tapez du texte)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

(add-hook 'c-mode-common-hook 'imenu-add-menubar-index)
(add-hook 'js-mode-hook 'imenu-add-menubar-index)

; Recherche automatique des fermetures et ouvertures des parenthèses
; Voir cette adresse pour quelquechose de plus fin :
; http://www.linux-france.org/article/appli/emacs/faq/emacs-faq-7.html
(load-library "paren")
(show-paren-mode 1)

(cua-mode t)
(transient-mark-mode t)
(setq cua-enable-cua-keys nil)
(setq cua-normal-cursor-color "red")
(setq cua-overwrite-cursor-color "yellow")
(setq cua-read-only-cursor-color "green")

; ----------------------------------------------------------------------
; Raccourcis claviers

; M-g pour aller à la x-ième ligne
(global-set-key (kbd "M-S g") 'goto-line)
(global-set-key [(meta g)] 'goto-line)

; Pour ne pas avoir à taper en entier la réponse yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(defun djcb-duplicate-line (&optional commentfirst)
  "comment line at point; if COMMENTFIRST is non-nil, comment the original"
  (interactive)
  (beginning-of-line)
  (push-mark)
  (end-of-line)
  (let ((str (buffer-substring (region-beginning) (region-end))))
    (when commentfirst
	  (comment-region (region-beginning) (region-end)))
    (insert-string
	 (concat (if (= 0 (forward-line 1)) "" "\n") str "\n"))
    (forward-line -1)))

;; or choose some better bindings....

;; duplicate a line
;(global-set-key (kbd "C-c y") 'djcb-duplicate-line)

;; duplicate a line and comment the first
;(global-set-key (kbd "C-x c") (lambda()(interactive)(djcb-duplicate-line t)))

(define-key global-map "\C-xc" 'copy-and-comment-region)

(global-set-key (kbd "<backtab>") (lambda () (interactive) (insert-char 9 1)))
(global-set-key (kbd "C-n") (lambda () (interactive) (insert-string "\\n\");")))
(global-set-key (kbd "C-c 1") (lambda ()
								(interactive)
								(insert-string "printf(\"1\\n\");")
								(indent-for-tab-command)
								(insert-string "\n")
								(next-line)
								))
(global-set-key (kbd "C-c 2") (lambda ()
								(interactive)
								(insert-string "printf(\"2\\n\");")
								(indent-for-tab-command)
								(insert-string "\n")
								(next-line)
								))
(global-set-key (kbd "C-c 3") (lambda ()
								(interactive)
								(insert-string "printf(\"3\\n\");")
								(indent-for-tab-command)
								(insert-string "\n")
								(next-line)
								))
(global-set-key (kbd "C-c 4") (lambda ()
								(interactive)
								(insert-string "printf(\"4\\n\");")
								(indent-for-tab-command)
								(insert-string "\n")
								(next-line)
								))

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-g c") 'magit-commit)
(global-set-key (kbd "C-x C-g p") 'magit-push)

(hc-toggle-highlight-trailing-whitespace)
(global-set-key (kbd "<f11>")
				'hc-toggle-highlight-trailing-whitespace)

(global-set-key (kbd "<f12>")
				'helm-imenu)
(global-set-key (kbd "<f9>")
				'ac-js2-jump-to-definition)

(defun toggle-indent-mode ()
  "Toggle between spaces (2) and tabs (4)"
  (interactive)
  (set-variable 'indent-tabs-mode (not indent-tabs-mode))
  (set-variable 'js2-basic-offset (if (= js2-basic-offset 4) 2 4)))

;; (global-set-key (kbd "<f8>") 'toggle-indent-mode)
;; (global-set-key (kbd "<f8>")
;; 				'ff-get-other-file)

(define-key global-map "\C-cs" 'ff-get-other-file)
(define-key global-map "\C-cd" 'delete-trailing-whitespace)
(define-key global-map "\C-ci" 'indent-region)
(define-key global-map "\C-cc" 'comment-region)
(define-key global-map "\C-cu" 'uncomment-region)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;(when (fboundp 'windmove-default-keybindings)
(windmove-default-keybindings 'meta)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

(js2r-add-keybindings-with-prefix "C-c C-v")

(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

;;(add-hook 'js2-mode-hook (lambda () (tern-mode t)))
(add-hook 'js2-mode-hook (lambda () (auto-complete-mode t)))
(add-hook 'js2-mode-hook 'prettier-js-mode)

(add-hook 'js2-mode-hook (lambda ()
                           (tern-mode)
                           (company-mode)))

;;(add-hook 'js2-mode-hook #'js2-refactor-mode)
(js2r-add-keybindings-with-prefix "C-c C-r")
;;(define-key js2-mode-map (kbd "C-k") #'js2r-kill)

(define-key js2-mode-map (kbd "M-.") nil)
(define-key js2-mode-map (kbd "M-,") nil)

(add-hook 'js2-mode-hook (lambda ()
						   (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))

;; (define-key tern-mode-keymap (kbd "M-.") nil)
;; (define-key tern-mode-keymap (kbd "M-,") nil)

;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))

;; (global-set-key (kbd "<C-tab>") 'tern-ac-complete)
;; (setq tern-ac-on-dot nil)

(setq ac-auto-show-menu nil)

;; (add-to-list 'load-path "~/.emacs.d/smeargle/")
(load-file "~/.emacs.d/smeargle.el")

;(global-set-key (kbd "C-x f") 'find-file-in-repository)

(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)
;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

(global-set-key (kbd "C-x f") 'helm-projectile)

(defadvice vc-svn-registered (around my-vc-svn-registered-tramp activate)
  "Don't try to use SVN on files accessed via TRAMP."
  (if (and (fboundp 'tramp-tramp-file-p)
           (tramp-tramp-file-p (ad-get-arg 0)))
      nil
    ad-do-it))
(defadvice vc-git-registered (around my-vc-git-registered-tramp activate)
  "Don't try to use GIT on files accessed via TRAMP."
  (if (and (fboundp 'tramp-tramp-file-p)
           (tramp-tramp-file-p (ad-get-arg 0)))
      nil
    ad-do-it))


(setq c-default-style "linux"
	  c-basic-offset 4)

(require 'ido-vertical-mode)
(ido-mode 1)
(ido-vertical-mode 1)

(require 'smex) ; Not needed if you use package.el
(smex-initialize) ; Can be omitted. This might cause a (minimal) delay
                  ; when Smex is auto-initialized on its first run.

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(define-key global-map (kbd "C-M-g") 'avy-goto-char)

(global-set-key (kbd "<f5>")
				'recompile)
(global-set-key (kbd "<f6>")
				'next-error)
(global-set-key (kbd "<f7>")
				'previous-error)

(setq shell-file-name "zsh")
(setq shell-command-switch "-ic")

(defun amend ()
  (interactive)
  (setq-default compile-command "amend")
  ;; (compile)
  )

(yas-global-mode 1)

(defun term-send-raw-string (chars)
  (let ((proc (get-buffer-process (current-buffer))))
    (if (not proc)
	(error "Current buffer has no process")
      ;; Note that (term-current-row) must be called *after*
      ;; (point) has been updated to (process-mark proc).
      (goto-char (process-mark proc))
      (if (term-pager-enabled)
	  (setq term-pager-count (term-current-row)))
      (process-send-string proc chars))))

(defun bury-compile-buffer-if-successful (buffer string)
  "Bury a compilation buffer if succeeded without warnings "
  (if (and
       (string-match "compilation" (buffer-name buffer))
       (string-match "finished" string)
       (not
        (with-current-buffer buffer
          (search-forward "warning" nil t))))
      (run-with-timer 1 nil
                      (lambda (buf)
						(switch-to-buffer-other-window "*compilation*")
						(insert "q"))
                        ;; (bury-buffer buf)
                        ;; (switch-to-prev-buffer (get-buffer-window buf) 'kill))
                      buffer)))
(add-hook 'compilation-finish-functions 'bury-compile-buffer-if-successful)

(global-set-key (kbd "M-p") 'ace-jump-mode)

;; (load-file "~/.emacs.d/camelCase-mode.el")
;; (require 'camelCase)
;; (add-hook 'find-file-hook 'camelCase-mode)
(global-set-key (kbd "C-=") 'er/expand-region)

(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
      (let ((web-mode-enable-part-face nil))
        ad-do-it)
    ad-do-it))
(put 'upcase-region 'disabled nil)

(defun copy-and-comment-region (beg end &optional arg)
  "Duplicate the region and comment-out the copied text.
See `comment-region' for behavior of a prefix arg."
  (interactive "r\nP")
  (copy-region-as-kill beg end)
  (goto-char end)
  (yank)
  (comment-region beg end arg))

(add-hook 'after-init-hook #'global-flycheck-mode)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(magit-diff-options nil)
 '(package-selected-packages
   (quote
	(prettier-js xref-js2 company centered-window elm-mode graphql-mode yaml-mode editorconfig ace-jump-mode markdown-mode typescript-mode helm-swoop dashboard which-key magit mocha flycheck-elixir elixir-mode web-mode tern-auto-complete speed-type sos smex scss-mode js2-refactor iedit ido-vertical-mode hydra helm-projectile haskell-mode ggtags flx-ido floobits find-file-in-repository fastnav expand-region diff-hl avy)))
 '(prettier-js-args (list "--use-tabs" "--single-quote"))
 '(safe-local-variable-values
   (quote
	((mocha-project-test-directory . "webserver/test/unit")
	 (mocha-project-test-directory . "webserver/test")
	 (mocha-reporter . "spec")
	 (mocha-project-test-directory . "test")
	 (mocha-options . "--recursive --reporter dot -t 5000")
	 (mocha-environment-variables . "NODE_ENV=test")
	 (mocha-which-node . "/home/guillaume/.nvm/versions/node/v6.9.2/bin/node")))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ob-js)

(which-key-mode)

;; http://endlessparentheses.com/emacs-narrow-or-widen-dwim.html
;; https://github.com/mwfogleman/config/blob/master/home/.emacs.d/michael.org
(defun narrow-or-widen-dwim (p)
  "Widen if buffer is narrowed, narrow-dwim otherwise.
  Dwim means: region, org-src-block, org-subtree, or
  defun, whichever applies first. Narrowing to
  org-src-block actually calls `org-edit-src-code'.

  With prefix P, don't widen, just narrow even if buffer
  is already narrowed."
  (interactive "P")
  (declare (interactive-only))
  (cond ((and (buffer-narrowed-p) (not p)) (widen)(recenter))
		((and (boundp 'org-src-mode) org-src-mode (not p))
		 (org-edit-src-exit))
		((region-active-p)
		 (narrow-to-region (region-beginning)
						   (region-end)))
		((derived-mode-p 'org-mode)
		 ;; `org-edit-src-code' is not a real narrowing
		 ;; command. Remove this first conditional if
		 ;; you don't want it.
		 (cond ((ignore-errors (org-edit-src-code) t)
				(delete-other-windows))
			   ((ignore-errors (org-narrow-to-block) t))
			   (t (org-narrow-to-subtree))))
		((derived-mode-p 'latex-mode)
		 (LaTeX-narrow-to-environment))
		(t (narrow-to-defun))))

;; This line actually replaces Emacs' entire narrowing
;; keymap, that's how much I like this command. Only
;; copy it if that's what you want.
(define-key ctl-x-map "n" #'narrow-or-widen-dwim)

(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

(dashboard-setup-startup-hook)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/emacs-livedown"))
(require 'livedown)

;; (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)

(set-fontset-font "fontset-default" nil
           (font-spec :size 12 :name "Symbola"))

(org-babel-do-load-languages
     'org-babel-load-languages
     '((ditaa . t)))
(setq org-ditaa-jar-path "/usr/share/java/ditaa/ditaa-0.11.jar")

;; active Org-babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;; other Babel languages
   (plantuml . t)))

(setq org-plantuml-jar-path
      (expand-file-name "/opt/plantuml/plantuml.jar"))

;(require 'centered-window-mode)

(editorconfig-mode 1)

