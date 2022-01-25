:<<EOF
This is a shell script for STM32 MCU Configuration. ...
Author:Sebastian ...
Date:2022.1.18 ...
This shell script's copyright@ own to the @Author ...
Compiledb will confige  Vim to read symbols in the project ...
Makefile tools  construct the project ...
If you want to use CMake to construct the project ,first you should config the CubeMX toolchain switched to CubeIDE ...
Use GNU/Global to generate the defines symbols to read sources and open in google-chrome on localhost with port 8000 ...
EOF

# Before you use this shell,you must confige your computer to install these tools or software:
# python3 compiledb (pip install) make Cmake(>3.0.0) GNU/Global
#global values
logfileflag=$1
projectEffect=0


echo "The STM32 project is configing..."
echo "Tools testing ..."

#function isToolExist(){
#	type $1
#	return $?
#}
#test GDB
type gdb
echo $?
gdbflag=$?
if [ $? -eq 0 ]
then
	echo "Test GNU/Dubugger is OK...:"
	echo $(gdb --version)
else
	echo "GNU/Debugger is not detected,please check your install and your system path"
fi
#test end

#test gcc
type gcc
echo $?
gccflag=$?
if [ $? -eq 0 ]
then
	echo "Test gcc is OK...:"
	echo $(gcc --version)
else
	echo "GNU/C_CppCompiler is not detected,please check your install and your system path"
fi
#test end

#test arm-none-eabi-gcc
type arm-none-eabi-gcc
echo $?
armgccflag=$?
if [ $? -eq 0 ]
then
	echo "Test arm-none-eabi-gcc is OK...:"
	echo $(arm-none-eabi-gcc --version)
else
	echo "GNU/arm-none-eabi-gcc is not detected,please check your install and your system path"
fi
#test end


#test make 
type make
echo $?
makeflag=$?
if [ $? -eq 0 ]
then
	echo "Test make is OK...:"
	echo $(make --version)
else
	echo "GNU/Makefile is not detected,please check your install and your system path"
fi
#test end

#test CMake 
type cmake
echo $?
cmakeflag=$?
if [ $? -eq 0 ]
then
	echo "Test cmake is OK...:"
	echo $(cmake --version)
else
	echo "CMake is not detected,please check your install and your system path"
fi
#test end

if test -e *.ioc
then
	echo "This is a STM32 project,test OK..."
	projectEffect=1
else
	echo "This is not a STM32 project,you should use this command in a STM32 project"
	projectEffect=0
fi
if projectEffect=1
then
	make
	compiledb make
	hgtags -v
	nohup htags-server – b ip 127.0.0.1 8000 &
	nohup google-chrome 127.0.0.1:8000
else
	echo "Stop!"
fi

