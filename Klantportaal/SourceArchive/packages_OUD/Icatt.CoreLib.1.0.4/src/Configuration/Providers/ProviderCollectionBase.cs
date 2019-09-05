using System;
using System.Configuration.Provider;
using System.Linq;

namespace Icatt.Configuration.Providers{

	/// <summary>
	/// Generic baseclasse for strong typed providercollections. SHOULE BE MOVED TO GENERAL Icatt lib assembly
	/// </summary>
	/// <typeparam name="T"></typeparam>
	/// <remarks></remarks>
	public class ProviderCollectionBase<T> : ProviderCollection where T:ProviderBase {
		//TODO MOVE TO GENERAL Icatt lib
		#region "Properties"
		new public T this[string name]{
			get { return (T) base[name]; }
		}
		#endregion

		#region "Methods"
		public override void Add(ProviderBase provider) {
			if (provider==null)throw new ArgumentNullException("provider");
			if (!(provider is T)) throw new ArgumentException(String.Format("The provider type is invalid. It should be of type '{0}' or derive from that type, but the actual type is '{1}'.",typeof(T).FullName,provider.GetType().FullName),"provider");
			base.Add(provider);
		}

		public void CopyTo(T[] array,int index) 
        {
			CopyTo(array.OfType<ProviderBase>().ToArray(),index);
		}

		#endregion

	}
}