﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Sphdhv.KlantPortaal.Host.WebHost.Properties {
    
    
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("Microsoft.VisualStudio.Editors.SettingsDesigner.SettingsSingleFileGenerator", "16.8.1.0")]
    internal sealed partial class Settings : global::System.Configuration.ApplicationSettingsBase {
        
        private static Settings defaultInstance = ((Settings)(global::System.Configuration.ApplicationSettingsBase.Synchronized(new Settings())));
        
        public static Settings Default {
            get {
                return defaultInstance;
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://mijn.accept.pensioenfondshaskoningdhv.nl/metadata.xml")]
        public string DigidMedataIssuer {
            get {
                return ((string)(this["DigidMedataIssuer"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://was-preprod1.digid.nl/saml/idp/resolve_artifact")]
        public string DigidResolveArtifactEndpoint {
            get {
                return ((string)(this["DigidResolveArtifactEndpoint"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://preprod1.digid.nl/saml/idp/request_authentication")]
        public string DigidRequestAuthenticationEndpoint {
            get {
                return ((string)(this["DigidRequestAuthenticationEndpoint"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("Sphdhv.KlantPortaal.Host.WebHost")]
        public string ApplicationId {
            get {
                return ((string)(this["ApplicationId"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("DEV")]
        public string EnvironmentId {
            get {
                return ((string)(this["EnvironmentId"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("False")]
        public bool StubDhvDeelnemerWebApi {
            get {
                return ((bool)(this["StubDhvDeelnemerWebApi"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://localhost:44392/")]
        public string DnnMijnOmgevingUrl {
            get {
                return ((string)(this["DnnMijnOmgevingUrl"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("wachtwoordwijzigen")]
        public string DnnPasswordResetConfirmationPage {
            get {
                return ((string)(this["DnnPasswordResetConfirmationPage"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://localhost:44392/logoff")]
        public string DnnLogoffPage {
            get {
                return ((string)(this["DnnLogoffPage"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("Authentication/VerifyToken")]
        public string VerifyTokenPath {
            get {
                return ((string)(this["VerifyTokenPath"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("0")]
        public byte AssertionConsumerServiceIndex {
            get {
                return ((byte)(this["AssertionConsumerServiceIndex"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("inloggenals")]
        public string DnnInloggenAlsPage {
            get {
                return ((string)(this["DnnInloggenAlsPage"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://localhost:44304/")]
        public string KlantPortaalBaseUrl {
            get {
                return ((string)(this["KlantPortaalBaseUrl"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("/Deelnemer/VerifyEmail")]
        public string EmailVerificatieEndpoint {
            get {
                return ((string)(this["EmailVerificatieEndpoint"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("False")]
        public bool StubDhvDocumentWebApi {
            get {
                return ((bool)(this["StubDhvDocumentWebApi"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("False")]
        public bool LogDeelnemerPortalApiCommunication {
            get {
                return ((bool)(this["LogDeelnemerPortalApiCommunication"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("4bb4eb36-fb4a-4a83-b7e7-e502c07fb84b")]
        public string KeyVaultApplicationId {
            get {
                return ((string)(this["KeyVaultApplicationId"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("67a674bd68a281d117648e1db4a19fcafae61972")]
        public string KeyVaultCertificateThumbprint {
            get {
                return ((string)(this["KeyVaultCertificateThumbprint"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("db6ebc6098355941e2b741fe54b647a32cca4c63")]
        public string DigidCertificateSubjectDistinguishedName {
            get {
                return ((string)(this["DigidCertificateSubjectDistinguishedName"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("2d653730-33a8-4ee4-8be6-65b9addac6df")]
        public string KeyVaultTenantId {
            get {
                return ((string)(this["KeyVaultTenantId"]));
            }
        }
        
        [global::System.Configuration.ApplicationScopedSettingAttribute()]
        [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
        [global::System.Configuration.DefaultSettingValueAttribute("https://sphdhvdeelnemerdev.vault.azure.net/")]
        public string KeyVaultUrl {
            get {
                return ((string)(this["KeyVaultUrl"]));
            }
        }
    }
}
