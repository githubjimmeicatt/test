using Sphdhv.KlantPortaal.Host.WebHost.Environment.KlantPortaal;

namespace Icatt.Membership.Access.User.ServiceTest
{
    public class UserAccessTestProxyFactory<TContext> : Icatt.ServiceModel.ProxyFactoryBase<KlantPortaalContext> where TContext : class
    {

            public override IContract CreateProxy<IContract>(KlantPortaalContext context)
    {

        var type = typeof(IContract);


      

        return null;
    }
}
}
