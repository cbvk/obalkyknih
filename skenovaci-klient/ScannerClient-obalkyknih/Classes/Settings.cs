using System;
using System.Xml.Serialization;
using System.IO;
using System.Windows;
using System.Text;
using SobekCM.Bib_Package.MARC.Parsers;
using Microsoft.Win32;
using System.Security.Cryptography;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;


namespace ScannerClient_obalkyknih
{
    /// <summary>Represents user and application settings</summary>
    public static class Settings
    {
        const int DEFAULT_ISBN_FIELD = 7;
        const int DEFAULT_ISSN_FIELD = 8;
        const int DEFAULT_CNB_FIELD = 48;
        const int DEFAULT_ISMN_FIELD = 1016;
        const int DEFAULT_EAN_FIELD = 1016;
        public const int DEFAULT_NKP_CNB_FIELD = 48; // for union search
        const int DEFAULT_BARCODE_FIELD = 1063;
        public const int DEFAULT_FIELD = 1035;

        #region USER SETTINGS (SAVED IN REGISTRY)

        /// <summary>Sets given value for registry key with given name</summary>
        /// <param name="isAdminForced">indicates that the previous value was enforced by admin and can't be changed</param>
        /// <param name="name">name associated with value</param>
        /// <param name="value">value</param>
        /// <param name="rvk">type of registry value</param>
        private static void SetRegistryValue(bool isAdminForced, string name, object value, RegistryValueKind rvk)
        {
            if (!isAdminForced)
            {
                UserSettingsRegistryKey.SetValue(name, value, rvk);
            }
        }

        /// <summary>Receives DWORD registry value associated with specified name retrieved from admin or user key</summary>
        /// <param name="isAdminForced">indicates that user key value should be ignored if any</param>
        /// <param name="name">name associated with value</param>
        /// <returns>numeric value associated with given name</returns>
        private static int GetIntRegistryValue(bool isAdminForced, string name, int defaultValue = 0)
        {
            if (isAdminForced)
            {
                return (int)AdminSettingsRegistryKey.GetValue(name, defaultValue);
            }
            return (int)UserSettingsRegistryKey.GetValue(name, defaultValue);
        }

        /// <summary>Returns REG_SZ registry value with specified name retrieved from admin or user key</summary>
        /// <param name="isAdminForced">indicates that user key value should be ignored if any</param>
        /// <param name="name">name associated with value</param>
        /// <returns>string value associated with given name</returns>
        private static string GetStringRegistryValue(bool isAdminForced, string name)
        {
            if (isAdminForced)
            {
                return AdminSettingsRegistryKey.GetValue(name, null) as string;
            }
            return UserSettingsRegistryKey.GetValue(name, null) as string;
        }

        /// <summary>Login to system ObalkyKnih.cz</summary>
        internal static string UserName
        {
            get
            {
                return GetStringRegistryValue(false, "Username");
            }
            set
            {
                SetRegistryValue(false, "Username", value, RegistryValueKind.String);
            }
        }

        /// <summary>Password to system ObalkyKnih.cz</summary>
        internal static string Password
        {
            get
            {
                byte[] cryptoPassword = (byte[])UserSettingsRegistryKey.GetValue("Password", new byte[0]);
                if (cryptoPassword.Length == 0)
                {
                    return "";
                }
                byte[] entropy = Encoding.Unicode.GetBytes((UserName ?? "") + "Aqo3ojW6eQkTWLVI3FBvtBmKyOtYmYSiimhWFdf8");
                string password = "";
                try
                {
                    password = Encoding.Unicode.GetString(ProtectedData.Unprotect(cryptoPassword, entropy, DataProtectionScope.CurrentUser));
                }
                catch (Exception)
                {
                    MessageBoxDialogWindow.Show("Chyba dešifrování  hesla", "Nepovedlo se dešifrovat heslo.",
                        "OK", MessageBoxDialogWindow.Icons.Error);
                }
                return password;
            }
            set
            {
                byte[] password = Encoding.Unicode.GetBytes(value ?? "");
                byte[] entropy = Encoding.Unicode.GetBytes((UserName ?? "") + "Aqo3ojW6eQkTWLVI3FBvtBmKyOtYmYSiimhWFdf8");
                try
                {
                    byte[] cryptoPassword = ProtectedData.Protect(password, entropy, DataProtectionScope.CurrentUser);
                    SetRegistryValue(false, "Password", cryptoPassword, RegistryValueKind.Binary);
                }
                catch (Exception)
                {
                    MessageBoxDialogWindow.Show("Chyba šifrování  hesla", "Nepovedlo se uložit heslo.",
                        "OK", MessageBoxDialogWindow.Icons.Error);
                }
            }
        }

