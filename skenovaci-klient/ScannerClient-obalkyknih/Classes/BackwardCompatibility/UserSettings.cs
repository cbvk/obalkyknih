using System;
using System.Text;
using System.Security.Cryptography;
using SobekCM.Bib_Package.MARC.Parsers;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Represents user settings, used for Serialization to persistent settings file,
    /// it should be used only for this purposes
    /// </summary>
    public class UserSettings
    {
        // Small random hash for harder decoding of password
        private const string randomHash = "Aqo3ojW6eQkTWLVI3FBvtBmKyOtYmYSiimhWFdf8";

        /// <summary>
        /// Login to ObalkyKnih
        /// </summary>
        public string UserName { get; set; }
        
        /// <summary>
        /// Password to ObalkyKnih
        /// </summary>
        public string Password { get; set; }

        /// <summary>
        /// Path to external image editor
        /// </summary>
        public string ExternalImageEditor { get; set; }

        /// <summary>
        /// Indicates whether XServer is default search engine
        /// </summary>
        public bool IsXServerEnabled { get; set; }

        /// <summary>
        /// Url to XServer
        /// </summary>
        public string XServerUrl { get; set; }

        /// <summary>
        /// Base where is searched unit in XServer
        /// </summary>
        public string XServerBase { get; set; }

        /// <summary>
        /// Indicates whether Z39.50 is default search engine
        /// </summary>
        public bool IsZ39Enabled { get; set; }

        /// <summary>
        /// URL of Z39.50 server
        /// </summary>
        public string Z39Server { get; set; }

        /// <summary>
        /// Port where is Z39.50 server available
        /// </summary>
        public int Z39Port { get; set; }

        /// <summary>
        /// Base where is searched unit in Z39.50
        /// </summary>
        public string Z39Base { get; set; }

        /// <summary>
        /// Code that represents requests through barcode in Z39.50 
        /// </summary>
        public int Z39BarcodeField { get; set; }

        /// <summary>
        /// Encoding used in Z39.50 server (utf8 / windows-1250)
        /// </summary>
        public Record_Character_Encoding Z39Encoding { get; set; }

        /// <summary>
        /// Login to Z39.50 (mostly not used)
        /// </summary>
        public string Z39UserName { get; set; }

        /// <summary>
        /// Password to Z39.50 (mostly not used)
        /// </summary>
        public string Z39Password { get; set; }

        /// <summary>
        /// Sigla of library
        /// </summary>
        public string Sigla { get; set; }

        // Returns decrypted version of password
        private string GetDecryptedPassword(string password)
        {
            if (string.IsNullOrEmpty(password))
            {
                return "";
            }
            string entropyString = randomHash + UserName ?? "";
            byte[] entropy = Encoding.Unicode.GetBytes(entropyString);
            byte[] encryptedData = Convert.FromBase64String(password);
            byte[] decryptedData = ProtectedData.Unprotect(encryptedData, entropy, DataProtectionScope.CurrentUser);
            return Encoding.Unicode.GetString(decryptedData);
        }

        // Returns encrypted version of password
        private string GetEncryptedPassword(string password)
        {
            if (password == null)
            {
                password = "";
            }
            string entropyString = randomHash + UserName ?? "";
            byte[] entropy = Encoding.Unicode.GetBytes(entropyString);
            byte[] encryptedData = ProtectedData.Protect(Encoding.Unicode.GetBytes(password), entropy, DataProtectionScope.CurrentUser);
            return Convert.ToBase64String(encryptedData);
        }

        /// <summary>
        /// Copies values into static Settings class
        /// </summary>
        public void SyncToSettings()
        {
            OldSettings.UserName = this.UserName;
            OldSettings.Password = GetDecryptedPassword(this.Password);
            OldSettings.IsXServerEnabled = this.IsXServerEnabled;
            OldSettings.XServerUrl = this.XServerUrl;
            OldSettings.XServerBase = this.XServerBase;
            OldSettings.IsZ39Enabled = this.IsZ39Enabled;
            OldSettings.Z39Server = this.Z39Server;
            OldSettings.Z39Port = this.Z39Port;
            OldSettings.Z39Base = this.Z39Base;
            OldSettings.Z39Encoding = this.Z39Encoding;
            OldSettings.Z39UserName = this.Z39UserName;
            OldSettings.Z39Password = this.Z39Password;
            OldSettings.Z39BarcodeField = this.Z39BarcodeField;
            OldSettings.Sigla = this.Sigla;
        }

        /// <summary>
        /// Copies values from static Settings class into this class
        /// </summary>
        public void SyncFromSettings()
        {
            this.UserName = OldSettings.UserName;
            this.Password = this.GetEncryptedPassword(OldSettings.Password);
            this.IsXServerEnabled = OldSettings.IsXServerEnabled;
            this.XServerUrl = OldSettings.XServerUrl;
            this.XServerBase = OldSettings.XServerBase;
            this.IsZ39Enabled = OldSettings.IsZ39Enabled;
            this.Z39Server = OldSettings.Z39Server;
            this.Z39Port = OldSettings.Z39Port;
            this.Z39Base = OldSettings.Z39Base;
            this.Z39Encoding = (OldSettings.Z39Encoding == 0) ?
                Record_Character_Encoding.Unicode : OldSettings.Z39Encoding;
            this.Z39UserName = OldSettings.Z39UserName;
            this.Z39Password = OldSettings.Z39Password;
            this.Z39BarcodeField = OldSettings.Z39BarcodeField;
            this.Sigla = OldSettings.Sigla;
        }
    }
}
