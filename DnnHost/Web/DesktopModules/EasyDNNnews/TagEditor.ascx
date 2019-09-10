<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.TagEditor, App_Web_tageditor.ascx.d988a5ac" %>
<script type="text/javascript">
	function ConfirmDelete() {
		return confirm('<%=_("Areyousure.Text")%>');
	}
</script>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=_("TagEditor")%></span>
		</div>
		<asp:UpdatePanel ID="upMainAjax" runat="server" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<div class="edNews_adminProgressOverlayWrapper">
					<asp:UpdateProgress ID="uppMainAjax" runat="server" AssociatedUpdatePanelID="upMainAjax" DisplayAfter="100" DynamicLayout="true">
						<ProgressTemplate>
							<div class="edNews_adminProgressOverlay"></div>
						</ProgressTemplate>
					</asp:UpdateProgress>
					<asp:Panel ID="pnlTagsGridView" runat="server" Visible="true" CssClass="sectionBox noPadding">
						<asp:GridView ID="gvTags" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" DataSourceID="odsTags" CssClass="strippedTable fullWidthTable noBorder tablePadding5 textCenter" DataKeyNames="TagID" OnRowCommand="gvTags_RowCommand" AllowPaging="True" OnPageIndexChanging="gvTags_PageIndexChanging">
							<Columns>
								<asp:TemplateField ShowHeader="False">
									<EditItemTemplate>
										<div class="edNews_boxedActions">
											<asp:LinkButton ID="LinkButton1" CssClass="edNews_aaSave edNews_tooltip" runat="server" CommandName="Update" data-tooltip-content='<%#_("LinkButton1Resource2.Text")%>' data-tooltip-position="top-left" resourcekey="LinkButton1Resource2" Text="Update" />
											<asp:LinkButton ID="LinkButton2" CssClass="edNews_aaCancel edNews_tooltip" runat="server" CausesValidation="False" CommandName="Cancel" data-tooltip-content='<%#_("LinkButton2Resource2.Text")%>' data-tooltip-position="top-left" resourcekey="LinkButton2Resource2" Text="Cancel" />
										</div>
									</EditItemTemplate>
									<ItemTemplate>
										<div class="edNews_boxedActions">
											<asp:LinkButton ID="LinkButton1" runat="server" CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("LinkButton1Resource1.Text")%>' data-tooltip-position="top-left" CausesValidation="False" CommandName="Edit" resourcekey="LinkButton1Resource1" Text="Edit" />
											<asp:LinkButton ID="LinkButton2" runat="server" CssClass="edNews_aaDelete color4 edNews_tooltip" data-tooltip-content='<%#_("LinkButton2Resource1.Text")%>' data-tooltip-position="top-left" CausesValidation="False" CommandName="Delete" resourcekey="LinkButton2Resource1" Text="Delete" OnClientClick="return ConfirmDelete();" />
											<asp:LinkButton ID="lbLocalizeimage" runat="server" CssClass="edNews_aaLocalization color2 edNews_tooltip" data-tooltip-content='<%#_("lbLocalizeimage.Text")%>' data-tooltip-position="top-left" CommandArgument='<%# Eval("TagID") %>' resourcekey="lbLocalizeimage" CommandName="Localize" Visible='<%#EnableLocalization%>' Text="Localize" />
										</div>
									</ItemTemplate>
									<ItemStyle Width="100px" CssClass="textLeft" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Tag" SortExpression="Name">
									<EditItemTemplate>
										<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("Name") %>'></asp:TextBox>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="Label1" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Number of articles" SortExpression="CountNumber">
									<ItemTemplate>
										<asp:Label ID="lblCountNumber" runat="server" Text='<%# Bind("CountNumber") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Localized">
									<ItemTemplate>
										<asp:Label ID="lblLocalizedList" runat="server" Text='<%# Bind("Localized") %>'></asp:Label>
									</ItemTemplate>
								</asp:TemplateField>
							</Columns>
							<EditRowStyle CssClass="editItemState" />
							<HeaderStyle CssClass="tableHeader" />
							<PagerStyle CssClass="contentPagination" />
						</asp:GridView>
						<div class="edNews_numberOfRows">
							<div>
								<asp:Label ID="lblFooterSelectNumberOfRows" runat="server" AssociatedControlID="ddlFooterNumberOfRows" resourcekey="lblFooterSelectNumberOfRowsResource1" Text="Number of rows:"></asp:Label>
								<asp:DropDownList ID="ddlFooterNumberOfRows" runat="server" AutoPostBack="True" resourcekey="ddlFooterNumberOfRowsResource1" OnSelectedIndexChanged="ddlFooterNumberOfRows_SelectedIndexChanged">
									<asp:ListItem resourcekey="ListItemResource40" Value="10">10</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource41" Value="20">20</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource42" Value="30">30</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource43" Value="50">50</asp:ListItem>
									<asp:ListItem resourcekey="ListItemResource44" Value="100">100</asp:ListItem>
								</asp:DropDownList>
							</div>
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlTagLocalization" CssClass="topMargin" runat="server" Visible="false">
						<asp:HiddenField ID="hfTagID" runat="server" />
						<table class="optionsList strippedTable fullWidthTable noBorder">
							<tr>
								<td class="tdLabel">
									<asp:Label ID="lblContentLocalizationMediaTitle" resourcekey="lblContentLocalizationMediaTitle" runat="server" Font-Bold="True" Text="Tag:" />
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationMediaTitleOriginal" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<asp:Label ID="lblPortalDefLanguage" runat="server" Text="Poratal default language:" resourcekey="lblPortalDefLanguageResource1" />
								</td>
								<td>
									<asp:Label ID="lblDefaultPortalLangugageImage" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<asp:Label ID="lblContentLocalizationLocalizedLanguages" runat="server" Text="Localized languages:" resourcekey="lblContentLocalizationLocalizedLanguages" />
								</td>
								<td>
									<asp:Label ID="lblContentLocalizationLocalizedLanguagesList" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlContentLocalizationSelectLanguage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationSelectLanguage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationSelectLanguage.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlContentLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlContentLocalizationSelectLanguage_SelectedIndexChanged" />
									<div class="mainActions smallActions displayInline noMargin">
										<asp:LinkButton ID="btnContentLocalizationCopyDefault" resourcekey="btnContentLocalizationCopyDefault" CssClass="copy" runat="server" OnClick="btnContentLocalizationCopyDefault_Click">Copy default values</asp:LinkButton>
										<asp:LinkButton ID="btnDeleteLocalization" resourcekey="btnDeleteLocalization" CssClass="delete" runat="server" OnClick="btnDeleteLocalization_Click" OnClientClick="return ConfirmDelete();">Delete selected tag locale</asp:LinkButton>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxLocalizedTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationTitle.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbxLocalizedTag" runat="server" CssClass="text s18" />
								</td>
							</tr>
						</table>
						<div class="mainActions">
							<asp:LinkButton ID="btnContentLocalizationUpdate" resourcekey="btnContentLocalizationUpdate" CssClass="downSave" runat="server" OnClick="btnContentLocalizationUpdate_Click">Save/Update localization</asp:LinkButton>
							<asp:LinkButton ID="btnContentLocalizationClose" resourcekey="btnContentLocalizationClose" CssClass="cancel" runat="server" OnClick="btnContentLocalizationClose_Click">Close</asp:LinkButton>
						</div>
						<asp:Label ID="lblErrorInfoMsg" runat="server" EnableViewState="false" Visible="false" />
					</asp:Panel>
				</div>
			</ContentTemplate>
		</asp:UpdatePanel>
	</div>
</div>
<asp:ObjectDataSource ID="odsTags" runat="server" SelectMethod="GetAllNewTags" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdateNewTagName" DeleteMethod="DeleteNewTag" EnablePaging="True" SelectCountMethod="GetAllNewTagsTotalTags">
	<DeleteParameters>
		<asp:Parameter Name="TagID" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="maximumRows" Type="Int32" />
		<asp:Parameter Name="startRowIndex" Type="Int32" />
	</SelectParameters>
	<UpdateParameters>
		<asp:Parameter Name="TagID" Type="Int32" />
		<asp:Parameter Name="Name" Type="String" />
		<asp:Parameter Name="CountNumber" Type="Int32" />
		<asp:Parameter Name="Localized" Type="String" />
	</UpdateParameters>
</asp:ObjectDataSource>
