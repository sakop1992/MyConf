(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(compile-command "make clean; ./fast_make.py;")
 '(custom-enabled-themes '(leuven-dark))
 '(custom-safe-themes
   '("8d14ca041310cdebae19e846f71c6c70c031ba7f17699ff0587c867708c76952" "1a28f468437692af960830825b70b11d212d8003a51b9eb186bf11ff8b6c2cf5" "6fb5ca6ffa60a425099eb68d35c3f49ff09fbdfcb0ceaed1374a38802e16236c" "fb6e289eb079d7e020f57b19125265dc11635b22907f29375b5ad751b14e7f3c" "a408b0ae89841683a263bface3c6e0f3eabc84c7f4fc4bfe44133e6cf8b103c9" "976d3b93935d13987a6f4cb3521849b20de502a4e07c117780e8eb55c3761165" "1e933e721c4095077562fea9ed93b9353039aab2bc91a83c79a22cf9ba9f48b2" "ccf798935bc7b94f03e21c81c2ae51d7b35ee22d20c036a88e85314e85d3d0f3" "47fad18a93a63242796cc440157e8bd2ecafbe868fd9dab8b1470c684d8fd7f9" "284e04e855276e90b5db774dde622affd9549be3faefd8da1da5f1d33e7f4b0b" default))
 '(custom-theme-directory "~/.emacs.d/themes")
 '(display-line-numbers t)
 '(gud-gdb-command-name
   "gdb -i=mi --args ./Debug/gcc/test/gtest_all/gtest_all --gtest_filter=")
 '(package-selected-packages
   '(helm-lsp auto-complete-clang lsp-mode helm-flyspell flyspell-correct-helm helm-ispell undo-tree gtags-mode magit mo-git-blame general multiple-cursors helm-gtags helm)))

;;##############################################################################
;; Global stuff
;;##############################################################################

(setq-default mode-line-format
              (list
               ;; Current line and column
               "[L%l, C%c] "
               ;; File name
               " %b "))

