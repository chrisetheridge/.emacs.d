;;; package --- Magit
;;; Commentary:
;;; Magit
;;; Code:

(defun magit-commit-mode-init ()
  (when (looking-at "\n")
    (open-line 1)))

(add-hook 'git-commit-mode-hook 'magit-commit-mode-init)

;;; Keybinds

(global-set-key [f4] 'magit-status)

;;; magit.el ends here
