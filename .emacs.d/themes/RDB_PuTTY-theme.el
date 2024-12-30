(deftheme RDB_PuTTY
  "Created 2020-11-16.")

(custom-theme-set-faces
 'RDB_PuTTY
 '(cursor ((t (:background "red"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((((type w32)) (:foundry "outline" :family "Arial")) (t (:family "Sans Serif"))))
 '(escape-glyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(homoglyph ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "brown"))))
 '(minibuffer-prompt ((((background dark)) (:foreground "cyan")) (((type pc)) (:foreground "magenta")) (t (:foreground "medium blue"))))
 '(highlight ((((class color) (min-colors 88) (background light)) (:background "darkseagreen2")) (((class color) (min-colors 88) (background dark)) (:background "darkolivegreen")) (((class color) (min-colors 16) (background light)) (:background "darkseagreen2")) (((class color) (min-colors 16) (background dark)) (:background "darkolivegreen")) (((class color) (min-colors 8)) (:foreground "black" :background "green")) (t (:inverse-video t))))
 '(region ((t (:foreground "brightyellow" :background "brightblack"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "SkyBlue4")) (((class color) (min-colors 16) (background light)) (:background "yellow")) (((class color) (min-colors 16) (background dark)) (:background "SkyBlue4")) (((class color) (min-colors 8)) (:foreground "black" :background "cyan")) (t (:inverse-video t))))
 '(trailing-whitespace ((((class color) (background light)) (:background "red1")) (((class color) (background dark)) (:background "red1")) (t (:inverse-video t))))
 '(font-lock-builtin-face ((((class grayscale) (background light)) (:weight bold :foreground "LightGray")) (((class grayscale) (background dark)) (:weight bold :foreground "DimGray")) (((class color) (min-colors 88) (background light)) (:foreground "dark slate blue")) (((class color) (min-colors 88) (background dark)) (:foreground "LightSteelBlue")) (((class color) (min-colors 16) (background light)) (:foreground "Orchid")) (((class color) (min-colors 16) (background dark)) (:foreground "LightSteelBlue")) (((class color) (min-colors 8)) (:weight bold :foreground "blue")) (t (:weight bold))))
 '(font-lock-comment-delimiter-face ((t (:inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "color-246"))))
 '(font-lock-constant-face ((t (:foreground "blue"))))
 '(font-lock-doc-face ((t (:inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:foreground "brightred"))))
 '(font-lock-keyword-face ((t (:foreground "cyan"))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "brightwhite"))))
 '(font-lock-regexp-grouping-backslash ((t (:inherit (bold)))))
 '(font-lock-regexp-grouping-construct ((t (:inherit (bold)))))
 '(font-lock-string-face ((t (:foreground "color-31"))))
 '(font-lock-type-face ((t (:foreground "color-40"))))
 '(font-lock-variable-name-face ((t (:inherit (default)))))
 '(font-lock-warning-face ((t (:inherit (error)))))
 '(button ((t (:inherit (link)))))
 '(link ((t (:underline (:color foreground-color :style line) :foreground "cyan1"))))
 '(link-visited ((t (:foreground "violet" :inherit (link)))))
 '(fringe ((((class color) (background light)) (:background "grey95")) (((class color) (background dark)) (:background "grey10")) (t (:background "gray"))))
 '(header-line ((t (:box nil :foreground "grey90" :background "grey20" :inherit (mode-line)))))
 '(tooltip ((t (:foreground "black" :background "lightyellow" :inherit (variable-pitch)))))
 '(mode-line ((t (:height 0.9 :weight light :box (:line-width 1 :color "grey75" :style released-button) :foreground "white" :background "dark green"))))
 '(mode-line-buffer-id ((t (:width normal :height 1.1 :weight bold :foreground "brightyellow" :background "color-22"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:height 0.9 :weight light :box (:line-width 1 :color nil :style nil) :foreground "grey80" :background "gray30" :inherit (mode-line)))))
 '(isearch ((t (:foreground "yellow" :background "dark slate blue"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((t (:foreground "brightyellow" :background "light slate blue"))))
 '(match ((((class color) (min-colors 88) (background light)) (:background "yellow1")) (((class color) (min-colors 88) (background dark)) (:background "RoyalBlue3")) (((class color) (min-colors 8) (background light)) (:foreground "black" :background "yellow")) (((class color) (min-colors 8) (background dark)) (:foreground "white" :background "blue")) (((type tty) (class mono)) (:inverse-video t)) (t (:background "gray"))))
 '(next-error ((t (:background "blue3" :inherit (region)))))
 '(query-replace ((t (:foreground "brown4" :background "palevioletred2" :inherit (isearch)))))
 '(magit-diff-conflict-heading ((t (:inherit (magit-diff-hunk-heading)))))
 '(magit-diff-our ((t (:inherit (magit-diff-removed)))))
 '(magit-diff-base ((((class color) (background light)) (:foreground "#aaaa11" :background "#ffffcc")) (((class color) (background dark)) (:foreground "#ffffcc" :background "#555522"))))
 '(magit-diff-their ((t (:inherit (magit-diff-added)))))
 '(magit-diff-added ((((class color) (background light)) (:foreground "#22aa22" :background "#ddffdd")) (((class color) (background dark)) (:foreground "#ddffdd" :background "#335533"))))
 '(magit-diff-context ((((class color) (background light)) (:foreground "grey50")) (((class color) (background dark)) (:foreground "grey70"))))
 '(magit-diff-removed ((((class color) (background light)) (:foreground "#aa2222" :background "#ffdddd")) (((class color) (background dark)) (:foreground "#ffdddd" :background "#553333"))))
 '(magit-diffstat-added ((((class color) (background light)) (:foreground "#22aa22")) (((class color) (background dark)) (:foreground "#448844"))))
 '(magit-diff-our-highlight ((t (:inherit (magit-diff-removed-highlight)))))
 '(magit-diff-revision-summary-highlight ((t (:inherit (magit-diff-hunk-heading-highlight)))))
 '(magit-diff-base-highlight ((((class color) (background light)) (:foreground "#aaaa11" :background "#eeeebb")) (((class color) (background dark)) (:foreground "#eeeebb" :background "#666622"))))
 '(diff-added ((t (:background "#335533" :inherit (diff-changed)))))
 '(diff-index ((t (:inherit diff-file-header :background "black"))))
 '(diff-header ((t (:background "color-16"))))
 '(diff-context ((((class color grayscale) (min-colors 88) (background light)) (:foreground "#333333")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "#dddddd"))))
 '(diff-removed ((t (:background "#553333" :inherit (diff-changed)))))
 '(diff-changed ((t nil)))
 '(diff-function ((t (:inherit diff-header :background "black"))))
 '(diff-hunk-header ((t (:inherit diff-header :background "black"))))
 '(diff-indicator-added ((t (:inherit (diff-added)))))
 '(diff-refine-changed ((t (:background "color-23"))))
 '(diff-refine-added ((t (:inherit diff-refine-changed :background "color-22"))))
 '(diff-refine-removed ((t (:background "#aa2222" :inherit (diff-refine-changed)))))
 '(diff-indicator-removed ((t (:inherit (diff-removed)))))
 '(diff-indicator-changed ((t (:inherit (diff-changed)))))
 '(ediff-current-diff-A ((((class color) (min-colors 88) (background light)) (:background "#ffdddd")) (((class color) (min-colors 88) (background dark)) (:background "#553333")) (((class color) (min-colors 16)) (:background "pale green" :foreground "firebrick")) (((class color)) (:background "yellow3" :foreground "blue3")) (t (:inverse-video t))))
 '(magit-diff-whitespace-warning ((t (:inherit (trailing-whitespace)))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "color-22"))))
 '(smerge-refined-removed ((default (:inherit (smerge-refined-change))) (((class color) (min-colors 88) (background light)) (:background "#ffbbbb")) (((class color) (min-colors 88) (background dark)) (:background "#aa2222")) (t (:inverse-video t))))
 '(smerge-refined-changed ((t nil)))
 '(magit-reflog-merge ((t (:foreground "green"))))
 '(smerge-base ((t (:background "black"))))
 '(smerge-lower ((((class color) (min-colors 88) (background light)) (:background "#ddffdd")) (((class color) (min-colors 88) (background dark)) (:background "#335533")) (((class color)) (:foreground "green"))))
 '(smerge-upper ((((class color) (min-colors 88) (background light)) (:background "#ffdddd")) (((class color) (min-colors 88) (background dark)) (:background "#553333")) (((class color)) (:foreground "red"))))
 '(default ((t (:family "default" :foundry "default" :width normal :height 1 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "pale green" :background "color-234" :stipple nil :inherit nil)))))

(provide-theme 'RDB_PuTTY)