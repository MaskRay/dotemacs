(add-to-list 'load-path (expand-file-name "el-get/el-get" dotfiles-dir))

(if (require 'el-get nil t)
    (progn
      (message "el-get is already installed, try M-x el-get-update")
      (load "el-get-sources"))
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp)
     (load "el-get-sources"))))

(provide 'el-get-init)
