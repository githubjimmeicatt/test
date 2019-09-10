<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Activate.ascx.cs" Inherits="WI.Modules.WowChartv3.Activate" %>
<%@ Register TagName="label" TagPrefix="dnn" Src="~/controls/labelcontrol.ascx" %>
<div class="dnnForm">
    <fieldset class="dnnClear" style="border: none; padding: 0px; margin: 0px">
        <div class="dnnFormItem">
            <dnn:label runat="server" controlname="txtEmail" resourcekey="Email" cssclass="dnnFormRequired" />
            <asp:TextBox ID="txtEmail" runat="server" CssClass="dnnFormRequired" />
            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" CssClass="dnnFormMessage dnnFormError" ResourceKey="Email.Required" />
        </div>
        <div class="dnnFormItem">
            <dnn:label runat="server" controlname="txtInvoice" resourcekey="Invoice" cssclass="dnnFormRequired" />
            <asp:TextBox ID="txtInvoice" runat="server" CssClass="dnnFormRequired" />
            <asp:RequiredFieldValidator ID="rfvInvoice" runat="server" ControlToValidate="txtInvoice" CssClass="dnnFormMessage dnnFormError" ResourceKey="Invoice.Required" />
        </div>
        <ul class="dnnActions dnnClear">
            <li>
                <asp:LinkButton ID="cmdActivate" runat="server" CssClass="dnnPrimaryAction" ResourceKey="Activate" /></li>
            <li>
                <asp:HyperLink ID="hlCancel" runat="server" class="dnnSecondaryAction" ResourceKey="Cancel"></asp:HyperLink></li>
        </ul>
    </fieldset>
</div>
