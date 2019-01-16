# Calcu-16
Calcu-16 is a processor I made to help me learn verlog.

TODO: Write about the instruction set.

## Building
To build Calcu-16 from source you must run ```build.sh```

## Programming
To run a program open ```bin/program.bin``` and uncomment the
program you want to run. Then open a terminal and type
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
uncomment the folowing lines.

# Using The Assembler
TODO: Explain how to use the assembler
