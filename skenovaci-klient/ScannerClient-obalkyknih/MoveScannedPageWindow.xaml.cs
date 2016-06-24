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
using ScannerClient_obalkyknih.Classes;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for MoveScannedPageWindow.xaml
    /// </summary>
    public partial class MoveScannedPageWindow : Window
    {

        public int maxItemCount;
        public int moveIntoValue;

        public MoveScannedPageWindow(int itemCount)
        {
            InitializeComponent();
            InputTextBox.Focus();
            maxItemCount = itemCount;
        }

        private void YesButton_Click(object sender, RoutedEventArgs e)
        {
            getInputBoxResult();
        }

        //allow to input only numbers
        private void NumericOnly(object sender, TextCompositionEventArgs e)
        {
            System.Text.RegularExpressions.Regex reg = new System.Text.RegularExpressions.Regex("^[0-9]");
            e.Handled = !reg.IsMatch(e.Text);
        }

        //disable certain commands
        private void textBox_PreviewExecuted(object sender, ExecutedRoutedEventArgs e)
        {
            if  (e.Command == ApplicationCommands.Copy ||
                e.Command == ApplicationCommands.Cut ||
                e.Command == ApplicationCommands.Paste)
            {
                e.Handled = true;
            }
        }

        private void textBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                getInputBoxResult();
            }
        }

        //validates the user input
        private void getInputBoxResult()
        {
            if (string.IsNullOrWhiteSpace(InputTextBox.Text))
            {
                MessageBoxDialogWindow.Show("Chyba!", "Nezadali jste žádné číslo!", "Ok", MessageBoxDialogWindow.Icons.Error);
                return;
            }

            try
            {
                 moveIntoValue = Convert.ToInt32(InputTextBox.Text);
                if (moveIntoValue > maxItemCount || moveIntoValue < 1)
                {
                    MessageBoxDialogWindow.Show("Chyba!", "Zadané číslo je mimo rozsahu!", "Ok", MessageBoxDialogWindow.Icons.Error);
                    return;
                }
            }
            catch (Exception)
            {
                MessageBoxDialogWindow.Show("Chyba!", "Nesprávný formát čísla!", "Ok", MessageBoxDialogWindow.Icons.Error);
                return;
            }
            DialogResult = true; 
        }
    }
}
