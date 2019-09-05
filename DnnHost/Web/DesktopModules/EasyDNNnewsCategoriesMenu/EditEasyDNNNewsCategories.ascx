<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Categories.EditEasyDNNNewsCategories, App_Web_editeasydnnnewscategories.ascx.565cbe7e" autoeventwireup="true" %>
<script type="text/javascript">
	/* <![CDATA[ */
    <%=PortalSharingJS%>

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

	function CategoriesExpand_Init() {

		$rblExpandCategories = $('#<%=rblExpandCategories.ClientID %> input:checked');

		if ($rblExpandCategories.val() == 2) {
			$('#<%= rowExpandCategoriesToLevel.ClientID %>').css('display', '');

			ValidatorEnable(document.getElementById('<%=rfvnodeExpandLevel.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%=rvnodeExpandLevel.ClientID %>'), true);
		}
		else {
			$('#<%= rowExpandCategoriesToLevel.ClientID %>').css('display', 'none');
			ValidatorEnable(document.getElementById('<%=rfvnodeExpandLevel.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%=rvnodeExpandLevel.ClientID %>'), false);
		}
	}

	jQuery(function ($) {
		$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});

		$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
			if(this.checked)
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), false);
			else
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), true);
			$('#<%=rowSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
		});

		$('#<%=rowSelectCategories.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));

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

		CategoriesExpand_Init();
		$('#<%=rblExpandCategories.ClientID %> input').change(function () {
			CategoriesExpand_Init()
		});
	});

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
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

			jQuery(function ($) {
				$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
					state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
				});

				$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
					$('#<%=rowSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
				});

				$('#<%=rowSelectCategories.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));

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

				CategoriesExpand_Init();
				$('#<%=rblExpandCategories.ClientID %> input').change(function () {
					CategoriesExpand_Init()
				});
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
				<asp:LinkButton runat="server" ID="btnSave" Text="Save" resourcekey="btnSaveSettingsResource1" /></li>
			<li class="edNews_saveAndClose">
				<asp:LinkButton runat="server" ID="btnSaveAndClose" Text="Save and close" resourcekey="btnSaveCloseResource1" /></li>
			<li class="edNews_close">
				<asp:LinkButton runat="server" ID="btnClose" Text="Close" resourcekey="btnCancelResource1" /></li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div class="edNews_adminWrapper edNews_widgets mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<span><%=_("NewsCategorymenu")%></span>
		</div>
		<asp:Panel ID="pnlPortalSharing" runat="server" CssClass="sectionBox noPadding">
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Portalsharing")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel width40">
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
		<asp:Panel ID="pnlSocialInstance" runat="server" Style="display: none;" CssClass="sectionBox noPadding">
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbIsSocialInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("cbIsSocialInstance.HelpText", true) %>" data-tooltip-position="top-right"><%=_("cbIsSocialInstance.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance" runat="server" Text="Community mode" Checked="false" />
						</div>
					</td>
				</tr>
			</table>
		</asp:Panel>
		<div class="sectionBox noPadding">
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
						<table class="optionsList fullWidthTable tablePadding5">
							<tr>
								<td class="tdLabel width40 textTop">
									<label for="<%=rblCategoryPermissionSource.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPermissionSource.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPermissionSource.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Selected="True" Text="None" Value="0" resourcekey="ListItemResource1"></asp:ListItem>
											<asp:ListItem class="normalRadioButton" Text="Portal" Value="1" resourcekey="ListItemResource2"></asp:ListItem>
											<asp:ListItem class="normalRadioButton" Text="Module" Value="2" resourcekey="ListItemResource3"></asp:ListItem>
										</asp:RadioButtonList>
									</div>
									<asp:Panel ID="pnlCategoryModuleInherite" runat="server" Visible="False">
										<asp:DropDownList ID="ddlPermFromModuleInstance" runat="server" />
									</asp:Panel>
								</td>
							</tr>
						</table>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Menuspecificoptions")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedtable noBorder">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=rblCathegoryMenuType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectMenuType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectMenuType.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList ID="rblCathegoryMenuType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCathegoryMenuType_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Selected="True" Value="CategoryMenu" resourcekey="ListItemResource4">Category menu</asp:ListItem>
								<asp:ListItem class="normalRadioButton" Value="AuthorMenu" resourcekey="ListItemResource5">Author menu</asp:ListItem>
								<asp:ListItem class="normalRadioButton" Value="CalendarCategoryMenu" resourcekey="CalendarCategoryMenu">Calendar category menu</asp:ListItem>
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbDisplayHeader.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayHeader.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayHeader.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayHeader" runat="server" Checked="True" Text="Display header" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=ddlOpenDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectModule.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectModule.Text") %></label>
					</td>
					<td>
						<asp:CheckBox CssClass="normalCheckBox" ID="cbModules" Style="display: none" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbModules_CheckedChanged" Text="Module" resourcekey="cbModulesResource1" />
						<asp:DropDownList ID="ddlOpenDetails" runat="server" />
					</td>
				</tr>
				<tr id="trPassAuthorUserID" runat="server" visible="false">
					<td class="tdLabel width40">
						<label for="<%=cbPassAuthorUserID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPassAuthorUserID.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPassAuthorUserID.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbPassAuthorUserID" runat="server" Checked="false" Text="Pass author userid in query string" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=rblExpandCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExpandAllCategories.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExpandAllCategories.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList runat="server" ID="rblExpandCategories" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="0" Text="None" resourcekey="liNone" Selected="True" />
								<asp:ListItem class="normalRadioButton" Value="1" Text="All" resourcekey="liAll" />
								<asp:ListItem class="normalRadioButton" Value="2" Text="To level" resourcekey="liToLevel" />
							</asp:RadioButtonList>
							<span id="rowExpandCategoriesToLevel" runat="server">
								<asp:TextBox ID="tbxnodeExpandLevel" runat="server" MaxLength="1" ValidationGroup="vgSaveSettings" CssClass="smallCentered" Text="1" />
								<asp:RequiredFieldValidator ID="rfvnodeExpandLevel" runat="server" CssClass="smallInfo error" ErrorMessage="This filed is required." ControlToValidate="tbxnodeExpandLevel" ValidationGroup="vgSaveSettings" />
								<asp:RangeValidator ID="rvnodeExpandLevel" runat="server" CssClass="smallInfo error" ErrorMessage="Enter value between 1 - 9." ControlToValidate="tbxnodeExpandLevel" ValidationGroup="vgSaveSettings" Display="Dynamic" MaximumValue="9" MinimumValue="1" Type="Integer" />
							</span>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbShowEmptyCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowEmptyCategories.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowEmptyCategories.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowEmptyCategories" runat="server" Checked="true" Text="Show categories with no articles" />
						</div>
					</td>
				</tr>
				<tr style="display: none">
					<td class="tdLabel width40">
						<label for="<%=cbPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectPage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectPage.Text") %></label>
					</td>
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
						<table class="optionsList fullWidthTable tablePadding5 strippedtable noBorder">
							<tr>
								<td class="tdLabel width40">
									<label for="<%=ddlTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTheme" runat="server" OnSelectedIndexChanged="ddlModuleTemplate_SelectedIndexChanged" AutoPostBack="True" ValidationGroup="vgSaveSettings" />
									<asp:CompareValidator ID="cvThemeSelect" runat="server" CssClass="smallInfo error" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme." Operator="NotEqual" ValidationGroup="vgSaveSettings" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width40">
									<label for="<%=ddlDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectDisplayStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectDisplayStyle.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlDisplayStyle" runat="server" ValidationGroup="vgSaveSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width40">
									<label for="<%=ddlHTMLTemplates.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlHTMLTemplates" runat="server" />
									<asp:CompareValidator ID="cvHTMLTemplate" runat="server" CssClass="smallInfo error" ControlToValidate="ddlHTMLTemplates" Display="Dynamic" ErrorMessage="Please select HTML template." Operator="NotEqual" ValidationGroup="vgSaveSettings" ValueToCompare="0" />
								</td>
							</tr>
						</table>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Filter")%></span>
			</div>
			<table runat="server" id="tblFilterContentOptions" class="optionsList fullWidthTable tablePadding5 strippedtable noBorder">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=rblFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterBy.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterBy.Text") %></label>
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
					<td class="tdLabel width40">
						<label for="<%=rblLimitBackEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowOnlyEventsLimit.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowOnlyEventsLimit.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblLimitBackEvents" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="0" Text="ShowAll" resourcekey="ShowAll" />
								<asp:ListItem class="normalRadioButton" Value="1" Text="Show only past events" resourcekey="ShowOnlyPastEvents" />
								<asp:ListItem class="normalRadioButton" Value="2" Text="Limit to number of days:" Selected="True" resourcekey="LimitToNumberOfDays" />
							</asp:RadioButtonList>
						</div>
						<asp:TextBox ID="tbPastEventLimit" runat="server" CssClass="smallCentered" Text="0" />
						<asp:RequiredFieldValidator ID="rfvPastEventLimit" CssClass="smallInfo error" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSaveSettings" />
						<asp:CompareValidator ID="cvPastEventLimit" CssClass="smallInfo error" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSaveSettings" />
					</td>
				</tr>
			</table>

			<table class="optionsList fullWidthTable tablePadding5 strippedtable noBorder">
				<tr>
					<td class="tdLabel width40 textTop">
						<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCelectCats.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCelectCats.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" runat="server" Checked="True" Text="Display all categories and subcategories" resourcekey="cbdisplayallcatsResource1" />
						</div>
						<div runat="server" id="rowSelectCategories">
							<div>
								<div class="switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
								</div>
								<label for="<%=cbAutoAddCatChilds.ClientID %>"><%=_("cbAutoAddCatChildsResource1.Text") %></label>
							</div>
							<asp:PlaceHolder ID="phDinamicTreeView" runat="server" />
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="vgSaveSettings" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40 textTop">
						<label for="<%=cbDisplayAllAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorFilter.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorFilter.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllAuthors" runat="server" Checked="True" Text="Display from all authors"/>
						</div>
						<asp:PlaceHolder ID="phGroupsAndAuthorsTreeView" runat="server" />
						<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" ErrorMessage="Please select at least one author." ValidationGroup="vgSaveSettings" resourcekey="cvAuthorsTreeview" />
					</td>
				</tr>
			</table>
			<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
				<div class="sectionBoxSubtitle highlighted3">
					<span><%=_("LocalizationText")%></span>
				</div>
				<table class="optionsList fullWidthTable tablePadding5">
					<tr>
						<td class="tdLabel width50">
							<label for="<%=cbHideUnlocalizedItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideUnlocalizedItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblHideUnlocalizedItems.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbHideUnlocalizedItems" runat="server" Text="Don't show unlocalized items:" />
							</div>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Visibility")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel width40 textTop">
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
			<p>
				<asp:Label ID="lblMainMessage" runat="server" EnableViewState="false" />
			</p>
			<div class="buttons" style="display: none">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="vgSaveSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSaveSettings" resourcekey="btnSaveCloseResource1" />
				<asp:HyperLink ID="btnCancel" runat="server" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>