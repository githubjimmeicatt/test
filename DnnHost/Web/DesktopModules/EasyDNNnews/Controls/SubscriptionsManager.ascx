<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.SubscriptionsManager, App_Web_subscriptionsmanager.ascx.b9f6810f" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<asp:Panel ID="pnlMainWrapper" runat="server">
	<div id="EDNadmin">
		<div class="module_action_title_box">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<h1>SUBSCRIPTIONS MANAGER</h1>
		</div>
		<div class="main_content gridview_content_manager article_manager">
			<asp:Panel ID="pnlAddMailSending" CssClass="section_box grey white_border_1" runat="server">
				<h1 class="section_box_title">
					<asp:Label ID="lblAddEditRSS" runat="server" Text="Add individual"></asp:Label>
				</h1>
				<div class="content">
					<div class="padded_wrapper">
						<div class="text_input_set">
						</div>
					</div>
				</div>
			</asp:Panel>
		</div>
	</div>
</asp:Panel>
<asp:Literal ID="generatedHtm" runat="server" Visible="False" />

