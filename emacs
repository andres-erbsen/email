(require 'notmuch)
(require 'undo-tree) ;; SETUP
(require 'evil) ;; SETUP
	(evil-mode 1) ;; SETUP

(autoload 'notmuch "notmuch" "notmuch mail" t)

(define-key notmuch-search-mode-map "a"
			(lambda ()
			  "archive message"
			  (interactive)
			  (notmuch-search-tag (list "+ham" "-spam" "-dormspam" "-inbox"))
			  (when (notmuch-search-get-result)
				(goto-char (notmuch-search-result-end)))))
(define-key notmuch-show-mode-map "a"
			(lambda ()
			  "archive message"
			  (interactive)
			  (notmuch-show-tag (list "+ham" "-spam" "-dormspam" "-inbox"))
			  (unless (notmuch-show-next-open-message)
				(notmuch-show-next-thread t))))
(define-key notmuch-show-mode-map "A"
			(lambda ()
			  "archive thread"
			  (interactive)
			  (notmuch-show-tag-all (list "+ham" "-spam" "-dormspam" "-inbox"))
			  (notmuch-show-next-thread t)))

(define-key notmuch-search-mode-map "d"
			(lambda ()
			  "mark message as dormspam"
			  (interactive)
			  (notmuch-search-tag (list "+ham" "-spam" "+dormspam" "-inbox"))
			  (when (notmuch-search-get-result)
				(goto-char (notmuch-search-result-end)))))
(define-key notmuch-show-mode-map "d"
			(lambda ()
			  "mark message as dormspam"
			  (interactive)
			  (notmuch-show-tag (list "+ham" "-spam" "+dormspam" "-inbox"))
			  (unless (notmuch-show-next-open-message)
				(notmuch-show-next-thread t))))
(define-key notmuch-show-mode-map "D"
			(lambda ()
			  "mark thread as dormspam"
			  (interactive)
			  (notmuch-show-tag-all (list "+ham" "-spam" "+dormspam" "-inbox"))
			  (notmuch-show-next-thread t)))

(define-key notmuch-search-mode-map "s"
			(lambda ()
			  "mark message as spam"
			  (interactive)
			  (notmuch-search-tag (list "-ham" "+spam" "-dormspam" "-inbox"))
			  (when (notmuch-search-get-result)
				(goto-char (notmuch-search-result-end)))))
(define-key notmuch-show-mode-map "s"
			(lambda ()
			  "mark message as spam"
			  (interactive)
			  (notmuch-show-tag (list "-ham" "+spam" "-dormspam" "-inbox"))
			  (unless (notmuch-show-next-open-message)
				(notmuch-show-next-thread t))))
(define-key notmuch-show-mode-map "S"
			(lambda ()
			  "mark thread as spam"
			  (interactive)
			  (notmuch-show-tag-all (list "-ham" "+spam" "-dormspam" "-inbox"))
			  (notmuch-show-next-thread t)))

(define-key notmuch-search-mode-map "k"
			(lambda ()
			  "mute thread"
			  (interactive)
			  (notmuch-search-tag (list "+muted-directly" "+muted" "+ham" "-spam" "-inbox"))
			  (when (notmuch-search-get-result)
				(goto-char (notmuch-search-result-end)))))
(define-key notmuch-show-mode-map "k"
			(lambda ()
			  "mute thread"
			  (interactive)
			  (notmuch-show-tag (list "+muted-directly"))
			  (notmuch-show-tag-all (list "+muted" "+ham" "-spam" "-inbox"))
			  (notmuch-show-next-thread t)))

(define-key notmuch-show-mode-map "o"
			(lambda () "open url" (interactive) (browse-url-at-point)))

(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "/home/oldie/browser.sh")

;; SETUP
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(browse-url-generic-program "/home/oldie/browser.sh" t)
 '(display-time-24hr-format t)
 '(mail-envelope-from (quote header))
 '(mail-host-address "andres.systems")
 '(mail-specify-envelope-from t)
 '(message-default-mail-headers "Cc: 
Bcc: 
")
 '(message-send-mail-function (quote message-send-mail-with-sendmail))
 '(message-sendmail-envelope-from (quote header))
 '(notmuch-crypto-process-mime (quote t))
 '(sendmail-program "msmtp"))

(load-file "~/.notmuch-queries.el")
