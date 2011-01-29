(require 'eim-extra)
(autoload 'eim-use-package "eim" "Another emacs input method")
(setq eim-use-tooltip nil)              ; don't use tooltip
(setq eim-punc-translate-p nil)         ; use English punctuation
(register-input-method
 "eim-py" "euc-cn" 'eim-use-package
 "拼音" "EIM Chinese Pinyin Input Method" "py.txt"
 'my-eim-py-activate-function)
(set-input-method "eim-py")             ; use Pinyin input method
(setq activate-input-method t)          ; active input method
(toggle-input-method nil)               ; default is turn off
(defun my-eim-py-activate-function ()
  (add-hook 'eim-active-hook
            (lambda ()
              (let ((map (eim-mode-map)))
                (define-key eim-mode-map "-" 'eim-previous-page)
                (define-key eim-mode-map "=" 'eim-next-page)))))

(provide 'eim-config)
