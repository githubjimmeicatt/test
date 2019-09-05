<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.Dashboard, App_Web_dashboard.ascx.d988a5ac" %>
<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topActions">
			<li class="edNews_close">
				<asp:HyperLink runat="server" ID="hlPowerOff" resourcekey="lbPowerOffResource1"></asp:HyperLink>
			</li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<span><%=_("Dashboard")%></span>
		</div>
		<div class="sectionBox">
			<div class="edNews__selectMenuWrapper">
				<ul class="edNews__selectMenu edNews__dashBoard">
					<li class="edNews__AddArticle">
						<asp:HyperLink runat="server" ID="lbAddArticle"><span><%=_("lbAddArticleResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__ArticleList">
						<asp:HyperLink runat="server" ID="lbArticleList"><span><%=_("lbArticleListResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__EventsManager">
						<asp:HyperLink runat="server" ID="lbEventsManager"><span><%=_("lbEventsManager")%></span></asp:HyperLink>
					</li>
					<li class="edNews__CategoryManager">
						<asp:HyperLink runat="server" ID="lbCategoryManager"><span><%=_("lbCategoryManagerResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__ApproveArticles">
						<asp:HyperLink runat="server" ID="lbApproveArticles"><span><%=_("lbApproveArticlesResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__Comments">
						<asp:HyperLink runat="server" ID="lbComments"><span><%=_("lbCommentsResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__Tags">
						<asp:HyperLink runat="server" ID="lbTags"><span><%=_("lbTagsResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__Tokens">
						<asp:HyperLink runat="server" ID="lbTokens"><span><%=_("LinkButton2Resource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__TemplatesEditor">
						<asp:HyperLink runat="server" ID="hlTemplatesEditor"><span><%=_("hlTemplatesEditor")%></span></asp:HyperLink>
					</li>
					<li class="edNews__GalleryManager">
						<asp:HyperLink runat="server" ID="lbGalleryManager"><span><%=_("lbGalleryManagerResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__AuthorProfiles">
						<asp:HyperLink runat="server" ID="lbAuthorProfiles"><span><%=_("lbAuthorProfilesResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__RSSImport">
						<asp:HyperLink runat="server" ID="lbRSSImport"><span><%=_("lbRSSImportResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__Notifications">
						<asp:HyperLink runat="server" ID="lbNotifications" Visible="False"><span><%=_("lbNotifications")%></span></asp:HyperLink>
					</li>
					<li class="edNews__CustomFields">
						<asp:HyperLink runat="server" ID="lblCustomFields"><span><%=_("lblCustomFieldsResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__DataImportExport">
						<asp:HyperLink runat="server" ID="hlDataImportExport"><span><%=_("hlDataImportExport")%></span></asp:HyperLink>
					</li>
				</ul>
				<ul class="edNews__selectMenu edNews__dashBoard">
					<li class="edNews__ModuleSettings">
						<asp:HyperLink runat="server" ID="lbModuleSettings"><span><%=_("lbModuleSettingsResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__DefaultSettings">
						<asp:HyperLink runat="server" ID="lbDefaultSettings"><span><%=_("LinkButton1Resource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__GeneralSettings">
						<asp:HyperLink runat="server" ID="lbGeneralSettings"><span><%=_("lbGeneralSettingsResource1")%></span></asp:HyperLink>
					</li>
					<li class="edNews__CrossPortalSharing">
						<asp:HyperLink runat="server" ID="lbCrossPortalSharing" Visible="False"><span><%=_("lbCrossPortalSharing")%></span></asp:HyperLink>
					</li>
					<li class="edNews__ApiConnection">
						<asp:HyperLink runat="server" ID="lbApiConnection" Visible="False"><span><%=_("lbApiConnection")%></span></asp:HyperLink>
					</li>
				</ul>
			</div>
		</div>
	</div>
</div>
