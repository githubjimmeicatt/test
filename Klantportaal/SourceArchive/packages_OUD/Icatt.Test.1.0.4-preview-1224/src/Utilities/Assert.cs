using System;
using System.Globalization;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace Icatt.Test.Utilities
{

    /// <summary>
    /// Wraps the static <see cref="Assert">Assert</see> and adds some custom extensions />
    /// </summary>
    /// <remarks>
    /// <para>Wrapping code generated using Resharper by creating e IAssert private field 'temp' and Alt Inserting the Delegating members, then removing the private field 'temp' and renaming all 'temp' to 'Assert'.</para>
    /// <para>Inteded use: var assert = new AssertWrapper(); assert.[SomeExtensionOrDelegatingAssertMethod]() </para>
    /// <para>Motivation: Extensible alternative to the static Assert. Common extension point for additional assertions. Create the extensions methods specific for your test project in your test project</para>
    /// </remarks>
    public class AssertWrapper //: IAssert
    {
        #region Assert delegating members

        public void AreEqual(object expected, object actual)
        {
            Assert.AreEqual(expected, actual);
        }

        public void AreEqual(object expected, object actual, string message)
        {
            Assert.AreEqual(expected, actual, message);
        }

        public void AreEqual(float expected, float actual, float delta)
        {
            Assert.AreEqual(expected, actual, delta);
        }

        public void AreEqual(double expected, double actual, double delta)
        {
            Assert.AreEqual(expected, actual, delta);
        }

        public void AreEqual(string expected, string actual, bool ignoreCase)
        {
            Assert.AreEqual(expected, actual, ignoreCase);
        }

        public void AreEqual(object expected, object actual, string message, params object[] parameters)
        {
            Assert.AreEqual(expected, actual, message, parameters);
        }

        public void AreEqual(double expected, double actual, double delta, string message)
        {
            Assert.AreEqual(expected, actual, delta, message);
        }

        public void AreEqual(string expected, string actual, bool ignoreCase, CultureInfo culture)
        {
            Assert.AreEqual(expected, actual, ignoreCase, culture);
        }

        public void AreEqual(string expected, string actual, bool ignoreCase, string message)
        {
            Assert.AreEqual(expected, actual, ignoreCase, message);
        }

        public void AreEqual(float expected, float actual, float delta, string message)
        {
            Assert.AreEqual(expected, actual, delta, message);
        }

        public void AreEqual(string expected, string actual, bool ignoreCase, string message, params object[] parameters)
        {
            Assert.AreEqual(expected, actual, ignoreCase, message, parameters);
        }

        public void AreEqual(double expected, double actual, double delta, string message, params object[] parameters)
        {
            Assert.AreEqual(expected, actual, delta, message, parameters);
        }

        public void AreEqual(float expected, float actual, float delta, string message, params object[] parameters)
        {
            Assert.AreEqual(expected, actual, delta, message, parameters);
        }

        public void AreEqual(string expected, string actual, bool ignoreCase, CultureInfo culture, string message)
        {
            Assert.AreEqual(expected, actual, ignoreCase, culture, message);
        }

        public void AreEqual(string expected, string actual, bool ignoreCase, CultureInfo culture, string message,
            params object[] parameters)
        {
            Assert.AreEqual(expected, actual, ignoreCase, culture, message, parameters);
        }

        public void AreEqual<T>(T expected, T actual)
        {
            Assert.AreEqual(expected, actual);
        }

        public void AreEqual<T>(T expected, T actual, string message)
        {
            Assert.AreEqual(expected, actual, message);
        }

        public void AreEqual<T>(T expected, T actual, string message, params object[] parameters)
        {
            Assert.AreEqual(expected, actual, message, parameters);
        }

        public void AreNotEqual(object notExpected, object actual)
        {
            Assert.AreNotEqual(notExpected, actual);
        }

        public void AreNotEqual(double notExpected, double actual, double delta)
        {
            Assert.AreNotEqual(notExpected, actual, delta);
        }

        public void AreNotEqual(object notExpected, object actual, string message)
        {
            Assert.AreNotEqual(notExpected, actual, message);
        }

        public void AreNotEqual(string notExpected, string actual, bool ignoreCase)
        {
            Assert.AreNotEqual(notExpected, actual, ignoreCase);
        }

        public void AreNotEqual(float notExpected, float actual, float delta)
        {
            Assert.AreNotEqual(notExpected, actual, delta);
        }

        public void AreNotEqual(float notExpected, float actual, float delta, string message)
        {
            Assert.AreNotEqual(notExpected, actual, delta, message);
        }

        public void AreNotEqual(string notExpected, string actual, bool ignoreCase, CultureInfo culture)
        {
            Assert.AreNotEqual(notExpected, actual, ignoreCase, culture);
        }

        public void AreNotEqual(double notExpected, double actual, double delta, string message)
        {
            Assert.AreNotEqual(notExpected, actual, delta, message);
        }

        public void AreNotEqual(object notExpected, object actual, string message, params object[] parameters)
        {
            Assert.AreNotEqual(notExpected, actual, message, parameters);
        }

        public void AreNotEqual(string notExpected, string actual, bool ignoreCase, string message)
        {
            Assert.AreNotEqual(notExpected, actual, ignoreCase, message);
        }

        public void AreNotEqual(string notExpected, string actual, bool ignoreCase, string message, params object[] parameters)
        {
            Assert.AreNotEqual(notExpected, actual, ignoreCase, message, parameters);
        }

        public void AreNotEqual(float notExpected, float actual, float delta, string message, params object[] parameters)
        {
            Assert.AreNotEqual(notExpected, actual, delta, message, parameters);
        }

        public void AreNotEqual(double notExpected, double actual, double delta, string message, params object[] parameters)
        {
            Assert.AreNotEqual(notExpected, actual, delta, message, parameters);
        }

        public void AreNotEqual(string notExpected, string actual, bool ignoreCase, CultureInfo culture, string message)
        {
            Assert.AreNotEqual(notExpected, actual, ignoreCase, culture, message);
        }

        public void AreNotEqual(string notExpected, string actual, bool ignoreCase, CultureInfo culture, string message,
            params object[] parameters)
        {
            Assert.AreNotEqual(notExpected, actual, ignoreCase, culture, message, parameters);
        }

        public void AreNotEqual<T>(T notExpected, T actual)
        {
            Assert.AreNotEqual(notExpected, actual);
        }

        public void AreNotEqual<T>(T notExpected, T actual, string message)
        {
            Assert.AreNotEqual(notExpected, actual, message);
        }

        public void AreNotEqual<T>(T notExpected, T actual, string message, params object[] parameters)
        {
            Assert.AreNotEqual(notExpected, actual, message, parameters);
        }

        public void AreNotSame(object notExpected, object actual)
        {
            Assert.AreNotSame(notExpected, actual);
        }

        public void AreNotSame(object notExpected, object actual, string message)
        {
            Assert.AreNotSame(notExpected, actual, message);
        }

        public void AreNotSame(object notExpected, object actual, string message, params object[] parameters)
        {
            Assert.AreNotSame(notExpected, actual, message, parameters);
        }

        public void AreSame(object expected, object actual)
        {
            Assert.AreSame(expected, actual);
        }

        public void AreSame(object expected, object actual, string message)
        {
            Assert.AreSame(expected, actual, message);
        }

        public void AreSame(object expected, object actual, string message, params object[] parameters)
        {
            Assert.AreSame(expected, actual, message, parameters);
        }

        public new bool Equals(object objA, object objB)
        {
            return Assert.Equals(objA, objB);
        }

        public void Fail()
        {
            Assert.Fail();
        }

        public void Fail(string message)
        {
            Assert.Fail(message);
        }

        public void Fail(string message, params object[] parameters)
        {
            Assert.Fail(message, parameters);
        }

        public void Inconclusive()
        {
            Assert.Inconclusive();
        }

        public void Inconclusive(string message)
        {
            Assert.Inconclusive(message);
        }

        public void Inconclusive(string message, params object[] parameters)
        {
            Assert.Inconclusive(message, parameters);
        }

        public void IsFalse(bool condition)
        {
            Assert.IsFalse(condition);
        }

        public void IsFalse(bool condition, string message)
        {
            Assert.IsFalse(condition, message);
        }

        public void IsFalse(bool condition, string message, params object[] parameters)
        {
            Assert.IsFalse(condition, message, parameters);
        }

        public void IsInstanceOfType(object value, Type expectedType)
        {
            Assert.IsInstanceOfType(value, expectedType);
        }

        public void IsInstanceOfType(object value, Type expectedType, string message)
        {
            Assert.IsInstanceOfType(value, expectedType, message);
        }

        public void IsInstanceOfType(object value, Type expectedType, string message, params object[] parameters)
        {
            Assert.IsInstanceOfType(value, expectedType, message, parameters);
        }

        public void IsNotInstanceOfType(object value, Type wrongType)
        {
            Assert.IsNotInstanceOfType(value, wrongType);
        }

        public void IsNotInstanceOfType(object value, Type wrongType, string message)
        {
            Assert.IsNotInstanceOfType(value, wrongType, message);
        }

        public void IsNotInstanceOfType(object value, Type wrongType, string message, params object[] parameters)
        {
            Assert.IsNotInstanceOfType(value, wrongType, message, parameters);
        }

        public void IsNotNull(object value)
        {
            Assert.IsNotNull(value);
        }

        public void IsNotNull(object value, string message)
        {
            Assert.IsNotNull(value, message);
        }

        public void IsNotNull(object value, string message, params object[] parameters)
        {
            Assert.IsNotNull(value, message, parameters);
        }

        public void IsNull(object value)
        {
            Assert.IsNull(value);
        }

        public void IsNull(object value, string message)
        {
            Assert.IsNull(value, message);
        }

        public void IsNull(object value, string message, params object[] parameters)
        {
            Assert.IsNull(value, message, parameters);
        }

        public void IsTrue(bool condition)
        {
            Assert.IsTrue(condition);
        }

        public void IsTrue(bool condition, string message)
        {
            Assert.IsTrue(condition, message);
        }

        public void IsTrue(bool condition, string message, params object[] parameters)
        {
            Assert.IsTrue(condition, message, parameters);
        }

        public string ReplaceNullChars(string input)
        {
            return Assert.ReplaceNullChars(input);
        }

        #endregion

        #region Assert extensions

        public void ArraysAreEqual<T>(T[] expected, T[] actual)
        {
            if (expected == null) Assert.IsNull(actual);
            Assert.IsNotNull(actual);
            Assert.AreEqual(expected.Length, actual.Length);
            for (var i = 0; i < expected.Length; i++)
            {
                Assert.AreEqual(expected[i], actual[i]);
            }
        }

        public void ArraysAreNotEqual<T>(T[] expected, T[] actual) 
        {
            if (expected == null || actual == null)
            {
                var exp = expected == null ? "NULL" : expected.GetType().Name;
                var act = actual == null ? "NULL" : actual.GetType().Name;
                throw new AssertFailedException($"Null values can't be compared. Value 'expected': {exp}, Value 'actual': {act}. Check for null prior to assert");
            }

            if (expected.Length != actual.Length)
                return; //different length, so not equal

            for (var i = 0; i < expected.Length; i++)
            {
                try
                {
                    Assert.AreEqual(expected[i], actual[i]);
                }
                catch (AssertFailedException)
                {
                    //AreEqual failed, so arrays are not equal
                    return; 
                }

            }

            throw new AssertFailedException($"All elements of the arrays are equal");

        }



        #endregion

    }

    //Do not remove these comments without reading the motivation
    //Recreate this inteface if needed by enabling Resharper en pressing F12 on the Assert class

    ///// <summary>
    ///// Inerface created thru reflication static Microsoft.VisualStudio.TestTools.UnitTesting,Assert class and deleting the static and public keywords
    ///// </summary>
    //interface IAssert
    //{
    //    //
    //    // Summary:
    //    //     Verifies that two specified objects are equal. The assertion fails if the objects
    //    //     are not equal.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first object to compare. This is the object the unit test expects.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(object expected, object actual);
    //    //
    //    // Summary:
    //    //     Verifies that two specified objects are equal. The assertion fails if the objects
    //    //     are not equal. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first object to compare. This is the object the unit test expects.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(object expected, object actual, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified singles are equal, or within the specified accuracy
    //    //     of each other. The assertion fails if they are not within the specified accuracy
    //    //     of each other.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first single to compare. This is the single the unit test expects.
    //    //
    //    //   actual:
    //    //     The second single to compare. This is the single the unit test produced.
    //    //
    //    //   delta:
    //    //     The required accuracy. The assertion will fail only if expected is different
    //    //     from actual by more than delta.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(float expected, float actual, float delta);
    //    //
    //    // Summary:
    //    //     Verifies that two specified doubles are equal, or within the specified accuracy
    //    //     of each other. The assertion fails if they are not within the specified accuracy
    //    //     of each other.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first double to compare. This is the double the unit test expects.
    //    //
    //    //   actual:
    //    //     The second double to compare. This is the double the unit test produced.
    //    //
    //    //   delta:
    //    //     The required accuracy. The assertion will fail only if expected is different
    //    //     from actual by more than delta.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is different from actual by more than delta.
    //    void AreEqual(double expected, double actual, double delta);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are equal, ignoring case or not as specified.
    //    //     The assertion fails if they are not equal.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first string to compare. This is the string the unit test expects.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(string expected, string actual, bool ignoreCase);
    //    //
    //    // Summary:
    //    //     Verifies that two specified objects are equal. The assertion fails if the objects
    //    //     are not equal. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first object to compare. This is the object the unit test expects.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(object expected, object actual, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified doubles are equal, or within the specified accuracy
    //    //     of each other. The assertion fails if they are not within the specified accuracy
    //    //     of each other. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first double to compare. This is the double the unit test expects.
    //    //
    //    //   actual:
    //    //     The second double to compare. This is the double the unit test produced.
    //    //
    //    //   delta:
    //    //     The required accuracy. The assertion will fail only if expected is different
    //    //     from actual by more than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is different from actual by more than delta.
    //    void AreEqual(double expected, double actual, double delta, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are equal, ignoring case or not as specified,
    //    //     and using the culture info specified. The assertion fails if they are not equal.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first string to compare. This is the string the unit test expects.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   culture:
    //    //     A System.Globalization.CultureInfo object that supplies culture-specific comparison
    //    //     information.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(string expected, string actual, bool ignoreCase, CultureInfo culture);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are equal, ignoring case or not as specified.
    //    //     The assertion fails if they are not equal. Displays a message if the assertion
    //    //     fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first string to compare. This is the string the unit test expects.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(string expected, string actual, bool ignoreCase, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified singles are equal, or within the specified accuracy
    //    //     of each other. The assertion fails if they are not within the specified accuracy
    //    //     of each other. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first single to compare. This is the single the unit test expects.
    //    //
    //    //   actual:
    //    //     The second single to compare. This is the single the unit test produced.
    //    //
    //    //   delta:
    //    //     The required accuracy. The assertion will fail only if expected is different
    //    //     from actual by more than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(float expected, float actual, float delta, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are equal, ignoring case or not as specified.
    //    //     The assertion fails if they are not equal. Displays a message if the assertion
    //    //     fails, and applies the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first string to compare. This is the string the unit test expects.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(string expected, string actual, bool ignoreCase, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified doubles are equal, or within the specified accuracy
    //    //     of each other. The assertion fails if they are not within the specified accuracy
    //    //     of each other. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first double to compare. This is the double the unit tests expects.
    //    //
    //    //   actual:
    //    //     The second double to compare. This is the double the unit test produced.
    //    //
    //    //   delta:
    //    //     The required accuracy. The assertion will fail only if expected is different
    //    //     from actual by more than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is different from actual by more than delta.
    //    void AreEqual(double expected, double actual, double delta, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified singles are equal, or within the specified accuracy
    //    //     of each other. The assertion fails if they are not within the specified accuracy
    //    //     of each other. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first single to compare. This is the single the unit test expects.
    //    //
    //    //   actual:
    //    //     The second single to compare. This is the single the unit test produced.
    //    //
    //    //   delta:
    //    //     The required accuracy. The assertion will fail only if expected is different
    //    //     from actual by more than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is different from actual by more than delta.
    //    void AreEqual(float expected, float actual, float delta, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are equal, ignoring case or not as specified,
    //    //     and using the culture info specified. The assertion fails if they are not equal.
    //    //     Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first string to compare. This is the string the unit test expects.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   culture:
    //    //     A System.Globalization.CultureInfo object that supplies culture-specific comparison
    //    //     information.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(string expected, string actual, bool ignoreCase, CultureInfo culture, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are equal, ignoring case or not as specified,
    //    //     and using the culture info specified. The assertion fails if they are not equal.
    //    //     Displays a message if the assertion fails, and applies the specified formatting
    //    //     to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first string to compare. This is the string the unit test expects.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   culture:
    //    //     A System.Globalization.CultureInfo object that supplies culture-specific comparison
    //    //     information.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual(string expected, string actual, bool ignoreCase, CultureInfo culture, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified generic type data are equal by using the equality
    //    //     operator. The assertion fails if they are not equal.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first generic type data to compare. This is the generic type data the unit
    //    //     test expects.
    //    //
    //    //   actual:
    //    //     The second generic type data to compare. This is the generic type data the unit
    //    //     test produced.
    //    //
    //    // Type parameters:
    //    //   T:
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual<T>(T expected, T actual);
    //    //
    //    // Summary:
    //    //     Verifies that two specified generic type data are equal by using the equality
    //    //     operator. The assertion fails if they are not equal. Displays a message if the
    //    //     assertion fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first generic type data to compare. This is the generic type data the unit
    //    //     test expects.
    //    //
    //    //   actual:
    //    //     The second generic type data to compare. This is the generic type data the unit
    //    //     test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Type parameters:
    //    //   T:
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual<T>(T expected, T actual, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified generic type data are equal by using the equality
    //    //     operator. The assertion fails if they are not equal. Displays a message if the
    //    //     assertion fails, and applies the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first generic type data to compare. This is the generic type data the unit
    //    //     test expects.
    //    //
    //    //   actual:
    //    //     The second generic type data to compare. This is the generic type data the unit
    //    //     test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Type parameters:
    //    //   T:
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected is not equal to actual.
    //    void AreEqual<T>(T expected, T actual, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified objects are not equal. The assertion fails if the
    //    //     objects are equal.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first object to compare. This is the object the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(object notExpected, object actual);
    //    //
    //    // Summary:
    //    //     Verifies that two specified doubles are not equal, and not within the specified
    //    //     accuracy of each other. The assertion fails if they are equal or within the specified
    //    //     accuracy of each other.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first double to compare. This is the double the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second double to compare. This is the double the unit test produced.
    //    //
    //    //   delta:
    //    //     The required inaccuracy. The assertion fails only if notExpected is equal to
    //    //     actual or different from it by less than delta.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual or different from it by less than delta.
    //    void AreNotEqual(double notExpected, double actual, double delta);
    //    //
    //    // Summary:
    //    //     Verifies that two specified objects are not equal. The assertion fails if the
    //    //     objects are equal. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first object to compare. This is the object the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(object notExpected, object actual, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are not equal, ignoring case or not as specified.
    //    //     The assertion fails if they are equal.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first string to compare. This is the string the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(string notExpected, string actual, bool ignoreCase);
    //    //
    //    // Summary:
    //    //     Verifies that two specified singles are not equal, and not within the specified
    //    //     accuracy of each other. The assertion fails if they are equal or within the specified
    //    //     accuracy of each other.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first single to compare. This is the single the unit test expects.
    //    //
    //    //   actual:
    //    //     The second single to compare. This is the single the unit test produced.
    //    //
    //    //   delta:
    //    //     The required inaccuracy. The assertion will fail only if notExpected is equal
    //    //     to actual or different from it by less than delta.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual or different from it by less than delta.
    //    void AreNotEqual(float notExpected, float actual, float delta);
    //    //
    //    // Summary:
    //    //     Verifies that two specified singles are not equal, and not within the specified
    //    //     accuracy of each other. The assertion fails if they are equal or within the specified
    //    //     accuracy of each other. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first single to compare. This is the single the unit test expects.
    //    //
    //    //   actual:
    //    //     The second single to compare. This is the single the unit test produced.
    //    //
    //    //   delta:
    //    //     The required inaccuracy. The assertion will fail only if notExpected is equal
    //    //     to actual or different from it by less than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual or different from it by less than delta.
    //    void AreNotEqual(float notExpected, float actual, float delta, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are not equal, ignoring case or not as specified,
    //    //     and using the culture info specified. The assertion fails if they are equal.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first string to compare. This is the string the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   culture:
    //    //     A System.Globalization.CultureInfo object that supplies culture-specific comparison
    //    //     information.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(string notExpected, string actual, bool ignoreCase, CultureInfo culture);
    //    //
    //    // Summary:
    //    //     Verifies that two specified doubles are not equal, and not within the specified
    //    //     accuracy of each other. The assertion fails if they are equal or within the specified
    //    //     accuracy of each other. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first double to compare. This is the double the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second double to compare. This is the double the unit test produced.
    //    //
    //    //   delta:
    //    //     The required inaccuracy. The assertion fails only if notExpected is equal to
    //    //     actual or different from it by less than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual or different from it by less than delta.
    //    void AreNotEqual(double notExpected, double actual, double delta, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified objects are not equal. The assertion fails if the
    //    //     objects are equal. Displays a message if the assertion fails, and applies the
    //    //     specified formatting to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first object to compare. This is the object the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(object notExpected, object actual, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are not equal, ignoring case or not as specified.
    //    //     The assertion fails if they are equal. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first string to compare. This is the string the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(string notExpected, string actual, bool ignoreCase, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are not equal, ignoring case or not as specified.
    //    //     The assertion fails if they are equal. Displays a message if the assertion fails,
    //    //     and applies the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first string to compare. This is the string the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(string notExpected, string actual, bool ignoreCase, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified singles are not equal, and not within the specified
    //    //     accuracy of each other. The assertion fails if they are equal or within the specified
    //    //     accuracy of each other. Displays a message if the assertion fails, and applies
    //    //     the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first single to compare. This is the single the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second single to compare. This is the single the unit test produced.
    //    //
    //    //   delta:
    //    //     The required inaccuracy. The assertion will fail only if notExpected is equal
    //    //     to actual or different from it by less than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual or different from it by less than delta.
    //    void AreNotEqual(float notExpected, float actual, float delta, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified doubles are not equal, and not within the specified
    //    //     accuracy of each other. The assertion fails if they are equal or within the specified
    //    //     accuracy of each other. Displays a message if the assertion fails, and applies
    //    //     the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first double to compare. This is the double the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second double to compare. This is the double the unit test produced.
    //    //
    //    //   delta:
    //    //     The required inaccuracy. The assertion will fail only if notExpected is equal
    //    //     to actual or different from it by less than delta.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual or different from it by less than delta.
    //    void AreNotEqual(double notExpected, double actual, double delta, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are not equal, ignoring case or not as specified,
    //    //     and using the culture info specified. The assertion fails if they are equal.
    //    //     Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first string to compare. This is the string the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   culture:
    //    //     A System.Globalization.CultureInfo object that supplies culture-specific comparison
    //    //     information.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(string notExpected, string actual, bool ignoreCase, CultureInfo culture, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified strings are not equal, ignoring case or not as specified,
    //    //     and using the culture info specified. The assertion fails if they are equal.
    //    //     Displays a message if the assertion fails, and applies the specified formatting
    //    //     to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first string to compare. This is the string the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second string to compare. This is the string the unit test produced.
    //    //
    //    //   ignoreCase:
    //    //     A Boolean value that indicates a case-sensitive or insensitive comparison. true
    //    //     indicates a case-insensitive comparison.
    //    //
    //    //   culture:
    //    //     A System.Globalization.CultureInfo object that supplies culture-specific comparison
    //    //     information.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual(string notExpected, string actual, bool ignoreCase, CultureInfo culture, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified generic type data are not equal. The assertion fails
    //    //     if they are equal.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first generic type data to compare. This is the generic type data the unit
    //    //     test expects not to match actual.
    //    //
    //    //   actual:
    //    //     The second generic type data to compare. This is the generic type data the unit
    //    //     test produced.
    //    //
    //    // Type parameters:
    //    //   T:
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual<T>(T notExpected, T actual);
    //    //
    //    // Summary:
    //    //     Verifies that two specified generic type data are not equal. The assertion fails
    //    //     if they are equal. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first generic type data to compare. This is the generic type data the unit
    //    //     test expects not to match actual.
    //    //
    //    //   actual:
    //    //     The second generic type data to compare. This is the generic type data the unit
    //    //     test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Type parameters:
    //    //   T:
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual<T>(T notExpected, T actual, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified generic type data are not equal. The assertion fails
    //    //     if they are equal. Displays a message if the assertion fails, and applies the
    //    //     specified formatting to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first generic type data to compare. This is the generic type data the unit
    //    //     test expects not to match actual.
    //    //
    //    //   actual:
    //    //     The second generic type data to compare. This is the generic type data the unit
    //    //     test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Type parameters:
    //    //   T:
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected is equal to actual.
    //    void AreNotEqual<T>(T notExpected, T actual, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified object variables refer to different objects. The
    //    //     assertion fails if they refer to the same object.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first object to compare. This is the object the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected refers to the same object as actual.
    //    void AreNotSame(object notExpected, object actual);
    //    //
    //    // Summary:
    //    //     Verifies that two specified object variables refer to different objects. The
    //    //     assertion fails if they refer to the same object. Displays a message if the assertion
    //    //     fails.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first object to compare. This is the object the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected refers to the same object as actual.
    //    void AreNotSame(object notExpected, object actual, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified object variables refer to different objects. The
    //    //     assertion fails if they refer to the same object. Displays a message if the assertion
    //    //     fails, and applies the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   notExpected:
    //    //     The first object to compare. This is the object the unit test expects not to
    //    //     match actual.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     notExpected refers to the same object as actual.
    //    void AreNotSame(object notExpected, object actual, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that two specified object variables refer to the same object. The assertion
    //    //     fails if they refer to different objects.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first object to compare. This is the object the unit test expects.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected does not refer to the same object as actual.
    //    void AreSame(object expected, object actual);
    //    //
    //    // Summary:
    //    //     Verifies that two specified object variables refer to the same object. The assertion
    //    //     fails if they refer to different objects. Displays a message if the assertion
    //    //     fails.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first object to compare. This is the object the unit test expects.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected does not refer to the same object as actual.
    //    void AreSame(object expected, object actual, string message);
    //    //
    //    // Summary:
    //    //     Verifies that two specified object variables refer to the same object. The assertion
    //    //     fails if they refer to different objects. Displays a message if the assertion
    //    //     fails, and applies the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   expected:
    //    //     The first object to compare. This is the object the unit test expects.
    //    //
    //    //   actual:
    //    //     The second object to compare. This is the object the unit test produced.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     expected does not refer to the same object as actual.
    //    void AreSame(object expected, object actual, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Determines whether two objects are equal.
    //    //
    //    // Parameters:
    //    //   objA:
    //    //     An object that can be cast to an Microsoft.VisualStudio.TestTools.UnitTesting.Assert
    //    //     instance.
    //    //
    //    //   objB:
    //    //     An object that can be cast to an Microsoft.VisualStudio.TestTools.UnitTesting.Assert
    //    //     instance.
    //    bool Equals(object objA, object objB);
    //    //
    //    // Summary:
    //    //     Fails the assertion without checking any conditions.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     Always thrown.
    //    void Fail();
    //    //
    //    // Summary:
    //    //     Fails the assertion without checking any conditions. Displays a message.
    //    //
    //    // Parameters:
    //    //   message:
    //    //     A message to display. This message can be seen in the unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     Always thrown.
    //    void Fail(string message);
    //    //
    //    // Summary:
    //    //     Fails the assertion without checking any conditions. Displays a message, and
    //    //     applies the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   message:
    //    //     A message to display. This message can be seen in the unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     Always thrown.
    //    void Fail(string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Indicates that the assertion cannot be verified.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertInconclusiveException:
    //    //     Always thrown.
    //    void Inconclusive();
    //    //
    //    // Summary:
    //    //     Indicates that the assertion can not be verified. Displays a message.
    //    //
    //    // Parameters:
    //    //   message:
    //    //     A message to display. This message can be seen in the unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertInconclusiveException:
    //    //     Always thrown.
    //    void Inconclusive(string message);
    //    //
    //    // Summary:
    //    //     Indicates that an assertion can not be verified. Displays a message, and applies
    //    //     the specified formatting to it.
    //    //
    //    // Parameters:
    //    //   message:
    //    //     A message to display. This message can be seen in the unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertInconclusiveException:
    //    //     Always thrown.
    //    void Inconclusive(string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that the specified condition is false. The assertion fails if the condition
    //    //     is true.
    //    //
    //    // Parameters:
    //    //   condition:
    //    //     The condition to verify is false.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     condition evaluates to true.
    //    void IsFalse(bool condition);
    //    //
    //    // Summary:
    //    //     Verifies that the specified condition is false. The assertion fails if the condition
    //    //     is true. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   condition:
    //    //     The condition to verify is false.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     condition evaluates to true.
    //    void IsFalse(bool condition, string message);
    //    //
    //    // Summary:
    //    //     Verifies that the specified condition is false. The assertion fails if the condition
    //    //     is true. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   condition:
    //    //     The condition to verify is false.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     condition evaluates to true.
    //    void IsFalse(bool condition, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is an instance of the specified type. The
    //    //     assertion fails if the type is not found in the inheritance hierarchy of the
    //    //     object.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is of expectedType.
    //    //
    //    //   expectedType:
    //    //     The type expected to be found in the inheritance hierarchy of value.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is null or expectedType is not found in the inheritance hierarchy of value.
    //    void IsInstanceOfType(object value, Type expectedType);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is an instance of the specified type. The
    //    //     assertion fails if the type is not found in the inheritance hierarchy of the
    //    //     object. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is of expectedType.
    //    //
    //    //   expectedType:
    //    //     The type expected to be found in the inheritance hierarchy of value.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is null or expectedType is not found in the inheritance hierarchy of value.
    //    void IsInstanceOfType(object value, Type expectedType, string message);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is an instance of the specified type. The
    //    //     assertion fails if the type is not found in the inheritance hierarchy of the
    //    //     object. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is of expectedType.
    //    //
    //    //   expectedType:
    //    //     The type expected to be found in the inheritance hierarchy of value.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is null or expectedType is not found in the inheritance hierarchy of value.
    //    void IsInstanceOfType(object value, Type expectedType, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is not an instance of the specified type.
    //    //     The assertion fails if the type is found in the inheritance hierarchy of the
    //    //     object.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is not of wrongType.
    //    //
    //    //   wrongType:
    //    //     The type that should not be found in the inheritance hierarchy of value.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is not null and wrongType is found in the inheritance hierarchy of value.
    //    void IsNotInstanceOfType(object value, Type wrongType);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is not an instance of the specified type.
    //    //     The assertion fails if the type is found in the inheritance hierarchy of the
    //    //     object. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is not of wrongType.
    //    //
    //    //   wrongType:
    //    //     The type that should not be found in the inheritance hierarchy of value.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is not null and wrongType is found in the inheritance hierarchy of value.
    //    void IsNotInstanceOfType(object value, Type wrongType, string message);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is not an instance of the specified type.
    //    //     The assertion fails if the type is found in the inheritance hierarchy of the
    //    //     object. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is not of wrongType.
    //    //
    //    //   wrongType:
    //    //     The type that should not be found in the inheritance hierarchy of value.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is not null and wrongType is found in the inheritance hierarchy of value.
    //    void IsNotInstanceOfType(object value, Type wrongType, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is not null. The assertion fails if it is
    //    //     null.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is not null.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is null.
    //    void IsNotNull(object value);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is not null. The assertion fails if it is
    //    //     null. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is not null.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is null.
    //    void IsNotNull(object value, string message);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is not null. The assertion fails if it is
    //    //     null. Displays a message if the assertion fails, and applies the specified formatting
    //    //     to it.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is not null.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is null.
    //    void IsNotNull(object value, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is null. The assertion fails if it is not
    //    //     null.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is null.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is not null.
    //    void IsNull(object value);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is null. The assertion fails if it is not
    //    //     null. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is null.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is not null.
    //    void IsNull(object value, string message);
    //    //
    //    // Summary:
    //    //     Verifies that the specified object is null. The assertion fails if it is not
    //    //     null. Displays a message if the assertion fails, and applies the specified formatting
    //    //     to it.
    //    //
    //    // Parameters:
    //    //   value:
    //    //     The object to verify is null.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     value is not null.
    //    void IsNull(object value, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     Verifies that the specified condition is true. The assertion fails if the condition
    //    //     is false.
    //    //
    //    // Parameters:
    //    //   condition:
    //    //     The condition to verify is true.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     condition evaluates to false.
    //    void IsTrue(bool condition);
    //    //
    //    // Summary:
    //    //     Verifies that the specified condition is true. The assertion fails if the condition
    //    //     is false. Displays a message if the assertion fails.
    //    //
    //    // Parameters:
    //    //   condition:
    //    //     The condition to verify is true.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     condition evaluates to false.
    //    void IsTrue(bool condition, string message);
    //    //
    //    // Summary:
    //    //     Verifies that the specified condition is true. The assertion fails if the condition
    //    //     is false. Displays a message if the assertion fails, and applies the specified
    //    //     formatting to it.
    //    //
    //    // Parameters:
    //    //   condition:
    //    //     The condition to verify is true.
    //    //
    //    //   message:
    //    //     A message to display if the assertion fails. This message can be seen in the
    //    //     unit test results.
    //    //
    //    //   parameters:
    //    //     An array of parameters to use when formatting message.
    //    //
    //    // Exceptions:
    //    //   T:Microsoft.VisualStudio.TestTools.UnitTesting.AssertFailedException:
    //    //     condition evaluates to false.
    //    void IsTrue(bool condition, string message, params object[] parameters);
    //    //
    //    // Summary:
    //    //     In a string, replaces null characters ('\0') with "\\0".
    //    //
    //    // Parameters:
    //    //   input:
    //    //     The string in which to search for and replace null characters.
    //    //
    //    // Returns:
    //    //     The converted string with null characters replaced by "\\0".
    //    string ReplaceNullChars(string input);
    //}
}
