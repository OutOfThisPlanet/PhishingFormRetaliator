Function PhishingFormFucker
{
    param([string]$PhishingURL, [string]$UserNameFormFieldID, [string]$PasswordFormFieldID, [string]$IDFieldID, [int]$IDLength, [string]$IDType)

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
        
        if ($IDType -eq "Hexadecimal" -or $IDType -eq "hex")
        {
            $RandomID = (1..$IDLength | ForEach-Object{ '{0:X}' -f (Get-Random -Max 16) }) -join ''
        }
        elseif ($IDType -eq "Decimal" -or $IDType -eq "dec")
        {
            $RandomID = (1..$IDLength | ForEach-Object{ '{0:X}' -f (Get-Random -Max 10) }) -join ''
        }
        elseif ($IDType -eq "Alphabetical" -or $IDType -eq "alpha")
        {
            $RandomID = -join ((65..90) | Get-Random -Count $IDLength | % {[char]$_})
        }
        
        $postParams = @{"$IDFieldID" = $RandomID; "$UserNameFormFieldID" = $Username; "$PasswordFormFieldID" = $Password;}

        Invoke-WebRequest $PhishingURL -Method POST -Body $postParams | Out-Null
    
        Write-Host $UserName " " -ForegroundColor Green -NoNewline
        Write-Host $Password " " -ForegroundColor Yellow -NoNewline
        Write-Host $RandomID " " -ForegroundColor Magenta 
       
    }
}


PhishingFormFucker `
-UserNameFormFieldID "INSERT-USERNAME-FIELD-ID" ` # This is the Username field ID - 
-PasswordFormFieldID "INSERT-PASSWORD-FIELD-ID" ` # This is the Password field ID
-IDType "Decimal" ` # This is to generate an formID of a specific type (Decimal, Hexidecimal, or Alphabetical)
-IDLength "8" ` # This is for the length of the random form ID
-IDFieldID "INSERT-FORM-ID" ` # This is the name of the form's ID
-PhishingURL "INSERT-PHISHING-URL" # This is the phishing page's url (usually a PHP file)
