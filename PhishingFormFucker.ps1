Function PhishingFormFucker
{
    param([string]$PhishingURL, [string]$UserNameFormFieldID, [string]$PasswordFormFieldID, [string]$IDFieldID)

    if ($PhishingURL -eq "" -or $UserNameFormFieldID -eq "" -or $PasswordFormFieldID -eq "" -or $IDFieldID -eq "")
    {
        Write-Host "Please pass in the following strings when running this script:" -ForegroundColor Red -BackgroundColor Black
        Write-Host "The URL for the webpage that holds the Phishy Form" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "The ID of the Email field" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "The ID of the Password field" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "The ID field ID" -ForegroundColor Yellow -BackgroundColor Black
        Write-Host "Example:" -ForegroundColor Red -BackgroundColor Black
        Write-Host 'PhishingFormFucker -PhishingURL "http://phishysite.com" -UserNameFormFieldID "YOUNEEDTOFINDTHISVALUE" -PasswordFormFieldID "YOUNEEDTOFINDTHISVALUE" -IDFieldID "YOUNEEDTOFINDTHISVALUE"' -ForegroundColor Green -BackgroundColor Black
        Return
    }

    $Names = (Invoke-WebRequest "https://raw.githubusercontent.com/powerlanguage/word-lists/master/word-list-raw.txt" | select -ExpandProperty Content | Out-String).Split("`n")
    $Suffixes = 0..9999
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
        $RandomHex = (1..32 | ForEach-Object{ '{0:X}' -f (Get-Random -Max 16) }) -join ''

        $postParams = @{"$IDFieldID" = $RandomHex; "$UserNameForm" = $Username; "$PasswordForm" = $Password}

        Invoke-WebRequest $PhishingURL -Method POST -Body $postParams
    
        Write-Host $UserName -ForegroundColor green
        Write-Host $Password -ForegroundColor Yellow
    }
}

PhishingFormFucker
