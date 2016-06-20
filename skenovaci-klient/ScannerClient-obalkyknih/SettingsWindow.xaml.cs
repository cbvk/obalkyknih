using System;
using System.Windows;
using System.Text;
using SobekCM.Bib_Package.MARC.Parsers;
using System.Windows.Input;
using System.Windows.Forms;

namespace ScannerClient_obalkyknih
{
    /// <summary>Interaction logic for SettingsWindow.xaml</summary>
    public partial class SettingsWindow : Window
    {
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();

        public SettingsWindow()
        {
            InitializeComponent();
            LoadSettings();

            // close on Esc
            CommandBinding cb = new CommandBinding(closeCommand, CloseExecuted, CloseCanExecute);
            this.CommandBindings.Add(cb);
            KeyGesture kg = new KeyGesture(Key.Escape);
            InputBinding ib = new InputBinding(closeCommand, kg);
            this.InputBindings.Add(ib);
        }

        // Loads settings from Settings class and writes them to components
        private void LoadSettings()
        {
            this.z39ServerRadioButton.IsEnabled = !Settings.IsAdminIsZ39Enabled;
            this.z39ServerRadioButton.IsChecked = Settings.IsZ39Enabled;
            this.z39ServerTextBox.IsEnabled = !Settings.IsAdminZ39ServerUrl && Settings.IsZ39Enabled;
            this.z39ServerTextBox.Text = Settings.Z39ServerUrl;
            this.z39PortTextBox.IsEnabled = !Settings.IsAdminZ39Port && Settings.IsZ39Enabled;
            this.z39PortTextBox.Text = Settings.Z39Port.ToString();
            this.z39DatabaseTextBox.IsEnabled = !Settings.IsAdminZ39Base && Settings.IsZ39Enabled;
            this.z39DatabaseTextBox.Text = Settings.Z39Base;
            this.z39UserNameTextBox.IsEnabled = !Settings.IsAdminZ39UserName && Settings.IsZ39Enabled;
            this.z39UserNameTextBox.Text = Settings.Z39UserName;
            this.z39PasswordTextBox.IsEnabled = !Settings.IsAdminZ39Password && Settings.IsZ39Enabled;
            this.z39PasswordTextBox.Text = Settings.Z39Password;
            this.z39BarcodeField.IsEnabled = !Settings.IsAdminZ39BarcodeField && Settings.IsZ39Enabled;
            this.z39BarcodeField.Text = Settings.Z39BarcodeField.ToString();
            this.z39CnbField.IsEnabled = !Settings.IsAdminZ39CnbField && Settings.IsZ39Enabled;
            this.z39CnbField.Text = Settings.Z39CnbField.ToString();
            this.z39EncodingComboBox.IsEnabled = !Settings.IsAdminZ39Encoding && Settings.IsZ39Enabled;
            if (Settings.Z39Encoding == Record_Character_Encoding.MARC)
            {
                this.z39EncodingComboBox.SelectedIndex = 2;
            }
            else if (Settings.Z39Encoding == Record_Character_Encoding.Windows1250)
            {
                this.z39EncodingComboBox.SelectedIndex = 1;
            }
            else
            {
                this.z39EncodingComboBox.SelectedIndex = 0;
            }

            this.xServerRadioButton.IsEnabled = !Settings.IsAdminIsXServerEnabled;
            this.xServerRadioButton.IsChecked = Settings.IsXServerEnabled;
            this.xServerUrlTextBox.IsEnabled = !Settings.IsAdminXServerUrl && Settings.IsXServerEnabled;
            this.xServerUrlTextBox.Text = Settings.XServerUrl;
            this.xServerDatabaseTextBox.IsEnabled = !Settings.IsAdminXServerBase && Settings.IsXServerEnabled;
            this.xServerDatabaseTextBox.Text = Settings.XServerBase;

            this.siglaTextBox.IsEnabled = !Settings.IsAdminSigla;
            this.siglaTextBox.Text = Settings.Sigla;

            this.baseTextBox.IsEnabled = !Settings.IsAdminBase;
            this.baseTextBox.Text = Settings.Base;

            this.alwaysDownloadUpdatesCheckBox.IsEnabled = !Settings.DisableUpdate;
            this.neverDownloadUpdatesCheckBox.IsChecked = Settings.DisableUpdate ? 
                true : Settings.NeverDownloadUpdates;

            this.neverDownloadUpdatesCheckBox.IsEnabled = !Settings.DisableUpdate;
            this.alwaysDownloadUpdatesCheckBox.IsChecked = Settings.DisableUpdate ?
                false : Settings.AlwaysDownloadUpdates;

            this.disableClosingConfirmationCheckBox.IsChecked = Settings.DisableClosingConfirmation;
            this.disableMissingAuthorYearNotificationCheckBox.IsChecked = Settings.DisableMissingAuthorYearNotification;
            this.disableWithoutCoverNotificationCheckBox.IsChecked = Settings.DisableWithoutCoverNotification;
            this.disableWithoutTocNotificationCheckBox.IsChecked = Settings.DisableWithoutTocNotification;
            this.disableCoverDeletionNotificationCheckBox.IsChecked = Settings.DisableCoverDeletionNotification;
            this.disableTocDeletionNotificationCheckBox.IsChecked = Settings.DisableTocDeletionNotification;
            this.disableCustomIdentifierNotificationCheckBox.IsChecked = Settings.DisableCustomIdentifierNotification;
            this.disableResolveIdentifierCheckBox.IsChecked = Settings.DisableResolveIdentifier;
            this.enableLocalImageCopy.IsChecked = Settings.EnableLocalImageCopy;
            this.scanLowDataFlowCheckBox.IsChecked = Settings.EnableScanLowDataFlow;
            this.scanLowResCheckBox.IsChecked = Settings.EnableScanLowRes;

            this.scanOutputDir.IsEnabled = !Settings.IsAdminScanOutputDir;
            this.scanOutputDir.Text = Settings.ScanOutputDir;
        }

