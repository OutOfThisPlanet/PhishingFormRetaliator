$Names = @("olivia", "amelia", "isla", "emily", "ava", "lily", "mia", "sophia", "isabella", "grace", "poppy", "ella", "evie", "charlotte", "jessica", "daisy", "sophie", "freya", "alice", "sienna", "", "ivy", "harper", "ruby", "isabelle", "willow", "phoebe", "evelyn", "scarlett", "chloe", "florence", "elsie", "millie", "layla", "matilda", "rosie", "esme", "eva", "lucy", "aria", "ellie", "sofia", "maisie", "erin", "lola", "lilly", "thea", "imogen", "eliza", "bella", "molly", "hannah", "emma", "violet", "luna", "amber", "lottie", "darcie", "maya", "georgia", "elizabeth", "zara", "penelope", "holly", "nancy", "rose", "emilia", "harriet", "gracie", "darcy", "mila", "orla", "abigail", "jasmine", "eleanor", "anna", "summer", "robyn", "lexi", "heidi", "annabelle", "maria", "aurora", "leah", "darcey", "victoria", "hallie", "martha", "amelie", "katie", "bonnie", "arabella", "lacey", "annie", "niamh", "lyla", "iris", "zoe", "clara", "maddison", "megan")
$Suffixes = 1952..2004
$PasswordLength = 5..9
$Domains = @("@gmail.com", "@yahoo.com", "@outlook.com", "@live.com", "@protonmail.com")

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
