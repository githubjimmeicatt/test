using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Globalization;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;

namespace Icatt.Security
{
    public static class SigningUtility
    {

        public const string DefaultSecret = "Elkj454Pkkd_ewr";

        public const string QuerystringSafeCharacterSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_|";
        public const string DefaultTimeFormat = "yyyyMMddHHmmss";
        public const string DefaultValueSeparator = "|";
        internal const string DefaultAesInitializationVector = "ZlwoiiTcChW8W6VC";



        /// <summary>
        /// Builds a string of length <paramref name="length"/> from charaters randomly selected from <paramref name="allowedCharacters"/>
        /// </summary>
        /// <param name="length"></param>
        /// <param name="allowedCharacters"></param>
        /// <returns></returns>
        public static string CreateRandomString(int length, char[] allowedCharacters)
        {
            if (length <= 0) throw new ArgumentOutOfRangeException("length", length, "Length should be greater then zero");
            if (allowedCharacters == null || allowedCharacters.Length == 0) throw new ArgumentNullException("allowedCharacters");

            var maxCollIndex = allowedCharacters.Length - 1;


            var rand = new ThreadSafeRandomizer();

            var sb = new StringBuilder(length);
            for (var i = 0; i < length; i++)
            {
                var charPos = rand.Next(0, maxCollIndex + 1);
                var chr = allowedCharacters[charPos];
                sb.Append(chr);
            }
            return sb.ToString();
        }

        /// <summary>
        /// Uses <see cref="QuerystringSafeCharacterSet"/> to produce a random set of charactes of length <paramref name="length"/>
        /// </summary>
        /// <param name="length"></param>
        /// <returns>The random set as a string</returns>
        public static string CreateRandomString(int length)
        {
            return CreateRandomString(length, QuerystringSafeCharacterSet.ToCharArray());
        }

        public static string BytesToBase64(byte[] input)
        {
            return Convert.ToBase64String(input, Base64FormattingOptions.None);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public static string BytesToHex(byte[] input)
        {
            var sb = new StringBuilder();
            foreach (var t in input)
            {
                sb.Append(t.ToString("x2"));
            }
            return sb.ToString();
        }

        public static SignatureValidator CreateValidator(NameValueCollection querystringOrFormParameters, string timeFormat = null, string secret = null)
        {
            return new SignatureValidator(querystringOrFormParameters, timeFormat, secret);
        }

        public static SignatureValidator CreateValidatorEncrypted(NameValueCollection querystringOrFormParameters, string sharedSecret, SupportedCipherSuite cipherSuite)
        {
            if (String.IsNullOrWhiteSpace(sharedSecret))
                throw new ArgumentNullException(nameof(sharedSecret));
            if (querystringOrFormParameters == null)
                throw new ArgumentNullException(nameof(querystringOrFormParameters));
            var utf8BitLen = Encoding.UTF8.GetBytes(sharedSecret).Length * 8;
            if (cipherSuite == SupportedCipherSuite.Aes && utf8BitLen != 256)
                throw new ArgumentException($"The length of the {nameof(sharedSecret)} key string MUST be 256 bits in UTF8 encoded format for the AES Cipher suite. Actual length in bits: {utf8BitLen}", nameof(sharedSecret));

            return new SignatureValidator(querystringOrFormParameters, sharedSecret, cipherSuite);
        }

        public static Signatory CreateSignatory(DateTime time, string timeFormat, params object[] values)
        {
            return new Signatory(null, null, time, timeFormat, values);
        }

        public static Signatory CreateSignatory(DateTime? time, string timeFormat, params object[] values)
        {
            return new Signatory(null, null, time, timeFormat, values);
        }

        public static Signatory CreateSignatory(string random, DateTime time, string timeFormat, params object[] values)
        {
            return new Signatory(null, random, time, timeFormat, values);
        }


        public static Signatory CreateSignatory(string separator, string random, DateTime time, string timeFormat, params object[] values)
        {
            return new Signatory(separator, random, time, timeFormat, values);
        }


        public static Signatory CreateSignatory(params object[] values)
        {
            return new Signatory(null, null, null, null, values);
        }


        #region new with secret

        public static Signatory CreateSignatoryWithSecret(string secret, DateTime time, string timeFormat, params object[] values)
        {
            return new Signatory(secret, null, null, time, timeFormat, values);
        }

        public static Signatory CreateSignatoryWithSecret(string secret, DateTime? time, string timeFormat, params object[] values)
        {
            return new Signatory(secret, null, null, time, timeFormat, values);
        }

        public static Signatory CreateSignatoryWithSecret(string secret, string random, DateTime time, string timeFormat, params object[] values)
        {
            return new Signatory(secret, null, random, time, timeFormat, values);
        }


        public static Signatory CreateSignatoryWithSecret(string secret, string separator, string random, DateTime time, string timeFormat, params object[] values)
        {
            return new Signatory(secret, separator, random, time, timeFormat, values);
        }


        public static Signatory CreateSignatoryWithSecret(string secret, params object[] values)
        {
            return new Signatory(secret, null, null, null, null, values);
        }

        public static Signatory CreateSignatoryForEncryption( string sharedSecret, SupportedCipherSuite cipherSuite, params object[] values)
        {
            if (string.IsNullOrWhiteSpace(sharedSecret))
                throw new ArgumentNullException(nameof(sharedSecret));
            var utf8BitLen = Encoding.UTF8.GetBytes(sharedSecret).Length * 8;
            if (cipherSuite == SupportedCipherSuite.Aes && utf8BitLen != 256)
                throw new ArgumentException($"The length of the {nameof(sharedSecret)} key string MUST be 256 bits in UTF8 encoded format for the AES Cipher suite. Actual length in bits: {utf8BitLen}", nameof(sharedSecret));

            return new Signatory(sharedSecret,null, null,null,null,cipherSuite,values);
        }

        #endregion

        #region nested types
        public enum SupportedCipherSuite
        {
            Aes
        }
        #endregion
    }


