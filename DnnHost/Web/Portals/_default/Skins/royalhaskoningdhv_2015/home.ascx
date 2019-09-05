<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="LANGUAGE" Src="~/Admin/Skins/Language.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGO" Src="~/Admin/Skins/Logo.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" TagName="NAV" Src="~/Admin/Skins/Nav.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TEXT" Src="~/Admin/Skins/Text.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LEFTMENU" Src="~/Admin/Skins/LeftMenu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKS" Src="~/Admin/Skins/Links.ascx" %>
<%@ Register TagPrefix="dnn" TagName="PRIVACY" Src="~/Admin/Skins/Privacy.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TERMS" Src="~/Admin/Skins/Terms.ascx" %>
<%@ Register TagPrefix="dnn" TagName="COPYRIGHT" Src="~/Admin/Skins/Copyright.ascx" %>
<%@ Register TagPrefix="dnn" TagName="STYLES" Src="~/Admin/Skins/Styles.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LINKTOMOBILE" Src="~/Admin/Skins/LinkToMobileSite.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.DDRMenu.TemplateEngine" Assembly="DotNetNuke.Web.DDRMenu" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="CONTROLPANEL" Src="~/Admin/Skins/controlpanel.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude runat="server" ID="DnnCssInclude1" FilePath="//fonts.googleapis.com/css?family=Open+Sans:600,400"></dnn:DnnCssInclude>
<dnn:DnnCssInclude runat="server" ID="OwlCarouselCss" FilePath="assets/css/owl.carousel.css" PathNameAlias="SkinPath"></dnn:DnnCssInclude>
<dnn:DnnCssInclude runat="server" ID="MainCss" FilePath="assets/css/main.min.css" PathNameAlias="SkinPath"></dnn:DnnCssInclude>

<dnn:DnnJsInclude runat="server" FilePath="assets/js/modernizr.js" PathNameAlias="SkinPath" />

<dnn:CONTROLPANEL runat="server" id="cp"  IsDockable="True" />

<div class="tpl-home">

    <div class="header">

        <div class="header-border" aria-hidden="true"></div>

        <div class="header-corp">

            <div class="header-inner">

                <a class="logo primary" href="/">Stichting Pensioenfonds HaskoningDHV</a>

                <div class="logo secondary">Royal HaskoningDHV</div>

            </div>

        </div>

    </div>

    <div class="main">

        <div class="row">

            <div class="col block dark" id="menuPaneLeft" runat="server"></div>

            <div class="col block normal" id="menuPaneMiddle" runat="server"></div>
            
            <div class="col block light last" id="menuPaneRight" runat="server"></div>

        </div>

        <div class="row fs-smaller">

            <div class="col" id="newsPane" runat="server"></div>

            <div class="col" id="aboutPane" runat="server"></div>

            <div class="col last" id="otherPane" runat="server"></div>

        </div>

        <p class="footer">
            <span><span>A</span> Laan 1914 nr. 35 3818 EX Amersfoort</span>
            <span>Postbus 1388 3800 BJ Amersfoort</span>
            <span><span>T</span> <a href="tel:(088) 348 2190">(088) 348 2190</a></span>
            <span><span>E</span> <a href="mailto:pensioenfonds@rhdhv.com">pensioenfonds@rhdhv.com</a></span>
        </p>
         
    </div>

    <div class="logofooter">Royal HaskoningDHV</div>

</div>

<div id="contentPane" runat="server"></div>

<dnn:DnnJsInclude runat="server" FilePath="assets/js/owl.carousel.min.js" PathNameAlias="SkinPath" />
<dnn:DnnJsInclude runat="server" FilePath="assets/js/jquery.backstretch.min.js" PathNameAlias="SkinPath" />

<script>
    
    (function($, window, document) {
        
        $(function() {
            
            var ieVersion = /*@cc_on (function() {switch(@_jscript_version) {case 1.0: return 3; case 3.0: return 4; case 5.0: return 5; case 5.1: return 5; case 5.5: return 5.5; case 5.6: return 6; case 5.7: return 7; case 5.8: return 8; case 9: return 9; case 10: return 10;}})() || @*/ 0;
            
            if (ieVersion !== 0) {
            
                $('html').addClass('ie-' + ieVersion);
            
            }
            
            $.backstretch('/Portals/_default/Skins/royalhaskoningdhv/assets/img/bg.png');
            
            $('.linklist ul').owlCarousel({
                singleItem: true,
                autoPlay: true,
                slideSpeed: 500,
                paginationSpeed: 800,
                navigation: true,
                navigationText: ['vorige','volgende']
            });
            
        });

    }(window.jQuery, window, document));
    
</script>