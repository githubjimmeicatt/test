using System.IO;
using System.Threading.Tasks;
using ImageMagick;

namespace Icatt.Heartcore.Data
{
    public static class ImageEngine
    {
        const int MaxDimension = 500;

        public static async Task<string> Blur(string filePath, int blurSize)
        {
            return await Blur(filePath, blurSize, blurSize);
        }

        public static async Task<string> Blur(string filePath, double radius, double sigma)
        {
            var fileName = Path.GetFileNameWithoutExtension(filePath);
            using var image = new MagickImage(filePath);
            image.ResizeIfNecessary();
            image.Blur(radius, sigma);
            var blurredPath = filePath.Replace(fileName, fileName + $"-blurred");
            await image.WriteAsync(blurredPath);
            return blurredPath;
        }

        private static void ResizeIfNecessary(this MagickImage image)
        {
            if (image.Width > image.Height && image.Width > MaxDimension)
            {
                image.AdaptiveResize(MaxDimension, 0);
            }
            else if (image.Height > MaxDimension)
            {
                image.AdaptiveResize(0, MaxDimension);
            }
        }
    }
}
