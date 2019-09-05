using log4net.Config;


// By convention the log4net configuration is places in tha app.config (web.config) and cannot be watched by the configurator.
//
// NB! This assembly level attribute MUST be set, otherwise the config settings in app.config are not picked up!!!
//     By default log4net watches for a [executablename].exe.log4net or [assemblyname].dll.log4net in the application folder.
//     Consuming applications/assemblies can define their own configuration attribute but MUST MAKE SURE TO BE THE
//     FIRST TO CALL TO LOG4NET.LOGMANAGER within the application domain because the first assembly 
//     that gets its XmlConfigurator attribute read, wins..
[assembly: XmlConfigurator(Watch = false)]
