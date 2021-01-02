find . -name "*.c" -o -name "*.S" -o -name "*.h" > cscope.files
cscope -q -R -b -i cscope.files
echo "cscope database created."

find . -name "*.py" > pycscope.files
pycscope -R -i pycscope.files
echo "pycscope database created."
