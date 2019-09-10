<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DateTimeRange.ascx.vb" Inherits="Icatt.DotNetNuke.Controls.UserControls.DateTimeRange" %>
<%@ Register TagPrefix="icatt" TagName="datetimeselect" Src="~/controls/ICATT interactive media/Icatt.DotNetNuke.Controls.UserControls/DateTimeSelect.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<table>
    <tr>
        <td><dnn:label id="lblStartOfRange" runat="server" controlname="dtsStartOfRange"/></td>
        <td><icatt:datetimeselect id="dtsStartOfRange" runat="server" /></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><asp:RequiredFieldValidator ID="valValidateStartDate" 
                resourcekey="valValidateStartDate.ErrorMessage" 
                ControlToValidate="dtsStartOfRange"
                CssClass="NormalRed"
                Display="Dynamic"
                Runat="server" 
                Enabled="false" ></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td><dnn:label id="lblEndOfRange" runat="server" controlname="dtsEndOfRange"/></td>
        <td><icatt:datetimeselect id="dtsEndOfRange" runat="server" /></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td><asp:RequiredFieldValidator ID="valValidateEndDate" 
                resourcekey="valValidateEndDate.ErrorMessage" 
                ControlToValidate="dtsEndOfRange"
                CssClass="NormalRed"
                Display="Dynamic"
                Runat="server" 
                Enabled="false" ></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td colspan="2"><asp:CompareValidator ID="valValidateRange" 
        Type="String" 
        Operator="GreaterThanEqual" 
        resourcekey="valValidateRange.ErrorMessage" 
        ControlToValidate="dtsEndOfRange" 
        ControlToCompare="dtsStartOfRange" 
        CssClass="NormalRed" 
        Display="Dynamic" 
        Runat="server" /></td>
    </tr>
</table>