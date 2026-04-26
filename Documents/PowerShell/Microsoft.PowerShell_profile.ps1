Invoke-Expression (&starship init powershell)

Import-Module PSReadLine
Import-Module -Name Terminal-Icons
Import-Module -Name PendingReboot

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows