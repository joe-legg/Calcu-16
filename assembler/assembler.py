# ! Warning !
# This code is the worst code
# I have ever writen. Reading
# it can cause and has caused
# permanent eye damage.

import sys

file = open(sys.argv[1])
assembly = file.read()
file.close()
tokens = assembly.split()
output = ""
curInstr = ""

jump = False

for tok in tokens:
    if tok == "add":
        curInstr += "0001"
    elif tok == "addi":
        curInstr += "0010"
    elif tok == "jmp":
        curInstr += "0011000000"
    elif tok == "jeq":
        curInstr += "0100"
    elif tok == "store":
        curInstr += "0101"
    elif tok == "load":
        curInstr += "0110"
    elif tok == "xor":
        curInstr += "0111"
    elif tok == "and":
        curInstr += "1000"
    elif tok[0] == "r":
        curInstr += "{0:03b}".format(int(tok[1]))
    else:
        curInstr += "{0:016b}".format(int(tok))

    if len(curInstr) == 26:
       output += curInstr + "\n"
       curInstr = ""
    elif len(curInstr) == 13:
        curInstr += "0000000000000\n"
        output += curInstr
        curInstr = ""

file = open(sys.argv[2], "w")
file.write(output)
