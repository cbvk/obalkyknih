using System;
using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Controls.Primitives;
using ScannerClient_obalkyknih.Classes;
using System.Windows.Threading;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for CreateNewUnitWindow.xaml
    /// </summary>
    public partial class CreateNewUnionWindow : Window
    {
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();

        /// <summary>GeneralRecord with identifier gained from identifierTextbox</summary>
        public GeneralRecord GeneralRecord { get; private set; }

        /// <summary>
        /// Constructor, creates new popup window for inserting of identifier, that stores in property
        /// </summary>
        public CreateNewUnionWindow(GeneralRecord generalRecord)
        {
            this.GeneralRecord = generalRecord;
            InitializeComponent();
            this.identifierTextBox.Focus();

            // close on Esc
            CommandBinding cb = new CommandBinding(closeCommand, CloseExecuted, CloseCanExecute);
            this.CommandBindings.Add(cb);
            KeyGesture kg = new KeyGesture(Key.Escape);
            InputBinding ib = new InputBinding(closeCommand, kg);
            this.InputBindings.Add(ib);
        }

        // Handles clicking on button, executes ShowUnitTabsControl
        private void NewUnionButton_Click(object sender, RoutedEventArgs e)
        {
            ShowNewUnionControl();
        }

        // Handles KeyDown event, so it can execute ShowUnitTabsControl by pressing Enter key in textbox
        private void IdentifierTextBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                ShowNewUnionControl();
            }
        }

        // shows tabsControl for the unit with entered identifier
        private void ShowNewUnionControl()
        {
            if (string.IsNullOrWhiteSpace(this.identifierTextBox.Text))
            {
                //show error message, if identifier was not entered
                MessageBoxDialogWindow.Show("Chyba!", "Prázdný identifikátor", "OK", MessageBoxDialogWindow.Icons.Error);
                return;
            }

            switch (this.identifierComboBox.Text)
            {
                case "Čárový kód":
                    this.GeneralRecord.IdentifierType = IdentifierType.BARCODE;
                    this.GeneralRecord.Barcode = this.identifierTextBox.Text;
                    break;
                case "ISBN":
                    this.GeneralRecord.IdentifierType = IdentifierType.ISBN;
                    ((Monograph)this.GeneralRecord).Isbn = this.identifierTextBox.Text;
                    break;
                case "ČNB":
                    this.GeneralRecord.IdentifierType = IdentifierType.CNB;
                    this.GeneralRecord.Cnb = this.identifierTextBox.Text;
                    break;
                case "OCLC":
                    this.GeneralRecord.IdentifierType = IdentifierType.OCLC;
                    this.GeneralRecord.Oclc = this.identifierTextBox.Text;
                    break;
                case "URN":
                    this.GeneralRecord.IdentifierType = IdentifierType.URN;
                    this.GeneralRecord.Urn = this.identifierTextBox.Text;
                    break;
                default:
                    throw new ArgumentException("Unsupported identifier type: " + identifierComboBox.Text);
            }

            this.DialogResult = true;
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
            this.DialogResult = false;
        }

        private void identifierComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // periodical should never come here
            if(this.GeneralRecord is Periodical)
            {
                throw new ArgumentException("CreateNewUnion called with Periodical GeneralRecord");
            }


            var tmp = this.identifierComboBox.Items[this.identifierComboBox.SelectedIndex].ToString();
            tmp = tmp.Substring("System.Windows.Controls.ComboBoxItem: ".Length);
            if (this.identifierTextBox != null)
            {
                this.identifierTextBox.Text = null;
                switch (tmp)
                {
                    case "Čárový kód":
                        if ((this.GeneralRecord as Monograph).DuplicateIdentifiers.ContainsKey(IdentifierType.BARCODE))
                        {
                            this.identifierTextBox.Text = (this.GeneralRecord as Monograph).DuplicateIdentifiers[IdentifierType.BARCODE];
                        }
                        break;
                    case "ISBN":
                        this.identifierTextBox.Text = (this.GeneralRecord as Monograph).PartIsbn;
                        break;
                    case "ČNB":
                        this.identifierTextBox.Text = (this.GeneralRecord as Monograph).PartCnb;
                        break;
                    case "OCLC":
                        this.identifierTextBox.Text = (this.GeneralRecord as Monograph).PartOclc;
                        break;
                }
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            this.identifierComboBox.SelectedIndex = 0;
            this.identifierTextBox.Text = (this.GeneralRecord as Monograph).PartIsbn;
        }

        private void identifierTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (Settings.DisableResolveIdentifier || this.identifierTextBox.Text.Length < 3)
            {
                return;
            }
            if (this.identifierTextBox.Text.Substring(0, 3) == "80-" || this.identifierTextBox.Text.Substring(0, 3) == "978")
            {
                this.identifierComboBox.SelectedIndex = 0;
            }
            else if (this.identifierTextBox.Text.Substring(0, 3) == "cnb")
            {
                this.identifierComboBox.SelectedIndex = 1;
            }
        }
    }
}
