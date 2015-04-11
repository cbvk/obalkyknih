using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ScannerClient_obalkyknih
{
    /// <summary>
    /// Exception of Z39.50 or X-Server
    /// </summary>
    [Serializable]
    public class Z39Exception : Exception
    {
        public Z39Exception(string errorMessage)
            : base(string.Format("Chyba: {0}", errorMessage))
        {
        }
    }
}
