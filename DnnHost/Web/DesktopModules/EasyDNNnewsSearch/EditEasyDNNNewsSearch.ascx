<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Search.EditEasyDNNNewsSearch, App_Web_editeasydnnnewssearch.ascx.75700bee" autoeventwireup="true" %>
<script type="text/javascript">
	//<![CDATA[

    <%=PortalSharingJS%>

	jQuery(function ($) {

		$('.edNews__toggleNextTableRow').on('change', 'input[type="checkbox"]', function () {
			var $this = $(this);
			
			if (!this.checked) {
				$this.closest('tr').next('tr').hide();
			} else {
				$this.closest('tr').next('tr').show();
			};
		});

		$('input[type="checkbox"]', '.edNews__toggleNextTableRow').trigger("change");

		$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID%>')
		});

		$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
			if (this.checked)
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

		toogleAdvancedCategoryPanels();

		$('#<%=cbCategoryCFGroupItems.ClientID%>').change(function () {
			toogleAdvancedCategoryPanels();
		});

		$('#<%= rowfilterbyEvents.ClientID %>').css('display', ($('#<%=rblFilterContent.ClientID %> input:checked').val() == 0 ? 'none' : ''));

		$('#<%=rblFilterContent.ClientID %> input').change(function () {
			if ($(this).val() == 0) {
				$('#<%= rowfilterbyEvents.ClientID %>').css('display', 'none');
				ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), false);
				ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), false);
			}
			else {
				$('#<%= rowfilterbyEvents.ClientID %>').css('display', '');
				ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), true);
				ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), true);
			}
		});
	});

	function toogleAdvancedCategoryPanels() {
		if ($("#<%=cbCategoryCFGroupItems.ClientID%>").is(':checked'))
			$("#<%=rowCategoryCFGroupItems.ClientID%>").show();
		else
			$("#<%=rowCategoryCFGroupItems.ClientID%>").hide();
	}

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
						ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), false);
						ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), false);
					}
					else {
						$('#<%= rowfilterbyEvents.ClientID %>').css('display', '');
						ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), true);
						ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), true);
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
		//]]>
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
			<span><%=_("Searchsettings") %></span>
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
		<asp:Panel ID="pnlSocialInstance" runat="server" CssClass="sectionBox noPadding" Style="display: none;">
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbIsSocialInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSocialInstance.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsSocialInstance.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance" runat="server" Checked="false" Text="Community mode:" />
						</div>
					</td>
				</tr>
			</table>
		</asp:Panel>
		<div class="sectionBox noPadding">
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Searchspecificoptions")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=ddlSelectNewsModuleToDisplayResults.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectNewsModule.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectNewsModule.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlSelectNewsModuleToDisplayResults" runat="server" ValidationGroup="vgSaveSettings" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=rblSearchCustomFields.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchType.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList ID="rblSearchCustomFields" runat="server" AutoPostBack="true" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList" OnSelectedIndexChanged="rblSearchCustomFields_SelectedIndexChanged">
								<asp:ListItem class="normalRadioButton" Value="Simple" Text="Simple search" resourcekey="liSimpleSearch" Selected="True" />
								<asp:ListItem class="normalRadioButton" Value="Advanced" Text="Advanced search" resourcekey="liAdvancedSearch" />
								<asp:ListItem class="normalRadioButton" Value="ByLetter" Text="Search by letter (glossary)" />
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
			</table>
			<table id="tblLetterSearchOptions" runat="server" class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbShowCountByLetter.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCountByLetter.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowCountByLetter.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCountByLetter" runat="server" Checked="True" Text="Show count by letter" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbDisableLetterWithNoContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisableLetterWithNoContent.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisableLetterWithNoContent.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisableLetterWithNoContent" runat="server" Checked="True" Text="Disable letter with no content" />
						</div>
					</td>
				</tr>
			</table>
			<asp:PlaceHolder runat="server" ID="phLetterSearch"></asp:PlaceHolder>
			<table id="tblSimpleSearch" runat="server" class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=ddlSearchPosition.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchButtonPosition.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchButtonPosition.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlSearchPosition" runat="server" resourcekey="ddlSearchPositionResource1">
							<asp:ListItem class="normalRadioButton" Value="button_outside" resourcekey="ListItemResource8">Outside search textbox</asp:ListItem>
							<asp:ListItem class="normalRadioButton" Value="-1" resourcekey="ListItemResource9">Inside search textbox</asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40 textTop">
						<label for="<%=rblSearchWay.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchWay.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchWay.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList ID="rblSearchWay" runat="server" CssClass="verticalList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="title" resourcekey="ListItemResource10" Text="Search title and subtitle" Selected="True" />
								<asp:ListItem class="normalRadioButton" Value="article" resourcekey="ListItemResource11" Text="Search article body" />
								<asp:ListItem class="normalRadioButton" Value="titleandarticle" resourcekey="ListItemResource12" Text="Search title, subtitle and article" />
								<asp:ListItem class="normalRadioButton" Value="titlearticledocumentslinks" resourcekey="lititlearticledocumentslinks" Text="Search title, subtitle, article, documents and links" />
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbAutoComplete.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAutoComplete.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAutoComplete.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox edNews__toggleNextTableRow">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoComplete" runat="server" Checked="True" Text="Auto complete box" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbAutocompleteLinkFromNewsDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAutocompleteLinkFromNewsDetails.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAutocompleteLinkFromNewsDetails.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbAutocompleteLinkFromNewsDetails" runat="server" Checked="False" Text="Autocomplete link" />
						</div>
					</td>
				</tr>
			</table>
			<table id="tblAdvancedSearch" runat="server" class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbDisplayHeader.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayHeader.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayHeader.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayHeader" runat="server" Checked="false" Text="Display header" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=rblSearchBarOrientation.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchBarOrientation.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchBarOrientation.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList ID="rblSearchBarOrientation" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="0" Text="Vertical" Selected="True" resourcekey="liVertical" />
								<asp:ListItem class="normalRadioButton" Value="1" Text="Horizontal" resourcekey="liHorizontal" />
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=ddlCfGroupSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblcfgroupselect.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblcfgroupselect.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlCfGroupSelect" runat="server" ValidationGroup="vgSaveSettings" resourcekey="ddlCfGroupSelectResource1" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbSearchOnlySelectedCFGroup.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchOnlySelectedCFGroup.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchOnlySelectedCFGroup.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbSearchOnlySelectedCFGroup" runat="server" Checked="false" Text="Search only articles containing selected CF group" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbCategoryCFGroupItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCategoryCFGroupItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCategoryCFGroupItems.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbCategoryCFGroupItems" runat="server" Checked="false" Text="Connect article categories with CF groups" />
						</div>
					</td>
				</tr>
				<tr runat="server" id="rowCategoryCFGroupItems" style="display: none;">
					<td colspan="2">
						<asp:PlaceHolder ID="phCategoryCFGroupItems" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbCFUseORBetweenElements.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblcbCFUseORBetweenElements.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblcbCFUseORBetweenElements.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbCFUseORBetweenElements" runat="server" Checked="false" Text="Use OR operation" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbShowCFUseORBetweenElements.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblcbShowCFUseORBetweenElements.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblcbShowCFUseORBetweenElements.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCFUseORBetweenElements" runat="server" Checked="false" Text="Show OR operation" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbClearButton.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblClearButton.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblClearButton.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbClearButton" runat="server" Checked="false" Text="Show clear button" />
						</div>
					</td>
				</tr>
			</table>
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td colspan="2">
						<asp:Label ID="lblSearchInfo" runat="server" EnableViewState="False" />
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
						<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
							<tr>
								<td class="tdLabel width40">
									<label for="<%=ddlTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTemplates_SelectedIndexChanged" />
									<asp:CompareValidator ID="cvThemeSelect" runat="server" CssClass="smallInfo error" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme" Operator="NotEqual" ValidationGroup="vgSaveSettings" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width40">
									<label for="<%=ddlDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectDisplayStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectDisplayStyle.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
								</td>
							</tr>
							<tr id="trModuleTemplate" runat="server" visible="false">
								<td class="tdLabel width40">
									<label for="<%=ddlHTMLTemplates.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("SelectHTMLTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("SelectHTMLTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlHTMLTemplates" runat="server" />
								</td>
							</tr>
						</table>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Filter")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel width40">
						<label for="<%=rblFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchFilterBy.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchFilterBy.Text") %></label>
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
						<div class="edNews_inputGroup displayInline">
							<asp:TextBox ID="tbPastEventLimit" runat="server" CssClass="smallCentered" Text="0" />
						</div>
						<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" CssClass="smallInfo error" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSaveSettings" />
						<asp:CompareValidator ID="cvPastEventLimit" runat="server" CssClass="smallInfo error" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSaveSettings" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40 textTop">
						<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterCategories.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterCategories.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" runat="server" Checked="True" Text="Search all categories on portal" resourcekey="cbdisplayallcatsResource1" />
						</div>
						<div id="tblSelectCategories" runat="server">
							<div>
								<div class="switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
								</div>
								<label><%=_("cbAutoAddCatChildsResource1.Text")%></label>
							</div>
							<asp:PlaceHolder ID="phDinamicTreeView" runat="server"></asp:PlaceHolder>
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="vgSaveSettings" resourcekey="cvCategoriesTreeview.ErrorMessage" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=cbDisplayAllAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterAuthors.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterAuthors.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllAuthors" runat="server" Checked="True" Text="Search all authors on portal" />
						</div>
						<asp:PlaceHolder ID="phGroupsAndAuthorsTreeView" runat="server" />
						<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" ErrorMessage="Please select at least one author." ValidationGroup="vgSaveSettings" resourcekey="cvAuthorsTreeview.ErrorMessage" />
					</td>
				</tr>
			</table>
			<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
				<table class="optionsList fullWidthTable tablePadding5" style="display: none">
					<tr>
						<td class="tdLabel width40">
							<label for="<%=cbHideUnlocalizedItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideUnlocalizedItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblHideUnlocalizedItems.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbHideUnlocalizedItems" runat="server" Text="Don't show unlocalized items" />
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
			<div class="buttons" style="display: none">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="vgSaveSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" resourcekey="btnSaveCloseResource1" ValidationGroup="vgSaveSettings" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>
