<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="TreeView.ascx.vb" Inherits="Icatt.DotNetNuke.Classification.UI.UserControls.TreeView" %>
<%@ Register TagPrefix="IcattWebControls" Namespace="Icatt.Web.UI.WebControls" Assembly="Icatt.Web.UI" %>
<a href="#" ID="btnCollapse" runat="server">collapse all</a>
<a href="#" ID="btnExpand" runat="server">expand all</a>
<div>
    <IcattWebControls:HierarchicalRepeater runat="server" EnableViewState="false" ID="hrptMenu">
        <HeaderTemplate><ul style="margin-left:20px;"></HeaderTemplate>
        <ItemHeaderTemplate><li class="jq_collapsed"></ItemHeaderTemplate>
        <ItemTemplate>
            <div class="hitarea">
                <%  	Select Case TreeViewStyle
                		Case Icatt.DotNetNuke.Classification.UI.UserControls.TreeViewItemStyle.TextOnly
                            %><%
                              Case Icatt.DotNetNuke.Classification.UI.UserControls.TreeViewItemStyle.Radio
                            %><input type="radio" class="radio" enableviewstate="false" runat="server" id="rbtnClassification" value='<%#Eval("Item.ClassificationId")%>' /><%
                        Case Icatt.DotNetNuke.Classification.UI.UserControls.TreeViewItemStyle.CheckBox
                            %><input type="checkbox" class="checkbox" enableviewstate="false" runat="server" id="cbxClassification" value='<%#Eval("Item.ClassificationId")%>' /><%
                    End Select%><asp:Label AssociatedControlID="cbxClassification" EnableViewState="false" runat="server" Text='<%#Eval("Item.ClassificationName")%>' ID="lblClassification" ></asp:Label>
            </div>
        </ItemTemplate>
        <ItemFooterTemplate></li></ItemFooterTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </IcattWebControls:HierarchicalRepeater>
</div>
<script language="javascript" type="text/javascript">
    (function($) {
        $(document).ready(function() {
            $("#<%=hrptMenu.ClientId %>").CollapsableTreeView({ collapseAllSelector: "#<%=btnCollapse.ClientId %>", expandAllSelector: "#<%=btnExpand.ClientId %>" });
        });
    })(jQuery);
</script>