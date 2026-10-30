$keys = (Get-Command Set-CsTeamsMeetingPolicy).Parameters.Keys
$keys | Where-Object { $_ -match 'AutoAdmit|Designated|Anonymous' }