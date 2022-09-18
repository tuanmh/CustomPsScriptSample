<#

Feel free to modify this file by implementing your logic.

This script is invoked by Windows "shell:startup". It runs
under Administrator interactive user in minimized window to
minimize changes that users will close the window before 
script finishes its run.

This script needs to complete its run fast to avoid
distracting users. A few seconds is ideal.

#>

Write-Host "Windows user `"$($env:USERNAME)`" logged in at $(Get-Date)."
$secret_id = aws cloudformation describe-stacks --stack-name "WinsMod" --query 'Stacks[0].Outputs[?OutputKey==`MsSqlSecretName`].OutputValue' --output text
$secret = aws secretsmanager get-secret-value --secret-id $secret_id  --query "SecretString" --output text | ConvertFrom-Json
Write-Host "Restoring database to MSSQL server" 
sqlcmd -U $secret.username -S $secret.host -P $secret.password -i sql-init.sql