<#
.SYNOPSIS
A script to be run via scheduled task to autoconnect AOVPN Device Tunnel prior the user logon
.DESCRIPTION
This script will include checks for AOVPN bugs (User + Device) and do additional logging

#>

$GPO_Folder = "C:\Windows\AOVPN"
$User_Tunnel_Name = "M3GR AOVPN" -replace ' ', '%20'
$Device_Tunnel_Name = "M3GR AOVPN Device" -replace ' ', '%20'

#In some cases when autoconnect checkbox is removed on the VPN user profile it will stop auto connecting
function Reset_AutoTriggers(){
    Set-ItemProperty -Path HKLM:\SYSTEM\CurrentControlSet\Services\RasMan\Config\ -Name AutoTriggerDisabledProfileList -Value "" -Type MultiString
}

#if AOVPN interface showing as *Unauthenticated* try to renew IP
function Check_Unauthenticated(){
    return [bool]$(Get-NetConnectionProfile | Where-Object {$_.InterfaceAlias -like "*Unauthenticated*"})
}

function ConnectDeviceVPN(){
    $vpn = Get-VpnConnection -Name $Device_Tunnel_Name -AllUserConnection;
    if($vpn.ConnectionStatus -eq "Disconnected"){
    rasdial $Device_Tunnel_Name 
    }
}

function ConnectUserVPN(){

}