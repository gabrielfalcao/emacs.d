(defun get-window-list()
  (let* ((result-windows (list)))
    (walk-windows (lambda (win) (push win result-windows)))
    result-windows))
