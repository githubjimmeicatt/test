namespace Icatt
{

    /// <summary>
    /// Creates a deep clone where all fields are alse deep cloned
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public interface IDeepCloneable<out T>
    {
        T CloneDeep();
    }
}