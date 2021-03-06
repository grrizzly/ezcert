﻿function Initialize-LocalClientCerts {
    Param(
        [switch]$Auto = $false
    )

    if ($Auto) {
        Write-Info "Creating client cert using default settings.", -ForegroundColor $infoColor
        New-LocalCA
        New-LocalClientCertificate
        Unlock-AppHostSecuritySection
        return
    }

    # TODO: Check for existing CA

    Write-Info @"
Hello! I will be your guide you through this client certificate setup journey.

First step is getting a CA to sign your client certificate with.
"@

    Write-Host "Do you have an existing CA you would like to use? [y/N]:"
    $caPath = $null
    $caPassword = $null
    $useDefaultCa = $false
    if((Read-Input -defaultValue "n") -eq "y") {
        Write-Host "Path to .pfx file (make sure the private key is included in the export):"
        $caPath = Read-Input
        Write-Host "Password:"
        $caPassword = Read-Input
    } else {
       
        Write-Info @"

OK. I'm going to create a CA for you.

I can also import the CA into your Local Machine certificate store.
(If you say no, you will have to manually import the .pfx in order for the client certificate we're going to generate later to work)

"@
        
        $autoImport = $true
        Write-Host "Auto-import? [Y/n]:"
        if ((Read-Input -defaultValue "y") -eq "n") {
            $autoImport = $false
        }

        $outputPath = ".\localCA.pfx"
        New-LocalCA -OutputFileName $outputPath -AutoImport $autoImport
        $useDefaultCa = $true
    }

    Write-Info @"


Alright, onto the client certificate!

"@
    Write-Host "Now what do you want the Common Name to be on the cert? [clientCertificate]: "

    $clientCertName = Read-Input -defaultValue "clientCertificate"
    
    Write-Info @"
I can import the client certificate into your personal store.
While not required, this allows you to easily verify your setup via a browser.

"@
   
    $autoImportClientCert = $true
    Write-Host "Auto-import? [Y/n]: "
    if ((Read-Input -defaultValue "y") -eq "n") {
        $autoImportClientCert = $false
    }

    Write-Host "Pfx output file location [./$clientCertName.pfx]: "
    $clientCertOutputLocation = Read-Input -defaultValue "$(Get-Item -Path $PWD)\$clientCertName.pfx"
    New-LocalClientCert -Name $clientCertName -UseDefaultCa $useDefaultCa -CaPath $caPath -CaPassword $caPassword -OutputFileName $clientCertOutputLocation -AutoImport $autoImportClientCert

    Write-Info @"
    

If you're using IIS Express, I can set up your environment to enable client certificates

"@
    Write-Host "Configure IIS Express? [Y/n]:"

    $configureIISExpress = (Read-Input -defaultValue "y") -eq "y"
    if($configureIISExpress) {
        Unlock-AppHostSecuritySection
    }

    Write-Info @"

If you're using a .Net project (pre-.Net core), I can set up your project to use client certificate authentication
    
This will modify your web.config file to add or modify the <access> element to the <security> element under <system.webServer>.
It will not modify or delete other elements. Keep in mind though that this will modify your existing file, so make sure it's under source control.

"@
    Write-Host "Configure project? [y/N]: "

    $configureProject = (Read-Input -defaultValue "n") -eq "y"
    if($configureProject) {
        Initialize-ClientCertConfig
    }

    Write-Success "All Done!"
    Write-Info @"
   
If you used the defaults, you're good to go. Launch your app and open it up in a browser.
You should get prompted for a certificate. Choose $clientCertName, and you will be able to authenticate.
"@

    if(!$configureIISExpress) {
        Write-Info @"


Since you didn't auto-configure IIS Express, you'll likely have to do so manually.
Open the applicationhost.config file located in <solutionDir>/.vs/config and edit the 'access' section defaults to the following:
 

<section name="access" overrideModeDefault="Allow" />'
    
(if that file doesn't exist, look for $env:USERPROFILE\Documents\IISExpress\config\applicationhost.config)
"@
    }

    if (!$configureProject) {
        Write-Info @"


Since you didn't auto-configure your project, you'll likely have to do so manually.
Open your web.config and add the following section under <system.webServer>:


<security>
    <access sslFlags="Ssl,SslRequireCert,SslNegotiateCert />
</security>

"@
    }
}
