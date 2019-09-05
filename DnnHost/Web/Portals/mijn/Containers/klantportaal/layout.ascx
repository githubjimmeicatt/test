<%@ Control AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>

<div class="tabcontent u-container">

    <div class="grid">

        <div class="col-span-12-sm col-span-8-md col-span-8-lg">

            <h1><dnn:TITLE runat="server" id="dnnTITLE" /></h1>
            <div id="ContentPane" runat="server"></div>

        </div>

    </div>

</div>