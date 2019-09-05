<%-- Register skin objects (see http://www.10poundgorilla.com/DNN/Skinning-Tool for reference) --%>

<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Skins.Skin" %>
<%@ Register TagPrefix="dnn" TagName="META" Src="~/Admin/Skins/Meta.ascx" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<%-- Set viewport meta tag --%>
<dnn:META ID="mobileScale" runat="server" Name="viewport" Content="width=device-width,initial-scale=1" />

<%-- Include CSS file(s) --%>
<dnn:DnnCssInclude runat="server" FilePath="//fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" />
<dnn:DnnCssInclude runat="server" FilePath="//cdn.icatt-services.nl/plugin/tooltipster/4.0/css/tooltipster.bundle.min.css" />
<dnn:DnnCssInclude runat="server" PathNameAlias="SkinPath" FilePath="assets/css/main.css" />

<%-- Include JS file(s) --%>
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/js/svg4everybody/2.0.3/svg4everybody.min.js" />
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/js/is.js/0.9.0/is.min.js" />
<dnn:DnnJsInclude runat="server" FilePath="//cdn.icatt-services.nl/plugin/tooltipster/4.0/js/tooltipster.bundle.min.js" />
<dnn:DnnJsInclude runat="server" PathNameAlias="SkinPath" FilePath="assets/js/main.js" />

<script>svg4everybody();</script>

<h1 class="u-visuallyhidden">Mijn SPHDHV</h1>

<div class="page-ie">

    <div class="page">

        <!-- Main -->

        <div class="main">

            <!-- Backlink -->

            <div class="u-bgcolor-dark-0">

                <div class="u-container">

                    <a class="backlink" href="https://www.pensioenfondshaskoningdhv.nl">
                        <svg><use xlink:href="<%=SkinPath%>assets/icons/output/icons.symbol.svg#icn-arrow-left"></use></svg>
                        pensioenfondshaskoningdhv.nl
                    </a>

                </div>

            </div>

            <!-- Header -->

            <div class="header u-bgcolor-dark">

                <div class="u-container">

                    <div class="header-logo">

                        <img src="<%=SkinPath%>assets/img/logo_subtitle.svg" alt="Pensioenfonds HaskoningDHV" />
                        <img src="<%=SkinPath%>assets/img/logo_block.svg" alt="Pensioenfonds HaskoningDHV" />

                    </div>
                    <%If HttpContext.Current.User.Identity.IsAuthenticated Then %>
                    <a class="header-logout" href="<%=Sphdhv.Dnn.Properties.Settings.Default.KlantportaalEndpoint + "authentication/logoff" %>">
                        <svg><use xlink:href="<%=SkinPath%>assets/icons/output/icons.symbol.svg#icn-logout"></use></svg>
                        Uitloggen
                    </a>
                    <%End If %>
                </div>

            </div>

            <div id="ContentPane" runat="server"></div>

        </div>

        <!-- Footer -->

        <div class="footer u-bgcolor-dark">

            <div class="u-container">

                <a href="https://www.pensioenfondshaskoningdhv.nl">
                    <img class="footer-primary-logo" src="<%=SkinPath%>assets/img/logo.svg" />
                    <img class="footer-primary-logo" src="<%=SkinPath%>assets/img/logo_block.svg" />
                </a>

                <div class="footer-address">
                    <p class="footer-addressline address">Laan 1914 nr. 35 3818 EX Amersfoort<br />Postbus 1388 3800 BJ Amersfoort</p>
                    <p class="footer-addressline phone">(088) 348 2190</p>
                    <p class="footer-addressline email"><a href="mailto:pensioenfonds@rhdhv.com">pensioenfonds@rhdhv.com</a></p>
                </div>

            </div>

        </div>

    </div>

</div>