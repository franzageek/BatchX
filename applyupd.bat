@echo off
del batchx.bat > NUL
rename batchxshell.bat batchx.bat > NUL
msg * "BatchX Shell updated successfully!"
(goto) 2>nul & del "%~f0"