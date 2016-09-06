namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Represents color of scanning
    /// </summary>
    public enum ScanColor
    {
        Color = 1,
        Gray = 2,
        BlackAndWhite = 4
    }

    /// <summary>
    /// Represents type of object
    /// </summary>
    public enum DocumentType
    {
        Cover,
        Toc,
        Auth
    }

    /// <summary>
    /// Represent type of image transformation
    /// </summary>
    public enum ImageTransforms
    {
        RotateLeft,
        RotateRight,
        Rotate180,
        FlipHorizontal,
        Deskew,
        Crop,
        CorrectColors
    }
}