        /// <summary>Indicates that X-Server is default search engine</summary>
        internal static bool IsXServerEnabled
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(IsAdminIsXServerEnabled, "UseXServer"));
            }
            set
            {
                SetRegistryValue(IsAdminIsXServerEnabled, "UseXServer", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that X-Server choice was made by admin and can't be changed in application</summary>
        internal static bool IsAdminIsXServerEnabled
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("useXServer", null) != null;
            }
        }

        /// <summary>URL of X-Server</summary>
        internal static string XServerUrl
        {
            get
            {
                return GetStringRegistryValue(IsAdminXServerUrl, "XServerUrl");
            }
            set
            {
                SetRegistryValue(IsAdminXServerUrl, "XServerUrl", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that X-Server URL was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminXServerUrl
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("XServerUrl", null) != null;
            }
        }

        /// <summary>Database which contains searched record</summary>
        internal static string XServerBase
        {
            get
            {
                return GetStringRegistryValue(IsAdminXServerBase, "XServerBase");
            }
            set
            {
                SetRegistryValue(IsAdminXServerBase, "XServerBase", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that X-Server base was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminXServerBase
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("XServerBase", null) != null;
            }
        }

        /// <summary>Indicates that Z39.50 is default search engine</summary>
        internal static bool IsZ39Enabled
        {
            get
            {
                return !IsXServerEnabled;
            }
            set
            {
                IsXServerEnabled = !value;
            }
        }

        /// <summary>Indicates that choice of Z39 was made by admin and can't be changed in application</summary>
        internal static bool IsAdminIsZ39Enabled
        {
            get
            {
                return AdminSettingsRegistryKey != null && IsAdminIsXServerEnabled;
            }
        }

        /// <summary>URL of Z39.50 server</summary>
        internal static string Z39ServerUrl
        {
            get
            {
                return GetStringRegistryValue(IsAdminZ39ServerUrl, "Z39ServerUrl");
            }
            set
            {
                SetRegistryValue(IsAdminZ39ServerUrl, "Z39ServerUrl", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that URL of Z39.50 server was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39ServerUrl
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39ServerUrl", null) != null;
            }
        }

        /// <summary>URL of Z39.50 server of unions (SKC)</summary>
        internal static string Z39UnionServerUrl
        {
            get { return "aleph.nkp.cz"; }
            /*
            get
            {
                return GetStringRegistryValue(IsAdminZ39UnionServerUrl, "Z39UnionServerUrl");
            }
            set
            {
                SetRegistryValue(IsAdminZ39UnionServerUrl, "Z39UnionServerUrl", value, RegistryValueKind.String);
            }
          */
        }

        /// <summary>Indicates that URL of Z39.50 union server was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39UnionServerUrl
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39UnionServerUrl", null) != null;
            }
        }

        /// <summary>Port on which is Z39.50 server available</summary>
        internal static int Z39Port
        {
            get
            {
                return GetIntRegistryValue(IsAdminZ39Port, "Z39Port");
            }
            set
            {
                SetRegistryValue(IsAdminZ39Port, "Z39Port", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that port of Z39.50 server was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39Port
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39Port", null) != null;
            }
        }

        /// <summary>Port on which is Z39.50 union server available</summary>
        internal static int Z39UnionPort
        {
            get { return 9991; }
            /*
            get
            {
                return GetIntRegistryValue(IsAdminZ39UnionPort, "Z39UnionPort");
            }
            set
            {
                SetRegistryValue(IsAdminZ39UnionPort, "Z39UnionPort", value, RegistryValueKind.DWord);
            }
             */
        }

        /// <summary>Indicates that port of Z39.50 union server was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39UnionPort
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39UnionPort", null) != null;
            }
        }

        /// <summary>Database that contains searched record</summary>
        internal static string Z39Base
        {
            get
            {
                return GetStringRegistryValue(IsAdminZ39Base, "Z39Base");
            }
            set
            {
                SetRegistryValue(IsAdminZ39Base, "Z39Base", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that base for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39Base
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39Base", null) != null;
            }
        }

        /// <summary>Database that contains searched union record</summary>
        internal static string Z39UnionBase
        {
            get { return "SKC-UTF"; }
            /*
            get
            {
                return GetStringRegistryValue(IsAdminZ39UnionBase, "Z39UnionBase");
            }
            set
            {
                SetRegistryValue(IsAdminZ39UnionBase, "Z39UnionBase", value, RegistryValueKind.String);
            }
             */
        }

        /// <summary>Indicates that union base for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39UnionBase
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39UnionBase", null) != null;
            }
        }

        /// <summary>Encoding of Z39.50 server</summary>
        internal static Record_Character_Encoding Z39Encoding
        {
            get
            {
                string enc = GetStringRegistryValue(IsAdminZ39Encoding, "Z39Encoding");
                switch (enc)
                {
                    case "MARC":
                        return Record_Character_Encoding.MARC;
                    case "WINDOWS-1250":
                        return Record_Character_Encoding.Windows1250;
                    case "UNICODE":
                        return Record_Character_Encoding.Unicode;
                    default:
                        return Record_Character_Encoding.UNRECOGNIZED;
                }
            }
            set
            {
                string encoding = "";
                switch (value)
                {
                    case Record_Character_Encoding.MARC:
                        encoding = "MARC";
                        break;
                    case Record_Character_Encoding.Windows1250:
                        encoding = "WINDOWS-1250";
                        break;
                    case Record_Character_Encoding.Unicode:
                        encoding = "UNICODE";
                        break;
                    default:
                        encoding = "UNRECOGNIZED";
                        break;
                }
                SetRegistryValue(IsAdminZ39Encoding, "Z39Encoding", encoding, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that encoding for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39Encoding
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39Encoding", null) != null;
            }
        }

        /// <summary>Encoding of Z39.50 union server</summary>
        internal static Record_Character_Encoding Z39UnionEncoding
        {
            get { return Record_Character_Encoding.Unicode; }
            /*
            get
            {
                string enc = GetStringRegistryValue(IsAdminZ39UnionEncoding, "Z39UnionEncoding");
                switch (enc)
                {
                    case "MARC":
                        return Record_Character_Encoding.MARC;
                    case "WINDOWS-1250":
                        return Record_Character_Encoding.Windows1250;
                    case "UNICODE":
                        return Record_Character_Encoding.Unicode;
                    default:
                        return Record_Character_Encoding.UNRECOGNIZED;
                }
            }
            set
            {
                string encoding = "";
                switch (value)
                {
                    case Record_Character_Encoding.MARC:
                        encoding = "MARC";
                        break;
                    case Record_Character_Encoding.Windows1250:
                        encoding = "WINDOWS-1250";
                        break;
                    case Record_Character_Encoding.Unicode:
                        encoding = "UNICODE";
                        break;
                    default:
                        encoding = "UNRECOGNIZED";
                        break;
                }
                SetRegistryValue(IsAdminZ39UnionEncoding, "Z39UnionEncoding", encoding, RegistryValueKind.String);
            }
            */
        }

        /// <summary>Indicates that encoding for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39UnionEncoding
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39UnionEncoding", null) != null;
            }
        }

        /// <summary>Optional login to Z39.50 server</summary>
        internal static string Z39UserName
        {
            get
            {
                return GetStringRegistryValue(IsAdminZ39UserName, "Z39UserName");
            }
            set
            {
                SetRegistryValue(IsAdminZ39UserName, "Z39UserName", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that user name for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39UserName
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39UserName", null) != null;
            }
        }

        /// <summary>Optional password to Z39.50 server</summary>
        internal static string Z39Password
        {
            get
            {
                return GetStringRegistryValue(IsAdminZ39Password, "Z39Password");
            }
            set
            {
                SetRegistryValue(IsAdminZ39Password, "Z39Password", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that password for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39Password
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39Password", null) != null;
            }
        }

        /// <summary>Search number for barcode attribute in Z39.50</summary>
        internal static int Z39BarcodeField
        {
            get
            {
                int barcode = GetIntRegistryValue(IsAdminZ39BarcodeField, "Z39BarcodeField");
                return barcode == 0 ? DEFAULT_BARCODE_FIELD : barcode;
            }
            set
            {
                SetRegistryValue(IsAdminZ39BarcodeField, "Z39BarcodeField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of barcode field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39BarcodeField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39BarcodeField", null) != null;
            }
        }

        /// <summary>Search number for ISBN attribute in Z39.50</summary>
        internal static int Z39IsbnField
        {
            get
            {
                int isbn = GetIntRegistryValue(IsAdminZ39IsbnField, "Z39IsbnField");
                return isbn == 0 ? DEFAULT_ISBN_FIELD : isbn;
            }
            set
            {
                SetRegistryValue(IsAdminZ39IsbnField, "Z39IsbnField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of ISBN field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39IsbnField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39IsbnField", null) != null;
            }
        }

        /// <summary>Search number for ISSN attribute in Z39.50</summary>
        internal static int Z39IssnField
        {
            get
            {
                int issn = GetIntRegistryValue(IsAdminZ39IssnField, "Z39IssnField");
                return issn == 0 ? DEFAULT_ISSN_FIELD : issn;
            }
            set
            {
                SetRegistryValue(IsAdminZ39IssnField, "Z39IssnField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of ISSN field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39IssnField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39IssnField", null) != null;
            }
        }

        /// <summary>Search number for ČNB attribute in Z39.50</summary>
        internal static int Z39CnbField
        {
            get
            {
                int cnb = GetIntRegistryValue(IsAdminZ39CnbField, "Z39CnbField");
                int defaultCnb = DEFAULT_CNB_FIELD;
                switch (Settings.Sigla)
                {
                    case "CBA001": defaultCnb = 2544; break;
                    case "KLG001": defaultCnb = 2383; break;
                }
                return cnb == 0 ? defaultCnb : cnb;
            }
            set
            {
                SetRegistryValue(IsAdminZ39CnbField, "Z39CnbField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of ČNB field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39CnbField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39CnbField", null) != null;
            }
        }

        /// <summary>Search number for ISMN attribute in Z39.50</summary>
        internal static int Z39IsmnField
        {
            get
            {
                int ismn = GetIntRegistryValue(IsAdminZ39IsmnField, "Z39IsmnField");
                int defaultIsmn = DEFAULT_ISMN_FIELD;
                switch (Settings.Sigla)
                {
                    case "CBA001": defaultIsmn = 2440; break;
                    case "KLG001": defaultIsmn = 2440; break;
                    case "LIA001": defaultIsmn = 2440; break;
                }
                return ismn == 0 ? defaultIsmn : ismn;
            }
            set
            {
                SetRegistryValue(IsAdminZ39IsmnField, "Z39IsmnField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of ISMN field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39IsmnField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39IsmnField", null) != null;
            }
        }

        /// <summary>Search number for OCLC attribute in Z39.50</summary>
        internal static int Z39OclcField
        {
            get
            {
                int oclc = GetIntRegistryValue(IsAdminZ39OclcField, "Z39OclcField");
                return oclc == 0 ? DEFAULT_FIELD : oclc;
            }
            set
            {
                SetRegistryValue(IsAdminZ39OclcField, "Z39OclcField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of OCLC field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39OclcField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39OclcField", null) != null;
            }
        }

        /// <summary>Search number for EAN attribute in Z39.50</summary>
        internal static int Z39EanField
        {
            get
            {
                int ean = GetIntRegistryValue(IsAdminZ39EanField, "Z39EanField");
                return ean == 0 ? DEFAULT_EAN_FIELD : ean;
            }
            set
            {
                SetRegistryValue(IsAdminZ39EanField, "Z39EanField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of EAN field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39EanField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39EanField", null) != null;
            }
        }

        /// <summary>Search number for URN attribute in Z39.50</summary>
        internal static int Z39UrnField
        {
            get
            {
                return GetIntRegistryValue(IsAdminZ39UrnField, "Z39UrnField");
            }
            set
            {
                SetRegistryValue(IsAdminZ39UrnField, "Z39UrnField", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of URN field for Z39.50 was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminZ39UrnField
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Z39UrnField", null) != null;
            }
        }

        /// <summary>Sigla of library</summary>
        internal static string Sigla
        {
            get
            {
                return GetStringRegistryValue(IsAdminSigla, "Sigla");
            }
            set
            {
                SetRegistryValue(IsAdminSigla, "Sigla", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that sigla was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminSigla
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Sigla", null) != null;
            }
        }

        /// <summary>Base of record - can be different than one in Z39.50 (MZK01-UTF vs MZK01)</summary>
        internal static string Base
        {
            get
            {
                return GetStringRegistryValue(IsAdminBase, "Base");
            }
            set
            {
                SetRegistryValue(IsAdminBase, "Base", value, RegistryValueKind.String);
            }
        }

        /// <summary>Indicates that base was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminBase
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("Base", null) != null;
            }
        }

        /// <summary>Disables updates by ADMIN (can be set only in registry and only with admin rights on local machine)</summary>
        internal static bool DisableUpdate
        {
            get
            {
                return AdminSettingsRegistryKey != null && Convert.ToBoolean(GetIntRegistryValue(true, "DisableUpdate"));
            }
        }

        /// <summary>Forces updates - only newest version can be used (can be set only in registry and only with admin rights on local machine)</summary>
        internal static bool ForceUpdate
        {
            get
            {
                return AdminSettingsRegistryKey != null && Convert.ToBoolean(GetIntRegistryValue(true, "ForceUpdate"));
            }
        }

        /// <summary>Ignores missing author and publish year</summary>
        internal static bool DisableMissingAuthorYearNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableMissingAuthorYearNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableMissingAuthorYearNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Ignores missing cover image</summary>
        internal static bool DisableWithoutCoverNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableWithoutCoverNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableWithoutCoverNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Ignores missing toc image</summary>
        internal static bool DisableWithoutTocNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableWithoutTocNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableWithoutTocNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>deletes cover image without confirmation</summary>
        internal static bool DisableCoverDeletionNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableCoverDeletionNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableCoverDeletionNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>deletes toc image without confirmation</summary>
        internal static bool DisableTocDeletionNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableTocDeletionNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableTocDeletionNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>deletes bib image without confirmation</summary>
        internal static bool DisableBibDeletionNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableBibDeletionNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableBibDeletionNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>do not show custom identifier notification</summary>
        internal static bool DisableCustomIdentifierNotification
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableCustomIdentifierNotification"));
            }
            set
            {
                SetRegistryValue(false, "DisableCustomIdentifierNotification", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>closes application without confirmation</summary>
        internal static bool DisableClosingConfirmation
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableClosingConfirmation"));
            }
            set
            {
                SetRegistryValue(false, "DisableClosingConfirmation", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Always downloads updates without confirmation</summary>
        internal static bool AlwaysDownloadUpdates
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "AlwaysDownloadUpdates"));
            }
            set
            {
                if (value && NeverDownloadUpdates)
                {
                    NeverDownloadUpdates = false;
                }
                SetRegistryValue(false, "AlwaysDownloadUpdates", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Doesn't ask for downloading of updates unless unsupported version</summary>
        internal static bool NeverDownloadUpdates
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "NeverDownloadUpdates"));
            }
            set
            {
                if (value && AlwaysDownloadUpdates)
                {
                    AlwaysDownloadUpdates = false;
                }
                SetRegistryValue(false, "NeverDownloadUpdates", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Doesn't ask for downloading of updates unless unsupported version</summary>
        internal static bool DisableResolveIdentifier
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "DisableResolveIdentifier"));
            }
            set
            {
                SetRegistryValue(false, "DisableResolveIdentifier", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Store aquired image to local storage</summary>
        internal static bool EnableLocalImageCopy
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "EnableLocalImageCopy"));
            }
            set
            {
                SetRegistryValue(false, "EnableLocalImageCopy", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Scan with low data flow</summary>
        internal static bool EnableScanLowDataFlow
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "EnableScanLowDataFlow"));
            }
            set
            {
                SetRegistryValue(false, "EnableScanLowDataFlow", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        /// <summary>Scan with low resolution</summary>
        internal static bool EnableScanLowRes
        {
            get
            {
                return Convert.ToBoolean(GetIntRegistryValue(false, "EnableScanLowRes"));
            }
            set
            {
                SetRegistryValue(false, "EnableScanLowRes", value ? 1 : 0, RegistryValueKind.DWord);
            }
        }

        internal static string ScanOutputDir
        {
            get
            {
                // default dir
                string localUploadDir = System.IO.Path.GetDirectoryName(System.Reflection.Assembly.GetExecutingAssembly().Location);
                localUploadDir = System.IO.Path.Combine(localUploadDir, "storage");
                // loaded from windows registry
                string scanOutputDir = GetStringRegistryValue(IsAdminScanOutputDir, "ScanOutputDir");
                return string.IsNullOrEmpty(scanOutputDir) ? localUploadDir : scanOutputDir;
            }
            set
            {
                SetRegistryValue(IsAdminScanOutputDir, "ScanOutputDir", value, RegistryValueKind.String);
            }
        }

        /// <summary>Default brightness slider value</summary>
        internal static double DefaultBrightness
        {
            get
            {
                return GetIntRegistryValue(IsAdminDefaultBrightness, "DefaultBrightness");
            }
            set
            {
                SetRegistryValue(IsAdminDefaultBrightness, "DefaultBrightness", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of default brightness was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminDefaultBrightness
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("IsAdminDefaultBrightness", null) != null;
            }
        }

        /// <summary>Default contrast slider value</summary>
        internal static double DefaultContrast
        {
            get
            {
                return GetIntRegistryValue(IsAdminDefaultContrast, "DefaultContrast");
            }
            set
            {
                SetRegistryValue(IsAdminDefaultContrast, "DefaultContrast", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of default contrast was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminDefaultContrast
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("IsAdminDefaultContrast", null) != null;
            }
        }

        /// <summary>Default gama slider value</summary>
        internal static double DefaultGamma
        {
            get
            {
                return GetIntRegistryValue(IsAdminDefaultGamma, "DefaultGamma", 1);
            }
            set
            {
                SetRegistryValue(IsAdminDefaultGamma, "DefaultGamma", value, RegistryValueKind.DWord);
            }
        }

        /// <summary>Indicates that numeric code of default contrast was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminDefaultGamma
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("IsAdminDefaultGamma", null) != null;
            }
        }

        /// <summary>Indicates that scan output directory was filled by admin and can't be changed in application</summary>
        internal static bool IsAdminScanOutputDir
        {
            get
            {
                return AdminSettingsRegistryKey != null && AdminSettingsRegistryKey.GetValue("ScanOutputDir", null) != null;
            }
        }

        /// <summary>Version of application used for information about new changes</summary>
        internal static string VersionInfo
        {
            get
            {
                return GetStringRegistryValue(false, "VersionInfo");
            }
            set
            {
                SetRegistryValue(false, "VersionInfo", value, RegistryValueKind.String);
            }
        }
        #endregion

        #region APPLICATION SETTINGS (COMPILED INTO CODE)

        // Registry key of obalkyknih - This shouldn't change, if changed, it has to be changed also in installer
        private static RegistryKey UserSettingsRegistryKey
        {
            get
            {
                RegistryKey regkey = null;
                bool is64bit = !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("PROCESSOR_ARCHITEW6432"));
                if (is64bit)
                {
                    using (var hkcu = RegistryKey.OpenBaseKey(RegistryHive.CurrentUser, RegistryView.Registry64))
                    {
                        regkey = hkcu.CreateSubKey(@"Software\ObalkyKnih-scanner");
                    }
                }
                else
                {
                    regkey = Registry.CurrentUser.CreateSubKey(@"Software\ObalkyKnih-scanner");
                }
                return regkey;
            }
        }

        private static RegistryKey AdminSettingsRegistryKey
        {
            get
            {
                RegistryKey regkey = null;
                bool is64bit = !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("PROCESSOR_ARCHITEW6432"));
                if (is64bit)
                {
                    using (var hklm = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, RegistryView.Registry64))
                    {
                        regkey = hklm.OpenSubKey(@"Software\ObalkyKnih-scanner");
                    }
                }
                else
                {
                    regkey = Registry.LocalMachine.OpenSubKey(@"Software\ObalkyKnih-scanner");
                }
                return regkey;
            }
        }
        /// <summary>Version of application</summary>
        internal static Version Version { get { return Assembly.GetEntryAssembly().GetName().Version; } }

        /// <summary>URL of folder containing update-info.xml file</summary>
        internal const string UpdateServer = "http://www.obalkyknih.cz/obalkyknih-scanner";
        //internal const string UpdateServer = "http://10.89.56.102/obalkyknih-scanner";

        /// <summary>URL of import function on obalkyknih.</summary>
        internal const string ImportLink = "http://www.obalkyknih.cz/api/import";
        //internal const string ImportLink = "http://10.89.56.102/api/import";
        //internal const string ImportLink = "http://localhost:3999/api/import";

        /// <summary>Returns path to temporary folder, where are stored images opened in external editor and downloaded updates</summary>
        internal static string TemporaryFolder { get { return System.IO.Path.GetTempPath() + "ObalkyKnih-scanner\\"; } }

        /// <summary>List of Title fields in Marc21 (245a 245b 245n, 245p)</summary>
        internal static IEnumerable<KeyValuePair<int, IEnumerable<char>>> MetadataTitleFields
        {
            get
            {
                return new List<KeyValuePair<int, IEnumerable<char>>> 
                { new KeyValuePair<int, IEnumerable<char>>(245, new List<char> { 'a', 'b', 'n', 'p' }) };
            }
        }
        
        /// <summary>Tag of Author field in Marc21</summary>
        internal static IEnumerable<KeyValuePair<int, IEnumerable<char>>> MetadataAuthorFields
        {
            get
            {
                return new List<KeyValuePair<int, IEnumerable<char>>> 
                { 
                    new KeyValuePair<int, IEnumerable<char>>(100, new List<char> { 'a', 'b', '7' }),
                    new KeyValuePair<int, IEnumerable<char>>(700, new List<char> { 'a', 'b', '7' })
                };
            }
        }

        /// <summary>Publish Year (AACR2) field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataPublishYearField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(260, 'c', null, null);
            }
        }
        
        /// <summary>Publish Year field (RDA) in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataPublishYearFieldRDA
        {
            get
            {
                return new Tuple<int, char, char?, char?>(264, 'c', null, null);
            }
        }

        /// <summary>ISBN field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataIsbnField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(20, 'a', null, null);
            }
        }

        /// <summary>ISBN field in Marc21 for yearbook (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataIsbnYearbookField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(902, 'a', null, null);
            }
        }

        /// <summary>ISSN field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataIssnField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(22, 'a', null, null);
            }
        }

        /// <summary>ČNB field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataCnbField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(15, 'a', null, null);
            }
        }

        /// <summary>OCLC field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataOclcField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(35, 'a', null, null);
            }
        }

        /// <summary>UPC field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataUpcField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(24, 'a', '1', null);
            }
        }

        /// <summary>ISMN field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataIsmnField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(24, 'a', '2', null);
            }
        }

        /// <summary>EAN field in Marc21 (field, subfield, ind1, ind2)</summary>
        internal static Tuple<int, char, char?, char?> MetadataEanField
        {
            get
            {
                return new Tuple<int, char, char?, char?>(24, 'a', '3', null);
            }
        }
        
        internal static Tuple<int, char, char?, char?> MetadataVolumeFieldA
        {
            get
            {
                return new Tuple<int, char, char?, char?>(915, 'a', null, null);
            }
        }
        
        internal static Tuple<int, char, char?, char?> MetadataPartNoFieldA
        {
            get
            {
                return new Tuple<int, char, char?, char?>(915, 'b', null, null);
            }
        }
        
        internal static Tuple<int, char, char?, char?> MetadataPublishYearFieldA
        {
            get
            {
                return new Tuple<int, char, char?, char?>(915, 'c', null, null);
            }
        }

        /// <summary>PPI used for scanning of cover</summary>
        internal const int CoverDPI = 300;

        /// <summary>Color type used for scanning of cover (Color/Grey/Black and White)</summary>
        internal const ScanColor CoverScanType = ScanColor.Color;

        /// <summary>PPI used for scanning of cover</summary>
        internal const int TocDPI = 300;

        /// <summary>PPI used for scanning in low resolution</summary>
        internal const int LowResDPI = 150;

        /// <summary>Color type used for scanning of cover (Color/Grey/Black and White)</summary>
        internal const ScanColor TocScanType = ScanColor.Color;

        /// <summary>Priznak posuvu slideru v tomto behu aplikace</summary>
        public static bool ImageTransformationSlidersChanged = false;
        #endregion

        /// <summary>Saves settings into registry if not already</summary>
        internal static void PersistSettings()
        {
            SetRegistryValue(false, "isMigrated", 1, RegistryValueKind.DWord);
            UserSettingsRegistryKey.Flush();
        }
    }
}