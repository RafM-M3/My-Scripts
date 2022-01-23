function ConnectVPN {
    $vpnName = $VPNConnection.Name
    $vpn = Get-VpnConnection -Name $vpnName;
    if($vpn.ConnectionStatus -eq "Disconnected"){
    rasdial $vpnName (Read-Host -Prompt "Enter VPN Username") (Read-Host -Prompt "Enter Password")
    }