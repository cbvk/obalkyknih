using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using DAP.Adorners;


namespace CroppingTest
{
	/// <summary>
	/// Interaction logic for Window1.xaml
	/// </summary>

	public partial class wndCroppingTest : System.Windows.Window
	{
		CroppingAdorner _clp;
		FrameworkElement _felCur = null;
		Brush _brOriginal;

		public wndCroppingTest()
		{
			InitializeComponent();
		}
		
		private void RemoveCropFromCur()
		{
			AdornerLayer aly = AdornerLayer.GetAdornerLayer(_felCur);
			aly.Remove(_clp);
		}

		private void AddCropToElement(FrameworkElement fel)
		{
			if (_felCur != null)
			{
				RemoveCropFromCur();
			}
			Rect rcInterior = new Rect(
				fel.ActualWidth * 0.2,
				fel.ActualHeight * 0.2,
				fel.ActualWidth * 0.6,
				fel.ActualHeight * 0.6);
			AdornerLayer aly = AdornerLayer.GetAdornerLayer(fel);
			_clp = new CroppingAdorner(fel, rcInterior);
			aly.Add(_clp);
			imgCrop.Source = _clp.BpsCrop();
			_clp.CropChanged += CropChanged;
			_felCur = fel;
			if (rbRed.IsChecked != true)
			{
				SetClipColorGrey();
			}
		}

		private void Window_Loaded(object sender, RoutedEventArgs e)
		{
			AddCropToElement(imgChurch);
			_brOriginal = _clp.Fill;
			RefreshCropImage();
		}

		private void RefreshCropImage()
		{
			if (_clp != null)
			{
				Rect rc = _clp.ClippingRectangle;

				tblkClippingRectangle.Text = string.Format(
					"Clipping Rectangle: ({0:N1}, {1:N1}, {2:N1}, {3:N1})",
					rc.Left,
					rc.Top,
					rc.Right,
					rc.Bottom);
				imgCrop.Source = _clp.BpsCrop();
			}
		}

		private void CropChanged(Object sender, RoutedEventArgs rea)
		{
			RefreshCropImage();
		}

		private void CropControls_Checked(object sender, RoutedEventArgs e)
		{
			if (dckControls != null)
			{
				dckControls.Visibility = Visibility.Visible;
				AddCropToElement(dckControls);
				RefreshCropImage();
			}
		}

		private void CropImage_Checked(object sender, RoutedEventArgs e)
		{
			if (dckControls != null && imgChurch != null)
			{
				dckControls.Visibility = Visibility.Hidden;
				AddCropToElement(imgChurch);
				RefreshCropImage();
			}
		}

		private void Window_SizeChanged(object sender, SizeChangedEventArgs e)
		{
			RefreshCropImage();
		}

		private void SetClipColorRed()
		{
			if (_clp != null)
			{
				_clp.Fill = _brOriginal;
			}
		}

		private void SetClipColorGrey()
		{
			if (_clp != null)
			{
				Color clr = Colors.Black;
				clr.A = 110;
				_clp.Fill = new SolidColorBrush(clr);
			}
		}

		private void Red_Checked(object sender, RoutedEventArgs e)
		{
			SetClipColorRed();
		}

		private void Grey_Checked(object sender, RoutedEventArgs e)
		{
			SetClipColorGrey();
		}
	}
}