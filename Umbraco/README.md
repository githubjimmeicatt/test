# Introduction 
TODO: Give a short introduction of your project. Let this section explain the objectives or the motivation behind this project. 

# Getting Started
sommige portals zitten achter een login, maar lokaal kan dat verschil niet goed gemaakt worden en wordt je dus altijd naar de adfs gestuurd om in  te loggen
alle @ws.lan accounts kunnen gebruikt worden. er is geen 2fa nodig.

werkt iets niet? 
-probeer npm install
-het kan zijn dat je bestanden van afgeschermde portals lokaal niet ziet, omdat die niet uit umbraco, maar uit een lokale map worden gehaald.

# Build and Test
Umbraco webhook development:
ngrok http https://localhost:44395 -host-header="localhost:44395"
als je in ngrok de melding krijgt dat je eerst moet registreren log dan in op de aangegeven url met het icatttest gmail account
voeg in umbraco een webhook toe met het domein dat ngrok creeert en disable tijdelijk de normale webhooks

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 

If you want to learn more about creating good readme files then refer the following [guidelines](https://docs.microsoft.com/en-us/azure/devops/repos/git/create-a-readme?view=azure-devops). You can also seek inspiration from the below readme files:
- [ASP.NET Core](https://github.com/aspnet/Home)
- [Visual Studio Code](https://github.com/Microsoft/vscode)
- [Chakra Core](https://github.com/Microsoft/ChakraCore)