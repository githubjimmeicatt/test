<%@ Control Language="VB" EnableViewState="false" AutoEventWireup="false" CodeFile="MenuView.ascx.vb" Inherits="Icatt.DotNetNuke.Modules.Menu.View" CodeFileBaseClass="Icatt.DotNetNuke.Modules.Menu.MenuViewBase" %>
<%@ Register TagPrefix="IcattWebControls" Namespace="Icatt.Web.UI.WebControls" Assembly="Icatt.Web.UI" %>

<IcattWebControls:HierarchicalRepeater runat="server" ID="hrptMenu">
	<HeaderTemplate></HeaderTemplate>
	<ItemHeaderTemplate></ItemHeaderTemplate>
	<ItemTemplate><a href="<%# getItemTabInfo(Container).FullUrl %>"><%# getItemTabInfo(Container).TabName%></a></ItemTemplate>
	<ItemFooterTemplate></ItemFooterTemplate>
	<FooterTemplate></FooterTemplate>
</IcattWebControls:HierarchicalRepeater>
