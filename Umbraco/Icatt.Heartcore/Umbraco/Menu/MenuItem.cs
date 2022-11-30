using System;
using System.Collections.Generic;

namespace Icatt.Heartcore.Umbraco.Menu
{
    public class MenuItem
    {
        public MenuItem(Guid id, bool showInMenu, string href, string title, IReadOnlyList<MenuItem> children, string createDate, string updateDate, string contentTypeAlias)
        {
            Id = id;
            ShowInMenu = showInMenu;
            Href = href ?? throw new ArgumentNullException(nameof(href));
            Title = title ?? throw new ArgumentNullException(nameof(title));
            Children = children ?? Array.Empty<MenuItem>();
            CreateDate = createDate;
            UpdateDate = updateDate;
            ContentTypeAlias = contentTypeAlias;
        }

        public Guid Id { get; }
        public bool ShowInMenu { get; }
        public string Href { get; }
        public string Title { get; }
        public IReadOnlyList<MenuItem> Children { get; }
        public string CreateDate { get; }
        public string UpdateDate { get; }
        public string ContentTypeAlias { get; }
    }
}
