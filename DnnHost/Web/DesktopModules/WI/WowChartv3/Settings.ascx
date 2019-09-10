<%@ Control Language="C#" AutoEventWireup="false" Inherits="WI.Modules.WowChartv3.Settings"
    CodeBehind="Settings.ascx.cs" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<fieldset>
    <div class="dnnFormItem">
        <dnn:Label runat="server" controlname="cbxDemoVersion" resourcekey="DemoVersion" />
        <asp:CheckBox ID="cbxDemoVersion" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" controlname="cbxSecureSQL" resourcekey="SecureSQL" />
        <asp:CheckBox ID="cbxSecureSQL" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" controlname="cbxDontLoadAngular" resourcekey="DontLoadAngular" />
        <asp:CheckBox ID="cbxDontLoadAngular" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" controlname="cbxDontLoadAngularRoute" resourcekey="DontLoadAngularRoute" />
        <asp:CheckBox ID="cbxDontLoadAngularRoute" runat="server" />
    </div>
    <div class="dnnFormItem">
        <dnn:Label runat="server" controlname="cbxHideChartsSelector" resourcekey="HideChartsSelector" />
        <asp:CheckBox ID="cbxHideChartsSelector" runat="server" />
    </div>
    <div class="dnnFormItem" runat="server" id="dvReplaceLicense" visible="false">
        <asp:LinkButton ID="cmdReplaceLicense" runat="server" CssClass="dnnSecondaryAction" resourcekey="cmdReplaceLicense" CausesValidation="False" OnClientClick="return confirm('Are You Sure You Want To Replace This License?');" OnClick="cmdReplaceLicense_Click" />
    </div>
</fieldset>
