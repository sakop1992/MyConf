(deftheme ScaleIO_2
  "Created 2020-02-03.")

(custom-theme-set-faces
 'ScaleIO_2
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "yellow" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "unknown" :family "DejaVu Sans Mono"))))
 '(cursor ((t (:background "red2"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((t (:foreground "brown"))))
 '(minibuffer-prompt ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "medium blue"))))
 '(highlight ((t (:background "red3"))))
 '(region ((t (:foreground "cyan" :background "navy"))))
 '(shadow ((t (:foreground "grey50"))))
 '(secondary-selection ((t (:background "yellow1"))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 '(font-lock-builtin-face ((((class grayscale) (background light)) (:weight bold :foreground "LightGray")) (((class grayscale) (background dark)) (:weight bold :foreground "DimGray")) (((class color) (min-colors 88) (background light)) (:foreground "dark slate blue")) (((class color) (min-colors 88) (background dark)) (:foreground "LightSteelBlue")) (((class color) (min-colors 16) (background light)) (:foreground "Orchid")) (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue")) (((class color) (min-colors 8)) (:weight bold :foreground "blue")) (t (:weight bold))))
 '(font-lock-comment-delimiter-face ((t (:foreground "light gray" :inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:slant oblique :foreground "dark gray"))))
 '(font-lock-constant-face ((t (:weight bold :foreground "magenta"))))
 '(font-lock-doc-face ((t (:slant oblique :foreground "LightCoral" :inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:height 1.1 :weight bold :foreground "mediumspringgreen"))))
 '(font-lock-keyword-face ((t (:weight bold :foreground "orange red"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:slant italic :foreground "CornFlowerBlue" :inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:weight bold :inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:weight bold :inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "yellow green"))))
 '(font-lock-type-face ((t (:foreground "SteelBlue1"))))
 '(font-lock-variable-name-face ((t (:foreground "green"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "Pink" :inherit (error)))))
 '(button ((t (:weight bold :underline (:color foreground-color :style line) :box (:line-width 2 :color "grey" :style released-button) :foreground "black" :background "grey" :inherit (link)))))
 '(link ((t (:underline (:color foreground-color :style line) :foreground "white"))))
 '(link-visited ((t (:foreground "magenta4" :inherit (link)))))
 '(fringe ((t (:foreground "Wheat" :background "grey30"))))
 '(header-line ((t (:height 0.9 :box (:line-width -1 :color "grey20" :style released-button) :foreground "grey90" :background "grey20" :inherit (mode-line)))))
 '(tooltip ((t (:foreground "black" :background "lightyellow" :inherit (variable-pitch)))))
 '(mode-line ((t (:height 0.9 :weight light :box (:line-width 3 :color "grey75" :style released-button) :foreground "cyan" :background "gray0"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "green" :background "red"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:height 0.9 :weight light :box (:line-width 1 :color nil :style nil) :foreground "grey80" :background "gray30" :inherit (mode-line)))))
 '(isearch ((t (:foreground "yellow" :background "dark slate blue"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((t (:background "light slate blue"))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(next-error ((t (:background "blue3" :inherit (region)))))
 '(query-replace ((t (:foreground "brown4" :background "palevioletred2" :inherit (isearch))))))

(provide-theme 'ScaleIO_2)
