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
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace ScannerClient_obalkyknih
{

    public partial class SetMultipleISBNs : Window
    {
        public HashSet<string> Identifiers;
        private List<TextBox> TextBoxList;
        public SetMultipleISBNs(string MainIdentifier, HashSet<string> SavedIdentifiers)
        {
            InitializeComponent();
            LoadIdentifiers(MainIdentifier, SavedIdentifiers);
        }
        public void AddMoreTextBoxes(object sender, RoutedEventArgs e)
        {
            AddTextBox(null);
        }

        private void AddTextBox(string identifier)
        {
            string TextBoxCaption = (identifier == null) ? "" : identifier;
            int TextBoxInsertIndex;
            TextBox NewTextBox = new TextBox
            {
                Height = 32,
                HorizontalAlignment = HorizontalAlignment.Center,
                Margin = new Thickness(24, 10, 0, 0),
                VerticalAlignment = VerticalAlignment.Top,
                Text = TextBoxCaption,
                Width = 197,
                VerticalContentAlignment = VerticalAlignment.Center,
                Background = new SolidColorBrush(Color.FromRgb(54, 54, 54)),
                Foreground = new SolidColorBrush(Color.FromRgb(192, 192, 192)),
                BorderBrush = new SolidColorBrush(Color.FromRgb(17, 17, 17))
            };

            TextBoxList.Add(NewTextBox);
            TextBoxInsertIndex = TextBoxList.Count();

            if (TextBoxList.Count() == 1)
            {
                NewTextBox.IsEnabled = false;
                NewTextBox.Foreground = new SolidColorBrush(Color.FromRgb(90, 90, 90));
            }
            panel.Children.Insert(TextBoxInsertIndex, NewTextBox);
        }

        private void SaveISBNs(object sender, RoutedEventArgs e)
        {
            Identifiers = new HashSet<string>();
            foreach (TextBox identifier in TextBoxList)
            {
                if (!string.IsNullOrWhiteSpace(identifier.Text) && (identifier.Text != TextBoxList.First().Text))
                {
                    Identifiers.Add(identifier.Text);
                }
            }
            this.DialogResult = true;
            this.Close();

        }

        private void LoadIdentifiers(string MainIdentifier, HashSet<string> SavedIdentifiers)
        {
            TextBoxList = new List<TextBox>();
            int EmptyTextBoxesCount = 1 - SavedIdentifiers.Count;
            AddTextBox(MainIdentifier);
            foreach (string Identifier in SavedIdentifiers)
            {
                AddTextBox(Identifier);
            }
            for (int i = 1; i <= EmptyTextBoxesCount; i++)
            {
                AddTextBox(null);
            }
        }
    }
}
