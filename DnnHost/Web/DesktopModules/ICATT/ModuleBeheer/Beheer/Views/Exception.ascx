<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Reflection" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.ModuleBeheer.Models.Beheer" %>
<%
    var exception = Model as Exception;

%>
<table>
    <%    
        
        while (exception != null)
        {
        
    %>
    <tr>
        <th>Type</th>
        <td><%: exception.GetType().FullName %></td>
    </tr>
    <tr>
        <th>Message</th>
        <td><%: exception.Message %></td>
    </tr>
    <tr>
        <th>Stacktrace</th>
        <td><%: exception.StackTrace %></td>
    </tr>
    <tr style="background-color: #ccc;">
        <th>Inner exceptions:</th>
        <td></td>
    </tr>

    <%
        if (exception is ReflectionTypeLoadException)
        {
    %>
    <tr style="background-color: #aaa;">
        <th>LOADER EXCEPTIONS</th>
        <td></td>
    </tr>
    <%
        var loadEx = exception as ReflectionTypeLoadException;
        foreach (var loaderException in loadEx.LoaderExceptions)
        {
            var localEx = loaderException;
            while (localEx != null)
            {
        
    %>
    <tr>
        <th>Type</th>
        <td><%: localEx.GetType().FullName %></td>
    </tr>
    <tr>
        <th>Message</th>
        <td><%: localEx.Message %></td>
    </tr>
    <tr>
        <th>Stacktrace</th>
        <td><%: localEx.StackTrace %></td>
    </tr>
    <tr style="background-color: #ccc;">
        <th>Inner exceptions:</th>
        <td></td>
    </tr>

    <%
                localEx = localEx.InnerException;
            }

        }

    }

    exception = exception.InnerException;

    }
        
    %>
</table>
