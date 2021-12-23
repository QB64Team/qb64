$Bucket = "qb64"
$Timestamp = (Get-Date).ToUniversalTime().ToString("yyyy-MM-dd-HH-mm-ss")
$Filename = "qb64_development_win-${Env:PLATFORM}.7z"
# Ideally this would change the directory name to have useful information, but Windows gives an error
# "The process cannot access the file because it is being used by another process.", so this feature
# is disabled until someone can work out a better way.
# $Dirname = "qb64_${Timestamp}_$($Env:GITHUB_SHA.substring(0,7))_win-${Env:PLATFORM}"
# Rename-Item qb64 $Dirname
$Dirname = qb64
Set-Location ..
7z a "-xr@${Dirname}\.ci\common-exclusion.list" "-xr@${Dirname}\.ci\win-exclusion.list" $Filename $Dirname 
aws --endpoint-url ${S3_ENDPOINT} s3api put-object --bucket ${Bucket} --body $Filename --acl public-read --key development-builds/$Filename
