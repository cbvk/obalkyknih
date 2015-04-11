using System;
using System.Collections.Generic;
using System.Text;
using System.Windows.Shapes;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Controls.Primitives;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;

using Point=System.Drawing.Point;

namespace DAP.Adorners
{
	public class CroppingAdorner : Adorner
	{
		#region Private variables
		// Width of the thumbs.  I know these really aren't "pixels", but px
		// is still a good mnemonic.
		private const int _cpxThumbWidth = 6;

		// PuncturedRect to hold the "Cropping" portion of the adorner
		private PuncturedRect _prCropMask;

		// Canvas to hold the thumbs so they can be moved in response to the user
		private Canvas _cnvThumbs;

		// Cropping adorner uses Thumbs for visual elements.  
		// The Thumbs have built-in mouse input handling.
		private CropThumb _crtTopLeft, _crtTopRight, _crtBottomLeft, _crtBottomRight;
		private CropThumb _crtTop, _crtLeft, _crtBottom, _crtRight;

		// To store and manage the adorner's visual children.
		private VisualCollection _vc;

		// DPI for screen
		private static double s_dpiX, s_dpiY;
		#endregion

		#region Properties
		public Rect ClippingRectangle
		{
			get
			{
				return _prCropMask.RectInterior;
			}
		}
        public Size CropZone { get; set; }
		#endregion

		#region Routed Events
		public static readonly RoutedEvent CropChangedEvent = EventManager.RegisterRoutedEvent(
			"CropChanged",
			RoutingStrategy.Bubble,
			typeof(RoutedEventHandler),
			typeof(CroppingAdorner));

		public event RoutedEventHandler CropChanged
		{
			add
			{
				base.AddHandler(CroppingAdorner.CropChangedEvent, value);
			}
			remove
			{
				base.RemoveHandler(CroppingAdorner.CropChangedEvent, value);
			}
		}
		#endregion

		#region Dependency Properties
		static public DependencyProperty FillProperty = Shape.FillProperty.AddOwner(typeof(CroppingAdorner));

		public Brush Fill
		{
			get { return (Brush)GetValue(FillProperty); }
			set { SetValue(FillProperty, value); }
		}

		private static void FillPropChanged(DependencyObject d, DependencyPropertyChangedEventArgs args)
		{
			CroppingAdorner crp = d as CroppingAdorner;

			if (crp != null)
			{
				crp._prCropMask.Fill = (Brush)args.NewValue;
			}
		}
		#endregion

		#region Constructor
		static CroppingAdorner()
		{
			Color clr = Colors.Red;
			System.Drawing.Graphics g = System.Drawing.Graphics.FromHwnd((IntPtr)0);

			s_dpiX = g.DpiX;
			s_dpiY = g.DpiY;
			clr.A = 80;
			FillProperty.OverrideMetadata(typeof(CroppingAdorner),
				new PropertyMetadata(
					new SolidColorBrush(clr),
					new PropertyChangedCallback(FillPropChanged)));
		}

		public CroppingAdorner(UIElement adornedElement, Rect rcInit)
			: base(adornedElement)
		{
			_vc = new VisualCollection(this);
			_prCropMask = new PuncturedRect();
			_prCropMask.IsHitTestVisible = false;
			_prCropMask.RectInterior = rcInit;
			_prCropMask.Fill = Fill;
			_vc.Add(_prCropMask);
			_cnvThumbs = new Canvas();
			_cnvThumbs.HorizontalAlignment = HorizontalAlignment.Stretch;
			_cnvThumbs.VerticalAlignment = VerticalAlignment.Stretch;

			_vc.Add(_cnvThumbs);
			BuildCorner(ref _crtTop, Cursors.SizeNS);
			BuildCorner(ref _crtBottom, Cursors.SizeNS);
			BuildCorner(ref _crtLeft, Cursors.SizeWE);
			BuildCorner(ref _crtRight, Cursors.SizeWE);
			BuildCorner(ref _crtTopLeft, Cursors.SizeNWSE);
			BuildCorner(ref _crtTopRight, Cursors.SizeNESW);
			BuildCorner(ref _crtBottomLeft, Cursors.SizeNESW);
			BuildCorner(ref _crtBottomRight, Cursors.SizeNWSE);

			// Add handlers for Cropping.
			_crtBottomLeft.DragDelta += new DragDeltaEventHandler(HandleBottomLeft);
			_crtBottomRight.DragDelta += new DragDeltaEventHandler(HandleBottomRight);
			_crtTopLeft.DragDelta += new DragDeltaEventHandler(HandleTopLeft);
			_crtTopRight.DragDelta += new DragDeltaEventHandler(HandleTopRight);
			_crtTop.DragDelta += new DragDeltaEventHandler(HandleTop);
			_crtBottom.DragDelta += new DragDeltaEventHandler(HandleBottom);
			_crtRight.DragDelta += new DragDeltaEventHandler(HandleRight);
			_crtLeft.DragDelta += new DragDeltaEventHandler(HandleLeft);

            //add eventhandler to drag and drop 
            adornedElement.MouseLeftButtonDown += new MouseButtonEventHandler(Handle_MouseLeftButtonDown);
            adornedElement.MouseLeftButtonUp += new MouseButtonEventHandler(Handle_MouseLeftButtonUp);
            adornedElement.MouseMove += new MouseEventHandler(Handle_MouseMove);

			// We have to keep the clipping interior withing the bounds of the adorned element
			// so we have to track it's size to guarantee that...
			FrameworkElement fel = adornedElement as FrameworkElement;

			if (fel != null)
			{
				fel.SizeChanged += new SizeChangedEventHandler(AdornedElement_SizeChanged);
			}
		}
		#endregion

