namespace Icatt.Test.Moq.Builders
{
    public class RouteValue
    {
        public string Key { get; private set; }
        public object Value { get; private set; }

        public RouteValue(string key, object value)
        {
            Key = key;
            Value = value;
        }
    }
}