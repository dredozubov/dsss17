(dolist (path '("~/.nix-profile/share/emacs/site-lisp/ProofGeneral/generic"
                "~/.nix-profile/share/emacs/site-lisp/ProofGeneral/lib"
                "~/.nix-profile/share/emacs/site-lisp/ProofGeneral/coq"))
  (add-to-list 'load-path path))

(load "proof-site")
