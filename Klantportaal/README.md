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

2.	Software dependencies
Add nuget package source http://nuget.icatt.local/nuget

3.	Latest releases
4.	API references

# Build and Test
Set Sphdhv.KlantPortaal.Host.WebHost as Startup project
Exclude Sphdhv.Test.DeelnemerPortalApi.Proxy.dll from Build server tests (needs to be added to ip-whitelist by Idella (formerly Piramide))

IN DEV: Check je externe ip-adres, deze moet 193.172.125.195 zijn ivm whitelist bij idella/piramide/idella/visma

Genereren van hashes voor CSP integrity checks:
https://www.srihash.org/

# Contribute

If you want to learn more about creating good readme files then refer the following [guidelines](https://www.visualstudio.com/en-us/docs/git/create-a-readme). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)