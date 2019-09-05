namespace Icatt
{
    public interface IRandomizer
    {
        void NextBytes(byte[] buffer);

        double NextDouble();

        int Next();

        int Next(int minValue, int maxValue);
        int Next( int maxValue);
    }
}