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
using PdfToImage;
using Microsoft.Win32;
using System.IO;
using System.Text.RegularExpressions;
using System.Collections;
using System.ComponentModel;
using System.Windows.Threading;
using System.Diagnostics;

namespace ScannerClient_obalkyknih
{
    enum ImageQuality { LOW, HIGH }

    /// <summary>
    /// Interaction logic for LoadFromPDF.xaml
    /// </summary>
    public partial class LoadFromPDF : Window
    {

        private PDFConvert converter = new PDFConvert();
        private string pdfFile = "";
        private string outputDirLow = "";
        private string outputDirHigh = "";
        private string name = "";
        private List<ImageSource> imagesList = new List<ImageSource>();

        private BackgroundWorker workerHighRes;
        private BackgroundWorker workerLowRes;

        private TabsControl parentObj;

        public string[] ConvertedFiles {
            get 
            {
                return Directory.GetFiles(outputDirHigh, "*.png"); 
            }
        }

        public LoadFromPDF(object obj)
        {
            parentObj = ((TabsControl)obj);
            pdfFile = parentObj.pdfFile;

            InitializeComponent();
            ComboBoxPagesSelection.SelectedIndex = 0;
            UpdateFromToComponents();

            textBoxFrom.TextChanged += textBoxFrom_TextChanged;
            textBoxTo.TextChanged += textBoxTo_TextChanged;

            if (pdfFile != "")
            {
                reloadPdf();
            }
        }

        #region PagesSelection
        private void UpdateFromToComponents()
        {
            int selectedIndex = ComboBoxPagesSelection.SelectedIndex;
            int from;
            int to;

            switch (selectedIndex)
            {
                case 0:
                    from = 1;
                    to = 5;
                    break;
                case 1:
                    from = 1;
                    to = 10;
                    break;
                case 2:
                    from = 1;
                    to = 15;
                    break;
                case 3:
                    from = 1;
                    to = 20;
                    break;
                case 4:
                    from = 1;
                    to = -1;
                    break;
                default:
                    return;
            }

            textBoxFrom.Text = from.ToString();
            textBoxTo.Text = to.ToString();
        }

        private void ComboBoxPagesSelection_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            UpdateFromToComponents();
        }

        private void updatePagesComboBox()
        {
            int first = GetFirstPage();
            int last = GetLastPage();

            if (first == 1 || first == -1)
            {
                switch (last)
                {
                    case 5:
                        ComboBoxPagesSelection.SelectedIndex = 0;
                        break;
                    case 10:
                        ComboBoxPagesSelection.SelectedIndex = 1;
                        break;
                    case 15:
                        ComboBoxPagesSelection.SelectedIndex = 2;
                        break;
                    case 20:
                        ComboBoxPagesSelection.SelectedIndex = 3;
                        break;
                    case -1:
                        ComboBoxPagesSelection.SelectedIndex = 4;
                        break;
                    default:
                        ComboBoxPagesSelection.SelectedIndex = 5;
                        break;
                }
            }
            else
            {
                ComboBoxPagesSelection.SelectedIndex = 5;
            }
        }

        private void textBoxFrom_TextChanged(object sender, TextChangedEventArgs e)
        {
            Regex regex = new Regex("^-1$|^[1-9][0-9]*$");

            if (!regex.IsMatch(textBoxFrom.Text))
            {
                textBoxFrom.Text = "-1";
            }

            updatePagesComboBox();
            reloadPdf();
        }

        private void textBoxTo_TextChanged(object sender, TextChangedEventArgs e)
        {
            Regex regex = new Regex("^-1$|^[1-9][0-9]*$");

            if (!regex.IsMatch(textBoxTo.Text))
            {
                textBoxTo.Text = "-1";
            }

            updatePagesComboBox();
            reloadPdf();
        }

        private int GetFirstPage()
        {
            return Int32.Parse(textBoxFrom.Text);
        }

        private int GetLastPage()
        {
            return Int32.Parse(textBoxTo.Text);
        }