;; Make Emacs recognize the Command key as Meta (Alt)
(setq mac-command-modifier 'meta)
(setq mac-option-modifier 'meta)

;; Open fileA and fileB at startup
(setq initial-buffer-choice nil)  ; Don't open a specific file on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))  ; Optional: Start Emacs maximized
(set-face-attribute 'default nil :height 140)

;; Open two specific files in different buffers
(setq inhibit-startup-screen t)
(defun open-my-files ()
  "Open fileA and fileB in separate buffers."
  (find-file "~/git/core/untrusted_proxy/enclave/configuration_manager.cpp")       ; Open fileA in the first buffer
  (split-window-right)           ; Split the window horizontally
  (other-window 1)               ; Move to the right window
  (find-file "~/.emacs")         ; Open fileB in the second buffer
  (other-window 1))              ; Move to the right window
;; Run the function after Emacs initializes
(add-hook 'emacs-startup-hook 'open-my-files)

(require 'ansi-color)
(defun my-ansi-colorize-compilation-buffer ()
  (ansi-color-apply-on-region compilation-filter-start (point)))
(add-hook 'compilation-filter-hook 'my-ansi-colorize-compilation-buffer)

(add-to-list 'load-path "~/.emacs.d/lisp")

(setq gtags-path "/opt/homebrew/bin/gtags")
(add-to-list 'exec-path gtags-path)
(setq helm-gtags-path-style 'relative)
(setenv "PATH" (concat "/opt/homebrew/bin:" (getenv "PATH")))
(setq exec-path (append exec-path '("/opt/homebrew/bin")))
(load-file "~/.emacs.d/lisp/gtags.el")

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Make Home and End keys behave as expected
(global-set-key (kbd "<home>") 'move-beginning-of-line)   ; Home key goes to beginning of line
(global-set-key (kbd "<end>") 'move-end-of-line)          ; End key goes to end of line

;; Optional: Support Shift + Home and Shift + End for text selection
(global-set-key (kbd "<S-home>") (lambda () (interactive) (set-mark-command nil) (beginning-of-line)))
(global-set-key (kbd "<S-end>") (lambda () (interactive) (set-mark-command nil) (end-of-line)))

(global-set-key (kbd "C-<right>") 'forward-word)  ; Example: Move forward by word
(global-set-key (kbd "C-<left>") 'backward-word)  ; Example: Move backward by word

;; TRAMP - Remote connect to dev VM.
(setq tramp-default-method "ssh")
(setq tramp-verbose 6) ;; Debugging info
(setq tramp-ssh-controlmaster-options
      "-o ControlMaster=auto -o ControlPath='~/.ssh/control-%%r@%%h:%%p' -o ControlPersist=no")
(setq remote-file-name-inhibit-cache nil)
(setq tramp-connection-timeout 10)
;; Disable remote shell configs
(setq tramp-remote-path '("/usr/bin" "/bin" "/usr/sbin" "/sbin"))
(global-set-key (kbd "C-x C-g") 'find-file)


;; Add MELPA repository to the list of package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

;;; .emacs -- Emacs configuration for Helm, Helm-Gtags, and fuzzy search

;; Ensure use-package is installed
(eval-when-compile
  (require 'use-package))

;;##############################################################################
;; Packages definitions
;;##############################################################################

;;; Helm configuration
(use-package helm
  :ensure t
  :config
  ;; Enable Helm mode
  (helm-mode 1)

  ;; Enable fuzzy matching for various Helm sources
  (setq helm-M-x-fuzzy-match t)
  (setq helm-buffers-fuzzy-matching t)
  (setq helm-recentf-fuzzy-match t)
  (setq helm-locate-fuzzy-match t)
  (setq helm-apropos-fuzzy-match t))
  (global-set-key (kbd "M-x") 'helm-M-x)
  (global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-display-buffer-height 5) ; Set max height
(setq helm-display-buffer-reuse-frame t) ; Reuse the current frame


;;; Helm-Gtags configuration
(use-package helm-gtags
  :ensure t
  :config
  ;; Suppress deprecated function warnings temporarily (not ideal for long-term)
  (setq helm-gtags-fuzzy-match t)
  ;; Enable helm-gtags mode and configure it
  (add-hook 'helm-gtags-mode-hook
            (lambda ()
              (setq helm-gtags-ignore-case t)
              (setq helm-gtags-auto-update t)))

  ;; Enable helm-gtags mode in programming-related modes
  (add-hook 'prog-mode-hook 'helm-gtags-mode))
(setq helm-gtags-project-root "~/git/core/")
(setq helm-gtags-debug t)

(define-key helm-map "\t" 'helm-execute-persistent-action)
(define-key helm-find-files-map "\t" 'helm-execute-persistent-action)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(setq helm-display-header-line nil)
(set-face-attribute 'helm-selection nil 
                    :background "purple"
                    :foreground "black")
(global-set-key (kbd "C-h b") 'helm-descbinds)
;(setq helm-gtags-highlight-candidate nil)
(setq helm-gtags-pulse-at-cursor 1)
;(setq helm-gtags-direct-helm-completing t)
(setq helm-gtags-direct-helm-completing t)
(setq helm-gtags-display-style 'detail)
;If this variable is non-nil, TAG file is updated after saving buffer
(setq helm-gtags-auto-update t)

;Positioning
(setq helm-split-window-in-side-p t)
(helm-autoresize-mode t)
(setq helm-autoresize-max-height 50)
(setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
(defun set-helm-auto-resize-max-height (hight)
  "Set helm buffer max hight"
  (interactive (list (read-from-minibuffer "helm-max-hight: " nil nil t))
  (setq helm-autoresize-max-height hight)));TODO Kopzon - doesn't work :(
(define-prefix-co\mmand 'Kopzon-h-map)
(global-set-key (kbd "M-h") 'Kopzon-h-map)
(general-define-key
 :prefix "M-h"
 "f" (lambda () (interactive) (setq helm-default-display-buffer-functions '(display-buffer-in-side-window)))
 "b" (lambda () (interactive) (setq helm-default-display-buffer-functions '(display-buffer-in-atom-window)))
 "min" (lambda () (interactive) (setq helm-autoresize-max-height 30))
 "med" (lambda () (interactive) (setq helm-autoresize-max-height 50))
 "max" (lambda () (interactive) (setq helm-autoresize-max-height 100)))

(setq helm-tramp-verbose 10)
(setq helm-tramp-ssh-connection-timeout 20)

(with-eval-after-load 'helm
  (define-key helm-find-files-map (kbd "<left>") 'left-char)   ; Move cursor left in minibuffer
  (define-key helm-find-files-map (kbd "<right>") 'right-char) ; Move cursor right in minibuffer
  (define-key helm-find-files-map (kbd "<up>") 'helm-previous-line)  ; Move up in the file list
  (define-key helm-find-files-map (kbd "<down>") 'helm-next-line))    ; Move down in the file list

;; Set the maximum width for file name column in Helm buffers
(setq helm-buffer-max-length 130)  ;; Allows for more space in the Helm buffer for file names




;;; Undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode))  ;; Enable undo-tree globally
(defun delete-undo-tree-files-on-buffer-kill ()
  "Delete the undo-tree files associated with the current buffer when the buffer is killed."
  (when (and (fboundp 'undo-tree-exclude-files) ;; Check if undo-tree package is available
             undo-tree-mode
             (file-exists-p (undo-tree-history-file-name)))
    (delete-file (undo-tree-history-file-name))))
(add-hook 'kill-buffer-hook 'delete-undo-tree-files-on-buffer-kill)

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
;; Flyspell-correct-helm Configuration (for correcting spelling interactively with Helm)
(use-package flyspell-correct-helm
  :ensure t
  :config
  ;; Bind the flyspell-correct-helm function to a key (e.g., C-;)
  (global-set-key (kbd "C-;") 'helm-flyspell-correct)
  ;; Set Helm as the interface for flyspell corrections
  (setq flyspell-correct-interface 'helm))
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
;(add-hook 'before-save-hook 'flyspell-buffer)
;; Optional: Customize the number of suggestions displayed by Helm for corrections
(setq flyspell-correct-helm-max-candidates 10) ;; Adjust this number as desired

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; Install and configure LSP mode
(use-package lsp-mode
  :ensure t
  :hook ((c-mode c++-mode python-mode) . lsp)
  :commands lsp
  :config
  (setq lsp-enable-symbol-highlighting t)
  (setq lsp-headerline-breadcrumb-enable nil) ;; Disable breadcrumb for cleaner UI
  (setq lsp-enable-snippet nil)) ;; Disable snippet support if not needed

(add-hook 'c++-mode-hook #'electric-pair-mode)

;(use-package clang-format
;  :ensure t
;  :config
;  (add-hook 'c++-mode-hook 'clang-format+-mode)  ; Enable clang-format+ mode for C++
;  (add-hook 'c-mode-hook 'clang-format+-mode)
;  (remove-hook 'before-save-hook 'clang-format-buffer)  ; Disable auto-format on save
;  (setq clang-format-on-save nil))  ; Disable auto-format on save
;
;(defun format-and-save ()
;  "Format the current region or buffer using clang-format, then save the buffer."
;  (interactive)
;  ;; Check if there is an active region
;  (if (use-region-p)
;      (clang-format-region (region-beginning) (region-end))  ;; Format the region
;    (clang-format-buffer))                                  ;; Format the entire buffer
;  ;; Save the buffer
;  (save-buffer))
;(global-set-key (kbd "C-x / /") 'format-and-save)
;
;(defun my-clang-format-on-return-and-semicolon ()
;  "Format the code using clang-format when pressing RET or ;."
;  (local-set-key (kbd ";")
;                 (lambda ()
;                   (interactive)
;                   (self-insert-command 1)
;                   (clang-format-region (line-beginning-position) (point)))))
;
;(add-hook 'c++-mode-hook 'my-clang-format-on-return-and-semicolon)
;(add-hook 'c-mode-hook 'my-clang-format-on-return-and-semicolon)


;;##############################################################################
;; Functions
;;##############################################################################

; Shift line up/down
(defun move-text-internal (arg)
   (cond
    ((and mark-active transient-mark-mode)
     (if (> (point) (mark))
            (exchange-point-and-mark))
     (let ((column (current-column))
              (text (delete-and-extract-region (point) (mark))))
       (forward-line arg)
       (move-to-column column t)
       (set-mark (point))
       (insert text)
       (exchange-point-and-mark)
       (setq deactivate-mark nil)))
    (t
     (beginning-of-line)
     (when (or (> arg 0) (not (bobp)))
       (forward-line)
       (when (or (< arg 0) (not (eobp)))
            (transpose-lines arg))
       (forward-line -1)))))
(defun move-text-down (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines down."
   (interactive "*p")
   (move-text-internal arg))
(defun move-text-up (arg)
   "Move region (transient-mark-mode active) or current line
  arg lines up."
   (interactive "*p")
   (move-text-internal (- arg)))
(global-set-key [(control shift up)]  'move-text-up)
(global-set-key [(control shift down)]  'move-text-down)

;TODO Kopzon - understand how macros can be saved by emacs itself and remove this function
(defun save-macro (name key)
    "save a macro. Take a name and key as argument
     and save the last defined macro under
     this name and keyboard shortcut under this key
     at the end of your .emacs"
     (interactive "SName of the macro: \nsKey: ")  ; ask for the name and key of the macro
     (kmacro-name-last-macro name)                 ; use this name for the macro
     (find-file user-init-file)                    ; open ~/.emacs or other user init file
     (goto-char (point-max))                       ; go to the end of the .emacs
     (newline)                                     ; insert a newline
     (insert-kbd-macro name)                       ; copy the macro
     (call-interactively 'eval-last-sexp)
     (insert "(global-set-key (kbd \"C-x ")
     (insert key)
     (insert "\") ")
     (insert "\'" (symbol-name name))
     (insert ")")
     (call-interactively 'eval-last-sexp)
     (newline)                                     ; insert a newline
     (switch-to-buffer nil))                       ; return to the initial buffer

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

;; Fix toggle-read-only issue
(defun toggle-read-only (arg)
  "Toggle read-only status for the current buffer.
If ARG is non-nil, set the buffer to read-only.
If ARG is nil or 0, make the buffer writable."
  (interactive "P")
  (setq buffer-read-only
        (if (null arg)                  ; If no argument or arg is 0
            (not buffer-read-only)      ; Toggle the current state
          (if (memq (prefix-numeric-value arg) '(4 t)) ; If ARG is `t` or `4`
              t
            nil)))                      ; Otherwise, make the buffer writable
  (message (if buffer-read-only "Buffer is now read-only" "Buffer is now writable")))

;(defun git-blame-to-buffer ()
;  "Run `git blame` on the current file and display the result in a new buffer."
;  (interactive)
;  (let ((file (buffer-file-name)))
;    (if file
;        (with-output-to-temp-buffer "*git-blame*"
;          (shell-command (format "git blame %s" file) "*git-blame*"))
;      (message "This buffer is not visiting a file."))))
;(global-set-key '[f8] 'git-blame-to-buffer)


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

;TODO P0 Kopzon remove
;; Customizations for all modes in CC Mode.
;(defun my-c-mode-common-hook ()
;  ;; set my personal style for the current buffer
;  (c-set-style "Kopzon Style")
;  ;; other customizations
;  (setq tab-width 4
;        ;; this will make sure spaces are used instead of tabs
;        indent-tabs-mode nil))
;(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;; Spell checking
(defun my-save-word ()
  (interactive)
  (let ((current-location (point))
        (word (flyspell-get-word)))
    (when (consp word)
      (flyspell-do-correct 'save nil (car word) current-location (cadr word) (caddr word) current-location))))
(add-to-list 'ispell-skip-region-alist '("^#include" forward-line))

; Multiple cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-x <down>") 'mc/edit-lines)
(global-set-key (kbd "C-x n") 'mc/mark-next-like-this)
(global-set-key (kbd "C-x p") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-x a") 'mc/mark-all-like-this)
(global-unset-key (kbd "M-<down-mouse-1>"))
(global-set-key (kbd "M-<mouse-1>") 'mc/add-cursor-on-click)

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
(defun grep-Kopzon--run (search-folder pattern-to-search &optional extra-args)
  "Run grep with specified arguments.
SEARCH-FOLDER is the folder to search in.
PATTERN-TO-SEARCH is the search pattern.
EXTRA-ARGS is a string containing additional arguments for grep."
  (let* ((default-directory search-folder)
         (command (format (concat "grep "
                                  "-rn "
                                  "--exclude '*~' "
                                  "--exclude '*#' "
                                  "--exclude '*TAGS' "
                                  "--exclude-dir '.git' "
                                  "%s "
                                  "'%s' "
                                  ".")
                          (or extra-args "")
                          pattern-to-search)))
    ;; Run the grep command
    (grep command)
    ;; Switch to the *grep* buffer after running the command
    (switch-to-buffer-other-window "*grep*")
    (highlight-phrase pattern-to-search 'hi-yellow)))

(defun grep-Kopzon--get-pattern (default-pattern)
  "Get the search pattern interactively, defaulting to DEFAULT-PATTERN.
If the user presses Enter without typing anything, DEFAULT-PATTERN is returned."
  (read-from-minibuffer
   (if default-pattern
       (format "Enter pattern to search (default: %s): " default-pattern)
     "Enter pattern to search: ")
   nil nil nil nil default-pattern))

(defun grep-Kopzon-rn-at-point ()
  "Run grep --color -rn for a user-specified or default word at point in the project root directory."
  (interactive)
  (let* ((default-pattern (thing-at-point 'word t))
         (pattern-to-search (grep-Kopzon--get-pattern default-pattern))
         (search-folder (or (project-root (project-current))
                            (error "Project root not found"))))
    (grep-Kopzon--run search-folder pattern-to-search)))

(defun grep-Kopzon-rni-at-point ()
  "Run grep --color -rni for a user-specified or default word at point in the project root directory."
  (interactive)
  (let* ((default-pattern (thing-at-point 'word t))
         (pattern-to-search (grep-Kopzon--get-pattern default-pattern))
         (search-folder (or (project-root (project-current))
                            (error "Project root not found"))))
    (grep-Kopzon--run search-folder pattern-to-search "-i")))

(defun grep-Kopzon-rn (pattern-to-search search-folder)
  "Run grep --color -rn <pattern-to-search> <search-folder>."
  (interactive 
   (list 
    (read-from-minibuffer "Pattern to search: " nil nil t)
    (read-directory-name "Directory to search in: " nil nil t)))
  (grep-Kopzon--run search-folder pattern-to-search))

(defun grep-Kopzon-rni (pattern-to-search search-folder)
  "Run grep --color -rni <pattern-to-search> <search-folder> (case-insensitive)."
  (interactive 
   (list 
    (read-from-minibuffer "Pattern to search: " nil nil t)
    (read-directory-name "Directory to search in: " nil nil t)))
  (grep-Kopzon--run search-folder pattern-to-search "-i"))

(defun grep-Kopzon-rni-include (pattern-to-search search-folder file-name-pattern)
  "Run grep --color -rni --include=<file-name-pattern> -e <pattern-to-search> <search-folder>."
  (interactive 
   (list 
    (read-from-minibuffer "Pattern to search: " nil nil t)
    (read-directory-name "Directory to search in: " nil nil t)
    (read-from-minibuffer "File name pattern to search in: " nil nil t)))
  (grep-Kopzon--run search-folder pattern-to-search 
                    (format "-i --include='*%s*'" file-name-pattern)))

;; Key binding for convenience
(global-set-key (kbd "C-x g") 'grep-Kopzon-rni)

;;##############################################################################
;; Maps
;;##############################################################################

(define-prefix-command 'Kopzon-r-map)
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
 "e" 'ediff-buffers
 "pl" 'xah-pop-local-mark-ring
 "po" 'pop-global-mark
 "M-b" 'helm-buffers-list
 "bb" 'helm-bookmarks
 "bs" 'bookmark-set
 "bd" 'bookmark-delete
 "bj" 'bookmark-jump
 "h" 'helm-cycle-resume
 "o" 'other-window
 "i" 'helm-imenu ;outline
 "d" 'helm-show-kill-ring
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
 "\\" 'helm-find-files
 "M-f" 'helm-find-files
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
 "//" 'format-and-save
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
 
 "§" 'helm-gtags-pop-stack
 "`" 'helm-gtags-pop-stack
 "3" 'helm-gtags-find-tag
 "M-3" 'helm-gtags-find-tag
 "gt" 'helm-gtags-find-tag
 "1" 'helm-gtags-find-rtag
 "M-1" 'helm-gtags-find-rtag
 "gr" 'helm-gtags-find-rtag
 "2" 'helm-gtags-find-symbol
 "M-2" 'helm-gtags-find-symbol
 "gs" 'helm-gtags-find-symbol
 "4" 'helm-gtags-find-pattern
 "M-4" 'helm-gtags-find-pattern
 "gp" 'helm-gtags-find-pattern
 "<up>" 'helm-gtags-resume
 "ss" 'helm-gtags-show-stack
)
; End of r-map

(define-prefix-command 'Kopzon-3-map)
(global-set-key (kbd "M-3") 'Kopzon-3-map)
;key (kbd "M-3") 'Kopzon-3-map
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

 "`" 'helm-gtags-pop-stack
 "3"  'helm-buffers-list
 "M-3"  'helm-buffers-list
 "9"  'one-gud-window
 "M-b" 'helm-buffers-list
 "k" 'kill-buffer
 "/." 'dot-emacs
 "//" 'format-and-save
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
 "<up>" 'helm-gtags-resume
 "ss" 'helm-gtags-show-stack
)
;;end M-3 map

(define-prefix-command 'Kopzon-g-map)
(global-set-key (kbd "M-g") 'Kopzon-g-map)
(general-define-key
 :prefix "M-g"
 "g" 'goto-line
 "<up>" 'move-text-up
 "<down>" 'move-text-down
 "M-g" 'grep-Kopzon-rn-at-point
 "M-i" 'grep-Kopzon-rni-at-point
 "M-d" 'grep-Kopzon-rn
 "<right>" (kbd "C-u 4 C-x <tab>")
 "<left>" (kbd "C-u -4 C-x <tab>"))
;g-map end

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
 "M-b" 'helm-buffers-list
 "/." 'dot-emacs
 "//" 'format-and-save
 "o" (kbd "C-x o")
 "j"  'ace-jump-mode
 "pl" 'xah-pop-local-mark-ring
 "po" 'pop-global-mark
 "M-b" 'helm-buffers-list

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

(global-set-key (kbd "M-\\") 'keyboard-quit)
(global-set-key (kbd "M-c") 'keyboard-quit )
(global-set-key (kbd "M-e") 'move-end-of-line)
(global-set-key (kbd "M-a") 'move-beginning-of-line)
(global-set-key (kbd "M-d") 'yank)
(global-set-key (kbd "C-d") 'yank)
(global-set-key (kbd "M-q") 'kill-region)
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

(defalias 'todoKopzon
   (kmacro "<up> M-e <return> / * * / <left> <left> SPC SPC <left> T O D O SPC P 0 SPC K o p z o n SPC - SPC"))
(global-set-key (kbd "C-x / t") 'todoKopzon)

(defalias 'commentKopzon
   (kmacro "<up> M-e <return> / * * / <left> <left> SPC SPC <left>"))
(global-set-key (kbd "C-x / c") 'commentKopzon)
