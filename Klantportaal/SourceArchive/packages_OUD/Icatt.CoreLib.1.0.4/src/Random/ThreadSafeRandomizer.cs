using System;

namespace Icatt
{
    /// <summary>
    /// Fast thread-safe randomizer
    /// </summary>
    /// <remarks>This randomizes uses a single static instance of Random and provices thread safe access to its methods</remarks>
    public class ThreadSafeRandomizer : IRandomizer
    {
        private static readonly object Lock = new object();

        private static Random _random;

        private static Random Random
        {
            get
            {
                if (_random == null)
                {
                    lock (Lock)
                    {
                        if (_random == null)
                        {
                            _random = new Random(RandomSeedUtility.GetSeed());

                        }
                    }

                }


                return _random;
            }
        }

        public int Next(int minValue,int maxValue)
        {
            lock (Lock)
            {
                return Random.Next(minValue, maxValue);
            }
        }

        public int Next( int maxValue)
        {
            lock (Lock)
            {
                return Random.Next( maxValue);
            }
        }

        public int Next()
        {
            lock (Lock)
            {
                return Random.Next();
            }
        }


        public void NextBytes(byte[]buffer)
        {
            lock (Lock)
            {
                Random.NextBytes(buffer);
            }
        }

        public  double NextDouble()
        {
            lock (Lock)
            {
                return Random.NextDouble();
            }
        }



    }

}
