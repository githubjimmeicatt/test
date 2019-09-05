<%@ Control Language="VB" EnableViewState="false" AutoEventWireup="false" CodeFile="MenuView.ascx.vb" Inherits="Icatt.DotNetNuke.Modules.Menu.View" CodeFileBaseClass="Icatt.DotNetNuke.Modules.Menu.MenuViewBase" %>
<%@ Register TagPrefix="IcattWebControls" Namespace="Icatt.Web.UI.WebControls" Assembly="Icatt.Web.UI" %>
<IcattWebControls:HierarchicalRepeater runat="server" ID="hrptMenu">
	<HeaderTemplate><ul class="submenu_sitemap"></HeaderTemplate>
	<ItemHeaderTemplate><li class='<%# lastItemClass(Container,"last_item") %> <%# hasChildrenClass(Container,"open") %> <%# itemClass(Container,"active","","sel") %>'></ItemHeaderTemplate>
	<ItemTemplate><a href="<%# getItemTabInfo(Container).FullUrl %>"><%# getItemTabInfo(Container).TabName%></a></ItemTemplate>
	<ItemFooterTemplate></li></ItemFooterTemplate>
	<FooterTemplate></ul></FooterTemplate>
</IcattWebControls:HierarchicalRepeater>
