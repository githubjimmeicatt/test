<%@ Control language="vb" inherits="Icatt.DotNetNuke.Modules.GoogleSearchResults.ViewGoogleSearchResults"
	codefile="ViewGoogleSearchResults.ascx.vb" autoeventwireup="false" explicit="True" %>
<%@ Register tagprefix="dnn" tagname="Audit" src="~/controls/ModuleAuditControl.ascx" %>
<span class="Normal">
<table cellpadding="0" cellspacing="0" border="0" runat="server" visible="false">
  <tr runat="server" visible="false">
    <td height="70" align="left" valign="top">
    <span class="relative">
      <asp:TextBox id="txtSearch" runat="server" cssclass="search_box" maxlength="50" />
      <asp:RequiredFieldValidator id="valSearch" runat="server" controltovalidate="txtSearch" enableclientscript="true" text="You must enter a query." display="Dynamic" />
      </span> </td>
    <td align="left" valign="top"><span class="relative">
      <asp:LinkButton ID="lbtSubmit" runat="server" Text="Zoeken" CssClass="search_box_sub" />
      </span></td>
  </tr>
</table>
<asp:Literal id="ltrGoogleMiniSearchResults" runat="server" />
</span>