        private void reloadPdf()
        {
            if (pdfFile == "") return;

            ClearImageList();
            DeleteTempFiles();

            int last = GetLastPage();
            int first = GetFirstPage();

            if (last != -1 && first > last)
            {
                textBoxTo.Text = first.ToString();
                return;
            }

            workerLowRes = new BackgroundWorker();
            workerLowRes.WorkerReportsProgress = true;
            workerLowRes.DoWork += workerLowRes_DoWork;
            workerLowRes.RunWorkerCompleted += workerLowRes_RunWorkerCompleted;
            workerLowRes.ProgressChanged += workerHighRes_ProgressChanged;

            int lastPage = GetLastPage();
            workerLowRes.RunWorkerAsync(new int[] { GetFirstPage(), lastPage==-1?1000:lastPage });
            MainGrid.IsEnabled = false;
            LabelConvertingInfo.Content = "Probíhá načítaní stránek z PDF souboru";
        }

        #endregion
        #region ConvertFile
        private bool ConvertPDFFile(string filename, ImageQuality imgQuality, int firstPage, int lastPage, long ticks = 0)
        {
            bool converted = false;
            converter.OutputToMultipleFile = true;
            converter.FirstPageToConvert = firstPage;
            converter.LastPageToConvert = lastPage;
            converter.FitPage = true;
            //converter.ResolutionX = 150;
            //converter.ResolutionY = 150;
            converter.RenderingThreads = 0;

            System.IO.FileInfo input = new FileInfo(filename);

            string output;
            string outputDir;
            name = input.Name;

            if (imgQuality == ImageQuality.LOW)
            {
                converter.Width = 400;
                converter.Height = 565;
                //converter.JPEGQuality = 9;
                //converter.OutputFormat = "jpeg";
                converter.OutputFormat = "png16m";
                outputDirLow = System.IO.Path.Combine(System.IO.Path.GetTempPath(), "ObalkyKnih-scanner", "PDFScanLow", DateTime.Now.Ticks.ToString());
                outputDir = outputDirLow;
                output = String.Format("{0}\\{1}{2}", outputDir, name, ".png");
            }
            else
            {
                converter.Width = 3500;
                converter.Height = 5000;
                converter.OutputFormat = "png16m";
                outputDirHigh = System.IO.Path.Combine(System.IO.Path.GetTempPath(), "ObalkyKnih-scanner", "PDFScanHigh", ticks.ToString());
                outputDir = outputDirHigh;
                output = String.Format("{0}\\{1}{2}", outputDir, DateTime.Now.Ticks + "_" + name, ".png");
            }

            //Creates temp directory if not exists
            if (!Directory.Exists(outputDir))
            {
                Directory.CreateDirectory(outputDir);
            }

            converted = converter.Convert(input.FullName, output);
            return converted;
        }
        #endregion
        #region ConvertToView
        private void ButtonLoadPDFPages_Click(object sender, RoutedEventArgs e)
        {
            OpenFileDialog ofd = new OpenFileDialog();
            ofd.Multiselect = false;
            ofd.Filter = "PDF Files | *.pdf";

            if (ofd.ShowDialog() == true)
            {
                pdfFile = ofd.FileName;
                parentObj.pdfFile = pdfFile;

                reloadPdf();
            }
        }

        private void workerLowRes_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            bool converted = false;
            try
            {
                if (e.Result != null)
                {
                    converted = (bool)e.Result;
                }
            }
            catch { }

            if (converted)
            {
                LabelConvertingInfo.Content = "Načítaní bylo dokončeno. Zvolte stránky, které se vloží";

                foreach (string image in Directory.GetFiles(outputDirLow, name + "*.png"))
                {
                    BitmapImage newImage = new BitmapImage();
                    newImage.BeginInit();
                    newImage.UriSource = new Uri(image);
                    newImage.CacheOption = BitmapCacheOption.OnLoad;
                    newImage.EndInit();
                    imagesList.Add(newImage);
                }

                //zoradeny podla cisel stranok
                ImageListView.ItemsSource = imagesList.OrderBy(i => Int32.Parse(Regex.Match((i as BitmapImage).UriSource.AbsolutePath, "(\\d+)\\.[^\\.]*$").Groups[1].Value) + GetFirstPage() - 1);
                ButtonLoadPDFPages.Content = "Načíst jiný soubor";
            }
            else
            {
                //@TODO: co robit ked sa nejaka konverzia nepodarila
                LabelConvertingInfo.Content = "Načítaní selhalo. Prosím zkontrolujte výsledek.";
                //MessageBox.Show(String.Format("{0}:Conversion failed!", DateTime.Now.ToShortTimeString()));
            }

