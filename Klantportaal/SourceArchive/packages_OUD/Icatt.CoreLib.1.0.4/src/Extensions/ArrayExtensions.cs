using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Extensions
{
    public static class ArrayExtensions
    {
        /// <summary>
        /// Returns a new Array that is a slice of the source Array
        /// </summary>
        /// <typeparam name="T">Any type</typeparam>
        /// <param name="source">Source array</param>
        /// <param name="start">Index of the first element in the slice</param>
        /// <param name="endIndex">Source index of the last element in the slice or a negative number that is substrated from the index of the last element in the the array. 
        /// So -1 points to the element before the last (at index length - 2), -2 at index (length -3) etcetera. 
        /// Zero is a normal index value and poinst to the first element in the source array. 
        /// A null (or missing) value corresponds to the last element of the array, same as the value of (source.Length - 1)</param>
        /// <returns></returns>
        /// <exception cref="ArgumentOutOfRangeException">Thrown when the calculated end index is larger then the start index or when the end index is larger then (source.length-1) or when the start index is negative</exception>
        public static T[] Slice<T>(this T[] source, int start, int? endIndex = null)
        {
            //Handles slice to end of source
            var end = endIndex ?? source.Length - 1;

            // Handles negative ends.
            if (end < 0)
            {
                end = source.Length + end - 1;
            }

            if (start < 0 || start > end || end > source.Length-1)
            {
                throw new ArgumentOutOfRangeException(nameof(start), $"The start index ({start}) or end index ({end}) are out of range for a source array of length {source.Length}");
            }

            // Return new array.

            //Calc new length
            var len = end - start + 1;

            var slice = new T[len];
            for (var i = 0; i < len; i++)
            {
                slice[i] = source[i + start];
            }
            return slice;
        }

    }
}
