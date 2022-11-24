using System;
using System.Collections.Generic;

namespace Icatt.Heartcore.Umbraco.Menu
{
    public class FooterItem
    {
        public FooterItem(Guid id, string href, string title, IReadOnlyList<FooterItem> children)
        {
            Id = id;
            Href = href ?? throw new ArgumentNullException(nameof(href));
            Title = title ?? throw new ArgumentNullException(nameof(title));
            Children = children ?? throw new ArgumentNullException(nameof(children));
        }

        public Guid Id { get; }
        public string Href { get; }
        public string Title { get; }
        public IReadOnlyList<FooterItem> Children { get; }
    }
}
