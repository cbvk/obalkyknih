using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for UploadWindow.xaml
    /// </summary>
    public partial class UploadWindow : Window
    {
        // Indicates if this window can be closed or not
        public bool isClosable = false;

        public UploadWindow()
        {
            InitializeComponent();
        }

        // Disables closing of this windows until isClosable flag isn't set to true
        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            if (!isClosable)
            {
                MessageBoxDialogWindow.Show("Vydržte prosím",
                    "Prosím počkejte než se odešlou všechny soubory.",
                    "OK", MessageBoxDialogWindow.Icons.Information);
                e.Cancel = true;
            }
        }
    }


}
