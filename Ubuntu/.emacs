(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compile-command "docker exec -it KopzonContainer make clean; docker exec -it KopzonContainer ./fast_make.py;")
 '(custom-enabled-themes '(leuven-dark))
 '(gud-gdb-command-name
   "gdb -i=mi --args ./Debug/gcc/test/gtest_all/gtest_all --gtest_filter=")
 '(package-selected-packages
   '(undo-tree gtags-mode ggtags magit mo-git-blame general multiple-cursors)))

;;##############################################################################
;; Global stuff
;;##############################################################################

(global-set-key (kbd "M-[ h") 'move-beginning-of-line)
(global-set-key (kbd "M-[ f") 'move-end-of-line)

(require 'ansi-color)
(defun my-ansi-colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'my-ansi-colorize-compilation-buffer)

(setq package-check-signature nil)

;; Make Emacs recognize the Command key as Meta (Alt)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)

;; Open fileA and fileB at startup
(setq initial-buffer-choice nil)  ; Don't open a specific file on startup
(set-face-attribute 'default nil :height 140)

;; Open two specific files in different buffers
(setq inhibit-startup-screen t)
(defun open-my-files ()
  "Open fileA and fileB in separate buffers."
  (find-file "~/git/core"))

;; Run the function after Emacs initializes
(add-hook 'emacs-startup-hook 'open-my-files)

(add-to-list 'load-path "~/.emacs.d/lisp")

(setq gtags-path "/opt/homebrew/bin/gtags")
(add-to-list 'exec-path gtags-path)
(setq gtags-path-style 'relative)
(setenv "PATH" (concat "/opt/homebrew/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/opt/homebrew/bin")))
(load-file "~/.emacs.d/lisp/gtags.el")

;; Ensure the package system is initialized
(require 'package)

;; Add MELPA repository to the list of package sources
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")))

;; Initialize package system
(package-initialize)

;; Install `use-package` if it is not already installed
(unless (package-installed-p 'use-package)
  (unless package-archive-contents
    (package-refresh-contents))  ;; Refresh if no package contents available
  (package-install 'use-package))

;; Load `use-package`
(eval-when-compile
  (require 'use-package))

;;##############################################################################
;; Packages definitions
;;##############################################################################

;;; Ensure package system is initialized
(require 'package)
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
	("melpa" . "https://melpa.org/packages/")))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)

(require 'general)

(declare-function general-imap "general")
(declare-function general-emap "general")
(declare-function general-nmap "general")
(declare-function general-vmap "general")
(declare-function general-mmap "general")
(declare-function general-omap "general")
(declare-function general-rmap "general")
(declare-function general-iemap "general")
(declare-function general-nvmap "general")
(declare-function general-itomap "general")
(declare-function general-otomap "general")
(declare-function general-tomap "general")

(use-package general
  :ensure t
  :config
  ;; Your keybinding code here
  )

;;; Undo tree
(use-package undo-tree
	     :ensure t
	     :config
	     (global-undo-tree-mode))  ;; Enable undo-tree globally

;;; Spell checking
(setq ispell-program-name "ispell")
(setq ispell-dictionary "english")  ;; or change to another dictionary if needed
;; Flyspell Configuration
(use-package flyspell
	     :ensure t
	     :init
	     ;; Enable flyspell mode in text and programming modes (for comments and strings)
	     (add-hook 'text-mode-hook 'flyspell-mode)
	     (add-hook 'prog-mode-hook 'flyspell-prog-mode)
	     :config
	     ;; Use flyspell-prog-mode in programming-related modes for spelling in comments and strings
	     (add-hook 'c-mode-hook 'flyspell-prog-mode)
	     (add-hook 'c++-mode-hook 'flyspell-prog-mode)
	     (add-hook 'python-mode-hook 'flyspell-prog-mode)
	     (add-hook 'java-mode-hook 'flyspell-prog-mode)
	     ;; Additional modes can be added similarly
	     )
;; Enable spell checking in C, C++, and other programming language comments and strings
(use-package flyspell
	     :ensure t
	     :config
	     ;; Ensure flyspell works in comments and strings in programming modes
	     (add-hook 'prog-mode-hook 'flyspell-prog-mode))
;; Optional: Customize the highlighting of misspelled words in programming buffers
(setq flyspell-highlight-phrase nil)  ;; Disable highlighting of whole phrases, only individual words
;; Optional: If you want to change the language dictionary for spell-checking
(setq ispell-dictionary "english")  ;; Set the default language dictionary to English
;; Optional: Enable automatic spell checking on file save
(add-hook 'before-save-hook 'flyspell-buffer)

;;##############################################################################
;; Functions
;;##############################################################################


					;TODO Kopzon - understand how macros can be saved by emacs itself and remove this function
;(defun save-macro (name key)
;      "save a macro. Take a name and key as argument
;     and save the last defined macro under
;     this name and keyboard shortcut under this key
;     at the end of your .emacs"
;      (interactive "SName of the macro: \nsKey: ")  ; ask for the name and key of the macro
;      (kmacro-name-last-macro name)                 ; use this name for the macro
;      (find-file user-init-file)                    ; open ~/.emacs or other user init file
;      (goto-char (point-max))                       ; go to the end of the .emacs
;      (newline)                                     ; insert a newline
;      (insert-kbd-macro name)                       ; copy the macro
;      (call-interactively 'eval-last-sexp)
;      (insert "(global-set-key (kbd \"C-x ")
;      (insert key)
;      (insert "\") ")
;      (insert "\'" (symbol-name name))
;      (insert ")")
;      (call-interactively 'eval-last-sexp)
;      (newline)                                     ; insert a newline
;      (switch-to-buffer nil))                       ; return to the initial buffer

					; Winner - window layout stack
(winner-mode t)
;;Ediff
(defmacro csetq (variable value)
  `(funcall (or (get ',variable 'custom-set)
		'set-default)
	    ',variable ,value))
(csetq ediff-window-setup-function 'ediff-setup-windows-plain)
(csetq ediff-split-window-function 'split-window-horizontally)
					;(csetq ediff-diff-options "-w")
					;(add-hook 'ediff-after-quit-hook-internal 'winner-undo)
(defun ora-ediff-hook ()
  (ediff-setup-keymap)
  (define-key ediff-mode-map "j" 'ediff-next-difference)
  (define-key ediff-mode-map "k" 'ediff-previous-difference))
(add-hook 'ediff-mode-hook 'ora-ediff-hook)

					;Smart scrolling
;;keep cursor at same position when scrolling
(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-<down>") 'scroll-up-line)
(global-set-key (kbd "M-<up>") 'scroll-down-line)
(global-set-key (kbd "M-C-u") (lambda () (interactive) (backward-up-list) (recenter-top-bottom)))

(global-set-key (kbd "M-<delete>") 'end-of-line)
(global-set-key (kbd "M-<help>") 'beginning-of-line)

					;Shortcuts to important files
(defun dot-emacs ()
  "Quickly open .emacs"
  (interactive)
  (find-file "~/.emacs"))
(global-set-key (kbd "C-x .") 'dot-emacs)

					;General porpose
(global-set-key (kbd "C-x <deletechar>") 'next-multiframe-window)
(global-set-key (kbd "C-x <end>") 'save-buffer)
(global-set-key (kbd "C-x / /") (kbd "C-x 1 C-x 3"))

(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (pos) 'read-face-name)
		  (get-char-property (pos) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

					;Git
(autoload 'mo-git-blame-current "mo-git-blame" nil t)
(global-set-key '[f8]   'mo-git-blame-current)
(global-set-key '[C-f8]   'mo-git-blame-quit)
(global-set-key '[f9]   'mo-git-blame-quit)

					;Rotate buffers
(defun rotate-windows-buffers ()
  "Rotate buffers in all windows of the current frame."
  (interactive)
  (let ((windows (window-list)))  ;; Get the list of windows in the current frame
    (when (> (length windows) 1)  ;; Only rotate if there are multiple windows
      (let ((buffers (mapcar #'window-buffer windows)))  ;; Get the list of buffers from each window
	(when (> (length buffers) 1)  ;; Ensure there are multiple buffers
	  ;; Rotate the list of buffers
	  (setq buffers (append (cdr buffers) (list (car buffers))))
	  ;; Set the rotated buffers back to the windows
	  (cl-loop
	   for window in windows
	   for buffer in buffers
	   do (set-window-buffer window buffer)))))))

					;compilation mode and shell mode buffer control
(setq special-display-buffer-names
      '("*compilation*" "*shell*" "*shell*<2>" "*shell*<3>" "*shell*<4>"))

(setq special-display-function
      (lambda (buffer &optional args)
	(switch-to-buffer buffer)
	(get-buffer-window buffer 0)))

;; Customizations for all modes in CC Mode.
(defun my-c-mode-common-hook ()
  ;; set my personal style for the current buffer
  (c-set-style "Kopzon Style")
  ;; other customizations
  (setq tab-width 4
	;; this will make sure spaces are used instead of tabs
	indent-tabs-mode nil))
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; Spell checking
(defun my-save-word ()
  (interactive)
  (let ((current-location (point))
	(word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))
(add-to-list 'ispell-skip-region-alist '("^#include" forward-line))

(use-package multiple-cursors
  :ensure t
  :bind (("C-x <down>" . mc/edit-lines)
	 ("C-x n" . mc/mark-next-like-this)
	 ("C-x p" . mc/mark-previous-like-this)
	 ("C-x a" . mc/mark-all-like-this)
	 ("M-<mouse-1>" . mc/add-cursor-on-click))
  :config
  ;; Unset the default binding for M-<down-mouse-1>
  (global-unset-key (kbd "M-<down-mouse-1>")))


;; Buffer manipulation
(defun close-all-buffers ()
  (interactive)
  (mapc 'kill-buffer (buffer-list)))
(defun close-other-buffers ()
  (interactive)                                                                ;
  (mapc 'kill-buffer (cdr (buffer-list (current-buffer)))))
(global-set-key (kbd "C-x c a") 'close-all-buffers)
(global-set-key (kbd "C-x c c") 'close-other-buffers)

					;Refresh all buffers
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
	 (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer)
		 (not (buffer-modified-p buffer)))
	(set-buffer buffer)
	(revert-buffer t t t))
      (setq list (cdr list))
      (setq buffer (car list))))
  (message "Refreshed open files"))
(global-set-key '[C-f5] 'revert-buffer)
(global-set-key '[f5] 'revert-all-buffers)


;; Copy and paste stuff
(defun duplicate-line ()
  "Duplicate the current line without affecting the yank buffer."
  (interactive)
  (save-excursion
    (let ((line-content (buffer-substring (line-beginning-position)
					  (line-end-position))))
      (end-of-line)
      (newline)
      (insert line-content))))
(global-set-key (kbd "M-d") 'yank)

(defun swap-line-up ()
  "Swap the current line with the line above, keeping the cursor on the new line."
  (interactive)
  (let ((col (current-column))        ; Save the current column position
	(line (line-number-at-pos)))  ; Save the current line number
    (save-excursion
      (beginning-of-line)             ; Move to the beginning of the current line
      (transpose-lines 1)             ; Swap the current line with the one above
      (forward-line -2))              ; Move cursor to the new line above (after the swap)
    (move-to-column col)              ; Restore cursor to the same column
    (goto-line (max 1 (1- line)))))   ; Ensure cursor is on the new position

(defun swap-line-down ()
  "Swap the current line with the line below, keeping the cursor on the new line."
  (interactive)
  (let ((col (current-column))        ; Save the current column position
	(line (line-number-at-pos)))  ; Save the current line number
    (save-excursion
      (beginning-of-line)             ; Move to the beginning of the current line
      (forward-line 1)                ; Move to the next line
      (transpose-lines 1)             ; Swap the current line with the one below
      (forward-line -1))              ; Move cursor to the new position (after the swap)
    (move-to-column col)              ; Restore cursor to the same column
    (goto-line (1+ line))))                ; Ensure cursor is on the new position
(global-set-key (kbd "<C-S-up>") 'swap-line-up)   ; Control + Shift + Up
(global-set-key (kbd "<C-S-down>") 'swap-line-down) ; Control + Shift + Down


					;GDB
(defun one-gud-window ()
  "Switch to the gud buffer and maximize"
  (interactive)
  (switch-to-buffer gud-comint-buffer)
  (delete-other-windows)
  (gud-refresh))
(global-set-key (kbd "C-x 9") 'one-gud-window)

;; Open core wrappers
(defun open-core-old (platform-name binary-name core-name)
  "Open a core file dumped by a specific distro"
  (interactive
   (list (read-from-minibuffer "Platform: ")
	 (read-file-name "Binary: ")
	 (read-file-name "Core: ")))
  (let* ((libs-dir (concat "~/libs/libs_" platform-name))
	 (cmd-line (concat "gdb -i=mi "
			   "-ex \"set libthread-db-search-path " libs-dir "\" "
			   "-ex \"set sysroot " libs-dir "\" "
			   "-ex \"set auto-load libthread-db on\" "
			   "-c " core-name " -e " binary-name)))
    (message cmd-line)
    (gdb cmd-line)))
(defun gdb-core (repo-name libs-dir core-name bin-name)
  "Run gdb with alternative libs dir"
  (interactive
   (list
    (read-from-minibuffer "Please specify git repository: " nil nil t)
    (read-directory-name "Please specify libs dir: " nil nil t)
    (read-file-name "Please specify core file: " nil nil t)
    (read-file-name "Please specify binary file: " nil nil t)))
  (gdb (format (concat "gdb "
		       "-ex \"print 0\" "
		       "-ex \"set sysroot %s\" "
		       "-ex \"set auto-load libthread-db on\" "
		       "-ex \"set auto-load safe-path %s\" "
		       "-ex \"set libthread-db-search-path %s\" "
		       "-ex \"set solib-search-path %s\" "
		       "-ex \"file %s\" "
		       "-ex \"core-file %s\" "
		       "-ex \"set substitute-path /home/sio/projects/src/ /home/sio/%s/src/\" "
		       "-ex \"set substitute-path /data/builds/workspace/ScaleIO-Common-Job/src/ /home/sio/%s/src/\" "
		       "-i=mi ")

	       libs-dir
	       libs-dir
	       libs-dir
	       libs-dir
	       bin-name
	       core-name
	       repo-name
	       repo-name)))
;; the * is not working well :(
(defun gdb-core-new (bug-dir)
  "Run gdb with alternative libs dir"
  (interactive
   (list
    (read-directory-name "Please specify bug directory: " nil nil t)))
  (gdb (format (concat "gdb "
		       "-ex \"print 0\" "
		       "-ex \"set sysroot %s/Kopzon/libs\" "
		       "-ex \"set auto-load libthread-db on\" "
		       "-ex \"set auto-load safe-path %s/Kopzon/libs\" "
		       "-ex \"set libthread-db-search-path %s/Kopzon/libs\" "
		       "-ex \"set solib-search-path %s/Kopzon/libs\" "
		       "-ex \"file %s/Kopzon/sds-*\" "
		       "-ex \"core-file %s/Kopzon/core*\" "
		       "-i=mi ")

	       bug-dir
	       bug-dir
	       bug-dir
	       bug-dir
	       bug-dir
	       bug-dir)))


;; grep
(defun grep-Kopzon-rn (pattern-to-search search-folder)
  "Run grep  --color -rn <pattern-to-search> <search-folder>"
  (interactive
   (list
    (read-from-minibuffer "Pattern to search: " nil nil t)
    (read-directory-name "Directory to search in: " nil nil t)))
  (grep (format (concat "grep "
			"--color "
			"-rn "
			"'%s' "
			"%s")

		pattern-to-search
		search-folder)))
(defun grep-Kopzon-rni (pattern-to-search search-folder)
  "Run grep  --color -rni <pattern-to-search> <search-folder>"
  (interactive
   (list
    (read-from-minibuffer "Pattern to search: " nil nil t)
    (read-directory-name "Directory to search in: " nil nil t)))
  (grep (format (concat "grep "
			"--color "
			"-rni "
			"'%s' "
			"%s")

		pattern-to-search
		search-folder)))
(global-set-key (kbd "C-x g") 'grep-Kopzon-rni)
(defun grep-Kopzon-rni-include (pattern-to-search search-folder file-name-pattern)
  "Run grep  --color -rni --include=<file-name-pattern> -e <pattern-to-search> <search-folder>"
  (interactive
   (list
    (read-from-minibuffer "Pattern to search: " nil nil t)
    (read-directory-name "Directory to search in: " nil nil t)
    (read-from-minibuffer "File name pattern to search in: " nil nil t)))
  (grep (format (concat "grep "
			"--color "
			"-rni "
			"--include=\*%s\* "
			"-e '%s' "
			"%s")

		file-name-pattern
		pattern-to-search
		search-folder)))

;;##############################################################################
;; Maps
;;##############################################################################

(define-prefix-co\mmand 'Kopzon-r-map)
(global-set-key (kbd "M-r") 'Kopzon-r-map)
(global-set-key (kbd "M-t") 'Kopzon-r-map) ; alias for typos
(general-define-key
 :prefix "M-r"
 "<left>" 'switch-to-prev-buffer
 "<right>" 'switch-to-next-buffer
 "[" 'switch-to-prev-buffer
 "]" 'switch-to-next-buffer
 "<down>" (kbd "C-x C-x C-g") ; return to previous point position

 "<next>" 'scroll-up-3-lines
 "<prior>" 'scroll-down-3-lines
 "<insertchar>" (kbd "C-e C-x C-e")
 "<deletechar>" 'next-multiframe-window
					; "<home>" 'save-buffers-kill-emacs
 "<end>" 'save-buffer
 "<select>" 'save-buffer

 "u" 'undo-tree-visualize
 "n" 'evil-exit-emacs-state
 "e" 'ediff-buffers
 "pl" 'xah-pop-local-mark-ring
 "po" 'pop-global-mark
 "M-b" 'buffers-list
 "bb" 'bookmarks
 "bs" 'bookmark-set
 "bd" 'bookmark-delete
 "bj" 'bookmark-jump
 "h" 'cycle-resume
 "o" 'other-window
 "i" 'imenu ;outline
 "d" 'show-kill-ring
 "qr" 'query-replace
 "M-d" 'duplicate-line
 "/1" 'delete-other-windows
 "/2" 'split-window-below
 "/3" 'split-window-right
 "/d" (kbd "C-x 1 C-x 3")
 "/0" 'delete-window
 "/ <up>" 'rotate-windows-buffers
 "/ <down>" 'rotate-windows-buffers
 "/ <right>" 'rotate-windows-buffers
 "/ <left>" 'rotate-windows-buffers
 "\\" 'find-files
 "M-f" 'find-files
 "j" 'ace-jump-word-mode
 "." 'save-buffer
 "M-." 'save-buffer
 "k" 'kill-buffer
 "x" (kbd "C-e C-x C-e <down> C-a")
 "'" (kbd "C-e C-x C-e <down> C-a")
 "SPC" (kbd "C-SPC")
 "M-g g" 'grep-Kopzon-rni
 "M-g s" 'grep-Kopzon-rn
 "M-g i" 'grep-Kopzon-rni-include
 "M-r" 'gud-break
 "r" 'gud-remove
 "9" 'one-gud-window
 "/." 'dot-emacs
 "/l" 'eval-buffer
 "c" (kbd "C-c C-c")
 "/c" (kbd "C-x / c")
 "/t" (kbd "C-x / t")

 "mmm" 'magit
 "mco" 'magit-checkout
 "mbc" 'magit-branch-create
 "mbd" 'magit-branch-delete
 "mcl" 'magit-clean
 "msf" 'magit-stage-file
 "msm" 'magit-stage-modified
 "msa" 'magit-stage-modified
 "mcm" 'magit-commit
 "mf" 'magit-fetch-all-prune
 "mdw" 'magit-ediff-show-working-tree ; ediff all files in the working tree
 "mdc" 'magit-ediff-compare           ; ediff two or more serialized hashes
 "mds" 'magit-ediff-show-commit       ; select commit hash to be shown
 "mdr" 'magit-diff-range              ; select commit hash to show diff with current working tree
 "mmg" 'magit-merge
 "ml" 'magit-log-current
 "mrh" 'magit-reset-hard
 "mpl" 'magit-pull
 "mps" 'magit-push
 "mri" 'magit-rebase-interactive
 "mss" 'magit-stash
 "msl" 'magit-stash-list
 "msp" 'magit-stash-pop
 "msc" 'magit-stash-clear
 "mt" 'magit-tag

 "3" 'gtags-find-tag
 "M-3" 'gtags-find-tag
 "gt" 'gtags-find-tag
 "1" 'gtags-find-rtag
 "M-1" 'gtags-find-rtag
 "gr" 'gtags-find-rtag
 "2" 'gtags-find-symbol
 "M-2" 'gtags-find-symbol
 "gs" 'gtags-find-symbol
 "4" 'gtags-find-pattern
 "M-4" 'gtags-find-pattern
 "gp" 'gtags-find-pattern
 "f" 'gtags-find-file
 "gf" 'gtags-find-file
 "\`" 'gtags-previous-history
 "M-\`" 'gtags-previous-history
 "gb" 'gtags-previous-history
 "gn" 'gtags-next-history
 "gu" 'kopzon-update-all-tags
					; "gu" 'ggtags-update-tags
					; "gu" 'gtags-update-tags
 "gc" 'gtags-create-tags
 "M-e" 'gtags-resume
 "<up>" 'gtags-resume
 "gh" 'gtags-show-stack
 )
;; End of M-r map

(define-prefix-command 'Kopzon-3-map)
(global-set-key (kbd "M-3") 'Kopzon-3-map)
(general-define-key
 :prefix "M-3"
 "<left>" 'switch-to-prev-buffer
 "<right>" 'switch-to-next-buffer
 "<up>" 'comint-previous-input
 "<down>" 'comint-next-input
 "[" 'switch-to-prev-buffer
 "]" 'switch-to-next-buffer

 "<next>" 'scroll-up-3-lines
 "<prior>" 'scroll-down-3-lines
 "<insertchar>" (kbd "C-e C-x C-e")
 "<deletechar>" 'next-multiframe-window
					; "<home>" 'save-buffers-kill-emacs
 "<end>" 'save-buffer
 "<select>" 'save-buffer
 "u" 'undo-tree-visualize

 "3"  'buffers-list
 "M-3"  'buffers-list
 "9"  'one-gud-window
 "M-b" 'buffers-list
 "k" 'kill-buffer
 "/." 'dot-emacs
 "/ <up>" 'rotate-windows-buffers
 "/ <right>" 'rotate-windows-buffers
 "/ <left>" 'rotate-windows-buffers
 "/1" 'delete-other-windows
 "/2" 'split-window-below
 "/3" 'split-window-right
 "/d" (kbd "C-x 1 C-x 3")
 "/0" 'delete-window

 "o" (kbd "C-x o")
 "j"  'ace-jump-mode
 "pl" 'xah-pop-local-mark-ring
 "po" 'pop-global-mark
 "1" 'er/contract-region
 "/c" (kbd "C-x / c")
 "/t" (kbd "C-x / t")
 "f" 'gtags-find-file
 "." 'save-buffer
 )
;;end M-3 map

(define-prefix-command 'Kopzon-1-map)
(global-set-key (kbd "M-1") 'Kopzon-1-map)
(general-define-key
 :prefix "M-1"
 "<next>" 'scroll-up-3-lines
 "<prior>" 'scroll-down-3-lines
					; "<insertchar>" 'mc/edit-lines
 "<deletechar>" 'next-multiframe-window
					; "<home>" 'save-buffers-kill-emacs
 "<end>" 'save-buffer
 "<select>" 'save-buffer

 "9"  'one-gud-window
 "M-b" 'buffers-list
 "/." 'dot-emacs
 "o" (kbd "C-x o")
 "j"  'ace-jump-mode
 "pl" 'xah-pop-local-mark-ring
 "po" 'pop-global-mark
 "M-b" 'buffers-list

 "e" (kbd "C-SPC C-e")
 "a" (kbd "C-SPC C-a")
 "ml" (kbd "C-a C-SPC C-e <down> C-a")
 "<right>" (kbd "C-SPC C-<right>") ;one word forward
 "<left>" (kbd "C-SPC C-<left>") ;one word backward
 "<down>" (kbd "C-a C-SPC <down>") ;one line forward
 "<up>" (kbd "C-a <down> C-SPC <up>") ;one line backward
 "1" (kbd "C-<left> C-SPC C-<right>")
 "M-1" (kbd "C-<left> C-SPC C-<right>")
 "2" (kbd "C-<left> C-SPC C-u 2 C-<right>")
 "3" (kbd "C-<left> C-SPC C-u 3 C-<right>")
 "4" (kbd "C-<left> C-SPC C-u 4 C-<right>")
 "5" (kbd "C-<left> C-SPC C-u 5 C-<right>")
 "6" (kbd "C-<left> C-SPC C-u 6 C-<right>")
 "\`" (kbd "C-<right> C-SPC C-<left>")
 "-2" (kbd "C-<right> C-SPC C-u 2 C-<left>")
 "-3" (kbd "C-<right> C-SPC C-u 3 C-<left>")
 "-4" (kbd "C-<right> C-SPC C-u 4 C-<left>")
 "-5" (kbd "C-<right> C-SPC C-u 5 C-<left>")
 "-6" (kbd "C-<right> C-SPC C-u 6 C-<left>")
 )
					; end M-1 map

(define-prefix-command 'Kopzon-2-map)
(global-set-key (kbd "M-2") 'Kopzon-2-map)
(general-define-key
 :prefix "M-2"
 "<next>" 'scroll-up-3-lines
 "<prior>" 'scroll-down-3-lines
					; "<insertchar>" 'mc/edit-lines
 "<deletechar>" 'next-multiframe-window
					; "<home>" 'save-buffers-kill-emacs
 "<end>" 'save-buffer
 "<select>" 'save-buffer

 "<right>" 'move-end-of-line
 "<left>" 'move-beginning-of-line
 )
					; end M-2 map

(define-prefix-command 'Kopzon-g-map)
(global-set-key (kbd "M-g") 'Kopzon-g-map)
(general-define-key
 :prefix "M-g"
 "g" 'goto-line
 "M-g" 'gtags-find-with-grep
 )
					; end M-g map

(global-set-key (kbd "M-\\") 'keyboard-quit)
(global-set-key (kbd "M-c") 'keyboard-quit )
(global-set-key (kbd "M-e") 'move-end-of-line)
(global-set-key (kbd "M-a") 'move-beginning-of-line)
(global-set-key (kbd "M-d") 'yank)
(global-set-key (kbd "C-d") 'yank)
(global-set-key (kbd "M-q") 'kill-region)
(global-set-key (kbd "M-i") 'evil-exit-emacs-state)
(global-set-key (kbd "C-i") 'evil-exit-emacs-state)
(global-set-key (kbd "M-\'") 'undo)
(global-set-key (kbd "M-l") 'recenter-top-bottom)
(global-set-key (kbd "<select>") 'move-end-of-line)
(global-set-key (kbd "M-n") (kbd "C-M-n"))
(global-set-key (kbd "M-p") (kbd "C-M-p"))
(global-set-key (kbd "M-u") (kbd "C-M-u"))

;;; End of .emacs file

;;##############################################################################
;; Auto saved macros
;;##############################################################################

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;(defalias 'todoKopzon
;  (kmacro "<up> M-e <return> / * * / <left> <left> SPC SPC <left> T O D O SPC P 0 SPC K o p z o n SPC - SPC"))
;(global-set-key (kbd "C-x / t") 'todoKopzon)

;(defalias 'commentKopzon
;  (kmacro "<up> M-e <return> / * * / <left> <left> SPC SPC <left>"))
;(global-set-key (kbd "C-x / c") 'commentKopzon)
