(defvar-local hackertyper-content ""
  "zb时输入的文本")

(defun hackertyper-self-insert-command-advise(&optional N)
  ""
  (interactive "P")
  (if (string= hackertyper-content "")
	  (progn 
		(hackertyper-disable)
		(self-insert-command (or N 1)))
	(insert (elt hackertyper-content 0))
	(setq hackertyper-content (substring hackertyper-content 1))))

;;;###autoload
(defun hackertyper-enable ()
  "开启zb模式"
  (interactive)
  (when (string= hackertyper-content "")
	(if (= (point) (point-max))
		(progn
		  (require 'file-helper)
		  (setq hackertyper-content (file-content (read-file-name "从哪个文件导入装逼的内容?"))))
	  (setq hackertyper-content (buffer-substring-no-properties (point) (point-max)))
	  (delete-region (point) (point-max))))
  (advice-add 'self-insert-command :override #'hackertyper-self-insert-command-advise))

;;;###autoload
(defun hackertyper-disable ()
  "关闭zb模式"
  (interactive)
  (advice-remove 'self-insert-command #'hackertyper-self-insert-command-advise))

(provide 'hackertyper)
