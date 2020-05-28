<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.ContentBlocks.Settings.SettingsContentBlocks, App_Web_settings.ascx.1edb1f7b" %>
<script type="text/javascript">
	/* <![CDATA[ */
	<%=PortalSharingJS%>

	jQuery(function ($) {

		var cbAutoAddCat1 = document.getElementById('<%=cbAutoAddCatChilds.ClientID%>');
		if (cbAutoAddCat1 != null) {
			$('#<%=phCategoriesTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
				state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
			});
		}

		$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
			if (this.checked)
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), false);
			else
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), true);

			$('#<%=rowCategoryFilter.ClientID%>').css('display', (this.checked ? 'none' : ''));
		});

		$('#<%=rowCategoryFilter.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));


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

		FilterByContent_Init();

		$('#<%=rblFilterContent.ClientID %> input').change(function () {
			FilterByContent_Init()
		});

		if ($('#<%= rblRestrictionByDateRange.ClientID %> input:checked').val() == 0) {
			$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', 'none');
		}
		else {
			$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', '');
		}

		$('#<%= rblRestrictionByDateRange.ClientID %> input').change(function () {
			if ($(this).val() == 0) {
				$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', 'none');
			}
			else {
				$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', '');
			}
		});
	});

	function FilterByContent_Init() {
		$rblFilterContent = $('#<%=rblFilterContent.ClientID %> input:checked');
		$ddlOrderArticlesBy = $('#<%= ddlOrderArticlesBy.ClientID %>');

		if ($rblFilterContent.val() == 0) {
			$('#<%= rowfilterbyEvents.ClientID %>').css('display', 'none');

			if ($ddlOrderArticlesBy.val() == 'StartDate')
				$ddlOrderArticlesBy.val('PublishDate')

			$("#<%= ddlOrderArticlesBy.ClientID %> option[value='StartDate']").attr('disabled', true);
			ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), false);
		}
		else {
			$('#<%= rowfilterbyEvents.ClientID %>').css('display', '');
			$("#<%= ddlOrderArticlesBy.ClientID %> option[value='StartDate']").attr('disabled', false);
			ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), true);
		}
	}

	function CategoryClientValidate(source, arguments) {
		if ($('#<%=cbDisplayAllCategories.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}

		if ($('#<%=phCategoriesTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
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
				var cbAutoAddCat2 = document.getElementById('<%=cbAutoAddCatChilds.ClientID%>');
				if (cbAutoAddCat2 != null) {
					$('#<%=phCategoriesTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
						state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
					});
				}

				$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
					$('#<%=rowCategoryFilter.ClientID%>').css('display', (this.checked ? 'none' : ''));
				});

				$('#<%=rowCategoryFilter.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));

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

				FilterByContent_Init();

				$('#<%=rblFilterContent.ClientID %> input').change(function () {
					FilterByContent_Init();
				});
			});
		}
	}
	/* ]]> */
