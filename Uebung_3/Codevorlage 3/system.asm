# Hilfsmakros um Systemaufrufe lesbarer zu machen
# Diese Datei kann in Aufgabenbearbeitungen ignoriert werden

.data
_insert_number_output_text: .asciz "Gib eine Zahl ein: "
_insert_string_output_text: .asciz "Gib einen Text ein: "

.text

.macro syscall_print_newline
addi sp, sp, -4
sw a0, (sp)
li a0, 10
addi sp, sp, -4
sw a7, (sp)
li a7, 11
ecall
lw a7, (sp)
addi sp, sp, 4
lw a0, (sp)
addi sp, sp, 4
.end_macro

.macro syscall_print_int_from_a0
addi sp, sp, -4
sw a7, (sp)
li a7, 1
ecall
syscall_print_newline
lw a7, (sp)
addi sp, sp, 4
.end_macro

# a0 enthaelt Adresse an der der String liegt
.macro syscall_print_string_from_a0
addi sp, sp, -4
sw a7, (sp)
li a7, 4
ecall
syscall_print_newline
lw a7, (sp)
addi sp, sp, 4
.end_macro

.macro syscall_print_char_from_a0
addi sp, sp, -4
sw a7, (sp)
li a7, 11
ecall
syscall_print_newline
lw a7, (sp)
addi sp, sp, 4
.end_macro

.macro syscall_read_int_to_a0
addi sp, sp, -8
sw a7, 4(sp)
sw a0, (sp)
la a0, _insert_number_output_text
addi sp, sp, -4
sw a7, (sp)
li a7, 4
ecall
lw a7, (sp)
addi sp, sp, 4
lw a0, (sp)
li a7, 5
ecall
lw a7, 4(sp)
addi sp, sp, 8
.end_macro

# In a0 wird die Adresse abgelegt, an der der String liegt
.macro syscall_read_string_to_a0
addi sp, sp, -8
sw a7, 4(sp)
sw a0, (sp)
la a0, _insert_string_output_text
addi sp, sp, -4
sw a7, (sp)
li a7, 4
ecall
lw a7, (sp)
addi sp, sp, 4
lw a0, (sp)
li a7, 8
ecall
lw a7, 4(sp)
addi sp, sp, 8
.end_macro

.macro syscall_exit
addi sp, sp, -4
sw a7, (sp)
li a7, 10
ecall
lw a7, (sp)
addi sp, sp, 4
.end_macro

.macro syscall_sleep_a0_ms
addi sp, sp, -4
sw a7, (sp)
li a7, 32
ecall
lw a7, (sp)
addi sp, sp, 4
.end_macro
