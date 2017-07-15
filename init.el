(add-to-list 'load-path "/home/nix/.nix-profile/share/emacs/site-lisp/elpa/use-package-2.3")
(add-to-list 'load-path "/home/nix/.nix-profile/share/emacs/site-lisp/elpa/bind-key-2.3")
(add-to-list 'load-path "/home/nix/.nix-profile/share/emacs/site-lisp/elpa/diminish-0.45")

(require 'use-package)

(use-package proof-site
  :load-path ("~/.nix-profile/share/emacs/site-lisp/ProofGeneral/generic"
              "~/.nix-profile/share/emacs/site-lisp/ProofGeneral/lib"
              "~/.nix-profile/share/emacs/site-lisp/ProofGeneral/coq")
  :config
  (use-package company-coq
    :load-path ("~/.nix-profile/share/emacs/site-lisp/elpa/dash-2.13.0"
                "~/.nix-profile/share/emacs/site-lisp/elpa/company-0.9.3"
                "~/.nix-profile/share/emacs/site-lisp/elpa/company-coq-1.0"
                "~/.nix-profile/share/emacs/site-lisp/elpa/yasnippet-0.11.0")
    :commands company-coq-mode
    :preface
    (use-package company-math
      :load-path "~/.nix-profile/share/emacs/site-lisp/elpa/company-math-1.2"
      :defer t
      :preface
      (use-package math-symbol-lists
        :load-path "~/.nix-profile/share/emacs/site-lisp/elpa/math-symbol-lists-1.2"
        :defer t))
    :config
    (unbind-key "M-<return>" company-coq-map))

  (use-package coq
    :no-require t
    :defer t
    :defines coq-mode-map
    :functions (proof-layout-windows coq-SearchConstant)
    :config
    (add-hook
     'coq-mode-hook
     (lambda ()
       (holes-mode -1)
       ;; (company-coq-mode 1)
       (set (make-local-variable 'fill-nobreak-predicate)
            (lambda ()
              (pcase (get-text-property (point) 'face)
                ('font-lock-comment-face nil)
                ((pred (lambda (x)
                         (and (listp x)
                              (memq 'font-lock-comment-face x)))) nil)
                (_ t))))))

    (bind-key "M-RET" #'proof-goto-point coq-mode-map)
    (bind-key "RET" #'newline-and-indent coq-mode-map)
    (defalias 'coq-Search #'coq-SearchConstant)
    (defalias 'coq-SearchPattern #'coq-SearchIsos)
    (bind-key "C-c C-a C-s" #'coq-Search coq-mode-map)
    (bind-key "C-c C-a C-o" #'coq-SearchPattern coq-mode-map)
    (bind-key "C-c C-a C-a" #'coq-SearchAbout coq-mode-map)
    (bind-key "C-c C-a C-r" #'coq-SearchRewrite coq-mode-map)
    (unbind-key "C-c h" coq-mode-map)))

(use-package tuareg
  :load-path "~/.nix-profile/share/emacs/site-lisp/tuareg-2.0.10"
  :mode (("\\.ml[ip]?\\'" . tuareg-mode)
         ("\\.eliomi?\\'" . tuareg-mode)))
