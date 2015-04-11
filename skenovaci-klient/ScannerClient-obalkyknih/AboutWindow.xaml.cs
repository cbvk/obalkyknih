using System;
using System.Windows;
using System.Windows.Controls;
using System.Reflection;
using System.IO;
using System.Windows.Input;
using SobekCM.Bib_Package.MARC;
using DAP.Adorners;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for AboutWindow.xaml
    /// </summary>
    public partial class AboutWindow : Window
    {
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();

        public AboutWindow()
        {
            InitializeComponent();
            this.applicationVersion.Content = Assembly.GetEntryAssembly().GetName().Version.Major
                 + "." + Assembly.GetEntryAssembly().GetName().Version.Minor;
            this.sobekVersion.Content = typeof(MARC_Field).Assembly.GetName().Version.Major
                 + "." + typeof(MARC_Field).Assembly.GetName().Version.Minor;
            this.croppingAdornerVersion.Content = typeof(CroppingAdorner).Assembly.GetName().Version.Major
                 + "." + typeof(CroppingAdorner).Assembly.GetName().Version.Minor;
            DateTime buildTime = new System.IO.FileInfo(Assembly.GetExecutingAssembly().Location).LastWriteTime;
            this.buildYear.Content = buildTime.Day.ToString() + ". "  + buildTime.Month + ". "
                + buildTime.Year.ToString();

            // close on Esc
            CommandBinding cb = new CommandBinding(closeCommand, CloseExecuted, CloseCanExecute);
            this.CommandBindings.Add(cb);
            KeyGesture kg = new KeyGesture(Key.Escape);
            InputBinding ib = new InputBinding(closeCommand, kg);
            this.InputBindings.Add(ib);
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
    }
}
