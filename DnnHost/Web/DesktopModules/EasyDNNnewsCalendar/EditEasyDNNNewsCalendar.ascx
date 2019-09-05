<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Calendar.EditEasyDNNNewsCalendar, App_Web_editeasydnnnewscalendar.ascx.3e42803b" autoeventwireup="true" %>
<script type="text/javascript">
	/* <![CDATA[ */
    <%=PortalSharingJS%>

	eds2_2(document).ready(function ($) {
		FullCalendarSettings_Init($);
		//FullCalendarHeight_Init($);

		CalendarType_Init($);
		$('#<%=rblCalendarType.ClientID %> input').change(function () {
			CalendarType_Init($);
		});

	});

	function FullCalendarHeight_Init($) {
		var proccess = function () {
			if ($('#<%=rblFullCalendarHeight.ClientID %> input:checked').val() === 'height') {
				ValidatorEnable(document.getElementById('<%= cvFullCalendarHeight.ClientID %>'), true);
				ValidatorEnable(document.getElementById('<%= rfvFullCalendarHeight.ClientID %>'), true);
				$('#<%=tbFullCalendarHeight.ClientID%>').css('display', '');
				$('#<%=trFullCalendarAspectRatio.ClientID%>').css('display', 'none');
				ValidatorEnable(document.getElementById('<%= rfvFullCalendarAspectRatio.ClientID %>'), false);
				ValidatorEnable(document.getElementById('<%= cvFullCalendarAspectRatio.ClientID %>'), false);
			}
			else {
				ValidatorEnable(document.getElementById('<%= cvFullCalendarHeight.ClientID %>'), false);
				ValidatorEnable(document.getElementById('<%= rfvFullCalendarHeight.ClientID %>'), false);
				$('#<%=tbFullCalendarHeight.ClientID%>').css('display', 'none');
				$('#<%=trFullCalendarAspectRatio.ClientID%>').css('display', '');
				ValidatorEnable(document.getElementById('<%= rfvFullCalendarAspectRatio.ClientID %>'), true);
				ValidatorEnable(document.getElementById('<%= cvFullCalendarAspectRatio.ClientID %>'), true);
			}
		}

		$('#<%=rblFullCalendarHeight.ClientID%> input').change(function () {
			proccess();
		});

		proccess();
	}

	jQuery(function ($) {
		$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
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

		$('#<%= trArchiveExpandMode.ClientID %>').css('display', ($('#<%=rblArchiveType.ClientID %> input:checked').val() == 0 ? 'none' : ''));

		$('#<%=rblArchiveType.ClientID %> input').change(function () {
			if ($(this).val() == 0) {
				$('#<%= trArchiveExpandMode.ClientID %>').css('display', 'none');
			}
			else {
				$('#<%= trArchiveExpandMode.ClientID %>').css('display', '');
			}
		});

		$('#<%=spanShowNewsRSSLink.ID%>').css('display', ($('#<%=cbShowArticles.ClientID %>')[0].checked ? '' : 'none'));

		$('#<%=cbShowArticles.ClientID %>').on('change', function () {
			$('#<%=spanShowNewsRSSLink.ClientID%>').css('display', (this.checked ? '' : 'none'));
		});

		$('#<%=cbShowCalendarArchive.ClientID%>, #<%=cbShowMonthlyArchive.ClientID%>, #<%=cbShowEventArchive.ClientID%>, #<%=cbDisplayHeaderEvents.ClientID%>, #<%=cbShowEvents.ClientID%>, #<%=cbIsTooltipEnabled.ClientID%>, #<%=cbUpcomingEventsToolTip.ClientID%> ').change(function () {
			var $target = $('.collapsable_container.' + this.id);

			if (this.id == '<%=cbShowEvents.ClientID %>') {
				if (this.checked) {
					var myVal = document.getElementById('<%=rfvPastEventLimit.ClientID %>'); ValidatorEnable(myVal, true);
					var myVal2 = document.getElementById('<%=cvPastEventLimit.ClientID %>'); ValidatorEnable(myVal2, true);
				}
				else {
					var myVal = document.getElementById('<%=rfvPastEventLimit.ClientID %>'); ValidatorEnable(myVal, false);
					var myVal2 = document.getElementById('<%=cvPastEventLimit.ClientID %>'); ValidatorEnable(myVal2, false);
				}
			}
			else if (this.id == '<%=cbIsTooltipEnabled.ClientID %>') {
				if (this.checked) {
					var myVal = document.getElementById('<%=rfvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal, true);
					var myVal2 = document.getElementById('<%=rvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, true);
				}
				else {
					var myVal = document.getElementById('<%=rfvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal, false);
					var myVal2 = document.getElementById('<%=rvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, false);
				}
			}
			else if (this.id == '<%=cbUpcomingEventsToolTip.ClientID %>') {
				if (this.checked) {
					var myVal = document.getElementById('<%=rfvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal, true);
					var myVal2 = document.getElementById('<%=rvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, true);
				}
				else {
					var myVal = document.getElementById('<%=rfvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal, false);
					var myVal2 = document.getElementById('<%=rvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, false);
				}
			}
			if (this.checked)
				$target.slideDown(200);
			else
				$target.slideUp(200);
		});
	});

	function CalendarType_Init($) {
		FullCalendarHeight_Init($);

		if ($('#<%=rblCalendarType.ClientID %> input:checked').val() == 3) {
			$('#<%=tblFullCalendarViews.ClientID %>').css('display', '');
			$('#<%=trDisplayCalendarMonthSelect.ClientID %>').css('display', 'none');
			$('#<%=tblAdvancedCalendarSettings.ClientID %>').css('display', '');
			$('#<%=tblAdvancedCalOptions.ClientID %>').css('display', 'none');

			ValidatorEnable(document.getElementById('<%= rfvNumOfItemsInCell.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rvNumOfItemsInCell.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rfvTitleLenght.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rvTitleLenght.ClientID %>'), true);

			ValidatorEnable(document.getElementById('<%= rvCellHeight.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%= rfvCellHeight.ClientID %>'), false);
		}
		else if ($('#<%=rblCalendarType.ClientID %> input:checked').val() == 2) {
			$('#<%= tblAdvancedCalOptions.ClientID %>').css('display', '');
			$('#<%= tblAdvancedCalendarSettings.ClientID %>').css('display', '');
			$('#<%= tblFullCalendarViews.ClientID %>').css('display', 'none');
			$('#<%= trDisplayCalendarMonthSelect.ClientID %>').css('display', '');

			ValidatorEnable(document.getElementById('<%= rfvNumOfItemsInCell.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rvNumOfItemsInCell.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rfvTitleLenght.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rvTitleLenght.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rvCellHeight.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%= rfvCellHeight.ClientID %>'), true);
		}
		else {
			$('#<%= tblFullCalendarViews.ClientID %>').css('display', 'none');
			$('#<%= trDisplayCalendarMonthSelect.ClientID %>').css('display', '');
			$('#<%= tblAdvancedCalOptions.ClientID %>').css('display', 'none');
			$('#<%= tblAdvancedCalendarSettings.ClientID %>').css('display', 'none');

			ValidatorEnable(document.getElementById('<%= rfvNumOfItemsInCell.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%= rvNumOfItemsInCell.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%= rfvTitleLenght.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%= rvTitleLenght.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%= rvCellHeight.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%= rfvCellHeight.ClientID %>'), false);
		}
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

	function FullCalendarSettings_Init($) {
		$('#<%=lbFullCalendarViews.ClientID %>').multipleSelect({
			selectAll: false,
			allSelected: false,
			minimumCountSelected: 100,
			placeholder: 'Select views',
			buttonWidth: '100%'
		});

		$('#<%=lbFullCalendarViews.ClientID %> .ui-multiselect').css('width', '100%');
	}

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			eds2_2(document).ready(function ($) {
				FullCalendarSettings_Init($);
				//FullCalendarHeight_Init($);

				CalendarType_Init($);
				$('#<%=rblCalendarType.ClientID %> input').change(function () {
					CalendarType_Init($);
				});
			});

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

			$('#<%= trArchiveExpandMode.ClientID %>').css('display', ($('#<%=rblArchiveType.ClientID %> input:checked').val() == 0 ? 'none' : ''));

			$('#<%=rblArchiveType.ClientID %> input').change(function () {
				if ($(this).val() == 0) {
					$('#<%= trArchiveExpandMode.ClientID %>').css('display', 'none');
				}
				else {
					$('#<%= trArchiveExpandMode.ClientID %>').css('display', '');
				}
			});

			$('#<%=spanShowNewsRSSLink.ID%>').css('display', ($('#<%=cbShowArticles.ClientID %>')[0].checked ? '' : 'none'));

			$('#<%=cbShowArticles.ClientID %>').on('change', function () {
				$('#<%=spanShowNewsRSSLink.ClientID%>').css('display', (this.checked ? '' : 'none'));
			});

			$('#<%=cbShowCalendarArchive.ClientID%>, #<%=cbShowMonthlyArchive.ClientID%>, #<%=cbShowEventArchive.ClientID%>, #<%=cbDisplayHeaderEvents.ClientID%>, #<%=cbShowEvents.ClientID%>, #<%=cbIsTooltipEnabled.ClientID%>, #<%=cbUpcomingEventsToolTip.ClientID%> ').change(function () {
				var $target = $('.collapsable_container.' + this.id);

				if (this.id == '<%=cbShowEvents.ClientID %>') {
					if (this.checked) {
						var myVal = document.getElementById('<%=rfvPastEventLimit.ClientID %>'); ValidatorEnable(myVal, true);
						var myVal2 = document.getElementById('<%=cvPastEventLimit.ClientID %>'); ValidatorEnable(myVal2, true);
					}
					else {
						var myVal = document.getElementById('<%=rfvPastEventLimit.ClientID %>'); ValidatorEnable(myVal, false);
						var myVal2 = document.getElementById('<%=cvPastEventLimit.ClientID %>'); ValidatorEnable(myVal2, false);
					}
				}
				else if (this.id == '<%=cbIsTooltipEnabled.ClientID %>') {
					if (this.checked) {
						var myVal = document.getElementById('<%=rfvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal, true);
						var myVal2 = document.getElementById('<%=rvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, true);
					}
					else {
						var myVal = document.getElementById('<%=rfvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal, false);
						var myVal2 = document.getElementById('<%=rvCalendarTooltipSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, false);
					}
				}
				else if (this.id == '<%=cbUpcomingEventsToolTip.ClientID %>') {
					if (this.checked) {
						var myVal = document.getElementById('<%=rfvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal, true);
						var myVal2 = document.getElementById('<%=rvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, true);
					}
					else {
						var myVal = document.getElementById('<%=rfvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal, false);
						var myVal2 = document.getElementById('<%=rvUpcomingEventsTTSummaryLenght.ClientID %>'); ValidatorEnable(myVal2, false);
					}
				}
				if (this.checked)
					$target.slideDown(200);
				else
					$target.slideUp(200);
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
			<span><%=_("Calendarsettings")%></span>
		</div>
		<asp:Panel ID="pnlPortalSharing" runat="server" CssClass="sectionBox noPadding">
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
							<asp:Button ID="btnSharingPortal" CssClass="primaryAction" runat="server" Text="Set portals" OnClick="btnSharingPortal_Click" />
						</div>
					</td>
				</tr>
			</table>
		</asp:Panel>
		<asp:Panel ID="pnlSocialInstance" runat="server" Style="display: none;" CssClass="sectionBox noPadding">
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel">
						<label for="<%=cbIsSocialInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSocialInstance.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsSocialInstance.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance" runat="server" Checked="false" Text="Community mode" />
						</div>
					</td>
				</tr>
			</table>
		</asp:Panel>
		<div class="sectionBox noPadding">
			<asp:UpdatePanel ID="upPermissionSettings" runat="server" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("Permissions")%></span>
					</div>
					<div class="edn_admin_progress_overlay_container">
						<asp:UpdateProgress ID="uppPermissionSettings" runat="server" AssociatedUpdatePanelID="upPermissionSettings" DisplayAfter="100" DynamicLayout="true">
							<ProgressTemplate>
								<div class="edn_admin_progress_overlay">
								</div>
							</ProgressTemplate>
						</asp:UpdateProgress>
						<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=rblCategoryPermissionSource.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPermissionSource.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPermissionSource.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Text="None" Value="0" Selected="True" resourcekey="ListItemResource1" />
											<asp:ListItem class="normalRadioButton" Text="Portal" Value="1" resourcekey="ListItemResource2" />
											<asp:ListItem class="normalRadioButton" Text="Module" Value="2" resourcekey="ListItemResource3" />
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
				<span><%=_("Modulespecificoptions")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowCalendarArchive.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCalendar.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowCalendar.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCalendarArchive" runat="server" Text="Display calendar" />
						</div>
					</td>
				</tr>
			</table>
			<div id="tblCollapsable1" class="collapsable_container <%=cbShowCalendarArchive.ClientID%>" style="<%=cssTableStyleCalendar%>">
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=rblCalendarType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectCalendarType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectCalendarType.Text") %></label>
						</td>
						<td>
							<div class="edNews_inputGroup">
								<asp:RadioButtonList ID="rblCalendarType" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblCalendarType_SelectedIndexChanged">
									<asp:ListItem class="normalRadioButton" resourcekey="liSimple" Value="1" Text="Simple" Selected="True" />
									<asp:ListItem class="normalRadioButton" resourcekey="liAdvanced" Value="2" Text="Advanced" />
									<asp:ListItem class="normalRadioButton" resourcekey="liAdvanced2" Value="3" Text="Advanced 2" />
								</asp:RadioButtonList>
							</div>
						</td>
					</tr>
				</table>
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectArticleEvents.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectArticleEvents.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowArticles" runat="server" resourcekey="cbShowArticlesCalendarArchiveResource1" Checked="True" Text="Articles" />
							</div>
							<label><%=_("cbShowArticlesCalendarArchiveResource1.Text") %></label>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowEvents" runat="server" resourcekey="cbShowEventsCalendarArchiveResource1" Text="Events (Start to end date)" />
							</div>
							<label><%=_("cbShowEventsCalendarArchiveResource1.Text") %></label>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowEventsBypublishDate" runat="server" resourcekey="cbShowEventsBypublishDate" Text="Events (Publish date)" />
							</div>
							<label><%=_("cbShowEventsBypublishDate.Text") %></label>
						</td>
					</tr>
					<tr runat="server" id="trLimitBackwordsEvents">
						<td class="tdLabel">
							<label for="<%=rblLimitBackEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitBackwordsEvents.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitBackwordsEvents.Text") %></label>
						</td>
						<td>
							<div class="edNews_inputGroup displayInline">
								<asp:RadioButtonList ID="rblLimitBackEvents" Style="float: left" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
									<asp:ListItem class="normalRadioButton" resourcekey="liShowAll" Value="All" Text="Show All" />
									<asp:ListItem class="normalRadioButton" resourcekey="liShowOnlyPastEvents" Value="ShowOnlyPastEvents" Text="Show only past events" />
									<asp:ListItem class="normalRadioButton" resourcekey="liLimitNumber" Value="Limit" Selected="True" Text="Limit to number of days:" />
								</asp:RadioButtonList>
							</div>
							<asp:TextBox ID="tbPastEventLimit" runat="server" CssClass="smallCentered" Text="0" />
							<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" CssClass="smallInfo error" ControlToValidate="tbPastEventLimit" ErrorMessage="This filed is required." meta:resourcekey="rfvRhumbImageWidthResource1" SetFocusOnError="True" ValidationGroup="vgSaveSettings" Display="Dynamic" />
							<asp:CompareValidator ID="cvPastEventLimit" runat="server" CssClass="smallInfo error" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" Type="Integer" ValidationGroup="vgSaveSettings" />
						</td>
					</tr>
					<tr runat="server" id="trDisplayCalendarMonthSelect">
						<td class="tdLabel">
							<label for="<%=cbDisplayCalendarMonthSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("DisplayMonthQuickSelection.HelpText", true) %>" data-tooltip-position="top-right"><%=_("DisplayMonthQuickSelection.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayCalendarMonthSelect" runat="server" Text=" " />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbIsTooltipEnabled.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsTooltipEnabled.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsTooltipEnabled.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbIsTooltipEnabled" runat="server" Text="Enable tooltips" />
							</div>
						</td>
					</tr>
					<tr runat="server" id="trCalendarTooltipSummaryLenght">
						<td class="tdLabel">
							<label for="<%=tbxCalendarTooltipSummaryLenght.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCalendarTooltipSummaryLenght.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCalendarTooltipSummaryLenght.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxCalendarTooltipSummaryLenght" runat="server" CssClass="smallCentered" Text="0" />
							<asp:RequiredFieldValidator ID="rfvCalendarTooltipSummaryLenght" runat="server" CssClass="smallInfo error" ControlToValidate="tbxCalendarTooltipSummaryLenght" ErrorMessage="Required value" />
							<asp:RangeValidator ID="rvCalendarTooltipSummaryLenght" runat="server" CssClass="smallInfo error" ControlToValidate="tbxCalendarTooltipSummaryLenght" ErrorMessage="Range not valid" MinimumValue="0" MaximumValue="4000" Type="Integer" />
						</td>
					</tr>
					<tr runat="server" id="trShowCalendarPortalTimeZone">
						<td class="tdLabel">
							<label for="<%=cbShowCalendarPortalTimeZone.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCalendarPortalTimeZone.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowCalendarPortalTimeZone.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCalendarPortalTimeZone" runat="server" Text="Display portal time zone" />
							</div>
						</td>
					</tr>
				</table>
				<table runat="server" id="tblFullCalendarViews" class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label class="edNews_tooltip" for="<%=lbFullCalendarViews.ClientID %>" data-tooltip-content="<%=_("lblFullCalendarViews.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFullCalendarViews.Text") %></label>
						</td>
						<td>
							<asp:ListBox ID="lbFullCalendarViews" runat="server" SelectionMode="Multiple" Style="width: 330px">
								<asp:ListItem Value="month" Text="month" />
								<asp:ListItem Value="basicWeek" Text="basicWeek" />
								<asp:ListItem Value="basicDay" Text="basicDay" />
								<asp:ListItem Value="agendaWeek" Text="agendaWeek" />
								<asp:ListItem Value="agendaDay" Text="agendaDay" />
								<asp:ListItem Value="listYear" Text="listYear" />
								<asp:ListItem Value="listMonth" Text="listMonth" />
								<asp:ListItem Value="listWeek" Text="listWeek" />
								<asp:ListItem Value="listDay" Text="listDay" />
							</asp:ListBox>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label class="edNews_tooltip" for="<%=ddlFullCalendarDefaultView.ClientID %>" data-tooltip-content="<%=_("lblFullCalendarDefaultView.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFullCalendarDefaultView.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlFullCalendarDefaultView" runat="server" Style="width: 330px">
								<asp:ListItem Value="month" Text="month" />
								<asp:ListItem Value="basicWeek" Text="basicWeek" />
								<asp:ListItem Value="basicDay" Text="basicDay" />
								<asp:ListItem Value="agendaWeek" Text="agendaWeek" />
								<asp:ListItem Value="agendaDay" Text="agendaDay" />
								<asp:ListItem Value="listYear" Text="listYear" />
								<asp:ListItem Value="listMonth" Text="listMonth" />
								<asp:ListItem Value="listWeek" Text="listWeek" />
								<asp:ListItem Value="listDay" Text="listDay" />
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label class="edNews_tooltip" for="<%=rblFullCalendarHeight.ClientID %>" data-tooltip-content="<%=_("lblFullCalendarHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFullCalendarHeight.Text") %></label>
						</td>
						<td>
							<div class="edNews_inputGroup displayInline">
								<asp:RadioButtonList ID="rblFullCalendarHeight" Style="float: left" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
									<asp:ListItem resourcekey="liUnset" Text="Unset" Value="unset" Selected="True" />
									<asp:ListItem resourcekey="liAuto" Text="Auto" Value="auto" />
									<asp:ListItem resourcekey="liHeight" Text="Height" Value="height"  />
								</asp:RadioButtonList>
							</div>
							<asp:TextBox ID="tbFullCalendarHeight" runat="server" CssClass="smallCentered" Text="650" />
							<asp:RequiredFieldValidator ID="rfvFullCalendarHeight" runat="server" CssClass="smallInfo error" ControlToValidate="tbFullCalendarHeight" ErrorMessage="This filed is required." resourcekey="rfvFullCalendarHeight.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSaveSettings" Display="Dynamic" />
							<asp:CompareValidator ID="cvFullCalendarHeight" runat="server" CssClass="smallInfo error" ControlToValidate="tbFullCalendarHeight" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvFullCalendarHeight.ErrorMessage" Type="Integer" ValidationGroup="vgSaveSettings" Display="Dynamic" />
						</td>
					</tr>
					<tr id="trFullCalendarAspectRatio">
						<td class="tdLabel">
							<label class="edNews_tooltip" for="<%=tbFullCalendarAspectRatio.ClientID %>" data-tooltip-content="<%=_("lblFullCalendarAspectRatio.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFullCalendarAspectRatio.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbFullCalendarAspectRatio" runat="server" CssClass="smallCentered" />
							<asp:RequiredFieldValidator ID="rfvFullCalendarAspectRatio" runat="server" CssClass="smallInfo error" ControlToValidate="tbFullCalendarAspectRatio" ErrorMessage="This filed is required." resourcekey="rfvFullCalendarHeight.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSaveSettings" Display="Dynamic" />
							<asp:CompareValidator ID="cvFullCalendarAspectRatio" runat="server" CssClass="smallInfo error" ControlToValidate="tbFullCalendarAspectRatio" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvFullCalendarHeight.ErrorMessage" Type="Double" ValidationGroup="vgSaveSettings" Display="Dynamic" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbFullCalendar_WeekNumbers.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("WeekNumbers.HelpText", true) %>" data-tooltip-position="top-right"><%=_("WeekNumbers.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbFullCalendar_WeekNumbers" runat="server" Text=" " />
							</div>
						</td>
					</tr>
				</table>
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder" runat="server" id="tblAdvancedCalendarSettings">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxNumOfItemsInCell.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumOfItemsInCell.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumOfItemsInCell.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxNumOfItemsInCell" runat="server" CssClass="smallCentered" Text="4" />
							<asp:RequiredFieldValidator ID="rfvNumOfItemsInCell" runat="server" CssClass="smallInfo error" ControlToValidate="tbxNumOfItemsInCell" ErrorMessage="Required value" />
							<asp:RangeValidator ID="rvNumOfItemsInCell" runat="server" CssClass="smallInfo error" ControlToValidate="tbxNumOfItemsInCell" ErrorMessage="Range not valid (0 - 100)" MinimumValue="0" MaximumValue="100" Type="Integer" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxTitleLenght.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTitleLenght.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTitleLenght.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxTitleLenght" runat="server" CssClass="smallCentered" Text="0" />
							<asp:RequiredFieldValidator ID="rfvTitleLenght" runat="server" CssClass="smallInfo error" ControlToValidate="tbxTitleLenght" ErrorMessage="Required value" />
							<asp:RangeValidator ID="rvTitleLenght" runat="server" CssClass="smallInfo error" ControlToValidate="tbxTitleLenght" ErrorMessage="Range not valid (0 - 200)" MinimumValue="0" MaximumValue="200" Type="Integer" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label class="edNews_tooltip" data-tooltip-content="<%=_("lblShowNewsRSSLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowNewsRSSLink.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox" runat="server" id="spanShowNewsRSSLink">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowNewsRSSLink" runat="server" resourcekey="cbShowNewsRSSLink" Checked="false" Text="News RSS" />
							</div>
							<label class="smallText"><%=_("cbShowNewsRSSLink.Text") %></label>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowEventRSSLink" runat="server" resourcekey="cbShowEventRSSLink" Checked="false" Text="Events RSS" />
							</div>
							<label class="smallText"><%=_("cbShowEventRSSLink.Text") %></label>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowListLink" runat="server" resourcekey="cbShowListLink" Checked="false" Text="Articles/events list" />
							</div>
							<label class="smallText"><%=_("cbShowListLink.Text") %></label>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbCalendarEventsExportIcon" runat="server" resourcekey="cbCalendarEventsExportIcon" Checked="false" Text="iCalendar export" />
							</div>
							<label class="smallText"><%=_("cbCalendarEventsExportIcon.Text") %></label>
						</td>
					</tr>
				</table>
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder" runat="server" id="tblAdvancedCalOptions">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxCellHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCellHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCellHeight.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxCellHeight" runat="server" CssClass="smallCentered" Text="100" />
							<asp:RequiredFieldValidator ID="rfvCellHeight" runat="server" CssClass="smallInfo error" ControlToValidate="tbxCellHeight" ErrorMessage="RequiredFieldValidator" />
							<asp:RangeValidator ID="rvCellHeight" runat="server" CssClass="smallInfo error" ControlToValidate="tbxCellHeight" ErrorMessage="RangeValidator" MinimumValue="0" MaximumValue="1080" Type="Integer" />
						</td>
					</tr>
				</table>
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlOpenDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventArticleOpen.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEventArticleOpen.Text") %></label>
						</td>
						<td>
							<asp:CheckBox CssClass="normalCheckBox" ID="cbModules" Style="display: none" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbModules_CheckedChanged" Text="Module" resourcekey="cbModulesResource1" />
							<asp:DropDownList ID="ddlOpenDetails" runat="server">
								<asp:ListItem Value="0" resourcekey="ListItemResource4" Text="Select" />
							</asp:DropDownList>
							<asp:Label ID="lblModuleError" runat="server" CssClass="smallInfo error" Text="Please select." Visible="False" resourcekey="lblModuleErrorResource1" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlFirstDayOfTheWeek.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFirstDayOfTheWeek.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFirstDayOfTheWeek.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlFirstDayOfTheWeek" runat="server">
								<asp:ListItem resourcekey="liMonday" Value="Monday" Text="Monday" />
								<asp:ListItem resourcekey="liTuesday" Value="Tuesday" Text="Tuesday" />
								<asp:ListItem resourcekey="liWednesday" Value="Wednesday" Text="Wednesday" />
								<asp:ListItem resourcekey="liThursday" Value="Thursday" Text="Thursday" />
								<asp:ListItem resourcekey="liFriday" Value="Friday" Text="Friday" />
								<asp:ListItem resourcekey="liSaturday" Value="Saturday" Text="Saturday" />
								<asp:ListItem resourcekey="liSunday" Value="Sunday" Text="Sunday" />
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbCalendarUserIDInLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("CalendarUserIDInLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("CalendarUserIDInLink.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbCalendarUserIDInLink" runat="server" Text="Pass userID querystring in article link" />
							</div>
						</td>
					</tr>
					<tr style="display: none">
						<td class="tdLabel"></td>
						<td>
							<asp:CheckBox CssClass="normalCheckBox" ID="cbPage" runat="server" AutoPostBack="True" OnCheckedChanged="cbPage_CheckedChanged" Text="Page" resourcekey="cbPageResource1" />
							<asp:DropDownList ID="ddlPageOpenDetails" runat="server" resourcekey="ddlPageOpenDetailsResource1" />
							<asp:Label ID="lblPageError" runat="server" CssClass="smallInfo error" Text="Please select." Visible="False" resourcekey="lblPageErrorResource1" />
						</td>
					</tr>
				</table>
			</div>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("archive")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowMonthlyArchive.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowMonthlyArchive.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowMonthlyArchive.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowMonthlyArchive" Text="Display archive" runat="server" />
						</div>
					</td>
				</tr>
			</table>
			<div id="tblCollapsable2" class="collapsable_container <%=cbShowMonthlyArchive.ClientID%>" style="<%=cssTableStyleMonthlyArchive%>">
				<asp:UpdatePanel ID="upArchiveType" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
					<ContentTemplate>
						<div class="edn_admin_progress_overlay_container">
							<asp:UpdateProgress ID="uppArchiveType" runat="server" AssociatedUpdatePanelID="upArchiveType" DisplayAfter="100" DynamicLayout="true">
								<ProgressTemplate>
									<div class="edn_admin_progress_overlay">
									</div>
								</ProgressTemplate>
							</asp:UpdateProgress>
							<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
								<tr>
									<td class="tdLabel">
										<label for="<%=rblArchiveType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArchiveType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArchiveType.Text") %></label>
									</td>
									<td>
										<div class="edNews_inputGroup">
											<asp:RadioButtonList ID="rblArchiveType" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
												<asp:ListItem class="normalRadioButton" resourcekey="liArchiveByMonth" Text="By month" Value="0" Selected="True" />
												<asp:ListItem class="normalRadioButton" resourcekey="liArchiveByYear" Text="By year" Value="1" />
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
								<tr id="trArchiveExpandMode" runat="server">
									<td class="tdLabel">
										<label for="<%=rblArchiveExpandMode.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArchiveExpandMode.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArchiveExpandMode.Text") %></label>
									</td>
									<td>
										<div class="edNews_inputGroup">
											<asp:RadioButtonList ID="rblArchiveExpandMode" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
												<asp:ListItem class="normalRadioButton" resourcekey="liArchiveCollapsAll" Text="Collapse all" Value="0" Selected="True" />
												<asp:ListItem class="normalRadioButton" resourcekey="liArchiveExpandAll" Text="Expand all" Value="1" />
												<asp:ListItem class="normalRadioButton" resourcekey="liArchiveExpandCurrentYear" Text="Expand current year" Value="2" />
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
							</table>
						</div>
					</ContentTemplate>
				</asp:UpdatePanel>
				<asp:UpdatePanel ID="upArchivetemplate" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
					<ContentTemplate>
						<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=rblArchiveFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArchiveFilterBy.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArchiveFilterBy.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList runat="server" ID="rblArchiveFilterContent" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="0" Text="Articles" resourcekey="Articles" />
											<asp:ListItem class="normalRadioButton" Value="1" Text="Events" resourcekey="Events" />
											<asp:ListItem class="normalRadioButton" Value="2" Text="All" Selected="True" resourcekey="liAll" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlArchiveTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArchiveTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArchiveTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlArchiveTemplate" runat="server" />
								</td>
							</tr>
						</table>
					</ContentTemplate>
				</asp:UpdatePanel>
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlMonthlyArchiveOpenDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowMonthArchiveModule.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowMonthArchiveModule.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlMonthlyArchiveOpenDetails" runat="server">
								<asp:ListItem Value="0" resourcekey="ListItemResource5" Text="Select" />
							</asp:DropDownList>
							<asp:Label ID="lblArchiveMonthlyModuleError" runat="server" CssClass="smallInfo error" Text="Please select." Visible="False" resourcekey="lblArchiveMonthlyModuleErrorResource1" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=lbSharingPortalID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayHeader.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayHeader.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayHeader" runat="server" Checked="true" Text="Display module header" />
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("upcomingEvents")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowEventArchive.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowEventArchive.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowEventArchive.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowEventArchive" runat="server" Text="Display upcoming events" />
						</div>
					</td>
				</tr>
			</table>
			<div id="tblCollapsable3" class="collapsable_container <%=cbShowEventArchive.ClientID%>" style="<%=cssTableStyleEvents%>">
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlOpenDetailsEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventArticleOpen.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEventArticleOpen.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlOpenDetailsEvents" runat="server">
								<asp:ListItem Value="0" resourcekey="ListItemResource4" Text="Select" />
							</asp:DropDownList>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbNumberOfEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfEvents.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfEvents.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbNumberOfEvents" runat="server" CssClass="smallCentered" Text="5" />
							<asp:RequiredFieldValidator ID="rfvNumberOfPosts" runat="server" CssClass="smallInfo error" ControlToValidate="tbNumberOfEvents" ErrorMessage="This filed is required." ValidationGroup="vgSaveSettings" resourcekey="rfvNumberOfEventsResource1.ErrorMessage" Display="Dynamic" />
							<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems2" runat="server" CssClass="smallInfo error" ControlToValidate="tbNumberOfEvents" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage"
								Type="Integer" ValidationGroup="vgSaveSettings" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbUpcomingEventsToolTip.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUpcomingEventsToolTip.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUpcomingEventsToolTip.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbUpcomingEventsToolTip" runat="server" Text="Enable tooltips" />
							</div>
						</td>
					</tr>
					<tr runat="server" id="trUpcomingEventsTTSummaryLenght">
						<td class="tdLabel">
							<label for="<%=tbxUpcomingEventsTTSummaryLenght.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUpcomingEventsTTSummaryLenght.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUpcomingEventsTTSummaryLenght.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxUpcomingEventsTTSummaryLenght" runat="server" CssClass="smallCentered" Text="0" />
							<asp:RequiredFieldValidator ID="rfvUpcomingEventsTTSummaryLenght" runat="server" CssClass="smallInfo error" ControlToValidate="tbxUpcomingEventsTTSummaryLenght" ErrorMessage="Required value" />
							<asp:RangeValidator ID="rvUpcomingEventsTTSummaryLenght" runat="server" CssClass="smallInfo error" ControlToValidate="tbxUpcomingEventsTTSummaryLenght" ErrorMessage="Range not valid" MinimumValue="0" MaximumValue="4000" Type="Integer" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbShowUpcomingEventsPortalTimeZone.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowUpcomingEventsPortalTimeZone.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowUpcomingEventsPortalTimeZone.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowUpcomingEventsPortalTimeZone" runat="server" Text="Display portal time zone" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbDisplayHeaderEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayHeader.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayHeader.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayHeaderEvents" runat="server" Checked="True" Text="Display module header" />
							</div>
						</td>
					</tr>
					<tr runat="server" id="trDisplayUpcomingEventsRSSlinks">
						<td class="tdLabel">
							<label class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayUpcomingEventsRSSlinks.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayUpcomingEventsRSSlinks.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowUpcomingRSSIcon" runat="server" resourcekey="cbShowUpcomingRSSIcon" Text="Events RSS" />
							</div>
							<label><%=_("cbShowUpcomingRSSIcon.Text") %></label>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbShowUpcomingEventsExportIcon" runat="server" resourcekey="cbShowUpcomingEventsExportIcon" Text="iCalendar export" />
							</div>
							<label><%=_("cbShowUpcomingEventsExportIcon.Text") %></label>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=lbSharingPortalID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("UpcomingEventsUserIDInLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("UpcomingEventsUserIDInLink.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbUpcomingEventsUserIDInLink" runat="server" Text="Pass userID querystring in article link" />
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Theme")%></span>
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
								<td class="tdLabel">
									<label for="<%=ddlTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTemplates_SelectedIndexChanged" AppendDataBoundItems="True" />
									<asp:CompareValidator ID="cvThemeSelect" runat="server" CssClass="smallInfo error" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme" Operator="NotEqual" ValidationGroup="vgSaveSettings" ValueToCompare="0" resourcekey="cvThemeSelectResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectDisplayStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectDisplayStyle.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlCalendarTooltipHtmlTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCalendarTooltipHtmlTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCalendarTooltipHtmlTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlCalendarTooltipHtmlTemplate" runat="server" /><div class="mainActions smallActions displayInline noMargin">
										<%--<asp:HyperLink runat="server" ID="hlEditHtmlTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />--%>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlUpcomingEventsTooltipHtmlTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUpcomingEventsTooltipHtmlTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUpcomingEventsTooltipHtmlTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlUpcomingEventsTooltipHtmlTemplate" runat="server" /><div class="mainActions smallActions displayInline noMargin">
										<%--<asp:HyperLink runat="server" ID="hlEditHtmlTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />--%>
									</div>
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
					<td class="tdLabel textTop">
						<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectCategories.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectCategories.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" runat="server" Checked="True" Text="Display all categories and subcategories" resourcekey="cbdisplayallcatsResource1" />
						</div>
						<div id="tblSelectCategories" runat="server">
							<div>
								<div class="switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
								</div>
								<label for="<%=cbAutoAddCatChilds.ClientID %>"><%=_("cbAutoAddCatChildsResource1.Text") %></label>
							</div>
							<asp:PlaceHolder ID="phDinamicTreeView" runat="server"></asp:PlaceHolder>
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" ErrorMessage="Please select at least one category." Display="Dynamic" Enabled="False" resourcekey="cvCategoriesTreeview.ErrorMessage" ValidationGroup="vgSaveSettings" />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel textTop">
						<label for="<%=cbDisplayAllAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterAuthors.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterAuthors.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllAuthors" runat="server" Checked="True" Text="Display articles from all authors" />
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
				<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
					<tr>
						<td class="tdLabel width50">
							<label for="<%=lbSharingPortalID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideUnlocalizedItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblHideUnlocalizedItems.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbHideUnlocalizedItems" runat="server" Text="Do not display articles without translation for selected language" />
							</div>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<div class="sectionBoxSubtitle highlighted3">
				<span><%=_("Visibility")%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
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
			<p>
				<asp:Label ID="lblMainMessage" runat="server" EnableViewState="false" />
			</p>
			<div class="buttons" style="display: none">
				<asp:Button ID="btnSaveSettings" runat="server" OnClick="btnSaveSettings_Click" Text="Save" ValidationGroup="vgSaveSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:Button ID="btnSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSaveSettings" resourcekey="btnSaveCloseResource1" />
				<asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" Text="Close" resourcekey="btnCancelResource1" />
			</div>
		</div>
	</div>
</div>
