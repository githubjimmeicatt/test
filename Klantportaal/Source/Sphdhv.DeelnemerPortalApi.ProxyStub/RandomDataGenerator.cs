using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using Icatt;

namespace Sphdhv.DeelnemerPortalApi.ProxyStub
{
    public static class RandomDataGenerator
    {
        private static int _recursionLimit = 2; //Max two levels of recursion

        private class PrimitiveTypeLimits
        {
            public Dictionary<Type, Range> Limits { get; }

            public PrimitiveTypeLimits(Dictionary<Type, Range> limits = null)
            {
                Limits = limits ?? new Dictionary<Type, Range>
                {
                    {typeof(byte), new Range {Min = byte.MinValue, Max = byte.MaxValue}},
                    {typeof(sbyte), new Range {Min = sbyte.MinValue, Max = sbyte.MaxValue}},
                    {typeof(short), new Range {Min = short.MinValue, Max = short.MaxValue}},
                    {typeof(ushort), new Range {Min = ushort.MinValue, Max = ushort.MaxValue}},
                    {typeof(int), new Range {Min = -1000, Max = 1000}},
                    {typeof(uint), new Range {Min = 0, Max = 10000u}},
                    {typeof(long), new Range {Min = -1000000L, Max = +1000000L}},
                    {typeof(ulong), new Range {Min = 0, Max = 10000000ul}},
                    {typeof(char), new Range {Min = char.MinValue, Max = char.MaxValue}},
                    {typeof(double), new Range {Min = -100000d, Max = +100000d}},
                    {typeof(float), new Range {Min = -1000f, Max = +1000f}},
                    {typeof(IntPtr), new Range {Min = long.MinValue, Max = long.MaxValue}},
                    {typeof(UIntPtr), new Range {Min = ulong.MinValue, Max = ulong.MaxValue}},
                };
            }

            public Range RangeFor(Type t)
            {
                Range range;
                if (Limits.TryGetValue(t,out range))
                {
                    return range;
                }
                return new Range{Min = Activator.CreateInstance(t), Max = Activator.CreateInstance(t)};
            }

            public object Max(Type t)
            {
                Range range;
                if (Limits.TryGetValue(t, out range))
                {
                    return range.Max;
                }
                return  Activator.CreateInstance(t) ;
            }

            public object Min(Type t)
            {
                Range range;
                if (Limits.TryGetValue(t, out range))
                {
                    return range.Min;
                }
                return Activator.CreateInstance(t);
            }

            public T Max<T>()
            {
                var t = typeof(T);

                Range range;
                if (Limits.TryGetValue(t, out range))
                {
                    return (T) range.Max;
                }
                return default(T);
            }
            public void Max<T>(object v)
            {
                Range range;
                if (!Limits.TryGetValue(typeof(T), out range))
                {
                    Limits[typeof(T)] = range = new Range();
                }
                range.Max = v;
            }

            public T Min<T>()
            {
                Range range;
                if (Limits.TryGetValue(typeof(T), out range))
                {
                    return (T)range.Min;
                }
                return default(T);
            }
            public void Min<T>(object v)
            {
                Range range;
                if (!Limits.TryGetValue(typeof(T),out range))
                {
                    Limits[typeof(T)] = range = new Range();
                }
                range.Min = v;
            }

            internal class Range
            {
                public object Max { get; set; }
                public object Min { get; set; }
            }

        }

        private static readonly IRandomizer Rand = new ThreadSafeRandomizer();

        public static T CreateRandomRecord<T>(string name = null, int defaultStringLength = 10)
        {
            return (T)CreateRandomRecord(typeof(T), name, defaultStringLength);
        }

        public static string CreateRandomString(int length, string allowedChars)
        {
            return Icatt.Security.SigningUtility.CreateRandomString(length, allowedChars.ToCharArray());
        }

        public static object CreateRandomRecord(Type recordType, string name = null, int defaultStringLength = 10,Stack<Type> callStack = null, object propertyLimits = null)
        {

            
            var t = recordType;
            var stack = callStack ?? new Stack<Type>();


            if (stack.Count(st => st == t) > _recursionLimit-1)
            {
                return null;
            }

            stack.Push(t);

#if DEBUG
            var tname = t.Name;
#endif
            if (t.IsPrimitive)
            {
                //Boolean, Byte, SByte, Int16, UInt16, Int32, UInt32, Int64, UInt64, IntPtr, UIntPtr, Char, Double, and Single.
                stack.Pop();
                return CreateRandomPrimitive(t);
            }

            if (t == typeof(string))
            {
                var rs = Icatt.Security.SigningUtility.CreateRandomString(defaultStringLength, "ÓÍÚÉÖÏÜËÇÁÄÀÈÙÌÒÕÃÑóíúéöïüëçáäàèùìòõãñABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".ToCharArray());
                stack.Pop();
                return (name ?? "") + ":" + rs;
            }

