using System;
using System.Collections.Generic;

namespace Icatt.Heartcore.Umbraco
{

    internal class GraphQlQueryRequest
    {
        public GraphQlQueryRequest(string query)
        {
            Query = query ?? throw new ArgumentNullException(nameof(query));
        }

        public string OperationName { get; set; }
        public Dictionary<string, string> Variables { get; set; } = new();
        public string Query { get; }
    }
}
