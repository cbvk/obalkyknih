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
    /// Interaction logic for ExternalImageLoadWindow.xaml
    /// </summary>
    public partial class ExternalImageLoadWindow : Window
    {
        // close on escape
        public static RoutedCommand closeCommand = new RoutedCommand();

        // define event
        public event MouseButtonEventHandler Image_Clicked;

        public ExternalImageLoadWindow()
        {
            InitializeComponent();

            // close on Esc
            CommandBinding cb = new CommandBinding(closeCommand, CloseExecuted, CloseCanExecute);
            this.CommandBindings.Add(cb);
            KeyGesture kg = new KeyGesture(Key.Escape);
            InputBinding ib = new InputBinding(closeCommand, kg);
            this.InputBindings.Add(ib);
        }

        // throw event on Image Clicked
        protected void OnImage_Clicked(object sender, MouseButtonEventArgs e)
        {
            this.Close();
            if (this.Image_Clicked != null)
                this.Image_Clicked(sender, e);
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
