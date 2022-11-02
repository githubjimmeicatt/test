using System.Threading.Tasks;

namespace Icatt.Heartcore.Umbraco.LikesComments
{
    /// <summary>
    /// Biedt functionaliteit om likes en comments aan een pagina toe te voegen. Gaat uit van de volgende setup in Umbraco:
    /// - De pagina heeft een property "likes" van het type Nested Content, met daarbinnen een lijst objecten
    ///     * ContentTypeAlias = "like"
    ///     * UserId(TextBox)
    ///     * UserFullName(TextBox)
    /// - De pagina heeft een property "comments" van het type Nested Content, met daarbinnen een lijst objecten
    ///     * ContentTypeAlias = "comment"
    ///     * UserId(TextBox)
    ///     * UserFullName(TextBox)
    ///     * Date(Date Picker)
    ///     * Usercontent(TextArea)
    /// </summary>
    public interface ILikesCommentsManager
    {
        Task DeleteComment(DeleteCommentModel comment);
        Task PostComment(PostCommentModel comment);
        Task UpsertLike(UpsertLikeModel like);
    }
}
