set fn=D:\Program Files\ImageMagick-7.0.7-Q16\convert.exe
for /f "tokens=*" %%i in ('dir/s/b *.png') do "%fn%" "%%i" -strip "%%i"