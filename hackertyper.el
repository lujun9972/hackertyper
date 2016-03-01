(defcustom hackertyper-buffer "*hackertyper*"
  "")

(defvar-local hackertyper-content ""
  "zb时输入的文本")

(defun hackertyper-self-insert-command(&optional N)
  ""
  (interactive "P")
  (if (string= hackertyper-content "")
	  (self-insert-command (or N 1))
	(insert (elt hackertyper-content 0))
	(setq hackertyper-content (substring hackertyper-content 1))))

;;;###autoload
(define-derived-mode hackertyper-mode fundamental-mode "hackertyper"
  "Major mode for running hacker typer"
  (local-set-key  [remap self-insert-command] 'hackertyper-self-insert-command)
  )

;;;###autoload
(defun hackertyper ()
  "开启zb模式"
  (interactive)
  (switch-to-buffer (get-buffer-create hackertyper-buffer))
  (erase-buffer)
  (hackertyper-mode)
  (setq hackertyper-content (with-temp-buffer
                              (insert-file-contents  (read-file-name "从哪个文件导入装逼的内容?"))
                              (buffer-substring (point-min) (point-max)))))

(provide 'hackertyper)
