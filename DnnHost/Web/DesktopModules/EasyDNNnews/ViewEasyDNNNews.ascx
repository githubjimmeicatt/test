<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.ViewEasyDNNNews, App_Web_vieweasydnnnews.ascx.d988a5ac" autoeventwireup="true" enableviewstate="true" %>

<script type="text/javascript">
	/*<![CDATA[*/
	<%=includeRegistrationDatePickerJS%>
	<%=includeLightBoxJs%>
	<%=includeGetNewsArticlesJS%>
	<%=includeCommentArticlesJS%>
	<%=includePrintJS%>
	<%=includeRegistrationCusotmFieldsJS%>
	<%=includePaymentCalculationJS%>
	<%=includeContactFormInitJs%>
	<%=includeGoogleRecaptchJs%>
	<%=includeContactAuthorAgreementValidationJs%>
	<%=includeArticleVotingJS%>

	eds3_5_jq(function ($) {
		if (typeof edn_fluidvids != 'undefined')
			edn_fluidvids.init({
				selector: ['.edn_fluidVideo iframe'],
				players: ['www.youtube.com', 'player.vimeo.com']
			});
		<%=includeedNewsOnePageInit%>
		<%=includeedsCommentsInit%>
		<%=includeOpenEventRegistrationModalBox%>

	});
	/*]]>*/
</script>
<%=includeAddThisJS%>
<asp:Literal ID="countfacebookJS" runat="server" EnableViewState="false" />

