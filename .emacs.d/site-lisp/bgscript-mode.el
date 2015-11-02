; Author: Greyson Fischer <gfischer@dxysolutions.com>
; Copyright: 2012 DXY Solutions
; License: GPLv2

; bgscript-mode hook allows the user to run their own code when this
; mode is run.

(defvar bgscript-mode-hook nil)

; Create a keymap

(defvar bgscript-mode-map
  (let ((map (make-keymap)))
    (define-key map "\C-j" 'newline-and-indent)
	(define-key map "\t" 'bgscript-indent-line)
    map)
  "Keymap for BGScript major mode")

; Map to the standard filename

(add-to-list 'auto-mode-alist '("\\.bgs\\'" . bgscript-mode))

; Define the basic level of syntax highlighting

(defvar bgscript-keywords
  (format
   "\\<%s\\>"
   (regexp-opt
    '("if" "const" "then" "else" "end" "event" "while" "call" "dim" "let" "procedure" "export")))
  "BGScript keywords")

(defvar bgscript-types
  (format
   "\\<%s\\>"
   (regexp-opt
    '("sfloat" "float")))
  "BGScript types")
(defvar bgscript-constants
  (format
   "\\<%s\\>"
   (regexp-opt
    '("gap_general_discoverable" "gap_undirected_connectable")))
  "BGScript constants")
(defvar bgscript-functions
  (format
   "\\<%s\\>"
   (regexp-opt
    '("memcpy" "memcmp"
      "attclient_attribute_write" "attclient_execute_write" "attclient_find_by_type_value"
      "attclient_find_information" "attclient_prepare_write" "attclient_read_by_group_type"
      "attclient_read_by_handle" "attclient_read_by_type" "attclient_read_long"
      "attclient_read_multiple" "attclient_write_command"
      "attributes_read" "attributes_read_type" "attributes_user_response" "attributes_write"
      "connection_disconnect" "connection_get_rssi" "connection_get_status" "connection_update"
      "connection_version_update"
      "gap_connect_direct" "gap_connect_selective" "gap_discover" "gap_end_procedure"
      "gap_set_adv_data" "gap_set_adv_parameters" "gap_set_directed_connectable_mode"
      "gap_set_filtering" "gap_set_mode" "gap_set_privacy_flags" "gap_set_scan_parameters"
      "hardware_adc_read" "hardware_i2c_read" "hardware_i2c_write"
      "hardware_io_port_config_direction" "hardware_io_port_config_function"
      "hardware_io_port_config_irq" "hardware_io_port_config_pull" "hardware_io_port_read"
      "hardware_io_port_write" "hardware_set_soft_timer" "hardware_set_txpower"
      "hardware_spi_config" "hardware_spi_transfer"
      "flash_ps_defrag" "flash_ps_dump" "flash_ps_erase_all" "flash_ps_erase"
      "flash_ps_load" "flash_ps_save"
      "sm_delete_bonding" "sm_encrypt_start" "sm_get_bonds" "sm_passkey_entry"
      "sm_set_bondable_mode" "sm_set_oob_data" "sm_set_parameters"
      "system_address_get" "system_endpoint_tx" "system_get_connections" "system_get_counters"
      "system_get_info" "system_hello" "system_reset" "system_whitelist_append"
      "system_whitelist_clear" "system_whitelist_remove"
      )))
  "BGScript functions")
(defvar bgscript-events
  (format
   "\\<%s\\>"
   (regexp-opt
    '("attclient_attribute_found" "attclient_attribute_value" "attclient_find_information_found"
      "attclient_group_found" "attclient_indicated" "attclient_procedure_completed"
      "attclient_read_multiple_response"
      "attributes_user_request" "attributes_value"
      "connection_disconnected" "connection_feature_ind" "connection_status" "connection_version_ind"
      "gap_mode_changed" "gap_scan_response"
      "hardware_adc_result" "hardware_io_port_status" "hardware_soft_timer"
      "flash_ps_key"
      "sm_bonding_fail" "sm_bond_status" "sm_passkey_display" "sm_passkey_request" "sm_smp_data"
      "system_boot" "system_endpoint_rx"
      )))
  "BGScript event names")

;; Create the font-lock
(defvar bgscript-font-lock-keywords
  `( (,bgscript-keywords . font-lock-keyword-face)
	 (,bgscript-types . font-lock-type-face)
	 (,bgscript-constants . font-lock-constant-face)
	 (,bgscript-functions . font-lock-function-name-face)
	 (,bgscript-events . font-lock-builtin-face) ))

;;
;; Indentation rules
;;

(defvar bgscript-default-tab-width 3)

(defun bgscript-indent-line ()
  "Indent current line as BGScript code"
  (interactive)
  (let ((savep (> (current-column) (current-indentation)))
		(indent (condition-case nil (max (bgscript-calculate-indentation) 0)
				  (error 0))))
	(if savep
		(save-excursion (indent-line-to indent))
	  (indent-line-to indent)) ))

(defun bgscript-calculate-indentation ()
  "Return the column to which the current line should be indented"
  (beginning-of-line)
  (cond ((bobp) 0)
		((looking-at "^[ \t]*\\(e\\(nd\\|lse\\)\\)\\>")
		 (- (bgscript-last-indentation) bgscript-default-tab-width))
		(t (bgscript-last-indentation)) ))

(defun bgscript-last-indentation ()
  "Walk backwards until a line with a distinct indentation marker appears"
  (let ((cur-indent nil))
	(save-excursion
	  (while (not cur-indent)
		  (forward-line -1)
		  (cond ((bobp) (setq cur-indent 0))
				((looking-at "^[ \t]*\\(e\\(vent\\|lse\\)\\|if\\)\\>")
				 (setq cur-indent (+ (current-indentation) bgscript-default-tab-width)))
				((looking-at "^[ \t]*end\\>")
				 (setq cur-indent (current-indentation))) )))
	cur-indent))

; Syntax table
(defvar bgscript-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?\# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?\r ">" table)
    table)
  "Syntax table for BGScript mode")

; Define the mode
(defun bgscript-mode ()
  "Major mode for editing BGScript files"
  (interactive)
  (kill-all-local-variables)
  (set-syntax-table bgscript-mode-syntax-table)
  (use-local-map bgscript-mode-map)
  (set (make-local-variable 'font-lock-defaults)
       '(bgscript-font-lock-keywords))
  (setq major-mode 'bgscript-mode)
  (setq mode-name "BGScript")
  (run-hooks 'bgscript-mode-hook) )

(provide 'bgscript-mode)
