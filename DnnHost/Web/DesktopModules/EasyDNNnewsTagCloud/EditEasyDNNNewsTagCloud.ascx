<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.TagCloud.EditEasyDNNNewsTagCloud, App_Web_editeasydnnnewstagcloud.ascx.c28fc201" autoeventwireup="true" %>
<script type="text/javascript">
	/* <![CDATA[ */
    <%=PortalSharingJS%>

	jQuery(function ($) {
		$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});

		$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
			if(this.checked)
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), false);
			else
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), true);

			$('#<%=tblSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
		});

		$('#<%=tblSelectCategories.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));

		$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAdd.ClientID %>')
		});

		if ($('#<%=cbIsSocialInstance.ClientID %>')[0].checked) {
			$('#<%=cbDisplayAllAuthors.ClientID %>')[0].checked = true;
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
		}

		$('#<%=cbIsSocialInstance.ClientID %>').on('change', function () {
			$('#<%=cbDisplayAllAuthors.ClientID %>')[0].checked = true;
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
		});

		$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', ($('#<%=cbDisplayAllAuthors.ClientID %>')[0].checked ? 'none' : ''));

		$('#<%=cbDisplayAllAuthors.ClientID %>').on('change', function () {
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', (this.checked ? 'none' : ''));
		});

		$('#<%= rowfilterbyEvents.ClientID %>').css('display', ($('#<%=rblFilterContent.ClientID %> input:checked').val() == 0 ? 'none' : ''));

		$('#<%=rblFilterContent.ClientID %> input').change(function () {
			if ($(this).val() == 0) {
				$('#<%= rowfilterbyEvents.ClientID %>').css('display', 'none');
				ValidatorEnable(document.getElementById('<%= rfvPastEventLimit.ClientID %>'), false);
				ValidatorEnable(document.getElementById('<%= cvPastEventLimit.ClientID %>'), false);
			}
			else {
				$('#<%= rowfilterbyEvents.ClientID %>').css('display', '');
				ValidatorEnable(document.getElementById('<%= rfvPastEventLimit.ClientID %>'), true);
				ValidatorEnable(document.getElementById('<%= cvPastEventLimit.ClientID %>'), true);
			}
		});
	});

	function CategoryClientValidate(source, arguments) {
		if ($('#<%=cbDisplayAllCategories.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}

		if ($('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function ClientValidateAuthors(source, arguments) {
		if ($('#<%=cbDisplayAllAuthors.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}

		if ($('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			jQuery(function ($) {
				$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
					state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
				});

				$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
					$('#<%=tblSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
    			});

				$('#<%=tblSelectCategories.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));

				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
					state_checkbox: $('#<%=cbAutoAdd.ClientID %>')
    			});

				if ($('#<%=cbIsSocialInstance.ClientID %>')[0].checked) {
					$('#<%=cbDisplayAllAuthors.ClientID %>')[0].checked = true;
    				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
    			}

				$('#<%=cbIsSocialInstance.ClientID %>').on('change', function () {
					$('#<%=cbDisplayAllAuthors.ClientID %>')[0].checked = true;
    				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
    			});

				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', ($('#<%=cbDisplayAllAuthors.ClientID %>')[0].checked ? 'none' : ''));

				$('#<%=cbDisplayAllAuthors.ClientID %>').on('change', function () {
					$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', (this.checked ? 'none' : ''));
    			});

				$('#<%= rowfilterbyEvents.ClientID %>').css('display', ($('#<%=rblFilterContent.ClientID %> input:checked').val() == 0 ? 'none' : ''));

				$('#<%=rblFilterContent.ClientID %> input').change(function () {
					if ($(this).val() == 0) {
						$('#<%= rowfilterbyEvents.ClientID %>').css('display', 'none');
    					ValidatorEnable(document.getElementById('<%= rfvPastEventLimit.ClientID %>'), false);
    					ValidatorEnable(document.getElementById('<%= cvPastEventLimit.ClientID %>'), false);
    				}
    				else {
    					$('#<%= rowfilterbyEvents.ClientID %>').css('display', '');
    					ValidatorEnable(document.getElementById('<%= rfvPastEventLimit.ClientID %>'), true);
    					ValidatorEnable(document.getElementById('<%= cvPastEventLimit.ClientID %>'), true);
    				}
    			});

			});

			var $category_menue_items = $('.edn_advanced_tree_view li');

			$category_menue_items.click(function (e) {
				var $target = $(e.target),
					$clicked,
					$child_list,
					$expand_collapse;

				if ($target.is('div') || $target.is('a.expand_collapse')) {
					$clicked = $(this);
					$child_list = $clicked.find('> ul');
					$expand_collapse = $clicked.find('> div > a.expand_collapse');

					if ($child_list.length == 1) {
						if ($child_list.is(':visible')) {
							$child_list.slideUp(200);
							$expand_collapse.removeClass('collapse');
						} else {
							$child_list.slideDown(200);
							$expand_collapse.addClass('collapse');
						}
					}

					return false;
				}
			});

		}
	}
	/* ]]> */
</script>
<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAdd" runat="server" Checked="true" Style="display: none" />
<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topActions">
			<li class="edNews_save">
				<asp:LinkButton runat="server" ID="btnSave" Text="Save" resourcekey="btnSaveSettingsResource1" />
			</li>
			<li class="edNews_saveAndClose">
				<asp:LinkButton runat="server" ID="btnSaveAndClose" Text="Save and close" resourcekey="btnSaveCloseResource1" />
			</li>
			<li class="edNews_close">
				<asp:LinkButton runat="server" ID="btnClose" Text="Close" resourcekey="btnCancelResource1" />
			</li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div class="edNews_adminWrapper edNews_widgets mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<span><%=_("Tagcloudsettings")%></span>
		</div>
		<asp:Panel ID="pnlSocialInstance" CssClass="sectionBox noPadding" runat="server" Style="display: none;">
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbIsSocialInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSocialInstance.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsSocialInstance.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance" Text="Community mode" runat="server" Checked="false" />
						</div>
					</td>
				</tr>
			</table>
		</asp:Panel>
		<div class="sectionBox noPadding">
			<asp:Panel ID="pnlPortalSharing" runat="server">
				<div class="sectionBoxSubtitle highlighted3">
					<span><%=_("Portalsharing")%></span>
				</div>
				<table class="optionsList fullWidthTable tablePadding5">
					<tr>
						<td class="tdLabel">
							<label for="<%=lbSharingPortalID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPortalSharing.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPortalSharing.Text") %></label>
						</td>
						<td>
							<asp:ListBox runat="server" ID="lbSharingPortalID" SelectionMode="Multiple" Style="width: 330px"></asp:ListBox>
							<asp:HiddenField runat="server" ID="hfSelectedSharingPortalID" />
							<div class="mainActions displayInline noMargin smallActions">
								<asp:Button ID="btnSharingPortal" runat="server" CssClass="primaryAction" Text="Set portals" OnClick="btnSharingPortal_Click" />
							</div>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Permissions")%></span>
			</div>
			<asp:UpdatePanel ID="upPermissionSettings" runat="server" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<div class="edn_admin_progress_overlay_container">
						<asp:UpdateProgress ID="uppPermissionSettings" runat="server" AssociatedUpdatePanelID="upPermissionSettings" DisplayAfter="100" DynamicLayout="true">
							<ProgressTemplate>
								<div class="edn_admin_progress_overlay">
								</div>
							</ProgressTemplate>
						</asp:UpdateProgress>
						<table class="optionsList fullWidthTable tablePadding5" cellpadding="0" cellspacing="0">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=rblCategoryPermissionSource.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPermissionSource.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPermissionSource.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Selected="True" Text="None" Value="0" resourcekey="ListItemResource1" />
											<asp:ListItem class="normalRadioButton" Text="Portal" Value="1" resourcekey="ListItemResource2" />
											<asp:ListItem class="normalRadioButton" Text="Module" Value="2" resourcekey="ListItemResource3" />
										</asp:RadioButtonList>
									</div>
									<asp:Panel ID="pnlCategoryModuleInherite" runat="server" CssClass="topMargin" Visible="False">
										<asp:DropDownList ID="ddlPermFromModuleInstance" runat="server" />
									</asp:Panel>
								</td>
							</tr>
						</table>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("TagCouldOptions")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder" cellpadding="0" cellspacing="0">
				<tr>
					<td class="tdLabel">
						<label for="<%=tbNumberOfTags.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfTags.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfTags.Text") %></label>
					</td>
					<td>
						<asp:TextBox ID="tbNumberOfTags" runat="server" CssClass="smallCentered" ValidationGroup="vgSaveSettings" resourcekey="tbNumberOfTagsResource1" Text="10" />
						<asp:RequiredFieldValidator ID="rfvNumberOfTags" runat="server" ForeColor="Red" ControlToValidate="tbNumberOfTags" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSaveSettings" resourcekey="rfvNumberOfTagsResource1" />
						<asp:CompareValidator ID="cvNumberOfTags" runat="server" ForeColor="Red" ControlToValidate="tbNumberOfTags" Display="Dynamic" ErrorMessage="Enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSaveSettings" resourcekey="cvNumberOfTagsResource1" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlSorting.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSorting.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSorting.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlSorting" runat="server">
							<asp:ListItem Value="TagName" Text="Tag name" resourcekey="ListItemResource4" />
							<asp:ListItem Value="Number" Text="Number of posts" resourcekey="ListItemResource5" />
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowTagCount.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowTagCount.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowTagCount.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowTagCount" runat="server" Text="Display tag count" Checked="False" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlOpenDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleToOpen.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleToOpen.Text") %></label>
					</td>
					<td>
						<asp:CheckBox CssClass="normalCheckBox" ID="cbModules" Style="display: none" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbModules_CheckedChanged" />
						<asp:DropDownList ID="ddlOpenDetails" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbDisplayHeader.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayHeader.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayHeader.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayHeader" runat="server" Text="Display header:" Checked="True" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbTagsByCategory.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagsByCategory.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagsByCategory.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbTagsByCategory" Text="Dynamically display tags from the selected category" runat="server" Checked="False" />
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:Label ID="lblTagCloudInfo" runat="server" EnableViewState="False" />
					</td>
				</tr>
				<tr style="display: none">
					<td class="tdLabel"></td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbPage" runat="server" AutoPostBack="True" OnCheckedChanged="cbPage_CheckedChanged" Text="Page" resourcekey="cbPageResource1" />
						</div>
						<asp:DropDownList ID="ddlPageOpenDetails" runat="server" />
					</td>
				</tr>
			</table>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Themeandtemplate")%></span>
			</div>
			<asp:UpdatePanel ID="upModuleTheme" runat="server" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<div class="edn_admin_progress_overlay_container">
						<asp:UpdateProgress ID="uppModuleTheme" runat="server" AssociatedUpdatePanelID="upModuleTheme" DisplayAfter="100" DynamicLayout="true">
							<ProgressTemplate>
								<div class="edn_admin_progress_overlay">
								</div>
							</ProgressTemplate>
						</asp:UpdateProgress>
						<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder" cellpadding="0" cellspacing="0">
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagsTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagsTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTemplates_SelectedIndexChanged" ValidationGroup="vgSaveSettings" />
									<asp:CompareValidator ID="cvThemeSelect" runat="server" ForeColor="Red" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme" Operator="NotEqual" ValidationGroup="vgSaveSettings" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectDisplayStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectDisplayStyle.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlDisplayStyle" runat="server" ValidationGroup="vgSaveSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlHtmTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHtmTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblHtmTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlHtmTemplate" runat="server" ValidationGroup="vgSaveSettings" />
								</td>
							</tr>
						</table>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Filter")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder" cellpadding="0" cellspacing="0">
				<tr>
					<td class="tdLabel">
						<label for="<%=rblFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTagsFilterBy.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTagsFilterBy.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList runat="server" ID="rblFilterContent" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="0" Text="Articles" resourcekey="Articles" />
								<asp:ListItem class="normalRadioButton" Value="1" Text="Events" resourcekey="Events" />
								<asp:ListItem class="normalRadioButton" Value="2" Text="All" Selected="True" resourcekey="liAll" />
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
				<tr runat="server" id="rowfilterbyEvents">
					<td class="tdLabel textTop">
						<label for="<%=rblLimitBackEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowOnlyEventsLimit.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowOnlyEventsLimit.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblLimitBackEvents" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="0" Text="ShowAll" resourcekey="ShowAll" />
								<asp:ListItem class="normalRadioButton" Value="1" Text="Show only past events" resourcekey="ShowOnlyPastEvents" />
								<asp:ListItem class="normalRadioButton" Value="2" Text="Limit to number of days:" Selected="True" resourcekey="LimitToNumberOfDays" />
							</asp:RadioButtonList>
							<asp:TextBox ID="tbPastEventLimit" runat="server" CssClass="smallCentered" Text="0" />
						</div>
						<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSaveSettings" />
						<asp:CompareValidator ID="cvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSaveSettings" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCelectCats.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCelectCats.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" runat="server" Checked="True" Text="Display tags from all categories" resourcekey="cbdisplayallcatsResource1" />
						</div>
					</td>
				</tr>
			</table>
			<table id="tblSelectCategories" runat="server" class="optionsList fullWidthTable tablePadding5" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
				<tr>
					<td class="tdLabel"></td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:PlaceHolder ID="phDinamicTreeView" runat="server"></asp:PlaceHolder>
						<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" ErrorMessage="Please select at least one category." Display="Dynamic" Enabled="False" resourcekey="cvCategoriesTreeview.ErrorMessage"
							ValidationGroup="vgSaveSettings" />
					</td>
				</tr>
			</table>
			<table class="optionsList fullWidthTable tablePadding5" cellpadding="0" cellspacing="0">
				<tr>
					<td class="tdLabel">
						<label for="<%=cbDisplayAllAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterAuthors.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterAuthors.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllAuthors" Text="Display articles from all authors" runat="server" Checked="True" />
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:PlaceHolder ID="phGroupsAndAuthorsTreeView" runat="server" />
						<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" ErrorMessage="Please select at least one author." ValidationGroup="vgSaveSettings" resourcekey="cvAuthorsTreeview.ErrorMessage" />
					</td>
				</tr>
			</table>
			<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
				<div class="sectionBoxSubtitle highlighted3">
					<span><%=_("LocalizationText")%></span>
				</div>
				<table class="optionsList fullWidthTable tablePadding5" cellpadding="0" cellspacing="0">
					<tr>
						<td class="tdLabel width50">
							<label for="<%=cbHideUnlocalizedItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideUnlocalizedItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblHideUnlocalizedItems.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbHideUnlocalizedItems" runat="server" Text="Do not show tags from articles without translation for selected language" />
							</div>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Visibility")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5" cellpadding="0" cellspacing="0">
				<tr>
					<td class="tdLabel textTop">
						<label for="<%=rblModuleVisibility.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleVisibility.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleVisibility.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList ID="rblModuleVisibility" runat="server" CssClass="verticalList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Selected="True" Text="Default (always show module)" Value="0" />
								<asp:ListItem class="normalRadioButton" Text="Visible only if article list mode" Value="1" />
								<asp:ListItem class="normalRadioButton" Text="Visible only if article details mode" Value="2" />
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="main_actions">
			<div class="buttons" style="display: none">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="vgSaveSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSaveSettings" resourcekey="btnSaveCloseResource1" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>
