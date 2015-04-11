using System;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Runtime.InteropServices;
using System.Windows.Controls;
using DAP.Adorners;
using System.Windows.Documents;
using System.IO;

namespace ScannerClient_obalkyknih
{
    /// <summary>Class for manipulation with images: adjusting brightness and contrast, rotation, flip, etc.</summary>
    public static class ImageTools
    {
        #region Rotate, Flip, Deskew functions

        /// <summary>Rotates image by amount of degree (only right angle rotations are allowed)</summary>
        /// <param name="image">image that will be rotated</param>
        /// <param name="degree">degree of clockwise rotation </param>
        public static BitmapSource RotateImage(BitmapSource inputSource, int degree)
        {
            TransformedBitmap tb = new TransformedBitmap(inputSource, new RotateTransform(degree));
            //copy pixels to new bitmapSource because of strange .NET native memory leak
            int stride = tb.PixelWidth * tb.Format.BitsPerPixel / 8;
            byte[] bitmapArray = new byte[tb.PixelHeight * stride];
            tb.CopyPixels(bitmapArray, stride, 0);
            return BitmapSource.Create(tb.PixelWidth, tb.PixelHeight, tb.DpiX, tb.DpiY, tb.Format,
                tb.Palette, bitmapArray, stride);
        }

        /// <summary> Flips image horizontally </summary>
        /// <param name="inputImagePath">path to image that will be flipped</param>
        /// <param name="inputImagePath">path to file, where will be flipped image saved</param>
        public static BitmapSource FlipHorizontalImage(BitmapSource inputSource)
        {
            TransformedBitmap tb = new TransformedBitmap(inputSource, new ScaleTransform(-1, 1));
            //copy pixels to new bitmapSource because of strange .NET native memory leak
            int stride = tb.PixelWidth * tb.Format.BitsPerPixel / 8;
            byte[] bitmapArray = new byte[tb.PixelHeight * stride];
            tb.CopyPixels(bitmapArray, stride, 0);
            return BitmapSource.Create(tb.PixelWidth, tb.PixelHeight, tb.DpiX, tb.DpiY, tb.Format,
                tb.Palette, bitmapArray, stride);
        }

        /// <summary> Deskew the image (rotate), so its text will be straight </summary>
        /// <param name="bitmapSource">source image that will be deskewed</param>
        /// <returns>Rotated BitmapSource</returns>
        /// <remarks>This is only method that uses GDI+</remarks>
        public static BitmapSource DeskewImage(BitmapSource bitmapSource, double skewAngle)
        {
            System.Drawing.Bitmap bmpOut;
            BitmapSource output;

            BmpBitmapEncoder encoder = new BmpBitmapEncoder();
            BitmapFrame frame = BitmapFrame.Create(bitmapSource);
            encoder.Frames.Add(frame);

            using (MemoryStream ms = new MemoryStream())
            {
                encoder.Save(ms);
                ms.Position = 0;

                System.Drawing.Bitmap bmpIn = new System.Drawing.Bitmap(ms);
                Deskew sk = new Deskew(bmpIn);
                bmpOut = sk.RotateImage(bmpIn, -skewAngle);

                bmpIn.Dispose();
            }

            using (MemoryStream ms = new MemoryStream())
            {
                bmpOut.Save(ms, System.Drawing.Imaging.ImageFormat.Bmp);
                bmpOut.Dispose();

                output = LoadFullSize(ms);
            }
            //copy pixels to new bitmapSource because of strange .NET native memory leak
            int stride = output.PixelWidth * output.Format.BitsPerPixel / 8;
            byte[] bitmapArray = new byte[output.PixelHeight * stride];
            output.CopyPixels(bitmapArray, stride, 0);
            return BitmapSource.Create(output.PixelWidth, output.PixelHeight, output.DpiX, output.DpiY, output.Format,
                output.Palette, bitmapArray, stride);
        }

