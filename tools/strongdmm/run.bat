@echo off
start "" .\runtime\bin\javaw.exe "-Xmx500m" "-Dsdmmparser.path=.\lib" -jar .\lib\strong-dmm-1.1.0.jar
exit
