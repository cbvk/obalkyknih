using System;
using System.Windows;
using System.Windows.Input;
using System.Diagnostics;
using System.Windows.Navigation;


namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for CredentialsWindow.xaml
    /// </summary>
    public partial class CredentialsWindow : Window
    {
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();

        public CredentialsWindow()
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

        // Loads credentials from settings file to window components
        private void LoadSettings()
        {
            this.userNameTextBox.Text = Settings.UserName;
            this.passwordBox.Password = Settings.Password;
        }

        // Saves credentials and if checkbox is checked, persists them to file
        private void SaveButton_Click(object sender, RoutedEventArgs e)
        {
            Settings.UserName = this.userNameTextBox.Text;
            Settings.Password = this.passwordBox.Password;
            Settings.PersistSettings();

            //close settings window
            Window parentWindow = Window.GetWindow(this);
            if (parentWindow != null)
            {
                parentWindow.Close();
            }
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

        // Open link in browser
        private void Hyperlink_RequestNavigate(object sender, RequestNavigateEventArgs e)
        {
            Process.Start(new ProcessStartInfo(e.Uri.AbsoluteUri));
            e.Handled = true;
        }

        // Save on Enter key in password textbox
        private void passwordBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                SaveButton_Click(null, null);
            }
        }

        // Focus to passwordBox on Enter key in userNameTextBox
        private void userNameTextBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                this.passwordBox.Focus();
            }
        }
    }
}
