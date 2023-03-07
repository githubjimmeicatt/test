# Introduction
Klantportaal is een portaal voor gebruikers van DHV om hun pensioengegevens in te kunnen zien middels een digId login.

# Getting Started
1.	Installation process
Latest build by Visual Studio 2019

Install these certificates:
- \\nas\devops\Certificates\SPHDHV\Aangeleverd door KPN\mijn.accept.pensioenfondshaskoningdhv.nl (add full controll permissions to logged in user)
- \\pelican\Certificates\Sphdhv.KlantPortaal.WebHost DEV (add full controll permissions to logged in user)
- \\pelican\Certificates\ICATT OTA Intermediate Certificate Authority
- \\pelican\Certificates\ICATT Root Certificate Authority (install in the trusted root certification authority store)
- \\nas\devops\Certificates\SPHDHV\Aangeleverd door Piramide\DHVapi-a_Authentication (add full controll permissions to logged in user)

nb. test digid accounts zijn te vinden in 1password, maar deze zijn regelmatig niet beschikbaar en daardoor niet meer gekoppeld aan dossiers in de pensioenwebservice.
het resultaat is een 'UnknownDossier' status. Je wordt dan weer terug geleid naar de login pagin. Er wordt geen melding getoond. 

2.	Software dependencies
Add nuget package source http://nuget.icatt.local/nuget



3.	Latest releases
4.	API references

# Build and Test
Set Sphdhv.KlantPortaal.Host.WebHost as Startup project
Exclude Sphdhv.Test.DeelnemerPortalApi.Proxy.dll from Build server tests (needs to be added to ip-whitelist/allowlist by Idella (formerly Piramide))

IN DEV:  ivm allowlist bij idella/piramide/idella/visma moet je internet verkeer naar piramide via een andere route. dat stel je eenmalig in.
open een command prompt in admin mode en voer dit commando uit: route add -p 217.114.98.195 MASK 255.255.255.255 192.168.1.10 

Genereren van hashes voor CSP integrity checks:
https://www.srihash.org/

# Security
Deze code wordt gecontroleerd met [Security Code Scan](https://security-code-scan.github.io/) en is geimplementeerd met nuget.
Eventuele problemen worden als error gemeld tijdens de build fase en dienen opgelost en/of als false positive suppresed worden


# Contribute
If you want to learn more about creating good readme files then refer the following [guidelines](https://www.visualstudio.com/en-us/docs/git/create-a-readme). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)