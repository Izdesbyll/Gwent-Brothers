; --- Tavern Gambler Bridge Script ---

#SingleInstance Force

; Configuration: Set your game paths here
global BB_EXE := "C:\Games\Battle Brothers\win32\BattleBrothers.exe"
global GWENT_EXE := "C:\Program Files (x86)\GOG Galaxy\Games\Gwent\Gwent.exe"


; Hotkey: Press F10 to start the "Tavern Trip"
F10::
{
    if WinExist("ahk_exe " . BB_EXE)
    {
        MsgBox("Entering the Tavern... Switching to Gwent.")
        WinMinimize("ahk_exe " . BB_EXE)
        
        if !WinExist("ahk_exe " . GWENT_EXE)
            Run("steam://rungameid/524220") ; Launches Gwent via Steam
        else
            WinActivate("ahk_exe " . GWENT_EXE)
    }
    return
}

; Hotkey: Press F11 when Gwent match is over
F11::
{
    ; 1. Ask for the result
    Result := InputBox("Enter Gwent Point Difference (e.g., 15 for win, -10 for loss):", "Tavern Result", "w300 h130").Value
    
    if (Result = "" || Result = "0")
    {
        MsgBox("Draw or Cancelled. Returning to the Mercenary life.")
        if WinExist("ahk_exe " . BB_EXE)
        {
            WinActivate("ahk_exe " . BB_EXE)
            Sleep(2000) ; Wait for game to focus
        }
    }
    else
    {
        ; 2. Switch back to Battle Brothers
        if WinExist("ahk_exe " . BB_EXE)
        {
            WinActivate("ahk_exe " . BB_EXE)
            Sleep(2000) ; Wait for game to focus
            ; Open console with Ctrl+G
            SendEvent("^g")
            Sleep 420
            ; Type the Squirrel command
            SendEvent("this.World.Assets.m.Money+=" . Result . ";")
            Sleep 60
            Sleep(300)
            MsgBox("Budget adjusted by " . Result . " crowns!")
        }
    }
    return
}