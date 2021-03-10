%windir%\System32\cmd.exe /c "echo off | clip"
wmic service where "name like '%%cbdhsvc_%%'" call stopservice
wmic service where "name like '%%cbdhsvc_%%'" call startservice