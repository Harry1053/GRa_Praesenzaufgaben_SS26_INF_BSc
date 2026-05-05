## Aufgabe 2: Arrayiteration

Benötigte Dateien: Präsenzmaterial > `Codevorlage 3.zip`

Gegeben sei folgender C-Code zur Berechnung eines Punktedurchschnitts:

```c
int[] points = {300, 17, 4962, 256, 7, 133, 8192};
int length = 7;

void avg() {
    int sum = 0;
    for (int i = 0; i < length; i++) {
        sum = sum + points[i];
    }
    print_int(sum / length);
}
```
**a)** Wandle den gegebenen Code in einen äquivalenten RISC-V Assemblercode für den RARS Simulator um. Verwende hierfür die Vorlage [...]. Das korrekte Ergebnis bei den gegebenen Zahlen ist 1981.

```asm
.data
points: .word 300, 17, 4962, 256, 7, 133, 8192
length: .word 7

.include "system.asm"

.text
avg:
    li t0, 0                # int sum = 0;
    li t1, 0                # i fuer for-loop;

    b Lcond                 # for-loop;

Lbody:
    slli t6, t1, 2          # left shift von i um 2
                            # semantisch: t6: i * 4
                            # um alle index zu loopen;

    la t4, points           # t4: addr(points[]);
    add t4, t4, t6          # t5: offset auf Startaddr addieren;
    lw t4, (t4)             # points[i] laden;

    add t0, t0, t4          # sum += points[i];

Lcond:
    la t2, length           # t2: addr(lenth);
    lw t2, (t2)             # lenth laden;
    blt t1, t2, Lbody       # i < length;

    div a0, t0, t2          # sum / length;

    syscall_print_int_from_a0

syscall_exit
