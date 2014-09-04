@echo off
rem SLEEP EM BAT
rem 1.1.1.1 is an invalid IP address and can never be reached.
rem -n 1 only attempt to connect once.
rem -w 3000 wait 3 seconds for reply.
rem -w 3000 wait 3 seconds for reply.
echo passo 1
echo "1.1.1.1 is an invalid IP address and can never be reached. 1.1.1.1 is an invalid IP address and can never be reached. 1.1.1.1 is an invalid IP address and can never be reached. 1.1.1.1 is an invalid IP address and can never be reached. 1.1.1.1 is an invalid IP address and can never be reached. 123"
ping 1.1.1.1 -n 1 -w 3000 > nul
echo passo 2
ping 1.1.1.1 -n 1 -w 3000 > nul
echo passo 3
ping 1.1.1.1 -n 1 -w 3000 > nul
echo passo 4
ping 1.1.1.1 -n 1 -w 3000 > nul
pause
