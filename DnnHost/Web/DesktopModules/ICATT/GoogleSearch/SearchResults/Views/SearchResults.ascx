<%@ Control  Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.GoogleSearch.Models" %>
<%
    var data = (SearchResultsModel)Model;
    
%>
<span class="Normal">
<table cellpadding="0" cellspacing="0" border="0" runat="server" visible="false">
  <tr id="Tr1" runat="server" visible="false">
    <td height="70" align="left" valign="top">
    <span class="relative">
      <input type="text" id="<%= ClientID %>-searchbox"/>
      
      </span> </td>
    <td align="left" valign="top"><span class="relative">
      <input type="submit" name="search" id="<%= ClientID %>-submit" />
      </span></td>
  </tr>
</table>
<%= data.SearchResults ?? "asdfasdfa"  %>
</span>