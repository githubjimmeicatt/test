<%@ Control AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>

<div class="dnn-container has-title">
    <h3 class="dnn-container-title"><dnn:TITLE runat="server" id="dnnTITLE" /></h3>
    <div id="ContentPane" runat="server"></div>
</div>