        #region Drag and drop handlers

        Double OrigenX;
        Double OrigenY;

        //  generic handler move selection with Drag'n'Drop
        private void HandleDrag(double dx, double dy)
        {
            Rect rcInterior = _prCropMask.RectInterior;
            rcInterior = new Rect(
               dx,
               dy,
                rcInterior.Width,
                rcInterior.Height);

            _prCropMask.RectInterior = rcInterior;
            SetThumbs(_prCropMask.RectInterior);
            RaiseEvent(new RoutedEventArgs(CropChangedEvent, this));
        }

        private void Handle_MouseMove(object sender, MouseEventArgs args)
        {
            Image Marco = sender as Image;
            if (Marco != null && Marco.IsMouseCaptured)
            {
                Double x = args.GetPosition(Marco).X; //posicion actual cursor
                Double y = args.GetPosition(Marco).Y;
                Double _x = _prCropMask.RectInterior.X; // posicion actual esquina superior izq del marco interior
                Double _y = _prCropMask.RectInterior.Y;
                Double _width = _prCropMask.RectInterior.Width; //dimensiones del marco interior
                Double _height = _prCropMask.RectInterior.Height;

                //si el click es dentro del marco interior
                if (((x > _x) && (x < (_x + _width))) && ((y > _y) && (y < (_y + _height))))
                {
                    //calculamos la diferencia de la posicion actual del cursor con respecto al punto de origen del arrastre
                    //y se la anadimos a la esquina sup. izq. del marco interior.
                    _x = _x + (x - OrigenX);
                    _y = _y + (y - OrigenY);

                    //comprobamos si es posible mover sin salirse del marco exterior por ninguna de sus dimensiones
                    //no supera el borde izquierdo de la imagen: !(_x < 0)
                    if (_x < 0)
                    {
                        _x = 0;
                    }
                    //no supera el borde derecho de la imagen: !((_x + _width) > Marco.Width)
                    if ((_x + _width) > Marco.ActualWidth)
                    {
                        _x = Marco.ActualWidth - _width;
                    }
                    //no supera el borde superior de la imagen: !(_y<0)
                    if (_y < 0)
                    {
                        _y = 0;
                    }
                    //no supera el borde inferior de la imagen: !((_y + _height) > Marco.Height)
                    if ((_y + _height) > Marco.ActualHeight)
                    {
                        _y = Marco.ActualHeight - _height;
                    }

                    //asignamos nuevo punto origen del arrastre y movemos el marco interior
                    OrigenX = x;
                    OrigenY = y;
                    HandleDrag(_x, _y);

                }
            }

        }

        private void Handle_MouseLeftButtonDown(object sender, MouseButtonEventArgs e)
        {
            Image Marco = sender as Image;
            if (Marco != null)
            {
                Marco.CaptureMouse();
                OrigenX = e.GetPosition(Marco).X; //iniciamos las variables en el punto de origen del arrastre
                OrigenY = e.GetPosition(Marco).Y;
            }
        }

        private void Handle_MouseLeftButtonUp(object sender, MouseButtonEventArgs e)
        {
            Image Marco = sender as Image;
            if (Marco != null)
            {
                Marco.ReleaseMouseCapture();
            }
        }
        #endregion

