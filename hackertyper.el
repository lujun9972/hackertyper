(defcustom hackertyper-buffer "*hackertyper*"
  "")

(defvar hackertyper-content ""
  "zb时输入的文本")

(defun hackertyper-self-insert-command(&optional N)
  ""
  (interactive "P")
  (if (string= hackertyper-content "")
	  (self-insert-command (or N 1))
	(insert (elt hackertyper-content 0))
	(setq hackertyper-content (substring hackertyper-content 1))))

;;;###autoload
(defun hackertyper ()
  "开启zb模式"
  (interactive)
  (let ((old-buffer-list (buffer-list))
        (new-buffer-list (progn
                           (find-file (read-file-name "从哪个文件导入装逼的内容?"))
                           (buffer-list)))
        (file-major-mode major-mode))
    (setq hackertyper-content (buffer-substring (point-min) (point-max)))
    (when (> (length new-buffer-list)
             (length old-buffer-list))
      (kill-buffer))
    (switch-to-buffer (get-buffer-create hackertyper-buffer))
    (erase-buffer)
    (funcall file-major-mode)
    (local-set-key  [remap self-insert-command] 'hackertyper-self-insert-command)))

(provide 'hackertyper)