        /// <summary> Get skew angle of image, how much degree have to be rotated to its text will be straight </summary>
        /// <param name="bitmapSource">image for which will be skew angle computed</param>
        /// <returns>Angle, how much degrees is image rotated from normal position</returns>
        /// <remarks>This is only method that uses GDI+ and does not use BitmapSource</remarks>
        public static double GetDeskewAngle(BitmapSource bitmapSource)
        {
            double skewangle;
            using (MemoryStream ms = new MemoryStream())
            {
                BmpBitmapEncoder encoder = new BmpBitmapEncoder();
                encoder.Frames.Add(BitmapFrame.Create(bitmapSource));
                encoder.Save(ms);
                ms.Position = 0;

                System.Drawing.Bitmap bmpIn = new System.Drawing.Bitmap(ms);
                Deskew sk = new Deskew(bmpIn);
                skewangle = sk.GetSkewAngle();
                bmpIn.Dispose();
            }

            return skewangle;
        }
        #endregion

        #region Cropping functions

        /// <summary>Finds crop zone in given image</summary>
        /// <param name="bitmapSource">input image</param>
        /// <returns>Rectangle of crop zone</returns>
        public static Rect FindCropZone(BitmapSource bitmapSource)
        {
            // define treshold of pixels
            int threshold = 30;
            //if not BGRA transform to BGRA
            if (bitmapSource.Format != PixelFormats.Rgb24)
                bitmapSource = new FormatConvertedBitmap(bitmapSource, PixelFormats.Rgb24, null, 0);

            int width = bitmapSource.PixelWidth;
            int height = bitmapSource.PixelHeight;
            int colors = bitmapSource.Format.BitsPerPixel / 8;
            int stride = width * colors;

            byte[] bitmapArray = new byte[height * stride];
            bitmapSource.CopyPixels(bitmapArray, stride, 0);

            int left = width, right = 0, top = height, bottom = 0;
            for (int j = 0; j < height - 1; j++)
            {
                int row = j * width;
                for (int i = 0; i < width - 1; i++)
                {
                    int index = (row + i) * colors;
                    if (Math.Abs(bitmapArray[index] - bitmapArray[index + 4]) > threshold ||
                       Math.Abs(bitmapArray[index + 1] - bitmapArray[index + 5]) > threshold ||
                       Math.Abs(bitmapArray[index + 2] - bitmapArray[index + 6]) > threshold)
                    {
                        left = (i < left) ? i : left;
                        right = (i > right) ? i + 1 : right;
                        top = (j < top) ? j : top;
                        bottom = (j > bottom) ? j + 1 : bottom;
                    }
                }
            }
            //add some margin for better look
            left = (left >= 2) ? left - 2 : left;
            top = (top >= 2) ? top - 2 : top;
            right = (right <= width - 2) ? right + 2 : right;
            bottom = (bottom <= height - 2) ? bottom + 2 : bottom;

            return new Rect(left, top, Math.Max(0, right - left), Math.Max(0, bottom - top));
        }

        /// <summary>Crops image bounded by rectangle of cropper</summary>
        /// <param name="image">image that will be cropped</param>
        /// <param name="cropper">object responsible for cropping</param>
        public static BitmapSource CropImage(BitmapSource image, CroppingAdorner cropper)
        {
            if (cropper != null)
            {
                return cropper.BpsCrop(image);
            }
            else
            {
                return null;
            }
        }

        /// <summary>Adds cropper object to element (adds cropping rectangle)</summary>
        /// <param name="fel">element to which will be added cropper</param>
        /// <param name="cropper">cropper, that will be added</param>
        /// <param name="cropZoneSize">width and height of cropZone</param>
        public static void AddCropToElement(FrameworkElement fel, ref CroppingAdorner cropper, Rect cropZoneSize)
        {
            AdornerLayer aly = null;
            Size cropZone = new Size(0,0);
            if (cropper != null && cropper.AdornedElement != null)
            {
                cropZone = cropper.CropZone;
                aly = AdornerLayer.GetAdornerLayer(fel);
                if (aly.GetAdorners(fel) != null)
                {
                    foreach (var adorner in aly.GetAdorners(fel))
                    {
                        aly.Remove(adorner);
                    }
                }
            }
            Rect rcInterior;
            if (cropZoneSize.Height < 1 || cropZoneSize.Width < 1)
            {
                rcInterior = new Rect(0, 0, fel.RenderSize.Width, fel.RenderSize.Height);
            }
            else
            {
                rcInterior = cropZoneSize;
            }
            aly = AdornerLayer.GetAdornerLayer(fel);
            cropper = new CroppingAdorner(fel, rcInterior);
            cropper.CropZone = cropZone;
            aly.Add(cropper);
        }
        #endregion

