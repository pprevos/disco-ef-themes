;;; disco-ef-themes --- Minor mode randomly switching between ef-themes

;;; Commentary:
;; Frivolous minor mode to randomly switch between any of the ef-themes.
;; Random theme based on whether the current theme is light or dark.

;;; Code:
(require 'ef-themes)

(defvar disco-ef-themes-timer nil
  "Stores the timer.")

(defvar disco-ef-themes-interval 10
  "Number of seconds between theme switches.")

(defun disco-ef-themes--start-timer ()
  "Start the timer for changing themes."
  (setq disco-ef-themes-timer
        (run-with-timer 0 disco-ef-themes-interval 'disco-ef-themes-load-random)))

(defun disco-ef-themes--stop-timer ()
  "Stop the timer for changing themes."
  (when disco-ef-themes-timer
    (cancel-timer disco-ef-themes-timer)
    (setq disco-ef-themes-timer nil)))

;;;###autoload
(defun disco-ef-themes-load-random ()
  "Load random Ef (εὖ/good) theme, based on current theme being light or dark."
  (interactive)
  (let* ((current-theme (car custom-enabled-themes))
         (theme-type (if (member current-theme ef-themes-light-themes)
                         'light 'dark)))
    (if (eq theme-type 'light)
        (ef-themes-load-random 'light)
      (ef-themes-load-random 'dark))))

;;;###autoload
(defun disco-ef-themes-change-shade ()
  "Toggle between light and dark themes."
  (interactive)
  (let* ((current-theme (car custom-enabled-themes))
         (theme-type (if (member current-theme ef-themes-light-themes)
                         'light 'dark)))
    (if (eq theme-type 'light)
        (ef-themes-load-random 'dark)
      (ef-themes-load-random 'light))))

(define-minor-mode disco-ef-themes-mode
  "Toggle disco-ef-themes minor mode."
  :init-value nil
  :lighter " Disco-EF")

;;;###autoload
(defun disco-ef-themes ()
  "Toggle the disco-ef-themes timer on and off."
  (interactive)
  (if disco-ef-themes-timer
      (disco-ef-themes--stop-timer)
    (disco-ef-themes--start-timer)))

(provide 'disco-ef-themes)
;;; disco-ef-themes ends here
