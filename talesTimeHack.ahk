;;Tales of Berseria Time Faker



full_command_line := DllCall("GetCommandLine", "str")
if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}
MsgBox A_IsAdmin: %A_IsAdmin%`nCommand line: %full_command_line%


Xbutton1::
hh := A_hour
run *runas cmd.exe
sleep 100
if (hh == 23)
{
hh := 00
}
else{
hh:= hh+1
}
Send time %hh%{return}
Sleep 50
Send exit{return}
return

Xbutton2::
ensureService()
resetClock()
return


resetClock(){
run *runas cmd.exe
sleep 100
Send w32tm /resync {return}
sleep 100 
Send exit{return}
}

ensureService(){
Send w32tm /unregister {return}
Send w32tm /register {return}
Send net start w32tm {return}
}

MButton::
#Persistent ; Prevent the script from exiting automatically.
OnExit, ExitSub  
ExitSub:
if A_ExitReason not in Logoff,Shutdown  ; Avoid spaces around the comma in this line.
{
    MsgBox, 4, , Are you sure you want to exit?
    IfMsgBox, No
        return
else
resetClock()
}
ExitApp