            if (t == typeof(Guid))
            {
                stack.Pop();
                return Guid.NewGuid();
            }


            if (t == typeof(DateTime))
            {
                var min = DateTime.Now.AddYears(-150).ToBinary();
                var max = DateTime.Now.AddYears(150).ToBinary();
                var l = CreateRandomPrimitive(min, max);
                stack.Pop();
                return DateTime.FromBinary(l);
            }

            if (t == typeof(DateTimeOffset))
            {
                var min = DateTime.Now.AddYears(-150).ToBinary();
                var max = DateTime.Now.AddYears(150).ToBinary();
                var l = CreateRandomPrimitive(min, max);
                stack.Pop();
                return new DateTimeOffset(DateTime.FromBinary(l));
            }


            if (t.IsConstructedGenericType)
            {
                var gt = t.GetGenericTypeDefinition();
                if (gt == typeof(Nullable<>))
                {
                    var tp = t.GenericTypeArguments[0];
                    stack.Pop();
                    return CreateRandomRecord(tp, name, defaultStringLength,stack); //return a value for the nullable type
                }
            }

            var constructors = t.GetConstructors(BindingFlags.Public | BindingFlags.Instance | BindingFlags.DeclaredOnly);

            //take one with least parameters
            var constructor = constructors.OrderBy(c => c.GetParameters().Length).FirstOrDefault();

            if (constructor == null)
            {
                stack.Pop();
                return null;
            }


            var args = constructor.GetParameters();

            var argValues = new object[args.Length];
            for (int i = 0; i < args.Length; i++)
            {
                if (t.IsArray)
                {
                    //size array, default 2 in alle dimensies
                    argValues[i] = _defaultArraySize;
                }
                else
                {
                    //Create a random parameter value
                    var pt = args[i].ParameterType;
                    argValues[i] = CreateRandomRecord(pt, args[i].Name, defaultStringLength,stack);
                }
            }

            //fallback for structs
            if (t.IsValueType)
            {
                //creates default(T)
                stack.Pop();
                return Activator.CreateInstance(t);
            }


            //create object
            var record = constructor.Invoke(argValues);

            if (t.IsArray)
            {
                //fill values of array
                for (int i = 0; i < 2; i++)
                {
                    var setMethod = t.GetMethods(BindingFlags.Public | BindingFlags.Instance).SingleOrDefault(m => m.Name.Equals("Set") && m.GetParameters().Length == 2);
                    setMethod?.Invoke(record, new[] { i, CreateRandomRecord(t.GetElementType(), null, defaultStringLength,stack) });
                }
                stack.Pop();
                return record;
            }

            if (t.GetMethod("Add") != null || t.IsInstanceOfType(typeof(IList<>) ))
            {

                var addMethod = t.GetMethod("Add");
                var addParams = addMethod.GetParameters();

                var addParamValues = new object[addParams.Length];

                //Add 2 records 
                for (int s = 0; s < 2; s++)
                {
                    for (int i = 0; i < addParams.Length; i++)
                    {
                        addParamValues[i] = CreateRandomRecord(addParams[i].ParameterType, addParams[i].Name, defaultStringLength,stack);
                    }

                    addMethod.Invoke(record, addParamValues);
                }

                stack.Pop();
                return record;

            }


            //set all properties with public setters
            foreach (var propertyInfo in t.GetProperties(BindingFlags.Public | BindingFlags.Instance).Where(p => p.CanWrite && (p.Name != "Capacity" || !typeof(IList).IsAssignableFrom(t))))
            {
                var value = CreateRandomRecord(propertyInfo.PropertyType, propertyInfo.Name, defaultStringLength,stack);
                propertyInfo.SetValue(record, value);
            }
            stack.Pop();
            return record;


        }

        private static int _defaultArraySize { get; set; } = 2;

        /// <summary>
        /// Default Primitive type limits user by randomizer
        /// </summary>
        private static readonly PrimitiveTypeLimits Dptl = new PrimitiveTypeLimits();


        public static object CreateRandomPrimitive(Type t, object min = null, object max = null)
        {
            if (min != null && t != min.GetType()) throw new ArgumentException($"Minimum value must be of type provided by parameter {nameof(t)}", nameof(min));
            if (max != null && t != max.GetType()) throw new ArgumentException($"Maximum value must be of type provided by parameter {nameof(t)}", nameof(max));