        // Enables XServer components, disables Z39.50 components
        private void XServerRadioButton_Checked(object sender, RoutedEventArgs e)
        {
            this.z39ServerRadioButton.IsChecked = false;
            this.z39ServerTextBox.IsEnabled = false;
            this.z39PortTextBox.IsEnabled = false;
            this.z39DatabaseTextBox.IsEnabled = false;
            this.z39EncodingComboBox.IsEnabled = false;
            this.z39UserNameTextBox.IsEnabled = false;
            this.z39PasswordTextBox.IsEnabled = false;
            this.z39BarcodeField.IsEnabled = false;
            this.xServerUrlTextBox.IsEnabled = !Settings.IsAdminXServerUrl;
            this.xServerDatabaseTextBox.IsEnabled = !Settings.IsAdminXServerUrl;
        }

        // Enables Z39.50 components, disables XServer components
        private void Z39ServerRadioButton_Checked(object sender, RoutedEventArgs e)
        {
            this.xServerRadioButton.IsChecked = false;
            this.z39ServerTextBox.IsEnabled = !Settings.IsAdminZ39ServerUrl;
            this.z39PortTextBox.IsEnabled = !Settings.IsAdminZ39Port;
            this.z39DatabaseTextBox.IsEnabled = !Settings.IsAdminZ39Base;
            this.z39EncodingComboBox.IsEnabled = !Settings.IsAdminZ39Encoding;
            this.z39UserNameTextBox.IsEnabled = !Settings.IsAdminZ39UserName;
            this.z39PasswordTextBox.IsEnabled = !Settings.IsAdminZ39Password;
            this.z39BarcodeField.IsEnabled = !Settings.IsAdminZ39BarcodeField;
            this.xServerUrlTextBox.IsEnabled = false;
            this.xServerDatabaseTextBox.IsEnabled = false;
        }

        // Persist settings to settings file and close settings window
        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            if (!ValidateInput())
            {
                return;
            }
            Settings.IsZ39Enabled = (bool) this.z39ServerRadioButton.IsChecked;
            Settings.IsXServerEnabled = (bool) this.xServerRadioButton.IsChecked;
            Settings.Z39ServerUrl = this.z39ServerTextBox.Text;
            Settings.Z39Port = int.Parse(this.z39PortTextBox.Text);
            Settings.Z39Base = this.z39DatabaseTextBox.Text;
            Settings.Z39UserName = this.z39UserNameTextBox.Text;
            Settings.Z39Password = this.z39PasswordTextBox.Text;
            Settings.Z39BarcodeField = int.Parse(this.z39BarcodeField.Text);
            Settings.Z39CnbField = int.Parse(this.z39CnbField.Text);
            if (this.z39EncodingComboBox.SelectedIndex == 2)
            {
                Settings.Z39Encoding = Record_Character_Encoding.MARC;
            }
            else if (this.z39EncodingComboBox.SelectedIndex == 1)
            {
                Settings.Z39Encoding = Record_Character_Encoding.Windows1250;
            }
            else
            {
                Settings.Z39Encoding = Record_Character_Encoding.Unicode;
            }

            Settings.XServerUrl = this.xServerUrlTextBox.Text;
            Settings.XServerBase = this.xServerDatabaseTextBox.Text;
            
            Settings.Sigla = this.siglaTextBox.Text;
            Settings.Base = this.baseTextBox.Text;

