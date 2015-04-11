using System;
using System.Windows;
using System.Windows.Input;
using System.Collections.Generic;
using System.Linq;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for MetadataWindow.xaml
    /// </summary>
    public partial class MetadataWindow : Window
    {
        public int MetadataIndex { get; private set; }
        IList<Metadata> metadataList;

        // reordered indexes of metadataList (int=position, int=index from MetadataIndex)
        public List<int> reorder = new List<int>();
        
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();


        /// <summary>
        /// Initializes MetadataWindow with given data
        /// </summary>
        /// <param name="metadataList">List of Metadata to show in window</param>
        public MetadataWindow(IList<Metadata> metadataList, int metadataIndex)
        {
            this.MetadataIndex = metadataIndex;
            InitializeComponent();

            // close on Esc
            CommandBinding cb = new CommandBinding(closeCommand, CloseExecuted, CloseCanExecute);
            this.CommandBindings.Add(cb);
            KeyGesture kg = new KeyGesture(Key.Escape);
            InputBinding ib = new InputBinding(closeCommand, kg);
            this.InputBindings.Add(ib);

            if (metadataList == null || metadataList.Count <= 0)
            {
                return;
            }
            this.metadataList = metadataList;

            // Re-sort (union possible records first)
            int i = 0;
            // each metadata list item
            foreach (var meta in metadataList)
            {
                // each ISBN tag in metadata
                bool doUnshift = false;
                foreach (var isbn in meta.VariableFields.Where(vf => Settings.MetadataIsbnField.Item1.ToString("D3").Equals(vf.TagName)))
                {
                    List<string> subfDescription = new List<string>();
                    // each q subtag
                    foreach (var subf in isbn.Subfields)
                    {
                        if (subf.Key == "q") subfDescription.Add(subf.Value);
                    }
                    doUnshift = (string.Join("", subfDescription).ToLower().IndexOf("soubor") != -1 && !doUnshift) ? true : doUnshift;
                }
                if (doUnshift)
                    reorder.Insert(0, i); // unshift
                else
                    reorder.Add(i); // push
                i++;
            }



            // Activate previous or next metadata arrows
            if (this.metadataList.Count > 0)
            {
                if (this.MetadataIndex < this.metadataList.Count - 1)
                {
                    this.nextMetadataLabel.IsEnabled = true;
                    this.nextMetadataLabel.Cursor = Cursors.Hand;
                }
                if (this.MetadataIndex > 0)
                {
                    this.previousMetadataLabel.IsEnabled = true;
                    this.previousMetadataLabel.Cursor = Cursors.Hand;
                }
            }
            ShowMetadata();
        }

        // Display Metadata from metadataList pointed by current metadataIndex
        private void ShowMetadata()
        {
            int pos = this.MetadataIndex;
            int idx = this.reorder[(this.reorder.Count>pos)?pos:0];
            this.indexLabel.Content = (pos + 1) + "/" + this.metadataList.Count;

            Metadata metadata = this.metadataList[idx];
            string textContent = "";

            if (metadata.Sysno != null)
            {
                textContent += "SYSNO\t" + metadata.Sysno + "\n";
            }

            foreach (var fixfield in metadata.FixedFields)
            {
                textContent += fixfield.Key + "\t" + fixfield.Value + "\n";
            }
            foreach (var varfield in metadata.VariableFields)
            {
                textContent += varfield.TagName + varfield.Indicator1 + varfield.Indicator2 + "\t";
                foreach (var sf in varfield.Subfields)
                {
                    textContent += " |" + sf.Key + " " + sf.Value;
                }
                textContent += "\n";
            }
            this.metadataLabel.Text = textContent;
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

        // Displays previous Metadata from metadataList and decreases metadataIndex
        private void PreviousMetadataLabel_Clicked(object sender, MouseButtonEventArgs e)
        {
            if (this.MetadataIndex > 0)
            {
                this.MetadataIndex--;
                this.nextMetadataLabel.IsEnabled = true;
                this.nextMetadataLabel.Cursor = Cursors.Hand;
            }
            if (this.MetadataIndex == 0)
            {
                this.previousMetadataLabel.IsEnabled = false;
                this.previousMetadataLabel.Cursor = Cursors.Arrow;
            }
            ShowMetadata();
        }

        // Displays next Metadata from metadataList and increases metadataIndex
        private void NextMetadataLabel_Clicked(object sender, MouseButtonEventArgs e)
        {
            if (this.MetadataIndex < this.metadataList.Count - 1)
            {
                this.MetadataIndex++;
                this.previousMetadataLabel.IsEnabled = true;
                this.previousMetadataLabel.Cursor = Cursors.Hand;
            }
            if (this.MetadataIndex == this.metadataList.Count - 1)
            {
                this.nextMetadataLabel.IsEnabled = false;
                this.nextMetadataLabel.Cursor = Cursors.Arrow;
            }
            ShowMetadata();
        }


        // Creates hover effect for transormation controllers
        private void Icon_MouseEnter(object sender, EventArgs e)
        {
            (sender as UIElement).Opacity = 0.7;
        }

        // Creates hover effect for transormation controllers
        private void Icon_MouseLeave(object sender, EventArgs e)
        {
            (sender as UIElement).Opacity = 1;
        }

        private void confirmMetadataButton_Click(object sender, RoutedEventArgs e)
        {
            this.DialogResult = true;
        }
    }
}
