using System;
using System.Xml.Serialization;
using System.IO;
using System.Windows;
using System.Text;
using SobekCM.Bib_Package.MARC.Parsers;
using Microsoft.Win32;


namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Represents user and application settings
    /// </summary>
    public static class OldSettings
    {
        #region USER SETTINGS

        /// <summary>
        /// Login to system ObalkyKnih.cz
        /// </summary>
        internal static string UserName { get; set; }

        /// <summary>
        /// Password to system ObalkyKnih.cz
        /// </summary>
        internal static string Password { get; set; }
       
        /// <summary>
        /// Indicates that X-Server is default search engine
        /// </summary>
        internal static bool IsXServerEnabled { get; set; }

        /// <summary>
        /// URL of X-Server
        /// </summary>
        internal static string XServerUrl { get; set; }

        /// <summary>
        /// Database which contains searched record
        /// </summary>
        internal static string XServerBase { get; set; }

        /// <summary>
        /// Indicates that Z39.50 is default search engine
        /// </summary>
        internal static bool IsZ39Enabled { get; set; }

        /// <summary>
        /// URL of Z39.50 server
        /// </summary>
        internal static string Z39Server { get; set; }

        /// <summary>
        /// Port on which is Z39.50 server available
        /// </summary>
        internal static int Z39Port { get; set; }

        /// <summary>
        /// Database that contains searched record
        /// </summary>
        internal static string Z39Base { get; set; }

        /// <summary>
        /// Encoding of Z39.50 server
        /// </summary>
        internal static Record_Character_Encoding Z39Encoding { get; set; }

        /// <summary>
        /// Optional login to Z39.50 server
        /// </summary>
        internal static string Z39UserName { get; set; }

        /// <summary>
        /// Optional password to Z39.50 server
        /// </summary>
        internal static string Z39Password { get; set; }

        /// <summary>
        /// Search number for barcode attribute in Z39.50
        /// </summary>
        internal static int Z39BarcodeField { get; set; }

        /// <summary>
        /// Sigla of library
        /// </summary>
        internal static string Sigla { get; set; }
        #endregion

        #region APPLICATION SETTINGS
        
        // Path to file with settings
        // This shouldn't change, if changed, it has to be changed also in installer
        private static string SettingsFile
        {
            get
            {
                return Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData)
                    + @"\ObalkyKnih-scanner\settings.config";
            }
        }
        
        /// <summary>
        /// URL of folder containing update-info.xml file
        /// </summary>
        internal const string UpdateServer = "https://obalkyknih.cz/obalkyknih-scanner";

        /// <summary>
        /// URL of import function on obalkyknih.cz
        /// </summary>
        internal const string ImportLink = "https://obalkyknih.cz/api/import";

        /// <summary>
        /// Returns path to temporary folder, where are stored images opened in external editor
        /// and downloaded updates
        /// </summary>
        internal static string TemporaryFolder { get { return System.IO.Path.GetTempPath() + "ObalkyKnih-scanner\\"; } }
        
        /// <summary>
        /// Tag of Title field in Marc21
        /// </summary>
        internal const int MetadataTitleField = 245;

        /// <summary>
        /// Tag of Title subfield in Marc21
        /// </summary>
        internal const char MetadataTitleSubfield = 'a';

        /// <summary>
        /// Tag of Additional Title subfield in Marc21
        /// </summary>
        internal const char MetadataTitleSubfield2 = 'b';

        /// <summary>
        /// Tag of Author field in Marc21
        /// </summary>
        internal const int MetadataAuthorField = 100;

        /// <summary>
        /// Tag of Author Name subfield in Marc21
        /// </summary>
        internal const char MetadataAuthorSubfieldName = 'a';

        /// <summary>
        /// Tag of Author Numeration subfield in Marc21
        /// </summary>
        internal const char MetadataAuthorSubfieldNumeration = 'b';

        /// <summary>
        /// Tag of Additional Authors field in Marc21
        /// </summary>
        internal const int MetadataAuthorField700 = 700;

        /// <summary>
        /// Tag of Publish Year field in Marc21
        /// </summary>
        internal const int MetadataPublishYearField = 260;

        /// <summary>
        /// Tag of Publih Year subfield in Marc21
        /// </summary>
        internal const char MetadataPublishYearSubfield = 'c';

        /// <summary>
        /// Tag of ISBN field in Marc21
        /// </summary>
        internal const int MetadataIsbnField = 20;

        /// <summary>
        /// Tag of ISBN subfield in Marc21
        /// </summary>
        internal const char MetadataIsbnSubfield = 'a';

        /// <summary>
        /// Tag of ISSN field in Marc21
        /// </summary>
        internal const int MetadataIssnField = 22;

        /// <summary>
        /// Tag of ISSN subfield in Marc21
        /// </summary>
        internal const char MetadataIssnSubfield = 'a';

        /// <summary>
        /// Tag of ČNB field in Marc21
        /// </summary>
        internal const int MetadataCnbField = 15;

        /// <summary>
        /// Tag of ČNB subfield in Marc21
        /// </summary>
        internal const char MetadataCnbSubfield = 'a';

        /// <summary>
        /// Tag of OCLC field in Marc21
        /// </summary>
        internal const int MetadataOclcField = 35;

        /// <summary>
        /// Tag of OCLC subfield in Marc21
        /// </summary>
        internal const char MetadataOclcSubfield = 'a';

        /// <summary>
        /// Tag of EAN field in Marc21
        /// </summary>
        internal const int MetadataEanField = 24;

        /// <summary>
        /// Tag of EAN subfield in Marc21
        /// </summary>
        internal const char MetadataEanSubfield = 'a';

        /// <summary>
        /// Tag of first indicator of EAN field in Marc21
        /// </summary>
        internal const char MetadataEanFirstIndicator = '3';

        /// <summary>
        /// Tag of UPC field in Marc21
        /// </summary>
        internal const int MetadataUpcField = 24;

        /// <summary>
        /// Tag of UPC subfield in Marc21
        /// </summary>
        internal const char MetadataUpcSubfield = 'a';

        /// <summary>
        /// Tag of first indicator of UPC field in Marc21
        /// </summary>
        internal const char MetadataUpcFirstIndicator = '1';

        /// <summary>
        /// PPI used for scanning of cover
        /// </summary>
        internal const int CoverDPI = 300;

        /// <summary>
        /// Color type used for scanning of cover (Color/Grey/Black and White)
        /// </summary>
        internal const ScanColor CoverScanType = ScanColor.Color;

        /// <summary>
        /// PPI used for scanning of cover
        /// </summary>
        internal const int TocDPI = 300;

        /// <summary>
        /// Color type used for scanning of cover (Color/Grey/Black and White)
        /// </summary>
        internal const ScanColor TocScanType = ScanColor.Color;
        #endregion

        /// <summary>
        /// Saves settings to disk
        /// </summary>
        internal static void PersistSettings()
        {
            try
            {
                Directory.CreateDirectory(SettingsFile.Remove(SettingsFile.LastIndexOf('\\')));
                XmlSerializer xmlSerializer = new XmlSerializer(typeof(UserSettings));
                UserSettings us = new UserSettings();
                using (FileStream fs = new FileStream(SettingsFile, FileMode.Create))
                {
                    us.SyncFromSettings();
                    xmlSerializer.Serialize(fs, us);
                }
            }
            catch (Exception)
            {
                MessageBoxDialogWindow.Show("Nastavení neuloženo", "Zápis nastavení se nezdařil.",
                    "OK", MessageBoxDialogWindow.Icons.Error);
            }
        }

        /// <summary>
        /// Reloads settings from values saved on disk
        /// </summary>
        internal static void ReloadSettings()
        {
            XmlSerializer xmlSerializer = new XmlSerializer(typeof(UserSettings));
                using (TextReader xml = new StreamReader(SettingsFile))
                {
                    UserSettings us = xmlSerializer.Deserialize(xml) as UserSettings;
                    us.SyncToSettings();
                }
        }

        /// <summary>Copies settings from config file into registry</summary>
        public static void MigrateOldSettings()
        {
            // if settings were already migrated, do nothing
            if (Registry.GetValue(@"HKEY_CURRENT_USER\Software\ObalkyKnih-scanner", "isMigrated", null) != null)
            {
                return;
            }

            if (!File.Exists(SettingsFile))
            {
                MessageBoxDialogWindow.Show("Nastavení neexistují", "Soubor s uživatelskými nastaveními neexistuje.",
                    "OK", MessageBoxDialogWindow.Icons.Error);
                return;
            }

            try
            {
                ReloadSettings();
            }
            catch (Exception)
            {
                MessageBoxDialogWindow.Show("Poškozené nastavení", "Soubor s uživatelskými nastaveními je poškozen.",
                    "OK", MessageBoxDialogWindow.Icons.Error);
                return;
            }

            if (Settings.UserName == null && !string.IsNullOrEmpty(UserName))
            {
                Settings.UserName = UserName;
            }

            if (string.IsNullOrEmpty(Settings.Password) && !string.IsNullOrEmpty(Password))
            {
                Settings.Password = Password;
            }

            Settings.IsXServerEnabled = IsXServerEnabled;

            if (Settings.XServerUrl == null && !string.IsNullOrEmpty(XServerUrl))
            {
                Settings.XServerUrl = XServerUrl;
            }

            if (Settings.XServerBase == null && !string.IsNullOrEmpty(XServerBase))
            {
                Settings.XServerBase = XServerBase;
            }

            Settings.IsZ39Enabled = IsZ39Enabled;

            if (Settings.Z39ServerUrl == null && !string.IsNullOrEmpty(Z39Server))
            {
                Settings.Z39ServerUrl = Z39Server;
            }

            if (Settings.Z39Port == 0 && Z39Port != 0)
            {
                Settings.Z39Port = Z39Port;
            }

            if (Settings.Z39Base == null && !string.IsNullOrEmpty(Z39Base))
            {
                Settings.Z39Base = Z39Base;
            }

            if (Settings.Z39Encoding == Record_Character_Encoding.UNRECOGNIZED &&
                Z39Encoding != Record_Character_Encoding.UNRECOGNIZED)
            {
                Settings.Z39Encoding = Z39Encoding;
            }

            if (Settings.Z39UserName == null && !string.IsNullOrEmpty(Z39UserName))
            {
                Settings.Z39UserName = Z39UserName;
            }

            if (Settings.Z39Password == null && !string.IsNullOrEmpty(Z39Password))
            {
                Settings.Z39Password = Z39Password;
            }

            if (Settings.Z39BarcodeField == 0 && Z39BarcodeField != 0)
            {
                Settings.Z39BarcodeField = Z39BarcodeField;
            }

            if (Settings.Sigla == null && !string.IsNullOrEmpty(Sigla))
            {
                Settings.Sigla = Sigla;
            }

            // delete config file if possible
            try
            {
                File.Delete(SettingsFile);
            }
            catch (Exception) { }

            // save indicator that values have been migrated successfully
            Registry.SetValue(@"HKEY_CURRENT_USER\Software\ObalkyKnih-scanner",
                "isMigrated", 1, RegistryValueKind.DWord);
        }
    }
}
