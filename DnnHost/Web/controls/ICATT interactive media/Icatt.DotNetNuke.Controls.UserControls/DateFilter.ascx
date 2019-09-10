<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="DateFilter.ascx.vb" Inherits="Icatt.DotNetNuke.Controls.UserControls.DateFilter" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<table id="tblDateFilter" runat="server" >
	<tr valign="top" align="left">
        <td>
            <asp:RadioButton runat="server" AutoPostBack="True" ID="rdoFromTo" GroupName="grpDateSelectionType" Text="Van - Tot" /><br />
            <asp:RadioButton runat="server" AutoPostBack="True" ID="rdoRecentFuture" GroupName="grpDateSelectionType" Text="Verleden - Toekomst" /><br />
            <asp:RadioButton runat="server" AutoPostBack="True" ID="rdoCurrent" GroupName="grpDateSelectionType" Text="Huidig" />
        </td>
    </tr>
</table>
<table>
    <tr valign="top" align="left">
		<td>
			<table id="tblFromTo" runat="server">
                <tr valign="top" align="left">
                    <td>
                        <dnn:label id="lblFromDate" runat="server" controlname="cmdFromDateCalendar"/>
                        <asp:TextBox ID="txtFromDate" runat="server" MaxLength="255" />
						<asp:HyperLink id="cmdFromDateCalendar" resourcekey="hlCalendar" Runat="server" CssClass="CommandButton" ImageUrl="~/images/calendar.png" enableviewstate="False" ></asp:HyperLink>
						<asp:CompareValidator ID="valFromDate" Type="Date" Operator="DataTypeCheck" resourcekey="valFromDate.ErrorMessage" ControlToValidate="txtFromDate" CssClass="NormalRed" Display="Dynamic" runat="server" />
                        <dnn:label id="lblToDate" runat="server" controlname="cmdToDateCalendar"/>
                        <asp:TextBox ID="txtToDate" runat="server" MaxLength="255"  />
						<asp:HyperLink id="cmdToDateCalendar" resourcekey="hlCalendar" Runat="server" CssClass="CommandButton" ImageUrl="~/images/calendar.png" enableviewstate="False" ></asp:HyperLink>
						<asp:CompareValidator ID="valToDate" Type="Date" Operator="DataTypeCheck" resourcekey="valToDate.ErrorMessage" ControlToValidate="txtToDate" CssClass="NormalRed" Display="Dynamic" runat="server" />
						<asp:CompareValidator ID="valToDateAgainstFromDate" Type="Date" Operator="GreaterThanEqual" resourcekey="valToDateAgainstFromDate.ErrorMessage" ControlToValidate="txtToDate" ControlToCompare="txtFromDate" CssClass="NormalRed" Display="Dynamic" Runat="server" />
                    </td>
                </tr>
            </table>
			<table id="tblPastFuture" runat="server">
                <tr valign="top" align="left">
                    <td>
                        <asp:DropDownList runat="server" ID="ddlPastFutureType">
                        </asp:DropDownList>
                        <asp:DropDownList runat="server" ID="ddlPastFutureCount">
                        </asp:DropDownList>
                        <asp:DropDownList runat="server" ID="ddlPastFuturePeriod">
                        </asp:DropDownList><br />
                        <asp:CheckBox runat="server" ID="cbxIncludeCurrentPeriod" />
                        <dnn:label id="lblIncludeCurrentPeriod" runat="server" controlname="cbxIncludeCurrentPeriod"/>
                    </td>
                </tr>
            </table>
			<table id="tblCurrent" runat="server">
                <tr valign="top" align="left">
                    <td>
                        <asp:DropDownList runat="server" ID="ddlCurrentType">
                        </asp:DropDownList>
                        <asp:DropDownList runat="server" ID="ddlCurrentPeriod">
                        </asp:DropDownList>
                    </td>
                </tr>
            </table>
		</td>
	</tr>
</table>