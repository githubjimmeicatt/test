﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sphdhv.Klantportaal.Audit.Properties {
    
    
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "16.10.0.0")]
    internal sealed partial class Settings : global::System.Configuration.ApplicationSettingsBase {
        
        private static Settings defaultInstance = ((Settings)(global::System.Configuration.ApplicationSettingsBase.Synchronized(new Settings())));
        
        public static Settings Default {
            get {
                return defaultInstance;
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("LoggingDatabase")]
        public string LoggingDatabaseConnectionString {
            get {
                return ((string)(this["LoggingDatabaseConnectionString"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("81732dd5-256c-4b50-afa6-54d01e74838f")]
        public string KeyVaultApplicationId {
            get {
                return ((string)(this["KeyVaultApplicationId"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://sphdhvauditdev.vault.azure.net/secrets/")]
        public string KeyVaultAuditSecretsUrl {
            get {
                return ((string)(this["KeyVaultAuditSecretsUrl"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("430E933F3A11CA44EDA086849C4781240A916FB0")]
        public string KeyVaultCertificateThumbprint {
            get {
                return ((string)(this["KeyVaultCertificateThumbprint"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://sphdhvauditdev.vault.azure.net/secrets/SphdhvKlantPortaalAuditKeyDEV/ba88" +
            "5e480a84483785999be18181ddd9")]
        public string KeyVaultAuditSecretNew {
            get {
                return ((string)(this["KeyVaultAuditSecretNew"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("")]
        public string KeyVaultAuditSecretOld {
            get {
                return ((string)(this["KeyVaultAuditSecretOld"]));
            }
        }
    }
}