            MainGrid.IsEnabled = true;
        }

        private void workerLowRes_DoWork(object sender, DoWorkEventArgs e)
        {
            int[] pageRange = (int[])e.Argument;
            if (pageRange[1] < pageRange[0])
            {
                return;
            }
            bool converted = false;
            try
            {
                converted = ConvertPDFFile(pdfFile, ImageQuality.LOW, pageRange[0], pageRange[1]);
                workerLowRes.ReportProgress(100);
            }
            catch { }
            e.Result = converted;
        }

        #endregion
        #region ConvertAndImport
        private void Button_Click(object sender, RoutedEventArgs e)
        {
            if (ImageListView.SelectedItems.Count == 0)
            {
                this.DialogResult = false;
                return;
            }

            int firstPage = GetFirstPage();

            List<int> pages = ImageListView.SelectedItems
                .Cast<ImageSource>()
                .Select(source =>
                {
                    return Int32.Parse(Regex.Match((source as BitmapImage).UriSource.AbsolutePath, "(\\d+)\\.[^\\.]*$").Groups[1].Value) + firstPage - 1;
                })
                .ToList();

            workerHighRes = new BackgroundWorker();
            workerHighRes.WorkerReportsProgress = true;
            workerHighRes.DoWork += workerHighRes_DoWork;
            workerHighRes.RunWorkerCompleted += workerHighRes_RunWorkerCompleted;
            workerHighRes.ProgressChanged += workerHighRes_ProgressChanged;

            workerHighRes.RunWorkerAsync(pages);
            LabelConvertingInfo.Content = "Probíhá ukládaní stránek z PDF souboru v původní kvalite";
        }
        #endregion

        private void ClearImageList()
        {
            for (int i = 0; i < imagesList.Count; i++)
            {
                imagesList[i] = null;
            }

            imagesList.Clear();
            ImageListView.ItemsSource = null;
        }

        public void DeleteTempFiles()
        {
            if (Directory.Exists(outputDirLow))
            {
                Directory.Delete(outputDirLow, true);
            }
            if (Directory.Exists(outputDirHigh))
            {
                Directory.Delete(outputDirHigh, true);
            }
        }

        #region worker
        private void workerHighRes_ProgressChanged(object sender, ProgressChangedEventArgs e)
        {
            progressBar.Value = e.ProgressPercentage;
        }

        private void workerHighRes_RunWorkerCompleted(object sender, RunWorkerCompletedEventArgs e)
        {
            bool converted = false;
            try
            {
                if (e.Result != null)
                {
                    converted = (bool)e.Result;
                }
            }
            catch { }
            if (converted)
            {
                ClearImageList();
                this.DialogResult = true;
            }
            else
            {
                //@TODO: co robit ked sa nejaka konverzia nepodarila
                LabelConvertingInfo.Content = "Ukládaní selhalo";
                MessageBox.Show(String.Format("{0}:Conversion failed!", DateTime.Now.ToShortTimeString()));
            }
        }

        private void workerHighRes_DoWork(object sender, DoWorkEventArgs e)
        {
            List<int> pages = (List<int>)e.Argument;
            long ticks = DateTime.Now.Ticks;

            bool converted = true;
            if (pages.Count == 1)
            {
                int page = pages[0];
                converted = ConvertPDFFile(pdfFile, ImageQuality.HIGH, page, page, ticks);
                workerHighRes.ReportProgress(100);
            }
            else
            {
                int firstPage = pages[0];
                int lastPage = firstPage;

                for (int i = 1; i < pages.Count; i++)
                {
                    int page = pages[i];

                    if (page > lastPage + 1)
                    {
                        converted &= ConvertPDFFile(pdfFile, ImageQuality.HIGH, firstPage, lastPage, ticks);
                        firstPage = page;
                        workerHighRes.ReportProgress((int)Math.Round((double)i / pages.Count * 100));
                    }
                    if (i == pages.Count - 1)
                    {
                        converted &= ConvertPDFFile(pdfFile, ImageQuality.HIGH, firstPage, page, ticks);
                        workerHighRes.ReportProgress(100);
                    }

                    lastPage = page;
                }
            }

            e.Result = converted;
        }
        #endregion
    }
}