        #region Color correction functions

        /// <summary>Applies automatic color corrections - stretches contrast, detects gamma correction and applies it</summary>
        /// <param name="bitmapSource">source image to correct</param>
        /// <returns>color corrected image</returns>
        public static BitmapSource ApplyAutoColorCorrections(BitmapSource bitmapSource)
        {
            bitmapSource = ImageTools.StretchContrast(bitmapSource);
            double gamma = ImageTools.AutoDetectGamma(bitmapSource);
            bitmapSource = ImageTools.AdjustGamma(bitmapSource, gamma);

            return bitmapSource;
        }

        /// <summary>Adjusts brightness of image</summary>
        /// <param name="sourceImage">image, that will be adjusted</param>
        /// <param name="brightness">brightness value on scale -255 to 255</param>
        /// <returns>new image with adjusted brightness</returns>
        public static BitmapSource AdjustBrightness(BitmapSource sourceImage, int brightness)
        {
            //if not RGB transform to RGB
            if (sourceImage.Format != PixelFormats.Rgb24)
            {
                sourceImage = new FormatConvertedBitmap(sourceImage, PixelFormats.Rgb24, null, 0);
            }

            int width = sourceImage.PixelWidth;
            int height = sourceImage.PixelHeight;
            int colors = sourceImage.Format.BitsPerPixel / 8;
            int stride = width * colors;

            byte[] bitmapArray = new byte[height*stride];
            sourceImage.CopyPixels(bitmapArray, stride, 0);
            
            for (int i = 0; i < height * stride; i++)
            {
                int color = brightness + bitmapArray[i];
                if (color > 255)
                {
                    color = 255;
                }
                if (color < 0)
                {
                    color = 0;
                }
                bitmapArray[i] = (byte)color;
            }

            return BitmapSource.Create(width, height, 300, 300, PixelFormats.Rgb24, sourceImage.Palette, bitmapArray, stride);
        }

        /// <summary>Adjusts contrast of image</summary>
        /// <param name="bitmapImage">image, that will be adjusted</param>
        /// <param name="contrast">contrast level on scale -100 to 100</param>
        /// <returns>new image with adjusted contrast</returns>
        public static BitmapSource AdjustContrast(BitmapSource sourceImage, double contrast)
        {
            contrast = (100.0 + contrast) / 100.0;
            contrast *= contrast;

            //if not RGB transform to RGB
            if (sourceImage.Format != PixelFormats.Rgb24)
            {
                sourceImage = new FormatConvertedBitmap(sourceImage, PixelFormats.Rgb24, null, 0);
            }

            int width = sourceImage.PixelWidth;
            int height = sourceImage.PixelHeight;
            int colors = sourceImage.Format.BitsPerPixel / 8;
            int stride = width * colors;

            byte[] bitmapArray = new byte[height * stride];
            sourceImage.CopyPixels(bitmapArray, stride, 0);
            
            for (int i = 0; i < height * stride; i++)
            {
                double tmpContrast = bitmapArray[i] / 255.0;
                tmpContrast -= 0.5;
                tmpContrast *= contrast;
                tmpContrast += 0.5;
                tmpContrast *= 255;

                if (tmpContrast > 255)
                {
                    tmpContrast = 255;
                }
                else if (tmpContrast < 0)
                {
                    tmpContrast = 0;
                }
                bitmapArray[i] = (byte)tmpContrast;
            }

            return BitmapSource.Create(width, height, sourceImage.DpiX, sourceImage.DpiY, PixelFormats.Rgb24, sourceImage.Palette, bitmapArray, stride);
        }

