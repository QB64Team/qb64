$Bucket = "qb64-development-builds"
$Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd-HH-mm-ss")
$Filename = "qb64_${Timestamp}_$($Env:GITHUB_SHA.substring(0,7))_win-${Env:PLATFORM}.7z"

Set-Location ..
7z a '-xr@qb64\.ci\common-exclusion.list' '-xr@qb64\.ci\win-exclusion.list' $Filename qb64
$OldFiles = aws --output json --query Contents[].Key s3api list-objects --bucket $Bucket --prefix win-$Env:PLATFORM | ConvertFrom-Json
aws s3 cp $Filename "s3://${Bucket}/win-${Env:PLATFORM}/"
Set-Content -Path latest.txt -NoNewline -Value $Filename
foreach ($f in $OldFiles) {
    aws s3 rm "s3://$Bucket/$f"
}
aws s3 cp latest.txt "s3://${Bucket}/win-${Env:PLATFORM}/"
