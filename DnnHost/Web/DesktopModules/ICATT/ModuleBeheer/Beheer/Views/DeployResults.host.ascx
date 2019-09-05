<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.ModuleBeheer.Models.Beheer" %>
<%@ Import Namespace="Icatt.Dnn.Mvc" %>
<%
    var resources = Model as List<string> ?? new List<string>(new []{"Unexpected model type"});

%>
<h2>De volgende resources zijn met success geplaatst:</h2>
<ul>
<%    

    foreach (var file in resources)
    {
%>
        <li><span><%: MvcModuleManager.MakeRelative(file,MvcModuleManager.ApplicationRootFolder) %></span></li>
<%
    }
%>
    </ul>
<a href="<%= Html.ActionLink("Default") %>">Terug naar de lijst</a>