<div class="<%=MainDivClass%>">
	<p id="themeDeveloperModeActive" runat="server" enableviewstate="false" visible="false" class="eds_themeDeveloperModeActive"><span id="themeDeveloperModeActiveText" runat="server"></span></p>

	<asp:Panel ID="pnlUserDashBoard" runat="server" Visible="false" CssClass="user_dashboard edn_userDashboard" EnableViewState="false">
		<asp:HyperLink ID="lbAddArticles" runat="server" Visible="false" EnableViewState="false" CssClass="add_article"><%=Localization.GetString("lbAddArticles.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbArticleEditor" runat="server" Visible="false" EnableViewState="false" CssClass="article_manager"><%=Localization.GetString("lbArticleEditor.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbEventsManager" runat="server" Visible="false" EnableViewState="false" CssClass="event_manager"><%=Localization.GetString("lbEventsManager.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbApproveComments" runat="server" Visible="false" EnableViewState="false" CssClass="approve_comments"><%=Localization.GetString("lbApproveComments.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbCategoryEdit" runat="server" Visible="false" EnableViewState="false" CssClass="category_manager"><%=Localization.GetString("lbCategoryEdit.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbApproveRoles" runat="server" Visible="false" EnableViewState="false" CssClass="approve_articles"><%=Localization.GetString("lbApproveRoles.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbDashboard" runat="server" Visible="false" EnableViewState="false" CssClass="dashboard"><%=Localization.GetString("lbDashboard.Text", ControlResxFile)%></asp:HyperLink>
		<asp:HyperLink ID="lbModuleSettings" runat="server" Visible="false" EnableViewState="false" CssClass="settings"><%=Localization.GetString("lbDBSettings.Text", ControlResxFile)%></asp:HyperLink>
		<div runat="server" id="divThemeSelection" visible="false">
			<a class="themeSettings eds_openModal edn_OpenThemeSelector" data-moduleid="<%=ModuleId %>" data-portalid="<%=PortalId %>" data-tabid="<%=TabId %>" data-target-id='<%=string.Format("themeSelection{0}",ModuleId)%>' data-basepath="<%=basePath %>"><%=Localization.GetString("lbThemeSelection.Text", ControlResxFile)%></a>
		</div>
		<asp:HyperLink ID="lbAboutMe" runat="server" Visible="false" EnableViewState="false" CssClass="author_profile"><%=Localization.GetString("lbAboutMe.Text", ControlResxFile)%></asp:HyperLink>
	</asp:Panel>

	<asp:Panel ID="pnlListArticles" runat="server" EnableViewState="false">
		<asp:Literal ID="litSearchInfo" runat="server" EnableViewState="false" />
		<asp:Literal ID="litListContent" runat="server" EnableViewState="false" />
		<asp:Literal ID="litPaging" runat="server" EnableViewState="false" />
	</asp:Panel>

	<asp:Literal ID="liDynamicScrollingMarkup" runat="server" Visible="false" />

	<asp:Panel ID="pnlViewArticle" runat="server">
		<p runat="server" id="BreadCrumbs" class="bread_crumbs" visible="false">
			<%=GenerateArticleBreadCrumbs()%>
		</p>
		<%=EditLink("admin_action edit")%>
		<%--<asp:LinkButton ID="lbPublishArticle" CssClass="admin_action publish_article" OnClick="PublishArticle_Click" Visible="false" runat="server"><%=Localization.GetString("Publish.Text", ControlResxFile)%></asp:LinkButton>
		<asp:LinkButton ID="lbApproveArticle" CssClass="admin_action publish_article" OnClick="ApproveArticle_Click" Visible="false" runat="server"><%=Localization.GetString("Approve.Text", ControlResxFile)%></asp:LinkButton>--%>
		<%=GenerateArticleHtml("EDNHeader")%>
		<asp:UpdatePanel ID="upHeader" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<asp:GridView ID="gvHeaderArtPagging" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" AllowPaging="True" PageSize="1" BorderStyle="None" BorderWidth="0px" CellPadding="0" GridLines="None" ShowHeader="False" OnPageIndexChanging="GvHeaderArtPagging_PageIndexChanging"
					EnableViewState="false">
					<Columns>
						<asp:TemplateField HeaderText="Article" ShowHeader="False">
							<ItemTemplate>
								<%# Eval("Article") %>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<PagerStyle HorizontalAlign="Center" />
				</asp:GridView>
			</ContentTemplate>
		</asp:UpdatePanel>
		<asp:PlaceHolder ID="plTopGallery" runat="server" />
		<%=GenerateArticleHtml("EDNContentTop")%>
		<%=GenerateArticleHtml("EDNContent")%>
		<asp:UpdatePanel ID="upArticle" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<%=GenerateArticleHtml("EDNContent")%>
				<asp:GridView CssClass="gvContentTable" ID="gvArticlePagging" runat="server" EnableModelValidation="true" AutoGenerateColumns="false" AllowPaging="true" PageSize="1" BorderStyle="None" BorderWidth="0px" CellPadding="0" GridLines="None" OnPageIndexChanging="GvArticlePagging_PageIndexChanging"
					ShowHeader="false" EnableViewState="false">
					<Columns>
						<asp:TemplateField HeaderText="Article" ShowHeader="False">
							<ItemTemplate>
								<%# Eval("Article") %>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<PagerSettings Mode="NumericFirstLast" />
					<PagerStyle HorizontalAlign="Center" CssClass="article_pagination" />
				</asp:GridView>
			</ContentTemplate>
		</asp:UpdatePanel>
		<%=GenerateArticleHtml("EDNContentBottom")%>
		<asp:PlaceHolder ID="plBottomGallery" runat="server" />
		<%=GenerateArticleHtml("EDNFooter")%>
		<asp:Panel ID="pnlArticelImagesGallery" runat="server" CssClass="edn_article_gallery">
			<ul>
				<asp:Repeater ID="repArticleImages" runat="server" EnableViewState="false">
					<ItemTemplate>
						<li>
							<a href='<%#Eval("FileName")%>' rel="ednSmbLight" data-smbdata='<%#Eval("SmbData")%>'>
								<asp:Image alt='<%#Eval("Title")%>' ID="imgArticleGalleryImage" ImageUrl='<%#Eval("Thumburl")%>' runat="server" /></a>
							</a>
						</li>
					</ItemTemplate>
				</asp:Repeater>
			</ul>
		</asp:Panel>
		<%=EditLink("admin_action edit")%>
		<asp:HiddenField ID="hfRate" runat="server" />
		<script type="text/javascript">
			// <![CDATA[
			eds3_5_jq(function ($) {
				var isArticleRated = false;
				if (!<%=DisableApplicationCookies.ToString().ToLowerInvariant()%>)
					isArticleRated = $.cookie("<%=EDNViewArticleID%>");
				var $rate_it = $(".EDN_article_rateit.M<%=ModuleId%>");

				$rate_it.bind('rated reset', function (e) {
					var ri = $(this),
						value = ri.rateit('value'),
						articleid = <%=publicOpenArticleID%>,
						portalId = <%=PortalId%>,
						moduleId = <%=ModuleId%>,
						tabId = <%=TabId%>;

					$rate_it.rateit('readonly', true);
					ri.rateit('readonly', true);

					if (!<%=DisableApplicationCookies.ToString().ToLowerInvariant()%>)
						$.cookie("<%=EDNViewArticleID%>", "true");

					document.getElementById("<%=hfRate.ClientID %>").value = value;

					$.ajax({
						url: "<%=_ControlPath%>ashx/RateArticle.ashx",
						type: "POST",
						cache: false,
						dataType: 'json',
						timeout: 15000,
						data: {
							portalId: portalId,
							moduleId: moduleId,
							tabId: tabId,
							articleid: articleid,
							ratingValue: value
						}
					})
						.done(function (response, status) {
							ri.siblings('.current_rating').text(response);
						})
						.fail(function () {
						})
						.always(function () {
						});
				})
					.rateit('value', document.getElementById("<%=hfRate.ClientID %>").value)
					.rateit('readonly', isArticleRated)
					.rateit('step', 1);

				$('#<%=upPanelComments.ClientID %>').on('click', '#<%=lbAddComment.ClientID %>', function () {
					var $lbAddComment = $('#<%=lbAddComment.ClientID %>'),
						noErrors = true,

						$authorNameInput = $('#<%=tbAddCommentName.ClientID %>'),
						$authorEmailInput = $('#<%=tbAddCommentEmail.ClientID %>'),
						$authorGDPRAgreement = $('#<%=cbShowCommentsGDPRComplianceAgreementRules.ClientID %>'),
						authorName,
						authorEmail,
						comment = $('#<%=tbAddComment.ClientID %>').val(),

						$noAuthorName = $('#<%=lblAddCommentNameError.ClientID %>'),
						$noAuthorEmail = $('#<%=lblAddCommentEmailError.ClientID %>'),
						$authorEmailNotValid = $('#<%=lblAddCommentEmailValid.ClientID %>'),
						$noComment = $('#<%=lblAddCommentError.ClientID %>'),
						$notValidCaptcha = $('#<%=lblCaptchaError.ClientID %>'),
						$noauthorGDPRAgreement = $('#<%=lblShowCommentsGDPRComplianceAgreementError.ClientID %>'),

						emailRegex = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;


					if ($lbAddComment.data('disable'))
						return false;

					if ($authorNameInput.length > 0) {
						authorName = $authorNameInput.val();

						$noAuthorName.css('display', 'none');

						if (authorName == '') {
							$noAuthorName.css('display', 'block');
							noErrors = false;
						}
					}

					if ($authorEmailInput.length > 0) {
						authorEmail = $authorEmailInput.val();

						$noAuthorEmail.css('display', 'none');
						$authorEmailNotValid.css('display', 'none');

						if (authorEmail == '') {
							$noAuthorEmail.css('display', 'block');
							noErrors = false;
						} else if (!emailRegex.test(authorEmail)) {
							$authorEmailNotValid.css('display', 'block');
							noErrors = false;
						}
					}

					if ($authorGDPRAgreement.length > 0) {
						$noauthorGDPRAgreement.css('display', 'none');
						if (!$authorGDPRAgreement[0].checked) {
							$noauthorGDPRAgreement.css('display', 'block');
							noErrors = false;
						}
					}

					if ($('#<%=pnlCommentsCaptcha.ClientID%>').length > 0) {
						var commentsCaptchaResponse = grecaptcha.getResponse(window.eds_commentsform_captchaId);
						if (commentsCaptchaResponse.length == 0) {
							$('#<%=hfCommentsFormCaptchaResponse.ClientID%>').val('');
							$notValidCaptcha.css('display', 'block');
							noErrors = false;
						}
						else {
							$('#<%=hfCommentsFormCaptchaResponse.ClientID%>').val(commentsCaptchaResponse);
							$notValidCaptcha.css('display', 'none');
						}
					}

					if (comment == '') {
						$noComment.css('display', 'block');
						noErrors = false;
					} else
						$noComment.css('display', 'none');

					if (noErrors)
						$lbAddComment.data('disable', true);
					else
						return false;
				});
			});
			//*/ ]]>
		</script>
		<asp:UpdatePanel ID="upPanelComments" runat="server" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<asp:Panel ID="pnlComments" runat="server" CssClass="article_comments" Visible="false">
					<span id='<%=Localization.GetString("CommentsAnchor.Text", ControlResxFile)%>'></span>
					<asp:Literal ID="numberOfCommentsHTML" runat="server" />
					<asp:DataList ID="dlComments" runat="server" DataKeyField="CommentID" OnItemCommand="DlComments_ItemCommand" CssClass="comment_list" RepeatLayout="Flow" EnableViewState="false">
						<ItemTemplate>
							<div id="c<%#Eval("CommentID")%>" class="comment level<%#NestedCommentClass(Eval("ReplayLevel"))%>">
								<asp:Panel ID="pnlCommentRating" runat="server" CssClass="votes" Visible='<%#ShowCommentsRatingascx && !Convert.ToBoolean(Eval("IsDeleted"))%>'>
									<div>
										<asp:ImageButton ID="imgBGoodVotes" runat="server" AlternateText="Up vote" aria-label="Up vote" ImageUrl='~/DesktopModules/EasyDNNNews/images/upvote.png' CommandArgument="<%# ((DataListItem) Container).ItemIndex %>" CommandName="GoodVote" />
										<asp:Label ID="lblGoodVotes" runat="server" Text='<%#Eval("GoodVotes")%>' />
									</div>
									<div>
										<asp:ImageButton ID="imgBBadVotes" runat="server" AlternateText="Down vote" aria-label="Down vote" ImageUrl="~/DesktopModules/EasyDNNNews/images/downvote.png" CommandArgument="<%# ((DataListItem) Container).ItemIndex %>" CommandName="BadVote" />
										<asp:Label ID="lblBadVotes" runat="server" Text='<%#Eval("BadVotes")%>' />
									</div>
								</asp:Panel>
								<div class="right_side">
									<%#DisplayComments(Eval("CommentID"),Eval("CommentersEmail"),Eval("ArticleID"),Eval("UserID"),Eval("AnonymName"),Eval("Comment"),Eval("DateAdded"), Eval("GoodVotes"),Eval("BadVotes"),Eval("Approved"),Eval("CommentersEmail"),Eval("PortalID"),Eval("IsDeleted")) %>
									<div class="actions">
										<asp:LinkButton ID="lbReplayToComment" CssClass="reply" runat="server" OnClientClick="setFocusComment();" Text='<%#lbReplayToCommentloc%>' CommandName="ReplayToCommet" CommandArgument='<%#Eval("CommentID")%>' Visible='<%#DisplayReplayTo && !Convert.ToBoolean(Eval("IsDeleted"))%>' />
										<asp:LinkButton ID="lbDeleteComment" CssClass="delete" OnClientClick='<%#CommentDeleteConfirm%>' runat="server" Text='<%#lbDeleteCommentLoc%>' CommandName="DeleteComment" CommandArgument='<%#Eval("CommentID")%>' Visible='<%#IsComentModerator() && !Convert.ToBoolean(Eval("IsDeleted"))%>' />
										<asp:LinkButton ID="lbEditComment" CssClass="edit" runat="server" Text='<%#lbEditCommentLoc%>' CommandName="EditComment" CommandArgument='<%#Eval("CommentID")%>' Visible='<%#IsComentModerator() && !Convert.ToBoolean(Eval("IsDeleted"))%>' />
									</div>
									<asp:HiddenField ID="hfCommentID" Value='<%#Eval("CommentID")%>' runat="server" />
								</div>
								<asp:Panel ID="pnlEditComments" runat="server" Visible="false" CssClass="edit_comment">
									<asp:TextBox ID="tbEditComment" Text='<%#Eval("Comment")%>' runat="server" TextMode="MultiLine" />
									<div class="actions">
										<asp:LinkButton ID="lbUpdateComment" runat="server" CommandArgument='<%#Eval("CommentID")%>' CommandName="UpdateComment" Text='<%#lbUpdateCommentLoc%>' />
										<asp:LinkButton ID="lbCancelUpdateComment" runat="server" CommandArgument='<%#Eval("CommentID")%>' CommandName="CancelEdit" Text='<%#lbCancelUpdateCommentLoc%>' />
									</div>
								</asp:Panel>
							</div>
						</ItemTemplate>
					</asp:DataList>
					<asp:Panel ID="pnlAddComments" runat="server" CssClass="add_comment">
						<h3>
							<%=LeaveAComment%></h3>
						<div class="add_article_box">
							<asp:Panel ID="pnlReplayToComment" runat="server" CssClass="comment_info" Visible="false">
								<asp:Label ID="lblReplayToComment" runat="server" Text="" />
							</asp:Panel>
							<asp:Panel ID="pnlCommentsNameEmail" runat="server">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="left">
											<asp:Label ID="lblAddCommentName" runat="server" AssociatedControlID="tbAddCommentName" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbAddCommentName" runat="server" CssClass="text" MaxLength="50" ValidationGroup="vgAddArtComment" />
											<asp:Label ID="lblAddCommentNameError" runat="server" Text="Please enter your name." Style="color: red; display: none;" />
										</td>
									</tr>
									<tr>
										<td class="left">
											<asp:Label ID="lblAddCommentEmail" runat="server" AssociatedControlID="tbAddCommentEmail" />
										</td>
										<td class="right">
											<asp:TextBox ID="tbAddCommentEmail" runat="server" CssClass="text" MaxLength="50" ValidationGroup="vgAddArtComment" />
											<asp:Label ID="lblAddCommentEmailError" runat="server" Text="Please enter email." Style="color: red; display: none;" />
											<asp:Label ID="lblAddCommentEmailValid" runat="server" Text="Please enter valid email." Style="color: red; display: none;" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td class="left">
										<asp:Label ID="lblAddComment" runat="server" AssociatedControlID="tbAddComment" />
									</td>
									<td class="right">
										<asp:TextBox ID="tbAddComment" runat="server" TextMode="MultiLine" MaxLength="10000" ValidationGroup="vgAddArtComment" />
										<asp:Label ID="lblAddCommentError" runat="server" Text="Please enter comment." Style="color: red; display: none;" />
									</td>
								</tr>
								<tr runat="server" id="trShowCommentsGDPRComplianceAgreement" visible="false">
									<td class="left">
										<asp:CheckBox ID="cbShowCommentsGDPRComplianceAgreementRules" Text="I agree" runat="server" />
									</td>
									<td class="right">
										<asp:Label ID="lblShowCommentsGDPRComplianceAgreementRules" runat="server" Text="" />
										<asp:Label ID="lblShowCommentsGDPRComplianceAgreementError" runat="server" Text="You must read and accept this rules." Style="color: red; display: none;" />
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlCommentsCaptcha" runat="server" Visible="False">
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td class="left"></td>
										<td class="right">
											<div class="g-comments-recaptcha"></div>
											<asp:Label ID="lblCaptchaError" runat="server" ForeColor="Red" Style="color: red; display: none;" />
											<asp:HiddenField ID="hfCommentsFormCaptchaResponse" runat="server" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<table cellspacing="0" cellpadding="0">
								<tr>
									<td class="left"></td>
									<td class="right bottom">
										<asp:LinkButton ID="lbAddComment" runat="server" OnClick="AddComment_Click" CssClass="submit" ValidationGroup="vgAddArtComment"><span><%=AddComment%></span></asp:LinkButton>
									</td>
								</tr>
							</table>
						</div>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlCommentInfo" runat="server" CssClass="article_comments" Visible="false" EnableViewState="false" />
				<asp:HiddenField ID="hfReplayToComment" runat="server" />
			</ContentTemplate>
		</asp:UpdatePanel>
		<asp:Literal ID="socComments" runat="server" EnableViewState="False" Visible="False" />
		<%=GenerateArticleHtml("EDNBottom")%>
	</asp:Panel>
	<asp:Label ID="lblInfoMassage" runat="server" Style="font-weight: bold" EnableViewState="false" Visible="false" />
	<div id="themeSelectionWrapper" runat="server" visible="false">
		<div id="themeSelection<%=ModuleId %>" class="eds_modalWrapper eds_themeSettings eds_resizable">
			<div class="eds_modalContent eds_animated">
				<h3><%=Localization.GetString("lbThemeSelection.Text", ControlResxFile)%></h3>
				<div class="edn__contentLoading">
					<img src="<%=_ControlPath%>images/ajax-loader.gif" />
				</div>
				<div id="themeSelectionModal<%=ModuleId %>" class="edNews_adminTheme"></div>
			</div>
		</div>
	</div>
	<asp:Literal runat="server" ID="ltJavaScript"></asp:Literal>
</div>

<div id="pnlEventRegistrationForm" runat="server" class="eds_modalWrapper eds_resizable">
	<div class="eds_modalContent eds_animated">
		<asp:Literal runat="server" ID="liUserProfileLink" />
		<h3><%=Localization.GetString("RegistrationForm.Text", EventRegistrationResxFile)%></h3>
		<div>
			<div runat="server" id="pnlRegistrationForm">
				<asp:Panel ID="pnlEventRegistrationLogedInUser" runat="server">
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblFirstNameLogedInHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblFirstNameLogedIn" runat="server" ControlName="lblFirstNameLogedInValue" />
						</span>
						<asp:TextBox ID="lblFirstNameLogedInValue" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblLastNameLogedInHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblLastNameLogedIn" runat="server" ControlName="lblLastNameLogedInValue" />
						</span>
						<asp:TextBox ID="lblLastNameLogedInValue" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblEmailLogedInHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblEmailLogedIn" runat="server" ControlName="lblEmailLogedInValue" />
						</span>
						<asp:TextBox ID="lblEmailLogedInValue" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlEventRegistrationUnVerified" runat="server">
					<div class="eds_labelAndInput">
						<asp:Label ID="lblFirstName" runat="server" AssociatedControlID="tbxFirstName"><%=Localization.GetString("lbRegFirstName.Text", EventRegistrationResxFile)%></asp:Label>
						<asp:TextBox ID="tbxFirstName" runat="server" ValidationGroup="vgEventRegistration" MaxLength="50" CausesValidation="true"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="tbxFirstName" ErrorMessage="Required!" ValidationGroup="vgEventRegistration" Display="Dynamic" SetFocusOnError="True" />
					</div>
					<div class="eds_labelAndInput">
						<asp:Label ID="lblLastName" runat="server" AssociatedControlID="tbxLastName"><%=Localization.GetString("lbRegLastName.Text", EventRegistrationResxFile)%></asp:Label>
						<asp:TextBox ID="tbxLastName" runat="server" ValidationGroup="vgEventRegistration" MaxLength="50"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="tbxLastName" ErrorMessage="Required!" ValidationGroup="vgEventRegistration" Display="Dynamic" SetFocusOnError="True" />
					</div>
					<div class="eds_labelAndInput">
						<asp:Label ID="lblEmail" runat="server" AssociatedControlID="tbxEmail"><%=Localization.GetString("lbRegEmail.Text", EventRegistrationResxFile)%></asp:Label>
						<asp:TextBox ID="tbxEmail" runat="server" ValidationGroup="vgEventRegistration" MaxLength="256"></asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="tbxEmail" ErrorMessage="Required!" ValidationGroup="vgEventRegistration" Display="Dynamic" SetFocusOnError="True" />
						<asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="tbxEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationExpression="(?!.*\.\.)(^[^\.][^@\s]+@[^@\s]+\.[^@\s\.]+$)" ValidationGroup="vgEventRegistration" SetFocusOnError="True" />
					</div>
				</asp:Panel>

				<asp:Panel ID="pnlExtendedUserData" runat="server">
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblStreetHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblStreet" runat="server" ControlName="tbxStreet" />
						</span>
						<asp:TextBox ID="tbxStreet" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblCityHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblCity" runat="server" ControlName="tbxCity" />
						</span>
						<asp:TextBox ID="tbxCity" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblRegionHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblRegion" runat="server" ControlName="tbxRegion" />
						</span>
						<asp:TextBox ID="tbxRegion" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblCountryHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblCountry" runat="server" ControlName="tbxCountry" />
						</span>
						<asp:TextBox ID="tbxCountry" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblPostalCodeHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblPostalCode" runat="server" ControlName="tbxPostalCode" />
						</span>
						<asp:TextBox ID="tbxPostalCode" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
					<div class="eds_labelAndInput">
						<span class="edNews_tooltip">
							<span id="lblTelephoneHelp" class="edNews_tooltipContent" runat="server"></span>
							<asp:Label ID="lblTelephone" runat="server" ControlName="tbxTelephone" />
						</span>
						<asp:TextBox ID="tbxTelephone" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox>
					</div>
				</asp:Panel>

				<div class="eds_labelAndInput" runat="server" id="sectionNumberOfTickets">
					<asp:Label ID="lblNumberOfTickets" AssociatedControlID="tbxNumberOfTickets" runat="server"><%=Localization.GetString("lbRegNumberOfSeats.Text", EventRegistrationResxFile)%></asp:Label>
					<asp:TextBox ID="tbxNumberOfTickets" runat="server" MaxLength="4" Text="1" CausesValidation="True" ValidationGroup="vgEventRegistration" CssClass="eds_numberOfTickets"></asp:TextBox>
					<asp:RequiredFieldValidator ID="rfvNumberOfTickets" runat="server" ControlToValidate="tbxNumberOfTickets" ValidationGroup="vgEventRegistration" ErrorMessage="Required!" Display="Dynamic" SetFocusOnError="True" CssClass="edn_errorMessage" />
					<asp:CompareValidator ID="cvNumberOfTickets" runat="server" ControlToValidate="tbxNumberOfTickets" ValidationGroup="vgEventRegistration" ErrorMessage="Must be a number!" Operator="DataTypeCheck" Type="Integer" Display="Dynamic" SetFocusOnError="True" CssClass="edn_errorMessage" />
					<asp:RangeValidator ID="rvNumberOfTickets" runat="server" ControlToValidate="tbxNumberOfTickets" MinimumValue="1" MaximumValue="10" ValidationGroup="vgEventRegistration" CssClass="edn_errorMessage" Type="Integer" SetFocusOnError="True" ErrorMessage="Number of tickets out of range!" />
				</div>
				<asp:UpdatePanel ID="upEventRegistration" runat="server" UpdateMode="Always" OnUnload="UpdatePanel_Unload">
					<ContentTemplate>
						<asp:PlaceHolder ID="phCustomFields" runat="server" Visible="false">
							<asp:HiddenField runat="server" ID="hfParenSelectedValue" />
							<asp:HiddenField runat="server" ID="hfLastSelectedIndexChanged" />
							<asp:HiddenField runat="server" ID="hfCFLastTriggerdByList" />
							<asp:HiddenField runat="server" ID="hfPreviousCFTemplateID" />
							<asp:HiddenField runat="server" ID="hfUploadFieldState" />
						</asp:PlaceHolder>
					</ContentTemplate>
				</asp:UpdatePanel>
				<div class="eds_labelAndInput" runat="server" id="sectionMessage">
					<asp:Label ID="lblMessage" AssociatedControlID="tbxMessage" runat="server"><%=Localization.GetString("lbRegAdditionalInformation.Text", EventRegistrationResxFile)%></asp:Label>
					<asp:TextBox ID="tbxMessage" runat="server" MaxLength="1024" TextMode="MultiLine" Rows="5"></asp:TextBox>
				</div>

				<asp:Literal ID="ltPriceData" runat="server"></asp:Literal>

				<asp:HiddenField ID="hfSelectedPayment" runat="server" />

				<div runat="server" id="divEventRegistrationCaptcha" class="eds_labelAndInput">
					<asp:Label ID="lblEventRegistrationCaptcha" runat="server"><%=Localization.GetString("lblEventRegistrationCaptcha.Text", EventRegistrationResxFile)%></asp:Label>
					<div class="g-eventregistration-recaptcha"></div>
					<asp:CustomValidator ID="cvEventRegistrationCaptcha" runat="server" ClientValidationFunction="eds_ValidateEventRegistrationCaptcha" Display="Dynamic" ErrorMessage="Please solve captcha." ValidationGroup="vgEventRegistration" />
					<asp:HiddenField ID="hfEventRegistrationCaptchaResponse" runat="server" />
				</div>

				<div class="eds_labelAndInput" runat="server" id="divEventRegistrationTermsAndConditionsAgreement">
					<script type="text/javascript">
						function validateEventRegistrationTermsAndConditionsAgreement(source, arguments) {
							if (eds3_5_jq('#<%=cbEventRegistrationTermsAndConditionsAgreement.ClientID%>')[0].checked) {
								arguments.IsValid = true; return true;
							}
							else {
								arguments.IsValid = false; return false;
							}
						}
					</script>
					<asp:CheckBox ID="cbEventRegistrationTermsAndConditionsAgreement" Text="" runat="server" />
					<asp:Label ID="lblEventRegistrationTermsAndConditionsAgreement" AssociatedControlID="cbEventRegistrationTermsAndConditionsAgreement" runat="server"></asp:Label>
					<asp:CustomValidator ID="cvEventRegistrationTermsAndConditionsAgreement" runat="server" ClientValidationFunction="validateEventRegistrationTermsAndConditionsAgreement" Display="Dynamic" ValidationGroup="vgEventRegistration"></asp:CustomValidator>
				</div>

				<div class="eds_labelAndInput" runat="server" id="divEventRegistrationEmailUseAgreement">
					<script type="text/javascript">
						function validateEventRegistrationEmailUseAgreement(source, arguments) {
							if (eds3_5_jq('#<%=cbEventRegistrationEmailUseAgreement.ClientID%>')[0].checked) {
								arguments.IsValid = true; return true;
							}
							else {
								arguments.IsValid = false; return false;
							}
						}
					</script>
					<asp:CheckBox ID="cbEventRegistrationEmailUseAgreement" Text="" runat="server" />
					<asp:Label ID="lblEventRegistrationEmailUseAgreement" AssociatedControlID="cbEventRegistrationEmailUseAgreement" runat="server"><%=Localization.GetString("lblEventRegistrationEmailUseAgreement.Text", EventRegistrationResxFile)%></asp:Label>
					<asp:CustomValidator ID="cvEventRegistrationEmailUseAgreement" runat="server" ClientValidationFunction="validateEventRegistrationEmailUseAgreement" Display="Dynamic" ValidationGroup="vgEventRegistration"></asp:CustomValidator>
				</div>

				<div class="edn_bottomButtonWrapper">
					<asp:Literal ID="liPayPalIcons" runat="server"></asp:Literal>
					<asp:ImageButton runat="server" CausesValidation="true" ID="imgBtnPayPal" title="PayPal check out" aria-label="PayPal check out" AlternateText="PayPalCheckout" ImageUrl="https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif" OnClick="RegisterEvent_Click" ValidationGroup="vgEventRegistration" />
					<asp:Button runat="server" CausesValidation="true" ID="btnRegisterEvent" Text="Register" OnClick="RegisterEvent_Click" ValidationGroup="vgEventRegistration" />
				</div>
			</div>
			<asp:Label ID="lblRegistrationInfo" runat="server" EnableViewState="false" CssClass="eds_infoMessages eds_info" Visible="false" />
			<asp:UpdateProgress ID="uppEventRegistration" runat="server" AssociatedUpdatePanelID="upEventRegistration" DisplayAfter="100" DynamicLayout="true">
				<ProgressTemplate>
					<div class="eds_eventRegistrationLoading">
					</div>
				</ProgressTemplate>
			</asp:UpdateProgress>
		</div>
		<span class="eds_modalClose eds_closeWindowButtonOuter" data-target-id='<%=pnlEventRegistrationForm.ClientID%>'>x</span>
	</div>
</div>

<asp:Panel ID="pnlContactForm" runat="server" Visible="False">
	<asp:HiddenField ID="hfContactFormID" runat="server" />
	<div class="eds_modalContent eds_animated">
		<h3>
			<asp:Label ID="lblContactFormTitle" runat="server" /></h3>
		<div>
			<asp:UpdatePanel ID="upContactForm" runat="server" UpdateMode="Always" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<asp:Panel ID="pnlContactFormMessageSent" runat="server" CssClass="eds_formStatus" Style="display: none">
						<asp:Label ID="lblMessageSent" runat="server" Text="Message sent." />
					</asp:Panel>
					<asp:Panel ID="pnlContactInputForm" runat="server">
						<div class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormYourName" runat="server" AssociatedControlID="tbContactFormYourName"></asp:Label>
							<asp:TextBox ID="tbContactFormYourName" runat="server" CssClass="text" Text="" />
							<asp:RequiredFieldValidator ID="rfvPleaseName" runat="server" ControlToValidate="tbContactFormYourName" ErrorMessage="Please enter your name." ValidationGroup="vgContactForm" Display="Dynamic" />
							<asp:CompareValidator ID="cvYourName" runat="server" ControlToValidate="tbContactFormYourName" Display="Dynamic" ErrorMessage="Please enter your name." Operator="NotEqual" ValidationGroup="vgContactForm" ValueToCompare="TEST"></asp:CompareValidator>
						</div>
						<div class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormYourEmail" runat="server" AssociatedControlID="tbContactFormYourEmail"></asp:Label>
							<asp:TextBox ID="tbContactFormYourEmail" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvPleaseEmail" runat="server" ControlToValidate="tbContactFormYourEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationGroup="vgContactForm" />
							<asp:RegularExpressionValidator ID="revValidEmail" runat="server" ControlToValidate="tbContactFormYourEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationGroup="vgContactForm" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
							<asp:CompareValidator ID="cvYourEmail" runat="server" ControlToValidate="tbContactFormYourEmail" Display="Dynamic" ErrorMessage="Please enter your email." Operator="NotEqual" ValidationGroup="vgContactForm" ValueToCompare="TEST"></asp:CompareValidator>
						</div>
						<div class="eds_labelAndInput eds_labelWidth100 eds_bigInput">
							<asp:Label ID="lblContactFormSubject" runat="server" AssociatedControlID="tbContactFormSubject"></asp:Label>
							<asp:TextBox ID="tbContactFormSubject" runat="server" Text="" CssClass="text" />
							<asp:RequiredFieldValidator ID="rfvPleaseSubject" runat="server" ControlToValidate="tbContactFormSubject" Display="Dynamic" ErrorMessage="Please enter a subject." ValidationGroup="vgContactForm" />
							<asp:CompareValidator ID="cvEmailSubject" runat="server" ControlToValidate="tbContactFormSubject" Display="Dynamic" ErrorMessage="Please enter a subject." Operator="NotEqual" ValidationGroup="vgContactForm" ValueToCompare="TEST"></asp:CompareValidator>
						</div>
						<div runat="server" id="divContactFormCompany" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCompany" runat="server" AssociatedControlID="tbContactFormCompany"></asp:Label>
							<asp:TextBox ID="tbContactFormCompany" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormCompany" runat="server" ControlToValidate="tbContactFormCompany" Display="Dynamic" ErrorMessage="Please enter company name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormStreet" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormStreet" runat="server" AssociatedControlID="tbContactFormStreet"></asp:Label>
							<asp:TextBox ID="tbContactFormStreet" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormStreet" runat="server" ControlToValidate="tbContactFormStreet" Display="Dynamic" ErrorMessage="Please enter street name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormCity" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCity" runat="server" AssociatedControlID="tbContactFormCity"></asp:Label>
							<asp:TextBox ID="tbContactFormCity" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormCity" runat="server" ControlToValidate="tbContactFormCity" Display="Dynamic" ErrorMessage="Please enter City name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormRegion" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormRegion" runat="server" AssociatedControlID="tbContactFormRegion"></asp:Label>
							<asp:TextBox ID="tbContactFormRegion" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormRegion" runat="server" ControlToValidate="tbContactFormRegion" Display="Dynamic" ErrorMessage="Please enter Region name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormCountry" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCountry" runat="server" AssociatedControlID="tbContactFormCountry"></asp:Label>
							<asp:TextBox ID="tbContactFormCountry" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormCountry" runat="server" ControlToValidate="tbContactFormCountry" Display="Dynamic" ErrorMessage="Please enter Country name." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormPostalCode" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormPostalCode" runat="server" AssociatedControlID="tbContactFormPostalCode"></asp:Label>
							<asp:TextBox ID="tbContactFormPostalCode" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormPostalCode" runat="server" ControlToValidate="tbContactFormPostalCode" Display="Dynamic" ErrorMessage="Please enter postal code." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormTelephone" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormTelephone" runat="server" AssociatedControlID="tbContactFormTelephone"></asp:Label>
							<asp:TextBox ID="tbContactFormTelephone" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormTelephone" runat="server" ControlToValidate="tbContactFormTelephone" Display="Dynamic" ErrorMessage="Please enter telephone." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormMobile" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormMobile" runat="server" AssociatedControlID="tbContactFormMobile"></asp:Label>
							<asp:TextBox ID="tbContactFormMobile" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormMobile" runat="server" ControlToValidate="tbContactFormMobile" Display="Dynamic" ErrorMessage="Please enter mobile number." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormWebsite" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormWebsite" runat="server" AssociatedControlID="tbContactFormWebsite"></asp:Label>
							<asp:TextBox ID="tbContactFormWebsite" CssClass="text" Text="" runat="server" />
							<asp:RequiredFieldValidator ID="rfvContactFormWebsite" runat="server" ControlToValidate="tbContactFormWebsite" Display="Dynamic" ErrorMessage="Please enter website url." ValidationGroup="vgContactForm" />
						</div>
						<div class="eds_labelAndInput eds_labelWidth100 eds_bigInput">
							<asp:Label ID="lblContactFormMessage" runat="server" AssociatedControlID="tbContactFormMessage"></asp:Label>
							<asp:TextBox ID="tbContactFormMessage" runat="server" CssClass="eds_bigerInput" TextMode="MultiLine" ValidationGroup="vgContactForm" />
							<asp:RequiredFieldValidator ID="rfvPleaseMessage" runat="server" ControlToValidate="tbContactFormMessage" Display="Dynamic" ErrorMessage="Please enter the message." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormTermsAndConditionsAgreement" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:CheckBox ID="cbContactFormTermsAndConditionsAgreement" Text="" runat="server" />
							<asp:Label ID="lblContactFormTermsAndConditionsAgreement" runat="server" AssociatedControlID="cbContactFormTermsAndConditionsAgreement"></asp:Label>
							<asp:CustomValidator ID="cvContactFormTermsAndConditionsAgreement" runat="server" ClientValidationFunction="validateContactFormTermsAndConditionsAgreement" Display="Dynamic" ErrorMessage="Please select if you agree." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormEmailUseAgreement" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:CheckBox ID="cbContactFormEmailUseAgreement" Text="" runat="server" />
							<asp:Label ID="lblContactFormEmailUseAgreement" runat="server" AssociatedControlID="cbContactFormEmailUseAgreement"></asp:Label>
							<asp:CustomValidator ID="cvContactFormEmailUseAgreement" runat="server" ClientValidationFunction="validateContactFormEmailUseAgreement" Display="Dynamic" ErrorMessage="Please select if you agree." ValidationGroup="vgContactForm" />
						</div>
						<div runat="server" id="divContactFormCaptcha" visible="false" class="eds_labelAndInput eds_labelWidth100">
							<asp:Label ID="lblContactFormCaptcha" runat="server"></asp:Label>
							<div class="g-contactform-recaptcha"></div>
							<asp:CustomValidator ID="cvContactFormCaptcha" runat="server" ClientValidationFunction="eds_ValidateContactFormCaptcha" Display="Dynamic" ErrorMessage="Please solve captcha." ValidationGroup="vgContactForm" />
							<asp:HiddenField ID="hfContactFormCaptchaResponse" runat="server" />
						</div>
						<div class="edn_bottomButtonWrapper">
							<asp:Button ID="btnSendContactEmail" runat="server" Text="Send" ValidationGroup="vgContactForm" CssClass="submit" OnClick="SendContactEmail_Click" />
						</div>
					</asp:Panel>
				</ContentTemplate>
			</asp:UpdatePanel>
			<asp:UpdateProgress ID="uppContactForm" runat="server" AssociatedUpdatePanelID="upContactForm" DisplayAfter="100" DynamicLayout="true">
				<ProgressTemplate>
					<div class="eds_eventRegistrationLoading">
					</div>
				</ProgressTemplate>
			</asp:UpdateProgress>
		</div>
		<span class="eds_modalClose eds_closeWindowButtonOuter" data-target-id='<%=pnlContactForm.ClientID%>'>x</span>
	</div>
</asp:Panel>

<asp:Literal ID="countdisqusJS" runat="server" EnableViewState="false" />