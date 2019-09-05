using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.ServiceModel
{


    public interface IProxyFactory<TContext> where TContext : class
    {
        IService CreateProxy<IService>(TContext context) where IService : class;

        IFactoryContainer<TContext> FactoryContainer { get; set; }

    }
}
