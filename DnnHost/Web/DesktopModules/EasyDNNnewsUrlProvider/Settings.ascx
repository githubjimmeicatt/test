<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Settings.ascx.cs" Inherits="EasyDNNSolutions.Modules.EasyDNNNewsUrlProvider.Settings" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>

<style type="text/css">
	.auto-style1 {
		width: 100%;
	}

	.auto-style2 {
		width: 423px;
	}
	.auto-style3 {
		width: 423px;
		height: 30px;
	}
	.auto-style4 {
		height: 30px;
	}
	.auto-style5 {
		width: 423px;
		height: 23px;
	}
	.auto-style6 {
		height: 23px;
	}
</style>
<div class="dnnFormItem">
	<table class="auto-style1">
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblArticleUrlPath" runat="server" Text="Article URL path:" /></td>
			<td>
				<asp:TextBox ID="tbArticleUrlPath" runat="server" />
				<asp:RegularExpressionValidator ID="revArticlePath" runat="server" ControlToValidate="tbArticleUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblCategoryUrlPath" runat="server" Text="Category URL path:" /></td>
			<td>
				<asp:TextBox ID="tbCategoryUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvCategoryPath" runat="server" ControlToValidate="tbCategoryUrlPath" ErrorMessage="Please enter category url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revCategoryPath" runat="server" ControlToValidate="tbCategoryUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style3">
				<asp:Label ID="lblTagUrlPath" runat="server" Text="Tag URL path:" /></td>
			<td class="auto-style4">
				<asp:TextBox ID="tbTagUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvTagUrlPath" runat="server" ControlToValidate="tbTagUrlPath" ErrorMessage="Please enter tag url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revTagPath" runat="server" ControlToValidate="tbTagUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblDateUrlPath" runat="server" Text="Date URL path:" /></td>
			<td>
				<asp:TextBox ID="tbDateUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvDateUrlPath" runat="server" ControlToValidate="tbDateUrlPath" ErrorMessage="Please enter date url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revDagPath" runat="server" ControlToValidate="tbDateUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblArchiveTitlePath" runat="server" Text="Archive URL path:" /></td>
			<td>
				<asp:TextBox ID="tbArchiveUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvArchiveUrlPath" runat="server" ControlToValidate="tbArchiveUrlPath" ErrorMessage="Please enter archive url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revArchivePath" runat="server" ControlToValidate="tbArchiveUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblArchiveByYearTitlePath" runat="server" Text="Yearly archive URL path:" /></td>
			<td>
				<asp:TextBox ID="tbArchiveByYearUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvArchiveByYearUrlPath" runat="server" ControlToValidate="tbArchiveByYearUrlPath" ErrorMessage="Please enter yearly archive url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revArchiveByYearPath" runat="server" ControlToValidate="tbArchiveByYearUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator></td>
		</tr>
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblAuthorTitlePath" runat="server" Text="Author URL path:" /></td>
			<td>
				<asp:TextBox ID="tbAuthorUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvAuthorUrlPath" runat="server" ControlToValidate="tbAuthorUrlPath" ErrorMessage="Please enter author url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revAuthorPath" runat="server" ControlToValidate="tbAuthorUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style3">
				<asp:Label ID="lblAuthorGroupTitlePath" runat="server" Text="Author group URL path:" /></td>
			<td class="auto-style4">
				<asp:TextBox ID="tbAuthorGroupUrlPath" runat="server" />
				<asp:RequiredFieldValidator ID="rfvAuthorGroupUrlPath" runat="server" ControlToValidate="tbAuthorGroupUrlPath" ErrorMessage="Please enter author group url path." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revAuthorGroupPath" runat="server" ControlToValidate="tbAuthorGroupUrlPath" Display="Dynamic" ErrorMessage="Please enter valid url path." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style2">
				<asp:Label ID="lblPageIDRewrite" runat="server" Text="PageID rewrite string:" /></td>
			<td>
				<asp:TextBox ID="tbPageIDRewrite" runat="server" />
				<asp:RequiredFieldValidator ID="rfvPageIDRewrite" runat="server" ControlToValidate="tbPageIDRewrite" ErrorMessage="Please enter text." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revPageIDRewrite" runat="server" ControlToValidate="tbPageIDRewrite" Display="Dynamic" ErrorMessage="Please enter valid query string." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
				<tr>
			<td class="auto-style2">
				<asp:Label ID="lblPgrIDRewrite" runat="server" Text="PgrID rewrite string:" /></td>
			<td>
				<asp:TextBox ID="tbPgrIDRewrite" runat="server" />
				<asp:RequiredFieldValidator ID="rfvPgrIDRewrite" runat="server" ControlToValidate="tbPgrIDRewrite" ErrorMessage="Please enter text." Display="Dynamic"></asp:RequiredFieldValidator>
				<asp:RegularExpressionValidator ID="revPgrIDRewrite" runat="server" ControlToValidate="tbPgrIDRewrite" Display="Dynamic" ErrorMessage="Please enter valid query string." SetFocusOnError="True" ValidationExpression="[\w-]+(/[\w- .?%&amp;=]*)?"></asp:RegularExpressionValidator>
			</td>
		</tr>
		<tr>
			<td class="auto-style5">
				<asp:Label ID="lblRewritePagerLinks" runat="server" Text="Rewrite pager links:" /></td>
			<td class="auto-style6">
				<asp:CheckBox ID="cbRewritePagerLinks" runat="server" />
			</td>
		</tr>
				<tr>
			<td class="auto-style5">
				<asp:Label ID="lblEnableUrlRewritter" runat="server" Text="Enable EasyDNNnewsUrlProvider:" /></td>
			<td class="auto-style6">
				<asp:CheckBox ID="cbEnableUrlProvider" runat="server" />
			</td>
		</tr>
	</table>
</div>

