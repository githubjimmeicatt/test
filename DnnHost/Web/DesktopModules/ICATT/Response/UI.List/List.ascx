<%@ Control language="vb" autoeventwireup="false" codebehind="List.ascx.vb" inherits="Icatt.DotNetNuke.Modules.Response.UI.List.List" %>
<%@ Import namespace="Icatt.DotNetNuke.Modules.Response.Business" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke" %>
<div id="divContainer" runat="server" class="responseListControlContainer" visible="<%# (me.Responselist IsNot Nothing) %>">
	<asp:Panel id="pnlConfigurationMessage" runat="server" cssclass="configMessage">
		<asp:Literal id="ltrlConfigMessageHtml" runat="server" text="<%# me.localizedString(LocalizedStringKey.ConfigurationMessageHtml) %>" />
	</asp:Panel>
	<asp:Repeater id="rptResponseList" runat="server">
		<HeaderTemplate>
			<asp:Panel id="pnlTitle" runat="server" cssclass="controlHeader" visible="<%# (Me.NrOfResponses > 0) %>">
				<div class="newsExtra">
				    <div id="divNrOfResponses" runat="server" class="aantalReacties">
					   <span class="right"><%#String.Format(Me.localizedString(LocalizedStringKey.NumberOfResponses), Me.NrOfResponses)%></span></div>
				    </div>
				    <!--<div id="divTitle" runat="server" class="title">
					    <%#Me.localizedString(LocalizedStringKey.Title)%>
				    </div>-->
			</asp:Panel>
			<asp:Panel id="pnlTitleNoResponses" runat="server" cssclass="noresponseHeader" visible="<%# Me.NrOfResponses = 0 %>">
				<asp:Label id="lblNoResponseTitle" runat="server" text="<%# me.localizedString(LocalizedStringKey.NoResponses) %>" /></asp:Panel>
			<!-- start list -->
			
		</HeaderTemplate>
		<SeparatorTemplate>
		</SeparatorTemplate>
		<ItemTemplate>
			<div class="reacties">
				<div class="edit" runat="server" visible="<%# isEditable %>" >
					<asp:HyperLink ID="hlEdit" NavigateUrl='<%# EditURL(Container )%>' runat="server"><asp:Image ID="imgEdit" Runat="server" ImageUrl="~/images/edit.gif" AlternateText="Edit" resourcekey="imgEdit"/></asp:HyperLink>&nbsp;
					<dnn:CommandButton OnCommand="deleteResponse"  CommandName="delete" CommandArgument='<%#Eval("ResponseId") %>' ID="cmdDelete" runat="server" CssClass="CommandButton" ImageUrl="~/images/delete.gif" CausesValidation="False" /></div>
				<div class="content">
					<asp:Literal id="ltrlResponse" runat="server" text="<%# DirectCast(Container.DataItem,ResponseInfo).ResponseText %>" /></div>
				<div class="reactieDetail">
					<asp:Literal id="ltrlFooter" runat="server" text="<%# constructFooterString(Container) %>" /><asp:HyperLink id="hlProfile" runat="server" navigateurl='<%# getProfileUrl(Container.DataItem) %>' text='<%# Eval("UserName") %>' visible='<%# Not String.IsNullOrEmpty(DataBinder.Eval(Container.DataItem,"UserName")) %>' />
				</div>
			</div>
		</ItemTemplate>
		<FooterTemplate>
			<!-- end list -->
			<div class="pageNav">
				<asp:Repeater id="rptPageNav" runat="server" datasource="<%# me.pageList %>" visible="<%# me.pagecount > 1 %>">
					<HeaderTemplate>
					</HeaderTemplate>
					<ItemTemplate>
						<a id="lnkPage" runat="server" href="<%# getPageUrl(Container.DataItem)  %>" visible="<%# (DirectCast(Container.DataItem,Int32) <> me.currentpage) %>"><%#(DirectCast(Container.DataItem, Int32)).ToString()%></a>
						<asp:label id="lblCurrentPage" runat="server" cssclass="current" visible='<%# (DirectCast(Container.DataItem,Int32) = me.currentpage) %>'><%#(DirectCast(Container.DataItem, Int32)).ToString%></asp:label></ItemTemplate>
					<SeparatorTemplate>
						&nbsp;</SeparatorTemplate>
					<FooterTemplate>
					</FooterTemplate>
				</asp:Repeater>
			</div>
		</FooterTemplate>
	</asp:Repeater>
</div>
