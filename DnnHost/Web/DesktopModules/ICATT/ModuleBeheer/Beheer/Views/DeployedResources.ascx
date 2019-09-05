<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.ModuleBeheer.Models.Beheer" %>
<%
    var resources   = Model as IEnumerable<string> ?? new string[]{};

%>
<h2>De volgende resources zijn met success geplaatst:</h2>
<%    

    foreach (var resource in resources)
    {
%>
        <div><span><%: resource %></span></div>
<%
    }
%>
<a href="<%= Html.ActionLink("Default") %>">Terug naar de lijst</a>