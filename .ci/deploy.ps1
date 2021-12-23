$Bucket = "qb64"
$Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd-HH-mm-ss")
$Filename = "qb64_development_win-${Env:PLATFORM}.7z"
$Dirname = "qb64_${Timestamp}_$($Env:GITHUB_SHA.substring(0,7))_win-${Env:PLATFORM}"
Set-Location ..
Rename-Item qb64 $Dirname
7z a "-xr@${Dirname}\.ci\common-exclusion.list" "-xr@${Dirname}\.ci\win-exclusion.list" $Filename $Dirname 
aws --endpoint-url ${S3_ENDPOINT} s3 cp $Filename "s3://${Bucket}/development-builds/${Filename}"
