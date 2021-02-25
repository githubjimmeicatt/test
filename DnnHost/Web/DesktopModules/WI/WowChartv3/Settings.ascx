<%@ Control Language="C#" AutoEventWireup="false" Inherits="WI.Modules.WowChartv3.Settings"
    CodeBehind="Settings.ascx.cs" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<div class="dnnFormItem">
    <dnn:Label runat="server" controlname="cbxDemoVersion" resourcekey="DemoVersion" />
    <asp:CheckBox ID="cbxDemoVersion" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:Label runat="server" controlname="cbxSecureSQL" resourcekey="SecureSQL" />
    <asp:CheckBox ID="cbxSecureSQL" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:Label runat="server" controlname="ddlAngularVersion" resourcekey="AngularVersion" />
    <asp:DropDownList ID="ddlAngularVersion" runat="server">
        <asp:ListItem Value="1.6.2" Text="1.6.2" />
        <asp:ListItem Value="1.3.9" Text="1.3.9" />
    </asp:DropDownList>
</div>
<div class="dnnFormItem">
    <dnn:Label runat="server" controlname="cbxHideChartsSelector" resourcekey="HideChartsSelector" />
    <asp:CheckBox ID="cbxHideChartsSelector" runat="server" />
</div>
<div class="dnnFormItem">
    <dnn:Label runat="server" controlname="txtCacheDuration" resourcekey="CacheDuration" />
    <asp:TextBox ID="txtCacheDuration" runat="server" type="Number" step="0.1" />
</div>
<div class="dnnFormItem" runat="server" id="dvReplaceLicense" visible="false">
    <asp:LinkButton ID="cmdReplaceLicense" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdReplaceLicense" CausesValidation="False" OnClientClick="return confirm('Are You Sure You Want To Replace This License?');" OnClick="cmdReplaceLicense_Click" />
</div>

