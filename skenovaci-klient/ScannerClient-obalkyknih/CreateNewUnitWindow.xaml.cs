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
    public partial class CreateNewUnitWindow : Window
    {
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();

        /// <summary>GeneralRecord with identifier gained from identifierTextbox</summary>
        public GeneralRecord GeneralRecord { get; private set; }
        
        /// <summary>
        /// Constructor, creates new popup window for inserting of identifier, that stores in property
        /// </summary>
        public CreateNewUnitWindow()
        {
            InitializeComponent();
            this.monographIdentifierTextBox.Focus();

            // close on Esc
            CommandBinding cb = new CommandBinding(closeCommand, CloseExecuted, CloseCanExecute);
            this.CommandBindings.Add(cb);
            KeyGesture kg = new KeyGesture(Key.Escape);
            InputBinding ib = new InputBinding(closeCommand, kg);
            this.InputBindings.Add(ib);
        }

        // Handles clicking on button, executes ShowUnitTabsControl
        private void NewUnitButton_Click(object sender, RoutedEventArgs e)
        {
            ShowNewUnitTabsControl();
        }

        // Handles KeyDown event, so it can execute ShowUnitTabsControl by pressing Enter key in textbox
        private void IdentifierTextBox_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.Key == Key.Enter)
            {
                ShowNewUnitTabsControl();
            }
        }

        // shows tabsControl for the unit with entered identifier
        private void ShowNewUnitTabsControl()
        {
            ComboBox identifierComboBox;
            string identifierValue = null;
            if (this.monographTabItem.IsSelected)
            {
                identifierComboBox = this.monographIdentifierComboBox;
                this.GeneralRecord = new Monograph();
                identifierValue = this.monographIdentifierTextBox.Text.Trim();
            }
            else
            {
                identifierComboBox = this.periodicalIdentifierComboBox;
                this.GeneralRecord = new Periodical();
                identifierValue = this.periodicalIdentifierTextBox.Text.Trim();
            }

            if (string.IsNullOrWhiteSpace(identifierValue))
            {
                //show error message, if identifier was not entered
                MessageBoxDialogWindow.Show("Chyba!", "Prázdný identifikátor", "OK", MessageBoxDialogWindow.Icons.Error);
                return;
            }

            switch (identifierComboBox.Text)
            {
                case "Čárový kód":
                    this.GeneralRecord.IdentifierType = IdentifierType.BARCODE;
                    this.GeneralRecord.Barcode = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
                case "ISBN":
                    this.GeneralRecord.IdentifierType = IdentifierType.ISBN;
                    ((Monograph)this.GeneralRecord).Isbn = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
                case "ISSN":
                    this.GeneralRecord.IdentifierType = IdentifierType.ISSN;
                    ((Periodical)this.GeneralRecord).Issn = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
                case "ČNB":
                    this.GeneralRecord.IdentifierType = IdentifierType.CNB;
                    this.GeneralRecord.Cnb = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
                case "OCLC":
                    this.GeneralRecord.IdentifierType = IdentifierType.OCLC;
                    this.GeneralRecord.Oclc = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
                case "URN":
                    this.GeneralRecord.IdentifierType = IdentifierType.URN;
                    this.GeneralRecord.Urn = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
                default:
                    this.GeneralRecord.IdentifierType = IdentifierType.BARCODE;
                    this.GeneralRecord.Barcode = this.GeneralRecord.IdentifierValue = identifierValue;
                    break;
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

        // Set focus according to selected tab
        private void TabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            e.Handled = true;
            if (this.monographTabItem != null &&  this.monographTabItem.IsSelected)
            {
                // set focus to textbox
                periodicalIdentifierTextBox.Dispatcher.BeginInvoke(DispatcherPriority.Background,
                    new Action(() => { periodicalIdentifierTextBox.Focus(); }));
            }
            else if(this.periodicalTabItem != null && this.periodicalTabItem.IsSelected)
            {
                periodicalIdentifierTextBox.Dispatcher.BeginInvoke(DispatcherPriority.Background,
                    new Action(() => { periodicalIdentifierTextBox.Focus(); }));
            }
        }

        private void monographIdentifierTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (Settings.DisableResolveIdentifier || this.monographIdentifierTextBox.Text.Length < 3)
            {
                return;
            }
            if (this.monographIdentifierTextBox.Text.Substring(0, 3) == "80-" || this.monographIdentifierTextBox.Text.Substring(0, 3) == "978")
            {
                this.monographIdentifierComboBox.SelectedIndex = 1;
            }
            else if (this.monographIdentifierTextBox.Text.Substring(0, 3) == "cnb")
            {
                this.monographIdentifierComboBox.SelectedIndex = 2;
            }
        }

        private void periodicalIdentifierTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            if (Settings.DisableResolveIdentifier || this.periodicalIdentifierTextBox.Text.Length < 3)
            {
                return;
            }
            if (this.periodicalIdentifierTextBox.Text.Length == 8)
            {
                this.periodicalIdentifierComboBox.SelectedIndex = 1;
            }
            else if (this.periodicalIdentifierTextBox.Text.Length > 5 && this.periodicalIdentifierTextBox.Text.Substring(4, 1) == "-")
            {
                this.periodicalIdentifierComboBox.SelectedIndex = 1;
            }
            else if (this.periodicalIdentifierTextBox.Text.Substring(0, 3) == "cnb")
            {
                this.periodicalIdentifierComboBox.SelectedIndex = 2;
            }
        }
    }
}
