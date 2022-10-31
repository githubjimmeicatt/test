using System;
using Icatt.Heartcore.Umbraco.Shared;

namespace Icatt.Heartcore.Umbraco.LikesComments
{
    public class Comment : HeartcoreComponent
    {
        public Comment(): base("comment")
        {

        }

        public string Usercontent { get; set; }
        public DateTimeOffset Date { get; private set; } = DateTimeOffset.UtcNow;
        public string UserId { get; set; }
        public string UserFullName { get; set; }
    }
}