            // Additional settings
            Settings.DisableClosingConfirmation = (bool)this.disableClosingConfirmationCheckBox.IsChecked;
            Settings.NeverDownloadUpdates = (bool)this.neverDownloadUpdatesCheckBox.IsChecked;
            Settings.AlwaysDownloadUpdates = (bool)this.alwaysDownloadUpdatesCheckBox.IsChecked;
            Settings.DisableMissingAuthorYearNotification = (bool)this.disableMissingAuthorYearNotificationCheckBox.IsChecked;
            Settings.DisableWithoutCoverNotification = (bool)this.disableWithoutCoverNotificationCheckBox.IsChecked;
            Settings.DisableWithoutTocNotification = (bool)this.disableWithoutTocNotificationCheckBox.IsChecked;
            Settings.DisableCoverDeletionNotification = (bool)this.disableCoverDeletionNotificationCheckBox.IsChecked;
            Settings.DisableTocDeletionNotification = (bool)this.disableTocDeletionNotificationCheckBox.IsChecked;
            Settings.DisableCustomIdentifierNotification = (bool)this.disableCustomIdentifierNotificationCheckBox.IsChecked;
            Settings.DisableResolveIdentifier = (bool)this.disableResolveIdentifierCheckBox.IsChecked;
            Settings.EnableLocalImageCopy = (bool)this.enableLocalImageCopy.IsChecked;
            Settings.EnableScanLowDataFlow = (bool)this.scanLowDataFlowCheckBox.IsChecked;
            Settings.EnableScanLowRes = (bool)this.scanLowResCheckBox.IsChecked;

            Settings.ScanOutputDir = this.scanOutputDir.Text;
            
            Settings.PersistSettings();

            //close window
            Window parentWindow = Window.GetWindow(this);
            if (parentWindow != null)
            {
                parentWindow.Close();
            }
        }

        // Validates input - format of sigla, Z39 port and Z39 barcode field
        private bool ValidateInput()
        {
            string errorMsg = "";
            bool isValid = true;

            //sigla
            char[] sigla = this.siglaTextBox.Text.ToCharArray();
            if (sigla.Length != 6)
            {
                errorMsg += "Sigla musí mít 6 znaků, 3 písmena a 3 čísla." + Environment.NewLine;
                isValid = false;
            }
            else
            {
                for (int i = 0; i < 2; i++)
                {
                    if (!char.IsUpper(sigla[i]))
                    {
                        errorMsg += "První 3 písmena sigly musí být velká písmena." + Environment.NewLine;
                        isValid = false;
                        break;
                    }
                }
                if (!('A'.Equals(sigla[2]) || 'B'.Equals(sigla[2]) || 'C'.Equals(sigla[2])
                    || 'D'.Equals(sigla[2]) || 'E'.Equals(sigla[2]) || 'F'.Equals(sigla[2]) || 'G'.Equals(sigla[2])))
                {
                    errorMsg += "Třetí písmeno sigly musí být z rozmezí A-G." + Environment.NewLine;
                    isValid = false;
                }

                for (int i = 3; i < 6; i++)
                {
                    if (!char.IsNumber(sigla[i]))
                    {
                        errorMsg += "Poslední 3 písmena sigly musí být čísla." + Environment.NewLine;
                        isValid = false;
                        break;
                    }
                }
            }

            int tmp;
            //z39 port
            if (!int.TryParse(this.z39PortTextBox.Text, out tmp))
            {
                errorMsg += "V poli Z39.50 Server Port musí být celé číslo, které reprezentuje port, na kterým je server pro z39.50 dostupný." + Environment.NewLine;
                isValid = false;
            }

            //z39 barcode field
            if (!int.TryParse(this.z39BarcodeField.Text, out tmp))
            {
                errorMsg += "V poli vyhledávací atribut musí být celé číslo, které reprezentuje kód, kterým se dotazuje přes čárový kód." + Environment.NewLine;
                isValid = false;
            }

            if (!isValid)
            {
                MessageBoxDialogWindow.Show("Nastavení obsahují chyby", errorMsg, "OK", MessageBoxDialogWindow.Icons.Error);
            }
            return isValid;
        }

        // Close on Esc
        private void CloseCanExecute(object sender, CanExecuteRoutedEventArgs e)
        {
            e.CanExecute = true;
            e.Handled = true;
        }

        // Close on Esc
        private void CloseExecuted(object sender, ExecutedRoutedEventArgs e)
        {
            this.Close();
        }

        // change other value of always/never
        private void AlwaysDownloadUpdatesCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            this.neverDownloadUpdatesCheckBox.IsChecked = false;
        }

        // change other value always/never
        private void NeverDownloadUpdatesCheckBox_Checked(object sender, RoutedEventArgs e)
        {
            this.alwaysDownloadUpdatesCheckBox.IsChecked = false;
        }

        private void chooseScanOutputDir_Click(object sender, RoutedEventArgs e)
        {
            FolderBrowserDialog fbd = new FolderBrowserDialog();
            DialogResult result = fbd.ShowDialog();
            string folderName = fbd.SelectedPath;
            if (!String.IsNullOrEmpty(folderName)) scanOutputDir.Text = folderName;
        }

    }
}