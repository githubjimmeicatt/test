using Icatt.ServiceModel;
using Sphdhv.KlantPortaal.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Icatt.Membership.Access.User.ServiceTest
{
    internal class DummyProxyFactory<TContext> : IProxyFactory<TContext> where TContext : class, IUserContext
    {
        Dictionary<Type, Func<TContext, object>> _mocks;

        public DummyProxyFactory(Dictionary<Type, Func<TContext, object>> mocks)
        {
            _mocks = mocks;
        }
        IFactoryContainer<TContext> IProxyFactory<TContext>.FactoryContainer { get; set; }

        IService IProxyFactory<TContext>.CreateProxy<IService>(TContext context)
        {
            var t = typeof(IService);
            if (_mocks.ContainsKey(t))
            {
                return _mocks[t](context) as IService;
            }

            throw new InvalidOperationException();
        }
    }

    internal class DummyContext : IUserContext
    {
        public string DossierNummer { get; set; }
        public string Bsn { get; set; }
        public string Ip { get; set; }
    }
}
