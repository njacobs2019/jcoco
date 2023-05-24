This repo is the source code to create a docker image for the [JCoCo Virtual Machine](https://kentdlee.github.io/JCoCoPages/_build/html/index.html).  It compiles and installs python 3.2.6, installs the JDK, and JCoCo.  The disassembler is included inside `/home`.  The image is available on DockerHub.

# Building the docker image
```
docker build -t jcoco:tag .
```

# Running the container
This runs the container and maps your current directory into `/home`.
```
docker run -v $(pwd):/home -it jcoco:tag /bin/bash
```

# JCoCo Example
Go to `/home` directory where you will find `disassembler.py` which can be used to disassemble a Python function into bytecode.  `addtwo.py` contains an example Python function and either runs the function or disassembles it depending on if there is a command line argument given to the program (if no arguments are given, the function is executed).  
Disassemble the function and pipe the bytecode to a file. `.casm` extensions represent coco assembly.  
```
python addtwo.py 1 >> addtwo.casm
```

Now run the byte code with coco  
```
coco addtwo.casm
```