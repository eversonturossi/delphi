@echo off
set banco=FIREBIRDBACKUP
@path C:\Program Files\Firebird\Firebird_2_5\bin
rem faz o backup
gbak -GARBAGE_COLLECT -BACKUP -TRANSPORTABLE -VERIFY %banco%.fdb %banco%.fbk -USER sysdba -PASSWORD masterkey
rem restauar o backup
gbak -GARBAGE_COLLECT -CREATE_DATABASE -PAGE_SIZE 16384 -VERIFY %banco%.fbk %banco%_new.fdb -USER sysdba -PASSWORD masterkey
rem apaba o backup
@del %banco%.fbk
@echo Concluido.
Pause