            if (t == typeof(bool))
            {
                return Rand.Next(0, 1) > 0;
            }
            if (t == typeof(byte))
            {
                min = min ?? Dptl.Min<byte>();
                max = max ?? Dptl.Max<byte>();
                return Rand.Next((byte)min, (byte)max);
            }
            if (t == typeof(sbyte))
            {
                min = min ?? Dptl.Min<sbyte>();
                max = max ?? Dptl.Max<sbyte>();
                return Rand.Next((sbyte)min, (sbyte)max);
            }
            if (t == typeof(short))
            {
                min = min ?? Dptl.Min<short>();
                max = max ?? Dptl.Max<short>();
                return Rand.Next((short)min, (short)max);
            }
            if (t == typeof(ushort))
            {
                min = min ?? Dptl.Min<ushort>();
                max = max ?? Dptl.Max<ushort>();
                return Rand.Next((ushort)min, (ushort)max);
            }
            if (t == typeof(int))
            {
                min = min ?? Dptl.Min<int>();
                max = max ?? Dptl.Max<int>();
                return Rand.Next((int)min, (int)max);
            }
            if (t == typeof(uint))
            {
                min = min ?? Dptl.Min<uint>();
                max = max ?? Dptl.Max<uint>();
                var vmin = (uint)min;
                var vmax = (uint)max;
                var halfofrange = vmax / 2d - vmin / 2d;
                // ReSharper disable once ArrangeRedundantParentheses - haakjes om tussentijdse overflow error te vermijden
                return vmin + (uint)Math.Round((halfofrange * Rand.NextDouble()) * 2);
            }
            if (t == typeof(long))
            {
                min = min ?? Dptl.Min<long>();
                max = max ?? Dptl.Max<long>();
                var lmax = (long)max;
                var lmin = (long)min;
                var halfofrange = lmax / 2d - lmin / 2d;
                // ReSharper disable once ArrangeRedundantParentheses - haakjes om tussentijdse overflow error te vermijden
                var lv = lmin + (long)Math.Round((halfofrange * Rand.NextDouble()) * 2);
                return lv;
            }
            if (t == typeof(ulong))
            {
                min = min ?? Dptl.Min<ulong>();
                max = max ?? Dptl.Max<ulong>();
                var vmin = (ulong)min;
                var vmax = (ulong)max;
                var halfofrange = vmax / 2d - vmin / 2d;
                // ReSharper disable once ArrangeRedundantParentheses - haakjes om tussentijdse overflow error te vermijden
                return vmin + (ulong)Math.Round((halfofrange * Rand.NextDouble()) * 2);
            }
            if (t == typeof(IntPtr))
            {
                var vmin = ((IntPtr?)min)?.ToInt64() ?? Dptl.Min<long>();
                var vmax = ((IntPtr?)max)?.ToInt64() ?? Dptl.Max<long>();

                return new IntPtr(CreateRandomPrimitive(vmin, vmax));
            }
            if (t == typeof(UIntPtr))
            {
                var vmin = ((UIntPtr?)min)?.ToUInt64() ?? Dptl.Min<ulong>();
                var vmax = ((UIntPtr?)max)?.ToUInt64() ?? Dptl.Max<ulong>();
                return new UIntPtr(CreateRandomPrimitive(vmin, vmax));
            }
            if (t == typeof(char))
            {
                min = min ?? Dptl.Min<char>();
                max = max ?? Dptl.Max<long>();
                return Rand.Next((char)min, (char)max);
            }
            if (t == typeof(double))
            {
                min = min ?? Dptl.Min<double>();
                max = max ?? Dptl.Max<double>();
                var vmin = (double)min;
                var vmax = (double)max;
                var halfofrange = vmax / 2d - vmin / 2d;
                // ReSharper disable once ArrangeRedundantParentheses - haakjes om tussentijdse overflow error te vermijden
                return vmin + Math.Round((halfofrange * Rand.NextDouble()) * 2);
            }
            if (t == typeof(float))
            {
                min = min ?? Dptl.Min<float>();
                max = max ?? Dptl.Max<float>();
                var fmin = (float)min;
                var fmax = (float)max;
                var halfofrange = fmax / 2d - fmin / 2d;
                // ReSharper disable once ArrangeRedundantParentheses - haakjes om tussentijdse overflow error te vermijden
                return fmin + (long)Math.Round((halfofrange * Rand.NextDouble()) * 2);
            }

            throw new InvalidOperationException($"Primitiva value requested for type that is not a primitive type : {t.FullName}");

        }

        public static dynamic CreateRandomPrimitive<T>() where T : struct
        {
            var t = typeof(T);

            return CreateRandomPrimitive(t);

        }

        public static dynamic CreateRandomPrimitive<T>(T min, T max) where T : struct
        {
            var t = typeof(T);

            return CreateRandomPrimitive(t, min, max);

        }
    }
}
