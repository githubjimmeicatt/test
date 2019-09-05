<%@ Control language="vb" CodeFile="IcattSearch.ascx.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Controls.Search" %>
<asp:RadioButton ID="optWeb" runat="server" CssClass="SkinObject" GroupName="Search" Text="Web" Visible="false" />
<asp:RadioButton ID="optSite" runat="server" CssClass="SkinObject" GroupName="Search" Text="Site" Visible="false" />

<span class="textmiddle">
    <asp:TextBox  runat="server" id="txtSearch" class="searchformfield" title="Typ uw zoekterm" value="Typ uw zoekterm" Text="" />
</span>
<!-- reference:<input name="" class="search" type="text" />-->
<%--<button type="submit" id="cmdSearch" runat="server" class="searchsubmit" value="zoek"></button>--%>
<input type="submit" value="zoek" id="cmdSearch" runat="server" class="searchbutton"/>
<!--reference:<input name="" type="submit" value="Zoeken" class="subsearch" />-->