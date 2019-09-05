<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="Settings.ascx.vb" Inherits="Icatt.DotNetNuke.Modules.Response.UI.List.Settings" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="2" border="0" summary="ModuleName Settings Design Table" >
   <tr>
        <td width="250"><dnn:label id="lblItemType" runat="server" controlname="txtItemType" suffix=":" /></td>
        <td valign="bottom" width="200">
			<asp:ListBox id="lbxItemType" runat="server"  rows="1" selectionmode="Single" />
        </td>
        <td width="250"><asp:CustomValidator id="valItemType" runat="server"  enableclientscript="false" controltovalidate="lbxItemType" validateemptytext="true"  /></td>
    </tr>
   <tr>
        <td><dnn:label id="lblItemIdParameterName" runat="server" controlname="txtItemIdParameterName" suffix=":" /></td>
        <td valign="bottom" >
			<asp:TextBox id="txtItemIdParameterName" runat="server" />
        </td>
        <td><asp:CustomValidator id="valItemIdParameterName" runat="server" enableclientscript="false" controltovalidate="txtItemIdParameterName" validateemptytext="true"  /></td>
    </tr>
    <tr>
        <td><dnn:label id="lblPageSize" runat="server" controlname="txtPageSize" suffix=":" /></td>
        <td valign="bottom" >
			<asp:TextBox id="txtPageSize" runat="server" />
        </td>
        <td><asp:CustomValidator id="valPageSizeRange" runat="server"  enableclientscript="false" controltovalidate="txtPageSize" validateemptytext="false"  /></td>
    </tr>

</table>