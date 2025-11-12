Invoke-Expression (&starship init powershell)

Import-Module PSReadLine
Import-Module -Name Terminal-Icons
Import-Module -Name PendingReboot

Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

function Check-RebootRequired {
    $rebootStatus = Test-PendingReboot -SkipConfigurationManagerClientCheck

    if ($rebootStatus.IsRebootPending) {
        Write-Host "⚠️  A system reboot is REQUIRED" -ForegroundColor Yellow
        Write-Host "Computer: $($rebootStatus.ComputerName)" -ForegroundColor Cyan
    } else {
        Write-Host "✓ No reboot required" -ForegroundColor Green
        Write-Host "Computer: $($rebootStatus.ComputerName)" -ForegroundColor Cyan
    }

    return $rebootStatus.IsRebootPending
}
