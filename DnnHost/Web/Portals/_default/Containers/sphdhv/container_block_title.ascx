<%@ Control AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>

<h2 class="dnn-container-title block__title"><dnn:TITLE runat="server" id="dnnTITLE" /></h2>
<div id="ContentPane" runat="server"></div>