using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Class for calculating skew angle and rotating image
    /// </summary>
    public class Deskew
    {

        // The Bitmap
        Bitmap cBmp;
        // The range of angles to search for lines
        double cAlphaStart = -20;
        double cAlphaStep = 0.2;
        int cSteps = 40 * 5;
        // Precalculation of sin and cos.
        double[] cSinA;
        double[] cCosA;
        // Range of d
        double cDMin;
        double cDStep = 1;
        int cDCount;
        // Count of points that fit in a line.
        int[] cHMatrix;

        /// <summary>
        /// constructor
        /// </summary>
        /// <param name="bmp">input image to deskew</param>
        public Deskew(Bitmap bmp)
        {
            cBmp = bmp;
        }


        /// <summary>
        /// Calculates the skew angle of the image
        /// </summary>
        /// <returns>Skew angle of image</returns>
        public double GetSkewAngle()
        {
            double sum = 0;
            int count = 0;

            // Hough Transformation
            Calc();
            // Top 20 of the detected lines in the image.
            HougLine[] hl = GetTop(10);
            // Average angle of the lines
            for (int i = 0; i <= 9; i++)
            {
                sum += hl[i].Alpha;
                count += 1;
            }
            return sum / (double)count;
        }


        /// <summary>
        /// Rotates the input image by theta degrees around center.
        /// </summary>
        /// <param name="bmpSrc">image to rotate</param>
        /// <param name="theta">angle of rotation</param>
        /// <returns>image rotated by theta degrees</returns>
        public Bitmap RotateImage(Bitmap bmpSrc, double theta)
        {
            Matrix mRotate = new Matrix();
            mRotate.Translate(bmpSrc.Width / -2, bmpSrc.Height / -2, MatrixOrder.Append);
            mRotate.RotateAt((float)theta, new System.Drawing.Point(0, 0), MatrixOrder.Append);
            using (GraphicsPath gp = new GraphicsPath())
            {  // transform image points by rotation matrix
                gp.AddPolygon(new System.Drawing.Point[] { new System.Drawing.Point(0, 0), new System.Drawing.Point(bmpSrc.Width, 0), new System.Drawing.Point(0, bmpSrc.Height) });
                gp.Transform(mRotate);
                System.Drawing.PointF[] pts = gp.PathPoints;

                // create destination bitmap sized to contain rotated source image
                Rectangle bbox = boundingBox(bmpSrc, mRotate);
                Bitmap bmpDest = new Bitmap(bbox.Width, bbox.Height);

                using (Graphics gDest = Graphics.FromImage(bmpDest))
                {  // draw source into dest
                    Matrix mDest = new Matrix();
                    mDest.Translate(bmpDest.Width / 2, bmpDest.Height / 2, MatrixOrder.Append);
                    gDest.FillRectangle(Brushes.White, 0, 0, bmpDest.Width, bmpDest.Height);
                    gDest.Transform = mDest;
                    gDest.DrawImage(bmpSrc, pts);
                    return bmpDest;
                }
            }
        }

        private static Rectangle boundingBox(Image img, Matrix matrix)
        {
            GraphicsUnit gu = new GraphicsUnit();
            Rectangle rImg = Rectangle.Round(img.GetBounds(ref gu));

            // Transform the four points of the image, to get the resized bounding box.
            System.Drawing.Point topLeft = new System.Drawing.Point(rImg.Left, rImg.Top);
            System.Drawing.Point topRight = new System.Drawing.Point(rImg.Right, rImg.Top);
            System.Drawing.Point bottomRight = new System.Drawing.Point(rImg.Right, rImg.Bottom);
            System.Drawing.Point bottomLeft = new System.Drawing.Point(rImg.Left, rImg.Bottom);
            System.Drawing.Point[] points = new System.Drawing.Point[] { topLeft, topRight, bottomRight, bottomLeft };
            GraphicsPath gp = new GraphicsPath(points,
                                                                new byte[] { (byte)PathPointType.Start, (byte)PathPointType.Line, (byte)PathPointType.Line, (byte)PathPointType.Line });
            gp.Transform(matrix);
            return Rectangle.Round(gp.GetBounds());
        }

        // Calculate the Count lines in the image with most points.
        private HougLine[] GetTop(int count)
        {

            HougLine[] hl = new HougLine[count];

            for (int i = 0; i <= count - 1; i++)
            {
                hl[i] = new HougLine();
            }

            for (int i = 0; i <= cHMatrix.Length - 1; i++)
            {
                if (cHMatrix[i] > hl[count - 1].Count)
                {
                    hl[count - 1].Count = cHMatrix[i];
                    hl[count - 1].Index = i;
                    int j = count - 1;
                    while (j > 0 && hl[j].Count > hl[j - 1].Count)
                    {
                        HougLine tmp = hl[j];
                        hl[j] = hl[j - 1];
                        hl[j - 1] = tmp;
                        j -= 1;
                    }
                }
            }

            for (int i = 0; i <= count - 1; i++)
            {
                int dIndex = hl[i].Index / cSteps;
                int alphaIndex = hl[i].Index - dIndex * cSteps;
                hl[i].Alpha = GetAlpha(alphaIndex);
                hl[i].D = dIndex + cDMin;
            }
            return hl;
        }

        // Hough Transforamtion:
        private void Calc()
        {
            int hMin = cBmp.Height / 4;
            int hMax = cBmp.Height * 3 / 4;

            Init();
            for (int y = hMin; y <= hMax; y++)
            {
                for (int x = 1; x <= cBmp.Width - 2; x++)
                {
                    // Only lower edges are considered.
                    if (IsBlack(x, y))
                    {
                        if (!IsBlack(x, y + 1))
                        {
                            Calc(x, y);
                        }
                    }
                }
            }
        }

        // Calculate all lines through the point (x,y).
        private void Calc(int x, int y)
        {
            for (int alpha = 0; alpha <= cSteps - 1; alpha++)
            {
                double d = y * cCosA[alpha] - x * cSinA[alpha];
                int dIndex = CalcDIndex(d);
                int index = dIndex * cSteps + alpha;
                try
                {
                    cHMatrix[index] += 1;
                }
                catch (Exception)
                {
                }
            }
        }

        private int CalcDIndex(double d)
        {
            return Convert.ToInt32(d - cDMin);
        }

        private bool IsBlack(int x, int y)
        {
            Color c = cBmp.GetPixel(x, y);
            double luminance = (c.R * 0.299) + (c.G * 0.587) + (c.B * 0.114);
            return luminance < 140;
        }

        private void Init()
        {
            // Precalculation of sin and cos.
            cSinA = new double[cSteps];
            cCosA = new double[cSteps];

            for (int i = 0; i <= cSteps - 1; i++)
            {
                double angle = GetAlpha(i) * Math.PI / 180.0;
                cSinA[i] = Math.Sin(angle);
                cCosA[i] = Math.Cos(angle);
            }
            // Range of d:
            cDMin = -cBmp.Width;
            cDCount = (int)(2 * (cBmp.Width + cBmp.Height) / cDStep);
            cHMatrix = new int[cDCount * cSteps];
        }

        private double GetAlpha(int index)
        {
            return cAlphaStart + index * cAlphaStep;
        }
    }

    // Representation of a line in the image.
    public class HougLine
    {
        public HougLine()
        {
            Count = 0;
            Index = 0;
            Alpha = 0;
            D = 0;
        }
        // count of points in the line.
        public int Count { get; set; }
        // index in Matrix.
        public int Index { get; set; }
        // The line is represented as all x,y that solve y*cos(alpha)-x*sin(alpha)=d
        public double Alpha { get; set; }
        public double D { get; set; }
    }
}