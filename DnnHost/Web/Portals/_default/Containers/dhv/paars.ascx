<%@ Control language="vb" AutoEventWireup="false" Explicit="True" Inherits="DotNetNuke.UI.Containers.Container" %>
<%@ Register TagPrefix="dnn" TagName="ACTIONS" Src="~/Admin/Containers/SolPartActions.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TITLE" Src="~/Admin/Containers/Title.ascx" %>
<%@ Register TagPrefix="dnn" TagName="BREADCRUMB" Src="~/Admin/Skins/BreadCrumb.ascx" %>

<div class="module-container paars">
	
	<h3 class="module-container-header cfn-thesansbold"><dnn:TITLE runat="server" id="dnnTITLE"  CssClass="TitleHead" /></h3>   
    <dnn:ACTIONS runat="server" id="dnnACTIONS"  ProviderName="DNNMenuNavigationProvider" ExpandDepth="1" PopulateNodesFromClient="True" /> 
    <div id="ContentPane" runat="server" class="Normal c_contentpane"></div>

</div>
