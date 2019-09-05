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

<dnn:DnnCssInclude runat="server" ID="OwlCarouselCss" FilePath="assets/css/owl.carousel.css" PathNameAlias="SkinPath"></dnn:DnnCssInclude>
<dnn:DnnCssInclude runat="server" ID="MainCss" FilePath="assets/css/main.min.css" PathNameAlias="SkinPath"></dnn:DnnCssInclude>

<dnn:DnnJsInclude runat="server" FilePath="assets/js/modernizr.js" PathNameAlias="SkinPath" />

<dnn:CONTROLPANEL runat="server" id="cp"  IsDockable="True" />

<div class="layout-header">

    <div class="layout-container">

        <p class="logo-header primary">Stichting Pensioenfonds HaskoningDHV</p>
        <p class="logo-header secondary">Royal HaskoningDHV</p>

    </div>

</div>

<div class="layout-container contentpage" id="main">

    <div>

        <div class="article">
            
            <div class="article-content" id="contentPane" runat="server">
                
                <a class="homebutton" href="/">Home</a>
                
            </div>
            
            <div class="article-aside" id="AsidePane" runat="server"></div>
            
        </div>
   
    </div>

</div>

<div class="layout-footer" id="footer">

    <div class="layout-footer-inner">

        <div class="layout-container">

        <p class="footer-copy">
            <small class="copy">
                <span>Laan 1914 nr. 35</span>
                <span>3818 EX Amersfoort</span>
                <span>Postbus 1388</span>
                <span>3800 BJ Amersfoort</span>
                <span>T (088) 348 2190</span>
                <span>F (033) 468 3738</span>
                <span>E <a href="mailto:pensioenfonds@rhdhv.com">pensioenfonds@rhdhv.com</a></span>
                <span>W <a href="http://www.pensioenfondshaskoningdhv.nl">www.pensioenfondshaskoningdhv.nl</a></span>
            </small>
        </p>

        </div>
   
   </div>

</div>

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
                slideSpeed: 2000,
                paginationSpeed: 800,
                afterInit: function(){
                    
                    this.$elem.append('<div class="owl-progress"><div class="owl-progress-inner"></div></div>');
                    
                    owlProgress(this);
                    
                },
                beforeMove: function(){
                    
                    owlProgress(this);
                
                }
            });
            
        });
        
        function owlProgress(instance) {

            if (instance.itemsAmount > 1) {
            
                var speed = instance.options.autoPlay;
                var wrapper = $(instance.$elem);
                var progress = wrapper.find('.owl-progress-inner');

                progress.css('width', '0%');

                progress.animate({
                    width: '100%'
                }, speed - 50);
                
            }

        }

    }(window.jQuery, window, document));
    
</script>