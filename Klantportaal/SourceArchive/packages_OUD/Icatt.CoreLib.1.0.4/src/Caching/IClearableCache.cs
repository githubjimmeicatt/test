namespace Icatt.Caching
{
    public interface IClearableCache : ICache
    {
        void Clear(string key);

    }
}