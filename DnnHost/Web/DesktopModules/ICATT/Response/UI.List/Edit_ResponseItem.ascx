<%@ Control language="vb" autoeventwireup="false" codebehind="Edit_ResponseItem.ascx.vb"
	inherits="Icatt.DotNetNuke.Modules.Response.UI.List.Edit_ResponseItem" %>
<%@ Register tagprefix="dnn" namespace="DotNetNuke.UI.WebControls" assembly="DotNetNuke" %>
<%@ Register tagprefix="dnn" tagname="Label" src="~/controls/LabelControl.ascx" %>
<div class="editResponseItemContainer">
	<table cellspacing="0" cellpadding="2" border="0" summary="ModuleName Settings Design Table">
		<tr>
			<td width="100">
				<dnn:label id="lblAuthor" runat="server" controlname="lblAuthorValue" suffix=":" />
			</td>
			<td>
				<asp:label id="lblAuthorValue" runat="server" text='<%# DataBinder.Eval(responseItem,"UserName") %>' />
			</td>
		</tr>
		<tr>
			<td width="100">
				<dnn:label id="lblRespondedAt" runat="server" controlname="lblRespondedAtValue" suffix=":" />
			</td>
			<td>
				<asp:label id="lblRespondedAtValue" runat="server" text='<%# DataBinder.Eval(responseItem,"RespondedAtUTC","{0:f}") %>' />
			</td>
		</tr>
		<tr>
			<td width="100">
				<dnn:label id="lblResponse" runat="server" controlname="lblResponse" suffix=":" />
			</td>
			<td>
				<asp:TextBox id="txtResponse" runat="server" textmode="MultiLine" text='<%# responseItem.ResponseText %>' rows="10" columns="10" cssclass="resizable" />
			</td>
		</tr>
	</table>
	<br />
	<dnn:CommandButton id="cmdUpdate" runat="server" resourcekey="cmdUpdate" imageurl="~/images/save.gif" />
	<dnn:CommandButton id="cmdCancel" runat="server" resourcekey="cmdCancel" imageurl="~/images/cancel.gif" />
</div>
