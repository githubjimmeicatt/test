<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.Settings, App_Web_settings.ascx.c7240fce" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topLinks">
			<li><span><%=Localization.GetString("SettingsTitle", LocalResourceFile) %></span></li>
		</ul>
		<ul class="edNews_topActions">
			<li class="edNews_save"><asp:LinkButton runat="server" ID="btnSave" Text="Save" /></li>
			<li class="edNews_saveAndClose"><asp:LinkButton runat="server" ID="btnSaveAndClose" Text="Save and close" /></li>
			<li class="edNews_close"><asp:LinkButton runat="server" ID="btnClose" Text="Close" /></li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div class="edNews_adminWrapper edNews_widgets mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="contentWrapper">
			<div class="edMCP_selectMenuWrapper">
				<%=WidgetTypeMenuHtml %>
			</div>
		</div>
		<div class="edn_admin_progress_overlay_container">
			<asp:PlaceHolder ID="phTreeView" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phFilters" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phSubscriptions" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phSocialEvents" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phContentBlocks" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phLatestArticles" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phRecentComments" runat="server" Visible="false" />
			<asp:PlaceHolder ID="phMyEvents" runat="server" Visible="false" />
		</div>
	</div>
</div>
