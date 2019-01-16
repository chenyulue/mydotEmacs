;; Use package mannagement
(require 'package)

;; Set the Elpa mirror for the package archives
(setq package-archives
      '(("gnu"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
        ("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
;;(add-to-list
;;  'package-archives
;;  '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
(package-initialize)

(setq package-list '(intero
		     hindent
		     rainbow-delimiters
		     hlint-refactor
		     flymake-hlint
		     hasky-stack
		     fill-column-indicator
		     solarized-theme ;; Color scheme
		     ))

;; rm -rf ~/.emacs.d/elpa to reload
(when (not package-archive-contents)
  (package-refresh-contents))
(dolist (package package-list)
  (when (not (package-installed-p package))
    (package-install package)))

;; Install Intero
;; (package-install 'intero)
(add-hook 'haskell-mode-hook 'intero-mode)
;; enable intero in all haskel-mode buffers by default
(intero-global-mode 1)

;; Use haskell-mode indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Use hindent to format the code by calling 'M-q'
(add-hook 'haskell-mode-hook #'hindent-mode)

;; rainbow-delimiters show each level of parenthesis or braces ina different color.
(require 'rainbow-delimiters)
(add-hook 'haskell-mode-hook #'rainbow-delimiters-mode)
;; 'hlint-refactor-mode' for code suggestionns
;; 'C-c , r' - Apply the suggestion under the cursor
;; 'C-c , b' - Apply the suggestions in the buffer
(require 'hlint-refactor)
(add-hook 'haskell-mode-hook 'hlint-refactor-mode)
;; 'flymake-hlint' for code suggestions
;; (require 'flymake-hlint)
;; (add-hook 'haskell-mode-hook 'flymake-hlint-load)

;; Use Hlint with intero on-the-fly
(with-eval-after-load 'intero
  (flycheck-add-next-checker 'intero '(warning . haskell-hlint)))

;; Show column indicator
(require 'fill-column-indicator)
(add-hook 'haskell-mode-hook 'fci-mode)
(setq fci-rule-column 80)
(setq fci-rule-color "#202000")

;; Smooth keyboard scrolling
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;=============== Key binding====================================
;; Bind 'F8' to 'haskell-navigate-imports', which focuses the editor
;; on each of the import blocks in the file;
;; 'C-c C-,' will sort and align the import sections nicely.
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))

;; Bind 'F9' to 'haskell-mode-stylish-buffer'
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f9] 'haskell-mode-stylish-buffer))

;; Bind 'M-s M-t' to intero targets
(global-set-key (kbd "M-s M-t") #'intero-targets)

;; Bind 'M-s M-s' to stack mode
(global-set-key (kbd "M-s M-s") #'hasky-stack-execute)

;; Use shift-arrow keys to move between windows
(windmove-default-keybindings)

;; ========================================================

;; Customize the color scheme


;; =========================================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-selected-packages (quote (intero))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