        /// <summary>Automatically stretch contrast range</summary>
        /// <param name="bitmapSource">source image to adjust colors</param>
        /// <returns>color adjusted image</returns>
        public static BitmapSource StretchContrast(BitmapSource bitmapSource)
        {
            //if not RGB transform to RGB
            if (bitmapSource.Format != PixelFormats.Rgb24)
            {
                bitmapSource = new FormatConvertedBitmap(bitmapSource, PixelFormats.Rgb24, null, 0);
            }

            int width = bitmapSource.PixelWidth;
            int height = bitmapSource.PixelHeight;
            int colors = bitmapSource.Format.BitsPerPixel / 8;
            int stride = width * colors;

            byte[] bitmapArray = new byte[height * stride];
            bitmapSource.CopyPixels(bitmapArray, stride, 0);

            // find min and max values in image
            byte min = 255;
            byte max = 0;
            int currentPixel = bitmapArray[0];
            for (int i = 1; i < height * stride; i++)
            {
                if (i % colors == 0)
                {
                    currentPixel = currentPixel / colors;
                    min = (min < currentPixel) ? min : (byte)currentPixel;
                    max = (max > currentPixel) ? max : (byte)currentPixel;
                    currentPixel = 0;
                }
                currentPixel += bitmapArray[i];
            }

            //stretch contrast in image
            double stretch = (double)255 / (max - min);
            for (int i = 0; i < height * stride; i++)
            {
                double newValue = ((bitmapArray[i] - min) * stretch);
                newValue = newValue < 0 ? 0 : newValue;
                newValue = newValue > 255 ? 255 : newValue;
                bitmapArray[i] = (byte)newValue;
            }

            return BitmapSource.Create(width, height, bitmapSource.DpiX, bitmapSource.DpiY, PixelFormats.Rgb24, bitmapSource.Palette, bitmapArray, stride);
        }

        /// <summary>Detect gamma correction value automatically</summary>
        /// <param name="bitmapSource">image, which gamma correction value will be computed</param>
        /// <returns>gamma correction value</returns>
        public static double AutoDetectGamma(BitmapSource bitmapSource)
        {
            //if not RGB transform to RGB
            if (bitmapSource.Format != PixelFormats.Rgb24)
            {
                bitmapSource = new FormatConvertedBitmap(bitmapSource, PixelFormats.Rgb24, null, 0);
            }

            int width = bitmapSource.PixelWidth;
            int height = bitmapSource.PixelHeight;
            int colors = bitmapSource.Format.BitsPerPixel / 8;
            int stride = width * colors;

            byte[] bitmapArray = new byte[height * stride];
            bitmapSource.CopyPixels(bitmapArray, stride, 0);

            //gamma = log(color_range / 2) / log(mean_value_of_pixels

            long sum = 0;
            for (int i = 0; i < stride * height; i++)
            {
                sum += bitmapArray[i];
            }
            long range = 256;
            double average = ((double) sum / (height * stride));
            double gamma = Math.Log(range / 2.0) / Math.Log(average);
            return gamma;
        }

        /// <summary>Adjust gamma value of the image</summary>
        /// <param name="bitmapSource">source image to adjust gamma</param>
        /// <param name="gamma">gamma correction value</param>
        /// <returns>gamma adjusted image</returns>
        public static BitmapSource AdjustGamma(BitmapSource bitmapSource, double gamma)
        {
            //if not RGB transform to RGB
            if (bitmapSource.Format != PixelFormats.Rgb24)
            {
                bitmapSource = new FormatConvertedBitmap(bitmapSource, PixelFormats.Rgb24, null, 0);
            }

            int width = bitmapSource.PixelWidth;
            int height = bitmapSource.PixelHeight;
            int colors = bitmapSource.Format.BitsPerPixel / 8;
            int stride = width * colors;

            byte[] bitmapArray = new byte[height * stride];
            bitmapSource.CopyPixels(bitmapArray, stride, 0);

            byte[] gammaArray = CreateGammaArray(gamma);
            // adjust gamma
            for (int i = 0; i < height * stride; i++)
            {
                bitmapArray[i] = gammaArray[bitmapArray[i]];
            }

            return BitmapSource.Create(width, height, bitmapSource.DpiX, bitmapSource.DpiY, bitmapSource.Format, bitmapSource.Palette, bitmapArray, stride);
        }

