<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DateTimeSelect.ascx.vb" Inherits="Icatt.DotNetNuke.Controls.UserControls.DateTimeSelect" %>
<asp:TextBox ID="txtDatePart" runat="server" MaxLength="10" Text='<%# Eval("DatePart") %>' />
<asp:HyperLink id="cmdDatePartCalendar" resourcekey="hlCalendar" Runat="server" CssClass="CommandButton" ImageUrl="~/images/calendar.png" enableviewstate="False" ></asp:HyperLink>
<asp:DropDownList ID="ddlHourPart" runat="server">
    <asp:ListItem Value="00:" Text="00:"></asp:ListItem>
    <asp:ListItem Value="01:" Text="01:"></asp:ListItem>
    <asp:ListItem Value="02:" Text="02:"></asp:ListItem>
    <asp:ListItem Value="03:" Text="03:"></asp:ListItem>
    <asp:ListItem Value="04:" Text="04:"></asp:ListItem>
    <asp:ListItem Value="05:" Text="05:"></asp:ListItem>
    <asp:ListItem Value="06:" Text="06:"></asp:ListItem>
    <asp:ListItem Value="07:" Text="07:"></asp:ListItem>
    <asp:ListItem Value="08:" Text="08:"></asp:ListItem>
    <asp:ListItem Value="09:" Text="09:"></asp:ListItem>
    <asp:ListItem Value="10:" Text="10:"></asp:ListItem>
    <asp:ListItem Value="11:" Text="11:"></asp:ListItem>
    <asp:ListItem Value="12:" Text="12:"></asp:ListItem>
    <asp:ListItem Value="13:" Text="13:"></asp:ListItem>
    <asp:ListItem Value="14:" Text="14:"></asp:ListItem>
    <asp:ListItem Value="15:" Text="15:"></asp:ListItem>
    <asp:ListItem Value="16:" Text="16:"></asp:ListItem>
    <asp:ListItem Value="17:" Text="17:"></asp:ListItem>
    <asp:ListItem Value="18:" Text="18:"></asp:ListItem>
    <asp:ListItem Value="19:" Text="19:"></asp:ListItem>
    <asp:ListItem Value="20:" Text="20:"></asp:ListItem>
    <asp:ListItem Value="21:" Text="21:"></asp:ListItem>
    <asp:ListItem Value="22:" Text="22:"></asp:ListItem>
    <asp:ListItem Value="23:" Text="23:"></asp:ListItem>
</asp:DropDownList>

<asp:DropDownList ID="ddlMinutePart" runat="server">
    <asp:ListItem Value="00" Text="00"></asp:ListItem>
    <asp:ListItem Value="30" Text="30"></asp:ListItem>
</asp:DropDownList>

<asp:CompareValidator ID="valDatePart" Type="Date" Operator="DataTypeCheck" resourcekey="valDatePart.ErrorMessage" ControlToValidate="txtDatePart" CssClass="NormalRed" Display="Dynamic" runat="server" />
<asp:RegularExpressionValidator ID="valHourpart" resourcekey="valHourPart.ErrorMessage" ValidationExpression="^(([0-1][0-9])|(2[0-3])):$" ControlToValidate="ddlHourPart" CssClass="NormalRed" Display="Dynamic" runat="server" />
<asp:RegularExpressionValidator ID="valMinutePart" resourcekey="valMinutePart.ErrorMessage" ValidationExpression="^[0-5][0-9]$" ControlToValidate="ddlMinutePart" CssClass="NormalRed" Display="Dynamic" runat="server" />
