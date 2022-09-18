<#
Feel free to modify this file by implementing your logic.
This script is invoked after initialization scripts completed running 
but before user has logged in.
This script runs under Administrator account but without any UI, 
meaning this script can't ask for user input. 
It's OK for this script to run a few minutes, as it runs before
users log in.
#>

Write-Host "Main script finished running at $(Get-Date)."
$secret_id = aws cloudformation describe-stacks --stack-name "WinsMod" --query 'Stacks[0].Outputs[?OutputKey==`MsSqlSecretName`].OutputValue' --output text
$secret = aws secretsmanager get-secret-value --secret-id $secret_id  --query "SecretString" --output text | ConvertFrom-Json
Write-Host "Restore database" 
sqlcmd -U $secret.username -S $secret.host -P $secret.password -i sql-init.sql