$Names = (Invoke-WebRequest "https://raw.githubusercontent.com/powerlanguage/word-lists/master/word-list-raw.txt" | select -ExpandProperty Content | Out-String).Split("`n")
$Suffixes = 00..2004
$PasswordLength = 5..12
$Domains = @("@gmail.com", "@yahoo.com", "@outlook.com", "@live.com", "@protonmail.com", "@gmail.es", "@gmail.co.uk", "@gmail.gov.uk")

while($true)
{
    $RandomNamesSeed = Get-Random -Minimum 0 -Maximum ($Names.Count -1)
    $RandomDomainsSeed = Get-Random -Minimum 0 -Maximum ($Domains.Count -1)
    $RandomSuffixSeed = Get-Random -InputObject $Suffixes
    $Username = $Names[$RandomNamesSeed] + $RandomSuffixSeed + $Domains[$RandomDomainsSeed]
    $PasswordLengthSeed = Get-Random -InputObject $PasswordLength
    $Password = ([char[]]([char]33..[char]95) + ([char[]]([char]97..[char]126)) + 0..9 | sort {Get-Random})[0..$PasswordLengthSeed] -join ''

    Write-Host $UserName -ForegroundColor green
    Write-Host $Password -ForegroundColor Yellow
}

#request post to phising site"s form still to be done. Will wait for a spam link.
