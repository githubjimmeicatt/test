<%@ Control language="vb" CodeBehind="~/admin/Skins/skin.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="DOTNETNUKE" Src="~/Admin/Skins/DotNetNuke.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/IcattSearch.ascx" %>
<%@ Register TagPrefix="icatt" TagName="FooterMenu" Src="~/DesktopModules/ICATT/Menu/UI.Menu/FooterMenuView.ascx" %>
<%@ Register TagPrefix="icatt" TagName="LeftMenu" Src="~/DesktopModules/ICATT/Menu/UI.Menu/LeftMenuView.ascx" %>
<%@ Register TagPrefix="icatt" TagName="Footer" Src="controls/Footer.ascx" %>

<div id="container" class="vervolgskin">

    <div id="header"> 
        <h1 id="logo">DHV Advies- en ingenieursbureau</h1>
        <div id="subheader" class="cf">
            <a href="/"><h2 id="sublogo">Stichting Pensioenfonds DHV</h2></a>
            <div id="searchbox">
                <dnn:SEARCH runat="server" id="dnnSEARCH" showWeb="False" showSite="False" />
            </div>
            <div id="textresize">
                <span id="text-smaller">kleiner</span><span id="text-larger">groter</span>
            </div>
        </div>
    </div>

    <ul id="metamenu" class="cf">
        <li class="metalink"><a href="/Home/OverPensioenfondsDHV/Contact.aspx">contact</a></li>
        <li class="metalink"><a href="/Home/OverPensioenfondsDHV/Disclaimer.aspx">disclaimer</a></li>
        <li class="metalink"><a href="/Home/OverPensioenfondsDHV/Inhoud.aspx">sitemap</a></li>
    </ul>

    <div id="PaneContainer" class="cf">

        <div runat="server" id="LeftPane" class="LeftPane">
            
            <div class="module-container blauw small menu">

                <icatt:LeftMenu ID="LeftMenu1" runat="server" 
				 ShowAdmin="true"
				 ShowRoot="false" 
				 ParentId="<%# Ctype(Me.PortalSettings.ActiveTab.BreadCrumbs(If(Me.PortalSettings.ActiveTab.Level < 1,0,1)),DotNetNuke.Entities.Tabs.TabInfo).TabID %>"
				 ShowSelectedTabsOnly="true" 
				 ShowSiblingsOfSelectedTabs="true" 
				 StartLevelIsRelative="false"
				 Depth="3" ></icatt:LeftMenu>
            
            </div>
        
        </div>

        <div id="RightPanesContainer" class="cf">
            
            <div id="article-header">

                <dnn:BREADCRUMB runat="server" id="dnnBREADCRUMB"  CssClass="Breadcrumb" RootLevel="0" Separator="&nbsp;:&nbsp;" />
                <h3 id="phPageTitle" class="article-title" runat="server"><%# PortalSettings.ActiveTab.TabName %></h3>
                <div id="article-options">
                    <a href="javascript:window.print()" class="print">pagina afdrukken</a>
                </div> 
                           
            </div>

            <div runat="server" id="RightPane" class="RightPane"></div>

            <div runat="server" id="ContentPane" class="ContentPane"></div>

        </div>

    </div>

    <icatt:Footer ID="Footer1" runat="server" />
			
</div>

 
<!-- Scripts -->
<script type="text/javascript" src="/Portals/_default/Skins/dhv/js/plugins.js"></script>
<script type="text/javascript" src="/Portals/_default/Skins/dhv/js/scripts.js"></script>
