using System;
using System.Diagnostics;

namespace Icatt
{

    /// <summary>
    /// Threas safe utility for retrieving new seeds on every call.
    /// </summary>
    public static class RandomSeedUtility
    {
        /// <summary>
        /// The _seedCounter is initialized close to int.MaxValue so it is possible to test the GetSeed behaviour at its limits without having to make more int.MaxValue calls, which takes half an hour..
        /// </summary>
        private static int _seedCounter = int.MaxValue-10; 
        private static readonly object Lock = new object();

        //The secret offset makes the seed less predictable then a straightforward (ticks mod maxint) and therefore makes the result of the pseudo-random function using the seed less predictable
        private const int SecretOffset = 398779812;

        /// <summary>
        /// Forces a new seed value on every call, even if within the same tick
        /// </summary>
        /// <returns></returns>
        public static int GetSeed()
        {
            int seed;

            //NB!
            // Lock placed on entire seed calculation and not just on NextIncrement because otherwise a 
            // thread may combine an older Ticks value with a later NextIncrement() result, to get the same seed
            // as a thread that gets the Ticks value later but the NextIncrement() earlier.
            lock (Lock)
            {
                //Stopwatch.GetTimestamp has a better resolution then DateTime.Ticks- depending on the hardware
                seed = (int)(((Stopwatch.GetTimestamp() % int.MaxValue) + NextIncrement() + SecretOffset) % int.MaxValue);
            }
            return seed;

        }

        /// <summary>
        /// Increments the seedcounter in a threadsafe way and circles back to int.MinValue if int.MaxValue is reached.
        /// </summary>
        private static int NextIncrement()
        {
            if (_seedCounter == int.MaxValue)
            {
                _seedCounter = int.MinValue;
            }
            else
            {
                _seedCounter++;

            }

            return _seedCounter;
        }
    }
}
