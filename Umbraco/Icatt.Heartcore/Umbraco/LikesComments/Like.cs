using Icatt.Heartcore.Umbraco.Shared;

namespace Icatt.Heartcore.Umbraco.LikesComments
{
    public class Like : HeartcoreComponent
    {
        public Like() : base("like")
        {

        }

        public string UserId { get; set; }
        public string UserFullName { get; set; }
    }
}
