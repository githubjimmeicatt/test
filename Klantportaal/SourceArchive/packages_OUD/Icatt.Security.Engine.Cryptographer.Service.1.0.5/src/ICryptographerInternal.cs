using System;

namespace Icatt.Security.Engine.Cryptographer.Service
{
    internal interface ICryptographerInternal : IDisposable
    {
        byte[] Encrypt( byte[] key, byte[] value);

        byte[] Decrypt( byte[] key, byte[] encryptedValue);

        byte[] CreateKey();

    }
}