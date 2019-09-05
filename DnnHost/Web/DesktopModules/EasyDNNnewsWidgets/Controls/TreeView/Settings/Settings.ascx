<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.Settings.SettingsTreeView, App_Web_settings.ascx.432bf0fe" %>
<script type="text/javascript">
	/* <![CDATA[ */
    <%=PortalSharingJS%>

	jQuery(function ($) {
		var cbAutoAddCat1 = document.getElementById('<%=cbAutoAddCatChilds.ClientID%>');
		if (cbAutoAddCat1 != null) {
			$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
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

		ShowArticles_Init();

		$('#<%=cbShowArticles.ClientID %>').on('change', function () {
			ShowArticles_Init();
		});

		$('#<%=rblFilterContent.ClientID %> input').change(function () {
			FilterByContent_Init()
		});

		CategoriesExpand_Init();
		$('#<%=rblExpandCategories.ClientID %> input').change(function () {
			CategoriesExpand_Init()
		});
	});

	function ShowArticles_Init() {
		if ($('#<%=cbShowArticles.ClientID %>')[0].checked) {

			$('#<%=rowOrderArticlesBy.ClientID %>').css('display', '');
			$('#<%=rowFilterBy.ClientID %>').css('display', '');

			FilterByContent_Init();
		}
		else {
			$('#<%=rowOrderArticlesBy.ClientID %>').css('display', 'none');
			$('#<%=rowFilterBy.ClientID %>').css('display', 'none');
			$('#<%=rowFilterByEvents.ClientID %>').css('display', 'none');
			ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), false);
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

	function FilterByContent_Init() {

		$rblFilterContent = $('#<%=rblFilterContent.ClientID %> input:checked');
		$ddlOrderArticlesBy = $('#<%= ddlOrderArticlesBy.ClientID %>');

		if ($rblFilterContent.val() == 0) {
			$('#<%= rowFilterByEvents.ClientID %>').css('display', 'none');

			if ($ddlOrderArticlesBy.val() == 'StartDate')
				$ddlOrderArticlesBy.val('PublishDate')

			$("#<%= ddlOrderArticlesBy.ClientID %> option[value='StartDate']").attr('disabled', true);
			ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), false);
		}
		else {
			$('#<%= rowFilterByEvents.ClientID %>').css('display', '');
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
				var cbAutoAddCat2 = document.getElementById('<%=cbAutoAddCatChilds.ClientID%>');
				if (cbAutoAddCat2 != null) {
					$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
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

				ShowArticles_Init();

				$('#<%=cbShowArticles.ClientID %>').on('change', function () {
					ShowArticles_Init();
				});

				$('#<%=rblFilterContent.ClientID %> input').change(function () {
					FilterByContent_Init()
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
<div class="sectionBox noPadding">
	<div class="sectionBoxHeader">
		<span class="sectionBoxHeaderTitle"><%=SettingsTitle%></span>
	</div>
	<asp:Panel ID="pnlPortalSharing" runat="server">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=Portalsharing%></span>
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
	<div id="pnlContentSelection" runat="server">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=ContentSelection %></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
			<tr>
				<td class="tdLabel">
					<label for="<%=cbShowArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowArticles.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowArticles.Text") %></label>
				</td>
				<td>
					<div class="switchCheckbox">
						<asp:CheckBox CssClass="normalCheckBox" ID="cbShowArticles" runat="server" Checked="True" Text=" " />
					</div>
				</td>
			</tr>
			<tr runat="server" id="rowOrderArticlesBy">
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
			<tr runat="server" id="rowFilterBy">
				<td class="tdLabel">
					<label for="<%=rblFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterBy.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterBy.Text") %></label>
				</td>
				<td>
					<div class="edNews_inputGroup">
						<asp:RadioButtonList runat="server" ID="rblFilterContent" CssClass="inlineList smallRadio styledRadio" RepeatLayout="UnorderedList">
							<asp:ListItem Value="0" class="normalRadioButton" Text="Articles" resourcekey="Articles" />
							<asp:ListItem Value="1" class="normalRadioButton" Text="Events" resourcekey="Events" />
							<asp:ListItem Value="2" class="normalRadioButton" Text="All" Selected="True" resourcekey="liAll" />
						</asp:RadioButtonList>
					</div>
				</td>
			</tr>
			<tr runat="server" id="rowFilterByEvents">
				<td class="tdLabel">
					<label for="<%=rblLimitBackEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowOnlyEventsLimit.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowOnlyEventsLimit.Text") %></label>
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
					<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgCatMenuSettings" />
					<asp:CompareValidator ID="cvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgCatMenuSettings" />
				</td>
			</tr>
		</table>
	</div>
	<asp:Panel ID="pnlSocialInstance" runat="server" Style="display: none;">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("SocialSettings.Text")%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td class="tdLabel">
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
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=Permissions%></span>
	</div>
	<table class="optionsList fullWidthTable tablePadding5">
		<tr>
			<td class="tdLabel">
				<label for="<%=rblCategoryPermissionSource.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPermissionSource.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPermissionSource.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup dispalyInline">
					<asp:RadioButtonList ID="rblCategoryPermissionSource" runat="server" OnSelectedIndexChanged="rblCategoryPermissionSource_SelectedIndexChanged" AutoPostBack="True" CssClass="inlineList smallRadio styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem class="normalRadioButton" ResourceKey="liNone" Selected="True" Text="None" Value="0" />
						<asp:ListItem class="normalRadioButton" ResourceKey="liPortal" Text="Portal" Value="1" />
						<asp:ListItem class="normalRadioButton" ResourceKey="liModule" Text="Module" Value="2" />
					</asp:RadioButtonList>
				</div>
				<asp:Panel ID="pnlCategoryModuleInherite" runat="server" Visible="False">
					<asp:DropDownList ID="ddlPermFromModuleInstance" runat="server" />
				</asp:Panel>
			</td>
		</tr>
	</table>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=Menuspecificoptions%></span>
	</div>
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
				<label for="<%=rblExpandCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExpandAllCategories.Help", true) %>" data-tooltip-position="top-right"><%=_("lblExpandAllCategories.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup displayInline">
					<asp:RadioButtonList runat="server" ID="rblExpandCategories" CssClass="inlineList smallRadio styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Value="0" class="normalRadioButton" Text="None" resourcekey="liNone" Selected="True" />
						<asp:ListItem Value="1" class="normalRadioButton" Text="All" resourcekey="liAll" />
						<asp:ListItem Value="2" class="normalRadioButton" Text="To level" resourcekey="liToLevel" />
					</asp:RadioButtonList>
				</div>
				<div runat="server" id="rowExpandCategoriesToLevel" class="edNews_inputGroup displayInline">
					<asp:TextBox ID="tbxnodeExpandLevel" runat="server" MaxLength="1" ValidationGroup="vgCatMenuSettings" CssClass="smallCentered" Text="1" />
					<asp:RequiredFieldValidator ID="rfvnodeExpandLevel" runat="server" ForeColor="Red" ErrorMessage="This filed is required." ControlToValidate="tbxnodeExpandLevel" ValidationGroup="vgCatMenuSettings" />
					<asp:RangeValidator ID="rvnodeExpandLevel" runat="server" ForeColor="Red" ErrorMessage="Enter value between 1 - 9." ControlToValidate="tbxnodeExpandLevel" ValidationGroup="vgCatMenuSettings" Display="Dynamic" MaximumValue="9" MinimumValue="1" Type="Integer" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbPassAuthorUserID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPassAuthorUserID.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPassAuthorUserID.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbPassAuthorUserID" runat="server" Checked="false" Text=" " />
				</div>
			</td>
		</tr>
	</table>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=Theme%></span>
	</div>
	<asp:UpdatePanel ID="upModuleTheme" runat="server" OnUnload="UpdatePanel_Unload">
		<ContentTemplate>
			<table class="optionsList fullWidthTable tablePadding5">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTheme.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlTheme" runat="server" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged" AutoPostBack="True" ValidationGroup="vgCatMenuSettings" />
						<asp:CompareValidator ID="cvThemeSelect" resourcekey="cvThemeSelect.ErrorMessage" runat="server" ForeColor="Red" ControlToValidate="ddlTheme" Display="Dynamic" ErrorMessage=" Please select theme." Operator="NotEqual" ValidationGroup="vgCatMenuSettings"
							ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlThemeStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeStyle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblThemeStyle.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlThemeStyle" runat="server" ValidationGroup="vgCatMenuSettings" />
						<asp:CompareValidator ID="cvdisplayStyleSelect" runat="server" ForeColor="Red" ControlToValidate="ddlThemeStyle" Display="Dynamic" ErrorMessage=" Please select theme style" Operator="NotEqual" ValidationGroup="vgCatMenuSettings" ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel width40">
						<label for="<%=ddlHTMLTemplates.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleTheme.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlHTMLTemplates" runat="server" />
						<asp:CompareValidator ID="cvHTMLTemplate" runat="server" CssClass="smallInfo error" ControlToValidate="ddlHTMLTemplates" Display="Dynamic" ErrorMessage="Please select HTML template." Operator="NotEqual" ValidationGroup="vgCatMenuSettings" ValueToCompare="" />
					</td>
				</tr>
			</table>
		</ContentTemplate>
	</asp:UpdatePanel>
	<asp:UpdateProgress ID="uppTheme" runat="server" AssociatedUpdatePanelID="upModuleTheme" DisplayAfter="100" DynamicLayout="true">
		<ProgressTemplate>
			<img alt="ajaxLoading" src="<%=Regex.Replace(ControlPath, "EasyDNNnewsWidgets/Controls/TreeView/Settings", "EasyDNNnews", RegexOptions.IgnoreCase)%>images/settings/ajaxLoading.gif" />
		</ProgressTemplate>
	</asp:UpdateProgress>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=Filter%></span>
	</div>
	<table class="optionsList fullWidthTable tablePadding5">
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCelectCats.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCelectCats.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" resourcekey="cbdisplayallcats" runat="server" Checked="True" Text="Display all categories and subcategories" />
				</div>
				<label><%=_("cbdisplayallcats.Text")%></label>
				<div runat="server" id="rowCategoryFilter">
					<div>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" resourcekey="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." />
						</div>
						<span><%=_("cbAutoAddCatChilds.Text")%></span>
					</div>
					<asp:PlaceHolder ID="phDinamicTreeView" runat="server" />
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
				<asp:CustomValidator ID="cvAuthorsTreeview" resourcekey="cvAuthorsTreeview.ErrorMessage" runat="server" ForeColor="Red" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one author." ValidationGroup="vgCatMenuSettings" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<asp:Label ID="lblCategoriesMenuInfo" runat="server" EnableViewState="False" />
			</td>
		</tr>
	</table>
	<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=LocalizationText%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td class="tdLabel width50">
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
</div>
<div class="main_actions">
	<p>
		<asp:CustomValidator ID="cvCategoriesTreeview" resourcekey="cvCategoriesTreeview.ErrorMessage" runat="server" ForeColor="Red" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category."
			ValidationGroup="vgCatMenuSettings" />
	</p>
</div>