    /// <summary>
    /// 
    /// </summary>
    public class SignatureValidator
    {
        private readonly string _sepeartor = SigningUtility.DefaultValueSeparator;
        private readonly string _random;
        private readonly DateTime? _time;
        private readonly string _timeFormat;
        private readonly IEnumerable<string> _values;
        private readonly string _signature;
        private readonly string _secret;
        private readonly SigningUtility.SupportedCipherSuite _cipherSuite;


        internal SignatureValidator(NameValueCollection formParamsOrQuerystring, string secret, SigningUtility.SupportedCipherSuite cipherSuite) : this(formParamsOrQuerystring,null,secret,cipherSuite)
        {
        }

        //internal SignatureValidator(string sepeartor, string random, string timeValue, string timeFormat, IEnumerable<string> values)
        //{
        //    _timeFormat = null;
        //    _sepeartor = sepeartor ?? SigningUtility.DefaultValueSeparator;
        //    _random = random;
        //    _timeFormat = timeFormat ?? SigningUtility.DefaultTimeFormat;

        //    DateTime time;
        //    if (DateTime.TryParseExact(timeValue, _timeFormat, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out time))
        //        _time = time;

        //    _values = values;
        //}


        internal SignatureValidator(NameValueCollection formParamsOrQuerystring, string timeFormat = null, string secret = null, SigningUtility.SupportedCipherSuite? cipherSuite = null )
        {
            if (cipherSuite.HasValue)
            {
                _cipherSuite = cipherSuite.Value;
            }

            _secret = secret ?? SigningUtility.DefaultSecret;
            _signature = formParamsOrQuerystring["s"];
            _random = formParamsOrQuerystring["r"];
            _timeFormat = timeFormat ?? SigningUtility.DefaultTimeFormat;

            var timeValue = formParamsOrQuerystring["d"];

            DateTime time;
            if (DateTime.TryParseExact(timeValue, _timeFormat, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out time))
                _time = time;


            var values = new List<string>();
            var nr = 1;
            string v;
            do
            {
                v = formParamsOrQuerystring["v" + nr];
                nr++;
                if (v != null)
                    values.Add(v);
            } while (v != null);
            _values = values;

        }


        public DateTime? Time
        {
            get { return _time; }
        }

        public IEnumerable<string> Values
        {
            get { return _values; }
        }

        public string Random
        {
            get { return _random; }
        }

        public string Signature
        {
            get { return _signature; }
        }

        public string Sepeartor
        {
            get { return _sepeartor; }
        }

        public string TimeFormat
        {
            get { return _timeFormat; }
        }

        public bool ValidateSignature()
        {
            var objArray = _values.Cast<object>().ToArray();

            var signatory = new Signatory(_secret, _sepeartor, _random, _time, _timeFormat, objArray);

            var signatureCheck = signatory.CreateSha512Signature();

            return signatureCheck.Equals(_signature, StringComparison.Ordinal);

        }

        public bool TryValidateEncryption(out DateTime time, out object[] values)
        {
            time = DateTime.MinValue;
            values = new object[] { };

            var base64Enc = _signature;

            var encrypte = Convert.FromBase64String(base64Enc);

            var decrypt = DecryptValues(_cipherSuite, encrypte);

            if (decrypt == null || decrypt.Length < 2)
                return false;

            //Ignore random value in encrypt[0]


            var timestring = decrypt[1] as string;

            if (!DateTime.TryParseExact(timestring, TimeFormat, CultureInfo.InvariantCulture, DateTimeStyles.AssumeLocal, out time))
            {
                return false;
            }

            values = decrypt.Skip(2).ToArray();

            return true;
        }

