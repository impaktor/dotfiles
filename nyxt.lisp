;; describe-command <command>

;; Resources:
;; https://github.com/aartaka/nyxt-config/
;; https://discourse.atlas.engineer/c/nyxt/configuration-expose/8
;; https://wiki.archlinux.org/title/Nyxt

;; Want emacs-like key handling:
(define-configuration buffer
  ((default-modes
    (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

;; if a site is not rendered properly, open it in firefox
(define-command-global open-in-firefox ()
  "Open the current URL in Firefox"
  (uiop:run-program (list "firefox" (render-url (url (current-buffer))))))

;; Replace C-SPC with M-x as in emacs.
;; (Note: the override-map takes presidence over all, including input)
(define-configuration input-buffer
    ((override-map
      (let ((map (make-keymap "override-map")))
        (define-key map "M-x" 'execute-command "C-space" 'nothing)))))


;; Adblocking
(define-configuration web-buffer
  ((default-modes
    (pushnew 'nyxt/mode/blocker:blocker-mode %slot-value%))))

;; Reduce tracking, make fingerprint more generic
(define-configuration web-buffer
  ((default-modes
    (pushnew 'nyxt/mode/reduce-tracking:reduce-tracking-mode %slot-value%))))


;; see history-entry() https://github.com/atlas-engineer/nyxt/blob/master/source/history.lisp


;; (defvar *my-search-engines*
;;   (list
;;    '("google" "https://google.com/search?q=~a" "https://google.com")
;;    '("python3" "https://docs.python.org/3/search.html?q=~a" "https://docs.python.org/3")
;;    '("doi" "https://dx.doi.org/~a" "https://dx.doi.org/"))
;;   List of search engines.)
