[xml]$xmlinfo = {<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
  <RegistrationInfo>
    <Author></Author>
    <Description></Description>
    <URI>\Restore Boot Camp Screen Brightness Fn Keys</URI>
  </RegistrationInfo>
  <Triggers>
    <LogonTrigger>
      <Enabled>true</Enabled>
    </LogonTrigger>
  </Triggers>
  <Principals>
    <Principal id="Author">
      <LogonType>InteractiveToken</LogonType>
      <RunLevel>HighestAvailable</RunLevel>
    </Principal>
  </Principals>
  <Settings>
    <MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
    <DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
    <StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
    <AllowHardTerminate>true</AllowHardTerminate>
    <StartWhenAvailable>false</StartWhenAvailable>
    <RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
    <IdleSettings>
      <StopOnIdleEnd>true</StopOnIdleEnd>
      <RestartOnIdle>false</RestartOnIdle>
    </IdleSettings>
    <AllowStartOnDemand>true</AllowStartOnDemand>
    <Enabled>true</Enabled>
    <Hidden>false</Hidden>
    <RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
    <WakeToRun>false</WakeToRun>
    <Priority>7</Priority>
  </Settings>
  <Actions Context="Author">
    <Exec>
      <Command></Command>
      <Arguments></Arguments>
    </Exec>
  </Actions>
</Task>}

$xmlinfo.Task.RegistrationInfo.Description = "**USE CMD/WIN+Fn KEY FOR NORMAL Fn KEY FUNCTIONALITY** || F1 = Lower Brightness || F2 = Increase Brightness"
$xmlinfo.Task.RegistrationInfo.Author = $env:username
$xmlinfo.Task.Actions.Exec.Command = "cmd.exe"
$xmlinfo.Task.Actions.Exec.Arguments = "/c start ""Restore Fn Keys"" ""$env:programfiles\Restore Boot Camp Screen Brightness Fn Keys\Restore Boot Camp Screen Brightness Fn Keys.exe"""
$xmlinfo.Save("$env:systemdrive\task.xml")
schtasks.exe /create /f /tn "Restore Boot Camp Screen Brightness Fn Keys" /xml "$env:systemdrive\task.xml" |Out-Null
if (Test-Path "$env:systemdrive\task.xml"){Remove-Item "$env:systemdrive\task.xml"}

wmic useraccount where name=`"$env:username`" set PasswordRequired=true
$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon'
Set-ItemProperty $RegistryPath 'AutoAdminLogon' -Value "0" -Type String 
Set-ItemProperty $RegistryPath 'DefaultUserName' -Value "" -type String
Set-ItemProperty $RegistryPath 'DefaultDomainName' -Value "" -type String
Set-ItemProperty $RegistryPath 'DefaultPassword' -Value "" -type String

Start-ScheduledTask -TaskName "Restore Boot Camp Screen Brightness Fn Keys"