        private object[] DecryptValues(SigningUtility.SupportedCipherSuite cipherSuite, byte[] encrypted)
        {
            string json;
            switch (cipherSuite)
            {
                case SigningUtility.SupportedCipherSuite.Aes:
                    json = Encrypter.AesDecrypter(_secret, SigningUtility.DefaultAesInitializationVector, CipherMode.CBC, encrypted);
                    break;
                default:
                    throw new ArgumentException($"Unsupported cipher suite: {cipherSuite}", nameof(cipherSuite));
            }

            if (string.IsNullOrEmpty(json))
                return null;

            var ser = new JavaScriptSerializer();
            return ser.Deserialize<object[]>(json);
        }
    }

    public class Signatory
    {

        private readonly string _separator;
        private readonly string _random;
        private DateTime _time;
        private readonly string _timeFormat;
        private readonly IEnumerable<object> _values;
        private readonly string _secret;
        private readonly SigningUtility.SupportedCipherSuite? _cipherSuite;

        internal Signatory(string separator, string random, DateTime? time, string timeFormat, params object[] values) : this (null,separator,random,time,timeFormat,values)
        {
        }


        internal Signatory(string secret, string separator, string random, DateTime? time, string timeFormat, params object[] values) : this (secret,separator,random,time,timeFormat,null,values)
        {
        }

        internal Signatory(string secret, string separator, string random, DateTime? time, string timeFormat, SigningUtility.SupportedCipherSuite? cipherSuite, params object[] values)
        {
            _values = values;
            _secret = secret ?? SigningUtility.DefaultSecret;
            _cipherSuite = cipherSuite;
            _separator = separator ?? SigningUtility.DefaultValueSeparator;
            _random = random ?? SigningUtility.CreateRandomString(10);
            _time = time ?? DateTime.Now;
            _timeFormat = timeFormat ?? SigningUtility.DefaultTimeFormat;
        }


        /// <summary>
        /// Builds a querystring containing the random as 'r', time as 'd', and values as v1,v2,.. etc and the signature as 's' paramter
        /// </summary>
        /// <returns>query string with properly url escapaed paramter values. No & or ? prefixed. Caller must add proper prefix</returns>
        public string BuildQuerystring()
        {
            //todo mapper specify queystring paramter names 

            var signature = CreateSha512Signature();


            var sb = new StringBuilder();
            sb
                .Append("r=")
                .Append(HttpUtility.UrlEncode(_random));

            sb.Append("&d=")
                .Append(HttpUtility.UrlEncode(_time.ToString(_timeFormat)));

            var count = 1;
            if (_values != null)
            {
                foreach (var value in _values)
                {
                    sb
                        .Append("&v" + count + "=")
                        .Append(HttpUtility.UrlEncode(value.ToString()));
                    count++;
                }
            }

            sb
                .Append("&s=")
                .Append(HttpUtility.UrlEncode(signature));

            return sb.ToString();

        }

        public string CreateHashSeed()
        {
            var seedElements = new[] { _secret, _random, _time.ToString(_timeFormat) }.Union(_values.AsEnumerable());

            var hashSeed = seedElements.Aggregate("", (current, element) => current + (current.Length > 0 ? _separator : "") + element);

            return hashSeed;
        }

        public string CreateEncryptionSeed()
        {
            var list = new List<object>();
            list.Add(_random);
            list.Add(_time.ToString(_timeFormat));
            list.AddRange(_values);

            var sr = new JavaScriptSerializer();

            return sr.Serialize(list);
        }

        public string CreateSha512Signature(Encoding encoding = null)
        {
            encoding = encoding ?? Encoding.UTF8;

            var prov = new SHA512CryptoServiceProvider();

            var hashSeed = CreateHashSeed();

            var bytes = encoding.GetBytes(hashSeed);

            var hash = prov.ComputeHash(bytes);

            return SigningUtility.BytesToBase64(hash);

        }

        public string BuilEncryptedQuerystring()
        {
            if (!_cipherSuite.HasValue)
                throw new InvalidOperationException("Cannot create an encrypted querystring if not Cipher Suite is defined. Provide a Cipher Suite in the constructor of the Signatory");

            var encryptedValue = EncryptValues(_cipherSuite.Value);

            var sb = new StringBuilder();
            sb
                .Append("s=")
                .Append(HttpUtility.UrlEncode(encryptedValue));


            return sb.ToString();
        }

        private string EncryptValues(SigningUtility.SupportedCipherSuite cipherSuite)
        {
            var seed = CreateEncryptionSeed();
            byte[] encr;

            switch (cipherSuite)
            {
                case SigningUtility.SupportedCipherSuite.Aes:
                    {
                        encr = Encrypter.AesEncrypter(_secret, SigningUtility.DefaultAesInitializationVector, CipherMode.CBC, seed);
                    }
                    break;
                default:
                    throw new ArgumentException($"Unsupported cipherSuite: {cipherSuite}", nameof(cipherSuite));
            }

            return SigningUtility.BytesToBase64(encr);
        }
    }
}
