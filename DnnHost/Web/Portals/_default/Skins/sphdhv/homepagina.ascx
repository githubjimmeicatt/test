<%-- Register skin objects (see http://www.10poundgorilla.com/DNN/Skinning-Tool for reference) --%>

<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="USER" Src="~/Admin/Skins/User.ascx" %>
<%@ Register TagPrefix="dnn" TagName="LOGIN" Src="~/Admin/Skins/Login.ascx" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" TagName="MENU" src="~/DesktopModules/DDRMenu/Menu.ascx" %>
<%@ Register TagPrefix="dnn" TagName="SEARCH" Src="~/Admin/Skins/Search.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>
<%-- Set viewport meta tag --%>

<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width,initial-scale=1" />

<%-- Include CSS file(s) --%>

<dnn:DnnCssInclude runat="server" FilePath="https://fonts.googleapis.com/css?family=Open+Sans:400,600,700" />
<dnn:DnnCssInclude runat="server" PathNameAlias="SkinPath" FilePath="assets/css/main.css" />

<%-- Include JS file(s) --%>

<dnn:DnnJsInclude runat="server" FilePath="https://js.icatt-services.nl/js/pgwbrowser/1.2/pgwbrowser.min.js" HtmlAttributesAsString="integrity:sha384-leBYE1Crk5R0v605Mdl109nz8SWT0HFwaVc0GgAzw4JQiq5J0GvN3tkVaKByT/ps,crossorigin:anonymous"/>
<dnn:DnnJsInclude runat="server" PathNameAlias="SkinPath" FilePath="assets/js/main.js" />

<%-- Skin HTML --%>

<div class="page page--home">

    <!--#include file="includes/include_header.ascx" -->

    <!--#include file="includes/include_nav.ascx" -->

    <div class="page__main">
    
        <div class="Announcements" id="MededelingPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_mededeling.ascx"></div>

        <div class="page__main__inner">

            <div class="grid">

                <div class="column column--span-4">

                    <div class="block block--primary-dark-blue">

                        <div id="spaarBovenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_title.ascx"></div>

                        <div id="spaarBenedenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_clean.ascx"></div>

                    </div>

                </div>
                <div class="column column--span-4">

                    <div class="block block--primary-dark-blue">

                        <div id="ontvangBovenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_title.ascx"></div>

                        <div id="ontvangBenedenPAne" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_clean.ascx"></div>

                    </div>

                </div>
                <div class="column column--span-4">

                    <div class="block block--primary-dark-blue">

                        <div id="deelnemersBovenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_title.ascx"></div>

                        <div id="deelnemersBenedenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_clean.ascx"></div>

                    </div>

                </div>

            </div>

            <div class="grid">

                <div class="column column--span-4 coverage-pane" id="dekkingsgraadPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_white.ascx"></div>
                <div class="column column--span-4 payment-pane" id="uitbetaaldatumPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_white.ascx"></div>
                <div class="column column--span-4 situation-pane" id="persoonlijkesituatiePane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_white.ascx"></div>

            </div>

            <div class="grid grid--last">

                <div class="column column--span-4 news-pane" id="actueelPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_white.ascx"></div>
                <div class="column column--span-4 samenvoegen-pane" id="samenvoegenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_white.ascx"></div>
                <div class="column column--span-4 questions-pane" id="vragenPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_block_white.ascx"></div>

            </div>

            <div id="ContentPane" runat="server" containertype="G" containername="sphdhv" containersrc="container_clean.ascx"></div>

        </div>
    
    </div>

    <!--#include file="includes/include_footer.ascx" -->

</div>