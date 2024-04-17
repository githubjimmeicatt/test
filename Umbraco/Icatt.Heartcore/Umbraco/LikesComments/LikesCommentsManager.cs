using System;
using System.Linq;
using System.Threading.Tasks;
using Ganss.Xss;
using Icatt.Heartcore.Umbraco.Shared;
using Umbraco.Headless.Client.Net.Management;

namespace Icatt.Heartcore.Umbraco.LikesComments
{
    public class LikesCommentsManager : ILikesCommentsManager
    {
        private const string CommentsProp = "comments";
        private const string LikesProp = "likes";

        private static readonly HtmlSanitizer s_sanitizer = new HtmlSanitizer( new HtmlSanitizerOptions() );
        private readonly IContentManagementService _contentManagement;

        public LikesCommentsManager(IContentManagementService contentManagement)
        {
            _contentManagement = contentManagement;
        }

        public async Task PostComment(PostCommentModel comment)
        {
            var sanitized = s_sanitizer.Sanitize(comment.Content);

            var list = await _contentManagement.Content.GetListAsync<Comment>(CommentsProp, comment.PageId);

            list.Add(new Comment
            {
                Usercontent = sanitized,
                UserId = comment.UserId,
                UserFullName = comment.UserFullName
            });

            await _contentManagement.Content.Update(list, true);
        }

        public async Task DeleteComment(DeleteCommentModel comment)
        {
            var list = await _contentManagement.Content.GetListAsync<Comment>(CommentsProp, comment.PageId);
            var match = list.FirstOrDefault(x => x.UserId == comment.UserId);
            if (match != null && list.Remove(match))
            {
                await _contentManagement.Content.Update(list);
            }
            //delete comment nu niet nodig, voor later
        }

        public async Task UpsertLike(UpsertLikeModel like)
        {
            var list = await _contentManagement.Content.GetListAsync<Like>(LikesProp, like.PageId);
            var match = list.FirstOrDefault(x => x.UserId == like.UserId);

            if (like.Value && match == null)
            {
                list.Add(new Like
                {
                    UserId = like.UserId,
                    UserFullName = like.UserFullName,
                });
                await _contentManagement.Content.Update(list);
            }

            else if (!like.Value && match != null && list.Remove(match))
            {
                await _contentManagement.Content.Update(list);
            }
        }
    }

    public class PostCommentModel
    {
        public Guid PageId { get; set; }
        public string UserId { get; set; }
        public string UserFullName { get; set; }
        public string Content { get; set; }
    }

    public class DeleteCommentModel
    {
        public Guid PageId { get; set; }
        public string UserId { get; set; }
    }

    public class UpsertLikeModel
    {
        public Guid PageId { get; set; }
        public string UserId { get; set; }
        public string UserFullName { get; set; }
        public bool Value { get; set; }
    }
}