</script>
<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAdd" runat="server" Checked="true" Style="display: none" />
<div class="sectionBox noPadding">
	<div class="sectionBoxHeader">
		<span class="sectionBoxHeaderTitle"><%=_("SettingsTitle")%></span>
	</div>
	<asp:Panel ID="pnlPortalSharing" runat="server">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("PortalSharing")%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td class="tdLabel">
					<label for="<%=lbSharingPortalID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPortalSharing.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPortalSharing.Text") %></label>
				</td>
				<td>
					<asp:ListBox runat="server" ID="lbSharingPortalID" SelectionMode="Multiple" Style="width: 330px"></asp:ListBox>
					<asp:HiddenField runat="server" ID="hfSelectedSharingPortalID" />
					<div class="mainActions displayInline noMargin smallActions">
						<asp:Button ID="btnSharingPortal" runat="server" CssClass="primaryAction" Text="Set portals" resourcekey="btnSharingPortal" OnClick="btnSharingPortal_Click" />
					</div>
				</td>
			</tr>
		</table>
	</asp:Panel>
	<asp:Panel ID="pnlSocialInstance" runat="server" Style="display: none;">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("SocialSettings.Text")%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td>
					<label for="<%=cbIsSocialInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSocialInstance.Help", true) %>" data-tooltip-position="top-right"><%=_("lblIsSocialInstance.Text") %></label>
				</td>
				<td>
					<div class="switchCheckbox">
						<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance" runat="server" Checked="false" Text=" " />
					</div>
				</td>
			</tr>
		</table>
	</asp:Panel>
	<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
		<tr>
			<td class="tdLabel">
				<label for="<%=cbDisplayHeader.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayHeader.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayHeader.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayHeader" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=ddlOpenDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectModule.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectModule.Text") %></label>
			</td>
			<td>
				<asp:DropDownList ID="ddlOpenDetails" runat="server" />
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbHtmlTemplateCategoryFilter.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHtmlTemplateCategoryFilter.Help", true) %>" data-tooltip-position="top-right"><%=_("lblHtmlTemplateCategoryFilter.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbHtmlTemplateCategoryFilter" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbIsPaginationEnabled.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsPaginationEnabled.Help", true) %>" data-tooltip-position="top-right"><%=_("lblIsPaginationEnabled.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbIsPaginationEnabled" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbShowAllCategoriesButton.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowAllCategoriesButton.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowAllCategoriesButton.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbShowAllCategoriesButton" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
	</table>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=_("Theme.Text")%></span>
	</div>
	<asp:UpdatePanel ID="upModuleTheme" runat="server" OnUnload="UpdatePanel_Unload">
		<ContentTemplate>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTheme.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlTheme" runat="server" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged" AutoPostBack="True" ValidationGroup="vgContentBlocks" />
						<asp:CompareValidator ID="cvThemeSelect" resourcekey="SelectTheme.ErrorMessage" runat="server" ForeColor="Red" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage="Please select theme." Operator="NotEqual" ValidationGroup="vgContentBlocks"
							ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlThemeStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeStyle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblThemeStyle.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlThemeStyle" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlListTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblListTemplate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblListTemplate.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlListTemplate" runat="server" />
						<asp:RequiredFieldValidator ID="rfvHtmlTemplate" runat="server" ControlToValidate="ddlListTemplate" InitialValue="" ForeColor="Red" ValidationGroup="vgContentBlocks" resourcekey="SelectHtmlTemplate.ErrorMessage"></asp:RequiredFieldValidator>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbLoadContentOnHover.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLoadContentOnHover.Help", true) %>" data-tooltip-position="top-right"><%=_("lblLoadContentOnHover.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbLoadContentOnHover" runat="server" Checked="false" Text=" " />
						</div>
					</td>
				</tr>
			</table>
		</ContentTemplate>
	</asp:UpdatePanel>
	<asp:UpdateProgress ID="uppTheme" runat="server" AssociatedUpdatePanelID="upModuleTheme" DisplayAfter="100" DynamicLayout="true">
		<ProgressTemplate>
			<img alt="ajaxLoading" src="<%=Regex.Replace(ControlPath, "EasyDNNnewsWidgets/Controls/ContentBlocks/Settings", "EasyDNNnews", RegexOptions.IgnoreCase)%>images/settings/ajaxLoading.gif" />
		</ProgressTemplate>
	</asp:UpdateProgress>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=_("Filter")%></span>
	</div>
	<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
		<tr>
			<td class="tdLabel">
				<label for="<%=tbNumberOfStartingArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfStartingArticle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfStartingArticle.Text") %></label>
			</td>
			<td>
				<asp:TextBox ID="tbNumberOfStartingArticle" runat="server" Text="1" CssClass="smallCentered" />
				<asp:RequiredFieldValidator ID="rfvNumberOfStartingArticle" runat="server" ControlToValidate="tbItemsPerPage" Display="Dynamic" resourcekey="ThisFiledIsRequired.ErrorMessage" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgContentBlocks" />
				<asp:CompareValidator runat="server" ID="cvNumberOfStartingArticle" ControlToValidate="tbItemsPerPage" Operator="GreaterThan" ValueToCompare="0" Type="Integer" resourcekey="MustBeGreaterThanZero.ErrorMessage" ErrorMessage="Must be greater than 0!" ValidationGroup="vgContentBlocks" />
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=tbItemsPerPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblItemsPerPage.Help", true) %>" data-tooltip-position="top-right"><%=_("lblItemsPerPage.Text") %></label>
			</td>
			<td>
				<asp:TextBox ID="tbItemsPerPage" runat="server" Text="10" CssClass="smallCentered" />
				<asp:RequiredFieldValidator ID="rfvItemsPerPage" runat="server" ControlToValidate="tbItemsPerPage" Display="Dynamic" resourcekey="ThisFiledIsRequired.ErrorMessage" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgContentBlocks" />
				<asp:CompareValidator runat="server" ID="cvItemsPerPage" ControlToValidate="tbItemsPerPage" Operator="GreaterThan" ValueToCompare="0" Type="Integer" resourcekey="MustBeGreaterThanZero.ErrorMessage" ErrorMessage="Must be greater than 0!" ValidationGroup="vgContentBlocks" />
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=ddlOrderArticlesBy.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPostOrder.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPostOrder.Text") %></label>
			</td>
			<td>
				<asp:DropDownList ID="ddlOrderArticlesBy" runat="server"></asp:DropDownList>
				&nbsp;
				<asp:DropDownList ID="ddlAscOrder" runat="server">
					<asp:ListItem Value="DESC" resourcekey="liDESC">Descending</asp:ListItem>
					<asp:ListItem Value="ASC" resourcekey="liASC">Ascending</asp:ListItem>
				</asp:DropDownList>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=rblRestrictionByDateRange.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRestrictionByDateRange.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRestrictionByDateRange.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblRestrictionByDateRange" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Value="0" class="normalRadioButton" Text="No restriction" Selected="True" resourcekey="liNoRestriction" />
						<asp:ListItem Value="1" class="normalRadioButton" Text="Number of days from current date" resourcekey="liNumberOfDaysFromCurrentDate" />
					</asp:RadioButtonList>
				</div>
				<asp:TextBox ID="tbxRestrictionByDateRange" runat="server" Width="50px" Style="display: none" CssClass="smallCentered"></asp:TextBox>
			</td>
		</tr>
		<tr runat="server">
			<td class="tdLabel">
				<label for="<%=rblFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterBy.Help", true) %>" data-tooltip-position="top-right"><%=_("lblFilterBy.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList runat="server" ID="rblFilterContent" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Value="0" class="normalRadioButton" Text="Articles" resourcekey="liArticles" />
						<asp:ListItem Value="1" class="normalRadioButton" Text="Events" resourcekey="liEvents" />
						<asp:ListItem Value="2" class="normalRadioButton" Text="All" Selected="True" resourcekey="liAll" />
					</asp:RadioButtonList>
				</div>
			</td>
		</tr>
		<tr runat="server" id="rowfilterbyEvents">
			<td class="tdLabel">
				<label for="<%=rblLimitBackEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterByEventsLimit.Help", true) %>" data-tooltip-position="top-right"><%=_("lblFilterByEventsLimit.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup displayInline">
					<asp:RadioButtonList ID="rblLimitBackEvents" runat="server" CssClass="inlineList smallRadio styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem class="normalRadioButton" Value="0" Text="Show all" resourcekey="liShowAll" />
						<asp:ListItem class="normalRadioButton" Value="1" Text="Show only past events" resourcekey="liShowOnlyPastEvents" />
						<asp:ListItem class="normalRadioButton" Value="2" Text="Limit to number of days:" resourcekey="liLimitToNumberOfDays" Selected="True" />
					</asp:RadioButtonList>
				</div>
				<asp:TextBox ID="tbPastEventLimit" runat="server" CssClass="smallCentered" Text="0" />
				<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" resourcekey="ThisFiledIsRequired.ErrorMessage" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgContentBlocks" />
				<asp:CompareValidator ID="cvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" resourcekey="PleaseEnterNumberOnly.ErrorMessage" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgContentBlocks" />
			</td>
		</tr>
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectCategories.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectCategories.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" resourcekey="DisplayAllCategories" runat="server" Checked="True" Text="Display all categories and subcategories" />
				</div>
				<label><%=_("DisplayAllCategories.Text")%></label>
				<div runat="server" id="rowCategoryFilter">
					<div>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" resourcekey="CascadeCategorySelection" runat="server" Text="Auto select all child categories." />
						</div>
						<span><%=_("CascadeCategorySelection.Text")%></span>
					</div>
					<asp:PlaceHolder ID="phCategoriesTreeView" runat="server" />
					<asp:CustomValidator ID="cvCategoriesTreeview" resourcekey="cvCategoriesTreeview.ErrorMessage" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" ErrorMessage="Please select at least one category." ValidationGroup="vgContentBlocks" Enabled="false" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=cbDisplayAllAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorFilter.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorFilter.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllAuthors" runat="server" Checked="True" Text=" " />
				</div>
				<asp:PlaceHolder ID="phGroupsAndAuthorsTreeView" runat="server" />
				<asp:CustomValidator ID="cvGroupAndAuthorsTreeview" resourcekey="PleaseSelectAtLeastOneAuthor.ErrorMessage" runat="server" CssClass="smallInfo error" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" ErrorMessage="Please select at least one author." ValidationGroup="vgContentBlocks" />
			</td>
		</tr>
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=rblFeaturedArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFeaturedArticles.Help", true) %>" data-tooltip-position="top-right"><%=_("lblFeaturedArticles.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList runat="server" ID="rblFeaturedArticles" CssClass="verticalList smallRadio styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Value="0" class="normalRadioButton" Text="Default" resourcekey="liDefault" Selected="True" />
						<asp:ListItem Value="1" class="normalRadioButton" Text="Show only featured articles" resourcekey="liShowOnlyFeaturedArticles" />
						<asp:ListItem Value="2" class="normalRadioButton" Text="Keep featured articles on top" resourcekey="liKeepFeaturedArticlesOnTop" />
					</asp:RadioButtonList>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: center; color: Red;">
				<asp:Label ID="lblCategoriesMenuInfo" runat="server" EnableViewState="False" />
			</td>
		</tr>
	</table>
	<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("LocalizationText")%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td class="tdLabel">
					<label for="<%=cbHideUnlocalizedItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideUnlocalizedItems.Help", true) %>" data-tooltip-position="top-right"><%=_("lblHideUnlocalizedItems.Text") %></label>
				</td>
				<td>
					<div class="switchCheckbox">
						<asp:CheckBox CssClass="normalCheckBox" ID="cbHideUnlocalizedItems" runat="server" Text=" " />
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
			<td class="tdLabel textTop">
				<label for="<%=rblModuleVisibility.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleVisibility.Help", true) %>" data-tooltip-position="top-right"><%=_("lblModuleVisibility.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblModuleVisibility" runat="server" CssClass="verticalList smallRadio styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem class="normalRadioButton" resourcekey="liDefaultAlwaysShowModule" Selected="True" Text="Default (always show module)" Value="0" />
						<asp:ListItem class="normalRadioButton" resourcekey="liVisibleOnlyIfArticleListMode" Text="Visible only if article list mode" Value="1" />
						<asp:ListItem class="normalRadioButton" resourcekey="liVisibleOnlyIfArticleDetailsMode" Text="Visible only if article details mode" Value="2" />
					</asp:RadioButtonList>
				</div>
			</td>
		</tr>
	</table>
</div>
