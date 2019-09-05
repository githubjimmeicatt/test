using Icatt.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Sphdhv.Klantportaal.Audit
{
    public class LoggingLevelDataSource
    {
        
            public IEnumerable<ListItem> GetItems()
            {
                return
                    Enum.GetNames(typeof(LoggingLevel))
                        .Select(name => new { Name = name, Value = (int)Enum.Parse(typeof(LoggingLevel), name) })
                        .OrderBy(item => item.Value)
                        .Select(item => new ListItem(item.Name + " - " + item.Value, item.Value.ToString()));
            }
  
    }
}