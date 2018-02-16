;; set load-path
(setq load-path
      (append
	 load-path
         (list
	  (expand-file-name "~gpitool/emacs/elisp")
;;	  (expand-file-name "~luizca/elisp")
	 )
      )
)

(require 'ps-print) ; load ps-print package

; Configuracao da impressao
(setq ps-spool-duplex t              ; both side
      ps-paper-type 'a4              ; paper type
      ps-printer-name 'imp_030       ; the printer's name
      ps-zebra-stripes t             ; turn on zebra stripes
      ps-landscape-mode t            ; turn on landscape
      ps-number-of-columns 2         ; print on 2 columns
      ps-left-margin 35              ; Acerta margem esquerda
      ps-inter-column 20             ; Espaco entre colunas
      ps-right-margin 35             ; Zero de margem direita
      ps-line-number t               ; turn on line number
      ps-print-only-one-header t     ; only one header over all columns
      ps-background-text '(("Preliminary"))  ; print "Preliminary" on 
					; the background
      )


; modifica cores do font-lock-mode
(require 'font-lock)
(set-face-foreground 'font-lock-builtin-face "orange")
(set-face-foreground 'font-lock-comment-face "red")
(set-face-foreground 'font-lock-constant-face "Tan")
(set-face-foreground 'font-lock-function-name-face "lightblue")
(set-face-foreground 'font-lock-keyword-face "CornflowerBlue")
(set-face-foreground 'font-lock-string-face "Aquamarine")
(set-face-foreground 'font-lock-type-face "green")
(set-face-foreground 'font-lock-variable-name-face "white")
(set-foreground-color "yellow")
(set-background-color "black")
(set-cursor-color "white")
;(set-face-foreground 'font-lock-warning-name-face "")

;; Tell cc-mode not to check for old-style (K&R) function declarations.
;; This speeds up indenting a lot.
(setq c-recognize-knr-p nil)

; carrega font-lock-mode automaticamente para c-mode e compilation-mode
;(add-hook 'c-mode-hook 'turn-on-font-lock)
;(add-hook 'compilation-mode-hook 'turn-on-font-lock)
;(add-hook 'makefile-mode-hook 'turn-on-font-lock)
; carrega font-lock-mode automaticamente para todos os modos
(global-font-lock-mode t)

(setq require-final-newline t)

;       '(("\\.C$" . IBM-c-mode)
;	 ("\\.H$" . IBM-c-mode)
;	 ("\\.tcl$" . tcl-mode)
;	 ("\\.tc$" . tcl-mode)
;        ("\\.pc\\'" . c-mode)
;        ("\\.awk\\$" . awk-mode)
;        ("\\.k\\$" . awk-mode)
;        ("\\.d$" . d-mode)
;	 ("\\.mkf$" . makefile-mode)
;	 ("mk" . makefile-mode)

; carrega c-mode para arquivos .pc
(setq auto-mode-alist
      (append 
       '(("\\.pc" . c-mode)
	 ("\\.x"  . c-mode)
	 ("\\.de" . d-mode)
	 ("\\.mkf" . makefile-mode)
	 ("\\.k" . awk-mode)
	 ("\\.awk" . awk-mode)
	 ("\\.mkf$" . makefile-mode)
	 ("mk" . makefile-mode)
        )
       auto-mode-alist))

(column-number-mode 1)

(put 'eval-expression 'disabled nil)

; Funcoes novas.
(defun insert-strcmp_diff ()
  "insert strcmp (, ) at cursor point."
  (interactive)
  (insert "strcmp (, )")
  (backward-char 3))

(defun insert-strcmp_ig ()
  "insert !strcmp (, ) at cursor point."
  (interactive)
  (insert "!strcmp (, )")
  (backward-char 3))

(defun insert-strcpy ()
  "insert strcpy (, ); at cursor point."
  (interactive)
  (insert "strcpy (, );")
  (backward-char 4))

(defun insert-if ()
  "insert a simple if clausule at cursor point."
  (interactive)
  (insert "if () {\n\n}\n")
  (backward-char 7))

(defun insert-while ()
  "insert a while clausule at cursor point."
  (interactive)
  (insert "while () {\n\n}\n")
  (backward-char 7))

(defun insert-string-vazia ()
  "insert a STRING_VAZIA constant at cursor point."
  (interactive)
  (insert "STRING_VAZIA"))

(defun insert-valor-nulo-numerico ()
  "insert a VALOR_NULO_NUMERICO constant at cursor point."
  (interactive)
  (insert "VALOR_NULO_NUMERICO"))

(defun insert-seta ()
  "insert a -> simbol at cursor point."
  (interactive)
  (insert "->"))

(defun insert-return-ok ()
  "insert a return (OK); text at cursor point."
  (interactive)
  (insert "return (OK);"))

(defun insert-return-nok ()
  "insert a return (NOK); text at cursor point."
  (interactive)
  (insert "return (NOK);"))

(defun insert-comentario ()
  "insert /*  */ at cursor point."
  (interactive)
  (insert "/*  */")
  (backward-char 3))

(defun insert-len-arr ()
  "insert .len = strlen (.arr); at cursor point."
  (interactive)
  (insert ".len = strlen (.arr);\n"))

(defun insert-arr-len ()
  "insert .arr[.len] = '\0'; at cursor point."
  (interactive)
  (insert ".arr[.len] = '\\0';\n"))

(defun insert-include ()
  "insert #include "" at cursor point."
  (interactive)
  (insert "#include \"\"")
  (backward-char 1))

(defun insert-registra-erro ()
  "insert BG_ARegistraErro (, "", STRING_VAZIA, STRING_VAZIA); at cursor point."
  (interactive)
  (insert "BG_ARegistraErro (, \"\", STRING_VAZIA, STRING_VAZIA);")
  (backward-char 34))

; Relogio no formato 24 horas
(setq display-time-24hr-format 1)
(display-time)

; Definicao de Teclado
;(global-set-key [?\C-.] 'compile)
;(global-set-key [?\C-c ?g] 'goto-line)



;(global-set-key [f14] 'undo)
;(global-set-key [f16] 'kill-ring-save)
;(global-set-key [f17] 'find-file)
;(global-set-key [f18] 'yank)
;(global-set-key [f19] 'search-forward)
;(global-set-key [?\M-f19] 'search-forward-regexp)
;(global-set-key [f20] 'kill-region)

(global-set-key [?\C-+] 'insert-strcmp_diff)
(global-set-key [?\C-=] 'insert-strcmp_ig)
(global-set-key [?\C--] 'insert-strcpy)
(global-set-key [?\C-_] 'insert-if)
(global-set-key [?\C-)] 'insert-while)
(global-set-key [?\C-(] 'insert-string-vazia)
(global-set-key [?\C-*] 'insert-valor-nulo-numerico)
(global-set-key [?\C-&] 'insert-seta)
(global-set-key [?\C-^] 'insert-return-ok)
(global-set-key [?\C-%] 'insert-return-nok)
(global-set-key [?\C-$] 'insert-comentario)
(global-set-key [?\C-#] 'insert-len-arr)
(global-set-key [?\C-@] 'insert-arr-len)
(global-set-key [?\C-!] 'insert-include)
(global-set-key [?\C-~] 'insert-registra-erro)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)

(global-set-key [C-home] 'beginning-of-buffer)
(global-set-key [C-end] 'end-of-buffer)

(global-set-key [f2] 'save-buffer)
(global-set-key [f3] 'kill-buffer)
(global-set-key [f4] 'goto-line)
(global-set-key [f5] 'query-replace)
(global-set-key [f6] 'undo)
(global-set-key [f7] 'repeat)
(global-set-key [f8] 'font-lock-fontify-buffer)
(global-set-key [f9] 'indent-region)

; Carrega D-mode
;(load "d-init")
;(load "d-mode")
;(load "em-version")
;(load "d-font-lock")

(setq text-mode-hook 'turn-on-auto-fill)
;(setq-default fill-column 80)


(autoload 'vm "vm" "Start VM on your primary inbox." t)
(autoload 'vm-other-frame "vm" "Like `vm' but starts in another frame." t)
(autoload 'vm-visit-folder "vm" "Start VM on an arbitrary folder." t)
(autoload 'vm-visit-virtual-folder "vm" "Visit a VM virtual folder." t)
(autoload 'vm-mode "vm" "Run VM major mode on a buffer" t)
(autoload 'vm-mail "vm" "Send a mail message using VM." t)
(autoload 'vm-submit-bug-report "vm" "Send a bug report about VM." t)

; (setq load-path  '("/net/gnu/share/emacs/site-lisp/elib" "/net/gnu/share/emacs/20.3/site-lisp" "/net/gnu/share/emacs/site-lisp" "/net/gnu/share/emacs/site-lisp/auctex" "/net/gnu/share/emacs/site-lisp/elib" "/net/gnu/share/emacs/site-lisp/auctex/style" "/net/gnu/share/emacs/20.3/leim" "/net/gnu/share/emacs/20.3/lisp" "/net/gnu/share/emacs/20.3/lisp/textmodes" "/net/gnu/share/emacs/20.3/lisp/progmodes" "/net/gnu/share/emacs/20.3/lisp/play" "/net/gnu/share/emacs/20.3/lisp/mail" "/net/gnu/share/emacs/20.3/lisp/language" "/net/gnu/share/emacs/20.3/lisp/international" "/net/gnu/share/emacs/20.3/lisp/gnus" "/net/gnu/share/emacs/20.3/lisp/emulation" "/net/gnu/share/emacs/20.3/lisp/emacs-lisp" "/net/gnu/share/emacs/20.3/lisp/calendar" "/home/andrels/elisp"))

(custom-set-variables
 '(vm-mime-charset-font-alist nil t)
 '(mail-signature (quote ~/\.signature) t)
 '(vm-mime-default-face-charsets (quote ("iso-8859-1" "us-ascii")) t))
(custom-set-faces)

; carrega iso-accents-mode para mail-mode
(add-hook 'mail-mode-hook 'iso-accents-mode)
(add-hook 'vm-mode' 'iso-accents-mode)

; (require 'hilit19)

(put 'upcase-region 'disabled nil)

;;; Emacs/W3 Configuration
(setq load-path (cons "/share/emacs/site-lisp" load-path))
(condition-case () (require 'w3-auto "w3-auto") (error nil))

(put 'downcase-region 'disabled nil)
