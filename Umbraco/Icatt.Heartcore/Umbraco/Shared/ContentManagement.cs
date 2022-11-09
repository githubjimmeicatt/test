using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json.Linq;
using Icatt.Heartcore.Umbraco.Shared;
using Umbraco.Headless.Client.Net.Management.Models;

namespace Umbraco.Headless.Client.Net.Management
{

    public class UmbracoList<T> : IReadOnlyCollection<T> where T : HeartcoreComponent
    {
        internal UmbracoList(Content content, string propertyName, Guid pageId)
        {
            if (string.IsNullOrWhiteSpace(propertyName))
            {
                throw new ArgumentException($"'{nameof(propertyName)}' cannot be null or whitespace.", nameof(propertyName));
            }

            if (pageId.Equals(Guid.Empty))
            {
                throw new ArgumentException($"'{nameof(pageId)}' cannot be empty.", nameof(pageId));
            }

            var value = content.GetValue(propertyName);

            JArray = value is JArray jArray ? jArray : new JArray();
            List = JArray.OfType<JObject>().Select(x => x.ToObject<T>()).ToList();
            Content = content;
            PropertyName = propertyName;
            PageId = pageId;
        }

        internal ICollection<T> List { get; }
        internal Content Content { get; }
        internal JArray JArray { get; }
        internal string PropertyName { get; }
        internal Guid PageId { get; }

        public int Count => List.Count;
        public IEnumerator<T> GetEnumerator() => List.GetEnumerator();
        IEnumerator IEnumerable.GetEnumerator() => List.GetEnumerator();

        public void Add(T t)
        {
            List.Add(t);
            JArray.Add(JObject.FromObject(t));
            Content.SetValue(PropertyName, JArray);
        }

        public bool Remove(T t)
        {
            var removedFromList = List.Remove(t);

            var match = JArray.OfType<JObject>().FirstOrDefault(x => x.TryGetValue("key", out var key) && key.Type == JTokenType.String && key.ToString() == t.Key);

            if (match == null) return false;

            var removedFromArray = JArray.Remove(match);
            if (removedFromArray)
            {
                Content.SetValue(PropertyName, JArray);
            }

            return removedFromList && removedFromArray;
        }
    }

    public static class ContentManagementExtensions
    {
        public static async Task<UmbracoList<T>> GetListAsync<T>(this IContentService contentService, string propertyName, Guid pageId) where T : HeartcoreComponent, new()
        {
            var content = await contentService.GetById(pageId);
            return new UmbracoList<T>(content, propertyName, pageId);
        }

        // DEZE HEEFT GEEN ASYNC IN DE NAAM ZODAT HET EEN OVERLOAD WORDT VAN DE GEWONE ContentService.Update
        /// <summary>
        /// Update an <see cref="UmbracoList{T}"/>
        /// </summary>
        /// <typeparam name="T">of type HeartcoreComponent</typeparam>
        /// <param name="list">the list to update</param>
        /// <param name="publish">Set to false if added content has to be checked by an editor before publishing</param>
        /// <returns></returns>
        public static async Task Update<T>(this IContentService contentService, UmbracoList<T> list, bool publish = true) where T : HeartcoreComponent
        {
            await contentService.Update(list.Content);

            if (publish)
            {
                _ = contentService.Publish(list.PageId);
            }
        }
    }
}
