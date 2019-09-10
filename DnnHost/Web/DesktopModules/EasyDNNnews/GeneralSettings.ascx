<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.GeneralSettings, App_Web_generalsettings.ascx.d988a5ac" %>
<script type="text/javascript">
	function ValidateCheckBoxList(sender, args) {
		args.IsValid = false;
		eds2_2("#<%=cblPortalSelection.ClientID%>").find(":checkbox").each(function () {
			if (eds2_2(this).prop("checked")) {
				args.IsValid = true;
				return;
			}
		});
	}
</script>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span><%=_("GeneralSettingsTitle")%></span>
		</div>
		<div class="sectionBox noPadding bottomPadded sectionBox2 edNews_adminProgressOverlayWrapper">
			<table class="optionsList fullWidthTable noBorder">
				<tr>
					<td class="tdLabel">
						<asp:Label ID="lblUseAdminNoSkinUrl" runat="server" Text="Load module interface without site theme:" resourcekey="lblUseAdminNoSkinUrl"></asp:Label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox ID="cbUseAdminNoSkinUrl" runat="server" Text="Load module interface without site theme" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<asp:Label ID="lblDisableApplicationCookies" runat="server" Text="Disable application cookies:" resourcekey="lblDisableApplicationCookies"></asp:Label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox ID="cbDisableApplicationCookies" runat="server" Text="Disable application cookies" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<asp:Label ID="lblDisableSocialMediaBoxSharingButtons" runat="server" Text="Disable social share buttons in SocialMediaBox lightbox:" resourcekey="lblDisableSocialMediaBoxSharingButtons"></asp:Label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox ID="cbDisableSocialMediaBoxSharingButtons" runat="server" Text="Disable social share buttons in SocialMediaBox lightbox" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<asp:Label ID="lblRedirectArticlesTo404" runat="server" Text="Return 404 for non existing articles:" resourcekey="lblRedirectArticlesTo404"></asp:Label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox ID="cbRedirectArticlesTo404" runat="server" Text="Return 404 for non existing articles" />
						</div>
					</td>
				</tr>
			</table>
			<div class="sectionBoxSubtitle highlighted3">
				<asp:Label ID="lblArticlehistory" runat="server" Text="Article history" resourcekey="lblArticlehistoryResource1"></asp:Label>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=tbArticleHistoryVersion.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleHistoryArchive.Help", true) %>" data-tooltip-position="top-right"><%=_("lblArticleHistoryArchive.Text") %></label>
					</td>
					<td>
						<asp:TextBox ID="tbArticleHistoryVersion" runat="server" CssClass="smallCentered" ValidationGroup="vgGeneralSettings">10</asp:TextBox>
						<asp:RequiredFieldValidator ID="rfvArticleHistoryVersion" CssClass="smallInfo error" runat="server" ControlToValidate="tbArticleHistoryVersion" ErrorMessage="This filed is required." ValidationGroup="vgGeneralSettings" Visible="False" SetFocusOnError="True" resourcekey="rfvModuleWidthResource1"></asp:RequiredFieldValidator>
					</td>
				</tr>
			</table>
			<div class="sectionBoxSubtitle highlighted3">
				<asp:Label ID="lblPageTitleConfigTitle" runat="server" Text="Page title configuration" resourcekey="lblPageTitleConfigTitleResource1"></asp:Label>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel textTop">
						<label><%=_("lblPageTitleConfig.Text") %></label>
					</td>
					<td>
						<asp:GridView ID="gvPageTitleFormating" runat="server" AutoGenerateColumns="False" EnableModelValidation="True" CssClass="strippedTable tablePadding5 textCenter" OnRowCommand="gvPageTitleFormating_RowCommand" OnDataBound="gvPageTitleFormating_DataBound" resourcekey="gvPageTitleFormatingResource1">
							<Columns>
								<asp:TemplateField HeaderText="Item" SortExpression="Title">
									<ItemTemplate>
										<asp:HiddenField ID="hfID" runat="server" Value='<%# Eval("ID") %>'></asp:HiddenField>
										<asp:Label ID="Label1" runat="server" Text='<%# Bind("Item") %>' resourcekey="Label1Resource1"></asp:Label>
									</ItemTemplate>
									<HeaderStyle CssClass="textLeft"></HeaderStyle>
									<ItemStyle CssClass="textLeft" Width="200px"></ItemStyle>
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Visible" SortExpression="Title">
									<ItemTemplate>
										<div class="switchCheckbox">
											<asp:CheckBox ID="cbVisible" runat="server" Checked='<%# Bind("Visible") %>' AutoPostBack="True" OnCheckedChanged="cbVisible_CheckedChanged" resourcekey="cbVisibleResource1" Text=" "></asp:CheckBox>
										</div>
									</ItemTemplate>
									<ItemStyle Width="100px" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Position">
									<ItemTemplate>
										<asp:HiddenField ID="hfPosition" runat="server" Value='<%# Eval("Position") %>'></asp:HiddenField>
										<div class="edNews_boxedActions">
											<asp:LinkButton ID="lbDocMoveDown" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Down" runat="server" CssClass="edNews_aaDown" resourcekey="lbDocMoveDownResource1">Down</asp:LinkButton>
											<asp:LinkButton ID="lbDocMoveUp" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Up" runat="server" CssClass="edNews_aaUp" resourcekey="lbDocMoveUpResource1">Up</asp:LinkButton>
										</div>
									</ItemTemplate>
									<ItemStyle Width="100px" />
								</asp:TemplateField>
							</Columns>
							<HeaderStyle CssClass="tableHeader" />
						</asp:GridView>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=tbSeparator.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblItemSeparator.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblItemSeparator.Text") %></label>
					</td>
					<td>
						<asp:TextBox ID="tbSeparator" runat="server" AutoPostBack="True" MaxLength="5" OnTextChanged="tbSeparator_TextChanged" CssClass="smallCentered">-</asp:TextBox>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label class="edNews_tooltip" data-tooltip-content="<%=_("lblPreview.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPreview.Text") %></label>
					</td>
					<td>
						<asp:Label ID="lblPageTitlePreview" runat="server" resourcekey="lblPageTitlePreviewResource1"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label class="edNews_tooltip" data-tooltip-content="<%=_("lblCatList.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCatList.Text") %></label>
					</td>
					<td>
						<asp:Label ID="lblPageCategoryTitlePreview" runat="server" resourcekey="lblPageCategoryTitlePreviewResource1"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label class="edNews_tooltip" data-tooltip-content="<%=_("lblTagList.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagList.Text") %></label>
					</td>
					<td>
						<asp:Label ID="lblPageTagTitlePreview" runat="server" resourcekey="lblPageTagTitlePreviewResource1"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=lblPageAuthorTitlePreview.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorList.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorList.Text") %></label>
					</td>
					<td>
						<asp:Label ID="lblPageAuthorTitlePreview" runat="server" resourcekey="lblPageAuthorTitlePreviewResource1"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbIncludePageNumberInPageTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIncludePageNumberInPageTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIncludePageNumberInPageTitle.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox ID="cbIncludePageNumberInPageTitle" runat="server" Text="Include page number" AutoPostBack="true" />
						</div>
					</td>
				</tr>
				<tr id="trDaylightSavingTimeTitle" runat="server">
					<td colspan="2" align="center">
						<asp:Label ID="lblDaylightTime" runat="server" Text="Daylight saving time"></asp:Label>
					</td>
				</tr>
				<tr id="trDaylightSavingTime" runat="server">
					<td class="tdLabel">
						<label for="<%=cbDaylightSavingTime.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDaylightSavingTime.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDaylightSavingTime.Text") %></label>
					</td>
					<td>
						<asp:CheckBox ID="cbDaylightSavingTime" runat="server" />
					</td>
				</tr>
			</table>
			<asp:UpdatePanel ID="upPermissionSettings" runat="server" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<div class="sectionBoxSubtitle highlighted3">
						<asp:Label ID="lblPortalRoles" runat="server" resourcekey="lblPortalRoles" Text="Custom portal roles" />
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=cbCustomRoles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCustomRoles.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCustomRoles.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cbCustomRoles" runat="server" OnCheckedChanged="cbCustomRoles_CheckedChanged" Text="Manually select available Security Roles" AutoPostBack="true" />
								</div>
							</td>
						</tr>
					</table>
					<div id="idCustomRoles" runat="server">
						<div class="sectionBoxSubtitle">
							<asp:Label ID="lblRoleInfo" runat="server" />
						</div>
						<div class="edNews_twoColumns noBorder edNews_withSeparator">
							<div>
								<div class="sectionBox noPadding">
									<div class="sectionBoxSubtitle highlighted2">
										<asp:Label ID="lblNotSelectedRolesTitle" resourcekey="lblNotSelectedRolesTitle" runat="server" Text="Available Security Roles:" />
									</div>
									<div class="edNews_inputGroup inputWidth100">
										<asp:ListBox ID="lboxNotSelectedRoles" runat="server" Style="min-height: 250px;" SelectionMode="Multiple" />
									</div>
									<asp:RequiredFieldValidator CssClass="smallInfo error" ID="rfvNotSelectedRoles" ValidationGroup="lboxNotSelectedRoles" ControlToValidate="lboxNotSelectedRoles" runat="server" ErrorMessage="Please select role to add!" Display="Dynamic" SetFocusOnError="True" />
								</div>
							</div>
							<div class="edNews_separator">
								<div class="mainActions smallActions noMargin">
									<asp:Button ID="btnRemoveRoleToPortal" runat="server" CssClass="primaryAction" Text="<<" OnClick="lbRemoveRoleToPortal_Click" ToolTip="Remove" ValidationGroup="lboxSelectedRoles" CausesValidation="true" />
									<asp:Button ID="btnAddRoleToPortal" runat="server" CssClass="primaryAction" Text=">>" OnClick="lbAddRoleToPortal_Click" ToolTip="Add" ValidationGroup="lboxNotSelectedRoles" CausesValidation="true" />
								</div>
							</div>
							<div>
								<div class="sectionBox noPadding">
									<div class="sectionBoxSubtitle highlighted2">
										<asp:Label ID="lblSelectedRoles" resourcekey="lblSelectedRoles" runat="server" Text="Selected Security Roles:" />
									</div>
									<div class="edNews_inputGroup inputWidth100">
										<asp:ListBox ID="lboxSelectedRoles" runat="server" Style="min-height: 250px;" SelectionMode="Multiple" ValidationGroup="lboxSelectedRoles" />
									</div>
									<asp:RequiredFieldValidator CssClass="smallInfo error" ID="rfvSelectedRoles" ValidationGroup="lboxSelectedRoles" ControlToValidate="lboxSelectedRoles" runat="server" ErrorMessage="Please select role to remove!" Display="Dynamic" SetFocusOnError="True" />
								</div>
							</div>
						</div>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<asp:UpdateProgress ID="uppPermissionSettings" runat="server" AssociatedUpdatePanelID="upPermissionSettings" DisplayAfter="100" DynamicLayout="true">
				<ProgressTemplate>
					<div class="edNews_adminProgressOverlay"></div>
				</ProgressTemplate>
			</asp:UpdateProgress>
			<asp:UpdatePanel ID="upClearImages" runat="server" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<div class="sectionBoxSubtitle highlighted3">
						<asp:Label ID="lblClearImages" resourcekey="lblClearImages" runat="server" Text="Clear images" />
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=rblClearImagesSource.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblClearImagesSource.Help", true) %>" data-tooltip-position="top-right"><%=_("lblClearImagesSource.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup">
									<asp:RadioButtonList ID="rblClearImagesSource" runat="server" RepeatLayout="UnorderedList" CssClass="styledRadio inlineList" AutoPostBack="True" OnSelectedIndexChanged="rblClearImagesSource_SelectedIndexChanged">
										<asp:ListItem ResourceKey="liCurrentPortal" class="normalRadioButton" Value="0" Text="Current portal" Selected="True" />
										<asp:ListItem ResourceKey="liAllPortals" class="normalRadioButton" Value="1" Text="All portal" Enabled="False" />
										<asp:ListItem ResourceKey="liSelectPortals" class="normalRadioButton" Value="2" Text="Select portals" Enabled="False" />
									</asp:RadioButtonList>
								</div>
							</td>
						</tr>
						<tr id="trPortalSelection" runat="server" visible="false">
							<td class="tdLabel textTop">
								<label for="<%=cblPortalSelection.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPortalSelection.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPortalSelection.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup">
									<asp:CheckBoxList CssClass="normalCheckBox styledCheckbox inlineList" ID="cblPortalSelection" runat="server" RepeatLayout="UnorderedList" RepeatDirection="Vertical" />
									<asp:CustomValidator ID="cvPortalSelection" Display="Dynamic" ValidationGroup="vgClearImages" resourcekey="cvPortalSelection.ErrorMessage" runat="server" ClientValidationFunction="ValidateCheckBoxList" SetFocusOnError="True">Please select at least one portal.</asp:CustomValidator>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop"></td>
							<td>
								<div class="mainActions displayInline smallActions noMargin">
									<asp:Button ID="btnClearImages" runat="server" resourcekey="btnClearImages" CssClass="delete" Text="Clear Images" ValidationGroup="vgClearImages" OnClick="btnClearImages_Click" />
								</div>
							</td>
						</tr>
					</table>
					<asp:Label ID="lblClearImagesMessage" CssClass="infoMessages success" runat="server" EnableViewState="False" resourcekey="lblClearImagesMessage" Visible="False"></asp:Label>
				</ContentTemplate>
			</asp:UpdatePanel>
			<asp:UpdateProgress ID="uppClearImages" runat="server" AssociatedUpdatePanelID="upClearImages" DisplayAfter="100" DynamicLayout="true">
				<ProgressTemplate>
					<div class="edNews_adminProgressOverlay"></div>
				</ProgressTemplate>
			</asp:UpdateProgress>
		</div>
		<asp:Label ID="lblMessage" runat="server" EnableViewState="False" resourcekey="lblMessageResource1"></asp:Label>
		<div class="mainActions">
			<asp:Button ID="btnSaveSettings" runat="server" CssClass="downSave" OnClick="btnSaveSettings_Click" Text="Save settings" ValidationGroup="vgGeneralSettings" resourcekey="btnSaveSettingsResource1" />
			<asp:Button ID="btnClose" runat="server" CssClass="downClose" OnClick="btnClose_Click" Text="Close" ValidationGroup="vgGeneralSettings" resourcekey="btnCloseResource1" />
		</div>
	</div>
</div>
