<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.ModuleBeheer.Models.Beheer" %>
<%
    
%>

<h2>Module <%: DnnContext.Controller.MvcInfo.MvcModule.DesktopModuleName %></h2>

<div class="contents-header">
    <div><label>View Model</label><span><%: Model.GetType().FullName %></span></div>
</div>
<div class="content">
<%
    foreach (var propInf in Model.GetType().GetProperties(BindingFlags.Instance|BindingFlags.Public))
    {
        %>
    <div><label><%: propInf.Name %></label><span><%: propInf.GetValue(Model) %></span></div>
    <%
    }
     %>    
</div>