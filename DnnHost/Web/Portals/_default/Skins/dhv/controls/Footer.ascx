<%@ Control Language="VB" AutoEventWireup="false" CodeFile="Footer.ascx.vb" Inherits="Portals__default_Skins_dhv_controls_Footer" %>
<%@ Register TagPrefix="icatt" TagName="FooterMenu_1" Src="~/DesktopModules/ICATT/Menu/UI.Menu/FooterMenuView.ascx" %>
<div id="footer" class="cf">
        <div class="footer-box">
            <h4 class="cfn-thesansbold">Stichting Pensioenfonds DHV</h4>
            <p class="address cfn-thesansbold">Laan 1914 nr.35<br />3818 EX Amersfoort<br /><br />T 088 - 348 21 90<br />F (033) 468 37 38<br />E <em class="eml-protect">pensioenfonds [at] dhv [dot] com</em></p>
        </div>
        <div class="footer-box">
            <h4 class="cfn-thesansbold"><a href="/Home/Ikspaarpensioen.aspx">Ik spaar pensioen</a></h4>
			<icatt:FooterMenu_1 runat="server" ShowRoot="false" ParentId="65" Depth="0" ></icatt:FooterMenu_1>
        </div>
        <div class="footer-box">
            <h4 class="cfn-thesansbold"><a href="/Home/Ikontvangpensioen.aspx">Ik ontvang pensioen</a></h4>
            <icatt:FooterMenu_1 ID="FooterMenu1" runat="server" ShowRoot="false" ParentId="66" Depth="0" ></icatt:FooterMenu_1>       
        </div>
        <div class="footer-box">
            <h4 class="cfn-thesansbold"><a href="/Home/OverPensioenfondsDHV.aspx">Over Pensioenfonds DHV</a></h4>
            <icatt:FooterMenu_1 ID="FooterMenu2" runat="server" ShowRoot="false" ParentId="74" Depth="0" ></icatt:FooterMenu_1>   
        </div>
    </div>
