nasm -f win64 main.asm -o main.obj
GoLink /entry main /console user32.dll kernel32.dll main.obj
pause