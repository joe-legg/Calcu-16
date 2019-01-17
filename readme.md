# Calcu-16
Calcu-16 is a processor I made to help me learn verilog. 

At first the plan was to make a module for each part of the
processor and attach them together in a core module but I
couldn't get it to work. The problem was that if I attach the
output of the register module to input *a* of the alu module
the output of the alu becomes *x*. This only happened when one
output of the register module was 0. You can see my first 
attempt in the ```old_attempt``` folder.

### Registers
Calcu-16 has eight general purpose registers named r0-r7. Each 
register is 16-bits wide. There are two other registers, the 
IR (Instruction Register 26-bit) and the PC (Program Counter 
16-bit).

### Instruction formats
#### Register Format
```
 0:3     4:6 7:9 10:12
 op-code registers       unused
  │           │              │
 ┌┴─┐ ┌───────┴─┐ ┌──────────┴┐
 0000 000 000 000 0000000000000
      └┬┘ └┬┘ └┬┘
      r1  r2  r3
```

#### Immediate/Memory Format
```
 0:3     4:6   7:9 10:25
 op-code registers immediate/addr
  │        │        │
 ┌┴─┐ ┌────┴┐ ┌─────┴────────┐
 0000 000 000 0000000000000000
      └┬┘ └┬┘
      r1  r2
```
### Instructions
|Instruction            |Op-Code  |Format     |Description                                     |
|-----------------------|---------|-----------|------------------------------------------------|
|nop                    |0000     |N/A        |Does nothing.                                   |
|add reg1, reg2, reg3   |0001     |Register   |Adds reg2 to reg3. Stores the result in reg1.   |
|addi reg1, reg2, Imm   |0010     |Immediate  |Adds reg2 to Imm. Stores the result in reg1.    |
|jmp addr               |0011     |Memory     |Sets the PC to the value of addr.               |
|jeq reg1, reg2, addr   |0100     |Memory     |If reg1 = reg2 then jump to addr.               |
|store reg1, reg2, addr |0101     |Memory     |Store reg1 at addr + reg2.                      |
|load reg1, reg2, addr  |0110     |Memory     |Load reg1 with the value stored at addr + reg2. |
|xor reg1, reg2, reg3   |0111     |Register   |XOR reg2 and reg3 put the result in reg2.       |
|and reg1, reg2, reg3   |1000     |Register   |AND reg2 and reg3 put the result in reg2.       |

## Building
To build Calcu-16 from source you must run ```build.sh```.

## Programming
To run a program open ```bin/program.bin``` and uncomment the
program you want to run. Then open a terminal and type:
```bash
cd bin
./calcu16
```
If you want to write your own program just add it to the end
of ```bin/program.bin```. To make writing the program easier
you could use my assembler although I don't recomend it.
Also, feel free to contribute any programs you make to the
```programs.bin``` file.

If you want to create a ```.vcd``` wave file then open
```src/calcu-16.v``` and ```src/calcu-16_tb.v```. Find the
part in each file where it says "Uncomment for debugging" and
uncomment the following lines.

# Using The Assembler
To use the assembler open the ```assembler``` folder. To
assemble the example counter program use the folowing command:
```bash
python assembler.py counter.asm counter.bin
````
This will create a file called counter.bin which you can then
copy the contents of into the ```bin/program.bin``` file.

You can write your own assembly programs and assemble them
with the folowing format:
```bash
python assembler.py [your program.asm] [name of the output file.bin]
```
