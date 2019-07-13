using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace C_R_M.Controllers
{
    public class Seguridad
    {
        private static readonly byte[] Clave = SHA256.Create().ComputeHash(Encoding.Unicode.GetBytes("WzsMlG39tfCGuX2EQM3vq8CoqGAxC0nWjICls8Cno"));
        private static readonly byte[] IV = SHA256.Create().ComputeHash(Encoding.Unicode.GetBytes("b0dJN2c6cklVUX1qUGlFfGMweXRKbH5fSEMuXjAgfQo")).Take(16).ToArray();

        public static string Encripta(string Cadena)
        {

            byte[] inputBytes = Encoding.ASCII.GetBytes(Cadena);
            byte[] encripted;
            RijndaelManaged cripto = new RijndaelManaged
            {
                BlockSize = 128
            };
            using (MemoryStream ms = new MemoryStream(inputBytes.Length))
            {
                using (CryptoStream objCryptoStream = new CryptoStream(ms, cripto.CreateEncryptor(Clave, IV), CryptoStreamMode.Write))
                {
                    objCryptoStream.Write(inputBytes, 0, inputBytes.Length);
                    objCryptoStream.FlushFinalBlock();
                    objCryptoStream.Close();
                }
                encripted = ms.ToArray();
            }
            return Convert.ToBase64String(encripted);
        }



        public static string Desencripta(string Cadena)
        {
            byte[] inputBytes = Convert.FromBase64String(Cadena);
            byte[] resultBytes = new byte[inputBytes.Length];
            string textoLimpio = String.Empty;
            RijndaelManaged cripto = new RijndaelManaged
            {
                BlockSize = 128
            };
            using (MemoryStream ms = new MemoryStream(inputBytes))
            {
                using (CryptoStream objCryptoStream = new CryptoStream(ms, cripto.CreateDecryptor(Clave, IV), CryptoStreamMode.Read))
                {
                    using (StreamReader sr = new StreamReader(objCryptoStream, true))
                    {
                        textoLimpio = sr.ReadToEnd();
                    }
                }
            }
            return textoLimpio;
        }
    }
}