		#region Thumb handlers
		// Generic handler for Cropping
		private void HandleThumb(
			double drcL,
			double drcT,
			double drcW,
			double drcH,
			double dx,
			double dy)
		{
			Rect rcInterior = _prCropMask.RectInterior;

			if (rcInterior.Width + drcW * dx < 0)
			{
				dx = -rcInterior.Width / drcW;
			}

			if (rcInterior.Height + drcH * dy < 0)
			{
				dy = -rcInterior.Height / drcH;
			}

			rcInterior = new Rect(
				rcInterior.Left + drcL * dx,
				rcInterior.Top + drcT * dy,
				rcInterior.Width + drcW * dx,
				rcInterior.Height + drcH * dy);

			_prCropMask.RectInterior = rcInterior;
			SetThumbs(_prCropMask.RectInterior);
			RaiseEvent( new RoutedEventArgs(CropChangedEvent, this));
		}

		// Handler for Cropping from the bottom-left.
		private void HandleBottomLeft(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					1, 0, -1, 1,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the bottom-right.
		private void HandleBottomRight(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					0, 0, 1, 1,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the top-right.
		private void HandleTopRight(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					0, 1, 1, -1,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the top-left.
		private void HandleTopLeft(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					1, 1, -1, -1,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the top.
		private void HandleTop(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					0, 1, 0, -1,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the left.
		private void HandleLeft(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					1, 0, -1, 0,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the right.
		private void HandleRight(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					0, 0, 1, 0,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}

		// Handler for Cropping from the bottom.
		private void HandleBottom(object sender, DragDeltaEventArgs args)
		{
			if (sender is CropThumb)
			{
				HandleThumb(
					0, 0, 0, 1,
					args.HorizontalChange,
					args.VerticalChange);
			}
		}
		#endregion

		#region Other handlers
		private void AdornedElement_SizeChanged(object sender, SizeChangedEventArgs e)
		{
			FrameworkElement fel = sender as FrameworkElement;
			Rect rcInterior = _prCropMask.RectInterior;
			bool fFixupRequired = false;
			double
				intLeft = rcInterior.Left,
				intTop = rcInterior.Top,
				intWidth = rcInterior.Width,
				intHeight = rcInterior.Height;

			if (rcInterior.Left > fel.RenderSize.Width)
			{
				intLeft = fel.RenderSize.Width;
				intWidth = 0;
				fFixupRequired = true;
			}

			if (rcInterior.Top > fel.RenderSize.Height)
			{
				intTop = fel.RenderSize.Height;
				intHeight = 0;
				fFixupRequired = true;
			}

			if (rcInterior.Right > fel.RenderSize.Width)
			{
				intWidth = Math.Max(0, fel.RenderSize.Width - intLeft);
				fFixupRequired = true;
			}

			if (rcInterior.Bottom > fel.RenderSize.Height)
			{
				intHeight = Math.Max(0, fel.RenderSize.Height - intTop);
				fFixupRequired = true;
			}
			if (fFixupRequired)
			{
				_prCropMask.RectInterior = new Rect(intLeft, intTop, intWidth, intHeight);
			}
		}
		#endregion

		#region Arranging/positioning
		private void SetThumbs(Rect rc)
		{
			_crtBottomRight.SetPos(rc.Right, rc.Bottom);
			_crtTopLeft.SetPos(rc.Left, rc.Top);
			_crtTopRight.SetPos(rc.Right, rc.Top);
			_crtBottomLeft.SetPos(rc.Left, rc.Bottom);
			_crtTop.SetPos(rc.Left + rc.Width / 2, rc.Top);
			_crtBottom.SetPos(rc.Left + rc.Width / 2, rc.Bottom);
			_crtLeft.SetPos(rc.Left, rc.Top + rc.Height / 2);
			_crtRight.SetPos(rc.Right, rc.Top + rc.Height / 2);
		}

		// Arrange the Adorners.
		protected override Size ArrangeOverride(Size finalSize)
		{
			Rect rcExterior = new Rect(0, 0, AdornedElement.RenderSize.Width, AdornedElement.RenderSize.Height);
			_prCropMask.RectExterior = rcExterior;
			Rect rcInterior = _prCropMask.RectInterior;
			_prCropMask.Arrange(rcExterior);

			SetThumbs(rcInterior);
			_cnvThumbs.Arrange(rcExterior);
			return finalSize;
		}
		#endregion

		#region Public interface
		public BitmapSource BpsCrop()
		{
			Rect rcInterior = _prCropMask.RectInterior;

			Point pxFromSize = UnitsToPx(rcInterior.Width, rcInterior.Height);

			Point pxFromPos = UnitsToPx(rcInterior.Left, rcInterior.Top);
			Point pxWhole = UnitsToPx(AdornedElement.RenderSize.Width, AdornedElement.RenderSize.Height);
			pxFromSize.X = Math.Max(Math.Min(pxWhole.X - pxFromPos.X, pxFromSize.X), 0);
			pxFromSize.Y = Math.Max(Math.Min(pxWhole.Y - pxFromPos.Y, pxFromSize.Y), 0);
			if (pxFromSize.X == 0 || pxFromSize.Y == 0)
			{
				return null;
			}

            //we will base cropping on the original source instead of using RenderTargetBitmap, that was in original code
            Image adornedImage = AdornedElement as Image;
            BitmapSource bmpSource = adornedImage.Source as BitmapSource;
            //both ratios should be the same, but for safety, we will use two values
            double ratioX = bmpSource.PixelWidth / (double) pxWhole.X;
            double ratioY = bmpSource.PixelHeight / (double)pxWhole.Y;

            //set CropZone property
            this.CropZone = new Size((ratioX * pxFromSize.X), (ratioY * pxFromSize.Y));
            //multiply each position by ratio of dimensions of original image size and rendered image size
            System.Windows.Int32Rect rcFrom = new System.Windows.Int32Rect((int)(ratioX * pxFromPos.X), (int)(ratioY * pxFromPos.Y),
                (int)CropZone.Width, (int)CropZone.Height);

			return new CroppedBitmap(bmpSource, rcFrom);
		}

        public BitmapSource BpsCrop(BitmapSource bmpSource)
        {
            Rect rcInterior = _prCropMask.RectInterior;

            Point pxFromSize = UnitsToPx(rcInterior.Width, rcInterior.Height);

            Point pxFromPos = UnitsToPx(rcInterior.Left, rcInterior.Top);
            Point pxWhole = UnitsToPx(AdornedElement.RenderSize.Width, AdornedElement.RenderSize.Height);
            pxFromSize.X = Math.Max(Math.Min(pxWhole.X - pxFromPos.X, pxFromSize.X), 0);
            pxFromSize.Y = Math.Max(Math.Min(pxWhole.Y - pxFromPos.Y, pxFromSize.Y), 0);
            if (pxFromSize.X == 0 || pxFromSize.Y == 0)
            {
                return null;
            }

            //both ratios should be the same, but for safety, we will use two values
            double ratioX = bmpSource.PixelWidth / (double)pxWhole.X;
            double ratioY = bmpSource.PixelHeight / (double)pxWhole.Y;

            //set CropZone property
            this.CropZone = new Size((ratioX * pxFromSize.X), (ratioY * pxFromSize.Y));
            //multiply each position by ratio of dimensions of original image size and rendered image size
            System.Windows.Int32Rect rcFrom = new System.Windows.Int32Rect((int)(ratioX * pxFromPos.X), (int)(ratioY * pxFromPos.Y),
                (int)CropZone.Width, (int)CropZone.Height);

            return new CroppedBitmap(bmpSource, rcFrom);
        }
		#endregion

		#region Helper functions
		private Thickness AdornerMargin()
		{
			Thickness thick = new Thickness(0);
			if (AdornedElement is FrameworkElement)
			{
				thick = ((FrameworkElement)AdornedElement).Margin;
			}
			return thick;
		}

		private void BuildCorner(ref CropThumb crt, Cursor crs)
		{
			if (crt != null) return;

			crt = new CropThumb(_cpxThumbWidth);

			// Set some arbitrary visual characteristics.
			crt.Cursor = crs;

			_cnvThumbs.Children.Add(crt);
		}

		private Point UnitsToPx(double x, double y)
		{
			return new Point((int)(x * s_dpiX / 96), (int)(y * s_dpiY / 96));
		}
		#endregion

		#region Visual tree overrides
		// Override the VisualChildrenCount and GetVisualChild properties to interface with 
		// the adorner's visual collection.
		protected override int VisualChildrenCount { get { return _vc.Count; } }
		protected override Visual GetVisualChild(int index) { return _vc[index]; }
		#endregion

		#region Internal Classes
		class CropThumb : Thumb
		{
			#region Private variables
			int _cpx;
			#endregion

			#region Constructor
			internal CropThumb(int cpx)
				: base()
			{
				_cpx = cpx;
			}
			#endregion

			#region Overrides
			protected override Visual GetVisualChild(int index)
			{
				return null;
			}

			protected override void OnRender(DrawingContext drawingContext)
			{
				drawingContext.DrawRoundedRectangle(Brushes.White, new Pen(Brushes.Black, 1), new Rect(new Size(_cpx, _cpx)), 1, 1);
			}
			#endregion

			#region Positioning
			internal void SetPos(double x, double y)
			{
				Canvas.SetTop(this, y - _cpx / 2);
				Canvas.SetLeft(this, x - _cpx / 2);
			}
			#endregion
		}
		#endregion
	}

}

