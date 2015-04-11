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
using System.Windows.Interop;
using System.Drawing;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Interaction logic for MessageBoxDialogWindow.xaml
    /// </summary>
    public partial class MessageBoxDialogWindow : Window
    {
        public MessageBoxDialogWindow(string title, string message, string checkBoxLabel,
            string buttonTrueLabel, string buttonFalseLabel, bool defaultChoice, Icons icon)
        {
            InitializeComponent();

            if (title != null)
            {
                this.Title = title;
            }

            if (message != null)
            {
                this.textBlock.Inlines.Add(message);
            }

            if (checkBoxLabel != null)
            {
                this.checkBox.Visibility = Visibility.Visible;
                this.checkBox.Content = checkBoxLabel;
            }

            if (buttonTrueLabel != null)
            {
                this.buttonTrue.Visibility = Visibility.Visible;
                this.buttonTrue.Content = buttonTrueLabel;
            }

            if (buttonFalseLabel != null)
            {
                this.buttonFalse.Visibility = Visibility.Visible;
                this.buttonFalse.Content = buttonFalseLabel;
            }

            if (defaultChoice == true)
            {
                this.buttonTrue.IsDefault = true;
            }
            else
            {
                this.buttonFalse.IsDefault = true;
            }

            switch (icon)
            {
                case Icons.Information:
                    image.Source = Imaging.CreateBitmapSourceFromHIcon(System.Drawing.SystemIcons.Information.Handle,
                        Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions());
                    System.Media.SystemSounds.Asterisk.Play();
                    break;
                case Icons.Question:
                    image.Source = Imaging.CreateBitmapSourceFromHIcon(System.Drawing.SystemIcons.Question.Handle,
                        Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions());
                    System.Media.SystemSounds.Question.Play();
                    break;
                case Icons.Warning:
                    image.Source = Imaging.CreateBitmapSourceFromHIcon(System.Drawing.SystemIcons.Warning.Handle,
                        Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions());
                    System.Media.SystemSounds.Exclamation.Play();
                    break;
                case Icons.Error:
                    image.Source = Imaging.CreateBitmapSourceFromHIcon(System.Drawing.SystemIcons.Error.Handle,
                        Int32Rect.Empty, BitmapSizeOptions.FromEmptyOptions());
                    System.Media.SystemSounds.Hand.Play();
                    break;
            }

            // if only 1 button, make it cancel button
            if (buttonFalse.Visibility != Visibility.Visible)
            {
                buttonTrue.IsCancel = true;
            }
        }

        public enum Icons
        {
            Information,
            Question,
            Warning,
            Error,
            None
        }

        // Set DialogResult property according to which button was clicked and close window
        private void button_Click(object sender, RoutedEventArgs e)
        {
            if (sender as Button == buttonTrue)
            {
                this.DialogResult = true;
            }
            else if (sender as Button == buttonFalse)
            {
                this.DialogResult = false;
            }
            else
            {
                this.DialogResult = null;
            }
        }

        // 1 button
        public static bool? Show(string title, string message, string buttonTrueLabel)
        {
            bool _;
            return Show(title, message, out _, null, buttonTrueLabel, null, true, Icons.None);
        }

        //1 button with icon
        public static bool? Show(string title, string message, string buttonTrueLabel, Icons icon)
        {
            bool _;
            return Show(title, message, out _, null, buttonTrueLabel, null, true, icon);
        }

        // 1 button with checkBox
        public static bool? Show(string title, string message, out bool isCheckBoxChecked, string checkBoxLabel, string buttonTrueLabel)
        {
            return Show(title, message, out isCheckBoxChecked, checkBoxLabel, buttonTrueLabel, null, true, Icons.None);
        }

        // 1 button with icon and checkBox
        public static bool? Show(string title, string message, out bool isCheckBoxChecked, string checkBoxLabel, string buttonTrueLabel, Icons icon)
        {
            return Show(title, message, out isCheckBoxChecked, checkBoxLabel, buttonTrueLabel, null, true, icon);
        }

        // 2 buttons
        public static bool? Show(string title, string message, string buttonTrueLabel, string buttonFalseLabel, bool defaultButton)
        {
            bool _;
            return Show(title, message, out _, null, buttonTrueLabel, buttonFalseLabel, defaultButton, Icons.None);
        }

        // 2 buttons with icon
        public static bool? Show(string title, string message, string buttonTrueLabel, string buttonFalseLabel, bool defaultButton, Icons icon)
        {
            bool _;
            return Show(title, message, out _, null, buttonTrueLabel, buttonFalseLabel, defaultButton, icon);
        }

        // 2 buttons with checkbox
        public static bool? Show(string title, string message, out bool isCheckBoxChecked, string checkBoxLabel, string buttonTrueLabel,
            string buttonFalseLabel, bool defaultButton)
        {
            return Show(title, message, out isCheckBoxChecked, checkBoxLabel, buttonTrueLabel, buttonFalseLabel, defaultButton, Icons.None);
        }

        // 2 buttons with checkbox and icon
        public static bool? Show(string title, string message, out bool isCheckBoxChecked, string checkBoxLabel,
            string buttonTrueLabel, string buttonFalseLabel, bool defaultChoice, Icons icon)
        {
            MessageBoxDialogWindow msgBox = new MessageBoxDialogWindow(title, message, checkBoxLabel,
                buttonTrueLabel, buttonFalseLabel, defaultChoice, icon);

            bool? returnValue = msgBox.ShowDialog();
            isCheckBoxChecked = (bool)msgBox.checkBox.IsChecked;
            return returnValue;
        }
    }
}