        // Creates array of gamma values
        private static byte[] CreateGammaArray(double color)
        {
            byte[] gammaArray = new byte[256];
            for (int i = 0; i < 256; ++i)
            {
                gammaArray[i] = (byte)Math.Min(255, (int)((255.0 * Math.Pow(i / 255.0, 1.0 / color)) + 0.5));
            }

            return gammaArray;
        }
        #endregion

        #region Image loading and saving functions

        /// <summary>Saves BitmapSource into file with with given path</summary>
        /// <param name="source">BitmapSource that will be saved</param>
        /// <param name="outputFile">Absolute path to file, where image will be saved</param>
        public static void SaveToFile(BitmapSource source, string outputFile)
        {
            using (FileStream fs = new FileStream(outputFile, FileMode.Create))
            {
                TiffBitmapEncoder encoder = new TiffBitmapEncoder();
                encoder.Compression = TiffCompressOption.Lzw;
                encoder.Frames.Add(BitmapFrame.Create(source));
                encoder.Save(fs);
            }
        }

        /// <summary>Loads BitmapSource from file with with given path</summary>
        /// <param name="fileName">File path to image</param>
        /// <returns>Decoded BitmapSource</returns>
        public static BitmapSource LoadFullSize(string fileName)
        {
            BitmapSource output;
            using (FileStream stream = new FileStream(fileName, FileMode.Open))
            {
                output = LoadFullSize(stream);
            }
            return output;
        }

        /// <summary>Loads BitmapSource from given MemoryStream</summary>
        /// <param name="memoryStream">MemoryStream containing image</param>
        /// <returns>Decoded BitmapSource</returns>
        public static BitmapSource LoadFullSize(Stream stream)
        {
            BitmapSource output;
            stream.Position = 0;

            BitmapImage bi = new BitmapImage();
            bi.BeginInit();
            bi.CacheOption = BitmapCacheOption.OnLoad;
            bi.CreateOptions = BitmapCreateOptions.PreservePixelFormat;
            bi.StreamSource = stream;
            bi.EndInit();
            bi.Freeze();

            output = bi;

            if (bi.Format != PixelFormats.Rgb24)
            {
                output = new FormatConvertedBitmap(bi, PixelFormats.Rgb24, null, 0);
            }

            int stride = output.PixelWidth * output.Format.BitsPerPixel / 8;
            byte[] bitmapArray = new byte[output.PixelHeight * stride];
            output.CopyPixels(bitmapArray, stride, 0);

            return BitmapSource.Create(output.PixelWidth, output.PixelHeight, output.DpiX, output.DpiY, PixelFormats.Rgb24,
                output.Palette, bitmapArray, stride);
        }

        /// <summary>Loads BitmapSource with given decode width from BitmapSource</summary>
        /// <param name="bitmapSource">source image</param>
        /// <param name="decodePixelHeight">Pixel height of decoded image</param>
        /// <returns>Decoded BitmapSource</returns>
        public static BitmapSource LoadGivenSizeFromBitmapSource(BitmapSource bitmapSource, int decodePixelHeight)
        {
            BitmapSource output;
            double scale = decodePixelHeight / (double)bitmapSource.PixelHeight;
            output = new TransformedBitmap(bitmapSource, new ScaleTransform(scale, scale));
            using (MemoryStream stream = new MemoryStream())
            {
                BmpBitmapEncoder enc = new BmpBitmapEncoder();
                enc.Frames.Add(BitmapFrame.Create(output));
                enc.Save(stream);
                output = LoadFullSize(stream);
            }
            return output;
        }
        #endregion
    }
}
