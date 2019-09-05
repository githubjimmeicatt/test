<%@ Control language="vb" CodeBehind="~/admin/Skins/skin.vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="DOTNETNUKE" Src="~/Admin/Skins/DotNetNuke.ascx" %>
<%@ Register TagPrefix="icatt" TagName="Footer" Src="controls/Footer.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/IcattSearch.ascx" %>

<div id="container" class="homeskin">

    <div id="header"> 
        <h1 id="logo">DHV Advies- en ingenieursbureau</h1>
        <div id="subheader" class="cf">
            <a href="/"><h2 id="sublogo">Stichting Pensioenfonds DHV</h2></a>
            <div id="searchbox">
                <dnn:SEARCH runat="server" id="dnnSEARCH" showWeb="False" showSite="False" />
            </div>
        </div>
    </div>

    <ul id="metamenu" class="cf">
        <li class="metalink"><a href="/Home/OverPensioenfondsDHV/Contact.aspx">contact</a></li>
        <li class="metalink"><a href="/Home/OverPensioenfondsDHV/Disclaimer.aspx">disclaimer</a></li>
        <li class="metalink"><a href="/Home/OverPensioenfondsDHV/Inhoud.aspx">sitemap</a></li>
    </ul>

    <div id="homenav" class="cf">
        
        <a href="/Home/Ikspaarpensioen.aspx" class="homenav-box opbouwen">Ik bouw pensioen op</a>
        <a href="/Home/Ikontvangpensioen.aspx" class="homenav-box ontvangen">Ik ontvang pensioen</a>
        <a href="/Home/OverPensioenfondsDHV.aspx" class="homenav-box about">Over Stichting Pensioenfonds DHV</a>

    </div>

    <div id="PaneContainer" class="cf">

        <div id="ContentPane" runat="server" class="cf ContentPane"></div>

    </div>

	<icatt:Footer runat="server" />
			
</div>
	
<!-- Scripts -->
<script type="text/javascript" src="/Portals/_default/Skins/dhv/js/plugins.js"></script>
<script type="text/javascript" src="/Portals/_default/Skins/dhv/js/scripts.js"></script>