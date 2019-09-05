<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.Settings.SettingsFilterMenu, App_Web_settings.ascx.90a72b57" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/javascript">
	/* <![CDATA[ */
    <%=PortalSharingJS%>

	jQuery(function ($) {
		var cbAutoAddCat1 = document.getElementById('<%=cbAutoAddCatChilds2.ClientID%>');
		if (cbAutoAddCat1 != null) {
			$('#<%=phDinamicTreeView2.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
				state_checkbox: $('#<%=cbAutoAddCatChilds2.ClientID %>')
			});
		}

		$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
			if(this.checked)
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview2.ClientID %>'), false);
			else
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview2.ClientID %>'), true);

			$('#<%=rowCategoryFilter.ClientID%>').css('display', (this.checked ? 'none' : ''));
		});

		$('#<%=rowCategoryFilter.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));


		$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAdd.ClientID %>')
		});

		$('#<%=tblShowAuthorFilter2.ClientID%>').css('display', ($('#<%=cbShowAuthorFilter2.ClientID %>')[0].checked ? '' : 'none'));

		$('#<%=cbShowAuthorFilter2.ClientID %>').on('change', function () {
			$('#<%=tblShowAuthorFilter2.ClientID%>').css('display', (this.checked ? '' : 'none'));
		});

		$('#<%=rowOrderBySelection2.ClientID%>').css('display', ($('#<%=cbOrderBySection2.ClientID %>')[0].checked ? '' : 'none'));

		$('#<%=cbOrderBySection2.ClientID %>').on('change', function () {
			$('#<%=rowOrderBySelection2.ClientID%>').css('display', (this.checked ? '' : 'none'));
		});

		if ($('#<%=cbIsSocialInstance2.ClientID %>')[0].checked) {
			$('#<%=cbDisplayAllAuthors2.ClientID %>')[0].checked = true;
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
		}

		$('#<%=cbIsSocialInstance2.ClientID %>').on('change', function () {
			$('#<%=cbDisplayAllAuthors2.ClientID %>')[0].checked = true;
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
		});

		$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', ($('#<%=cbDisplayAllAuthors2.ClientID %>')[0].checked ? 'none' : ''));

		$('#<%=cbDisplayAllAuthors2.ClientID %>').on('change', function () {
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', (this.checked ? 'none' : ''));
		});

		FilterByContent_Init();

		$('#<%=rblFilterContent.ClientID %> input').change(function () {
			FilterByContent_Init()
		});

		$('#<%=tblCategoryFilter2.ClientID%>').css('display', ($('#<%=cbShowCategoryFilter2.ClientID %>')[0].checked ? '' : 'none'));

		$('#<%=cbShowCategoryFilter2.ClientID %>').on('change', function () {
			$('#<%=tblCategoryFilter2.ClientID%>').css('display', (this.checked ? '' : 'none'));
		});

	});

	function FilterByContent_Init() {
		$rblFilterContent = $('#<%=rblFilterContent.ClientID %> input:checked');

		if ($rblFilterContent.val() == 0) {
			$('#<%= rowFilterByEvents.ClientID %>').css('display', 'none');

			ValidatorEnable(document.getElementById('<%=rfvPastEventLimit2.ClientID %>'), false);
			ValidatorEnable(document.getElementById('<%=cvPastEventLimit2.ClientID %>'), false);
		}
		else {
			$('#<%= rowFilterByEvents.ClientID %>').css('display', '');
			ValidatorEnable(document.getElementById('<%=rfvPastEventLimit2.ClientID %>'), true);
			ValidatorEnable(document.getElementById('<%=cvPastEventLimit2.ClientID %>'), true);
		}
	}

	function CategoryClientValidate(source, arguments) {
		if ($('#<%=cbDisplayAllCategories.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}

		if ($('#<%=phDinamicTreeView2.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function ClientValidateAuthors(source, arguments) {
		if ($('#<%=cbDisplayAllAuthors2.ClientID%>')[0].checked) {
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
				var cbAutoAddCat4 = document.getElementById('<%=cbAutoAddCatChilds2.ClientID%>');
				if (cbAutoAddCat4 != null) {
					$('#<%=phDinamicTreeView2.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
						state_checkbox: $('#<%=cbAutoAddCatChilds2.ClientID %>')
					});
				}

				$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {
					$('#<%=rowCategoryFilter.ClientID%>').css('display', (this.checked ? 'none' : ''));
				});

				$('#<%=rowCategoryFilter.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));


				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
					state_checkbox: $('#<%=cbAutoAdd.ClientID %>')
				});

				$('#<%=tblShowAuthorFilter2.ClientID%>').css('display', ($('#<%=cbShowAuthorFilter2.ClientID %>')[0].checked ? '' : 'none'));

				$('#<%=cbShowAuthorFilter2.ClientID %>').on('change', function () {
					$('#<%=tblShowAuthorFilter2.ClientID%>').css('display', (this.checked ? '' : 'none'));
				});

				$('#<%=cbOrderBySection2.ClientID %>').on('change', function () {
					$('#<%=rowOrderBySelection2.ClientID%>').css('display', (this.checked ? '' : 'none'));
				});

				if ($('#<%=cbIsSocialInstance2.ClientID %>')[0].checked) {
					$('#<%=cbDisplayAllAuthors2.ClientID %>')[0].checked = true;
					$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
				}

				$('#<%=cbIsSocialInstance2.ClientID %>').on('change', function () {
					$('#<%=cbDisplayAllAuthors2.ClientID %>')[0].checked = true;
					$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('disabled', 'disabled');
				});

				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', ($('#<%=cbDisplayAllAuthors2.ClientID %>')[0].checked ? 'none' : ''));

				$('#<%=cbDisplayAllAuthors2.ClientID %>').on('change', function () {
					$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', (this.checked ? 'none' : ''));
				});

				FilterByContent_Init();

				$('#<%=rblFilterContent.ClientID %> input').change(function () {
					FilterByContent_Init()
				});

				$('#<%=tblCategoryFilter2.ClientID%>').css('display', ($('#<%=cbShowCategoryFilter2.ClientID %>')[0].checked ? '' : 'none'));

				$('#<%=cbShowCategoryFilter2.ClientID %>').on('change', function () {
					$('#<%=tblCategoryFilter2.ClientID%>').css('display', (this.checked ? '' : 'none'));
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
	<asp:Panel ID="pnlPortalSharing2" runat="server">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("PortalSharing")%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td class="tdLabel">
					<label for="<%=lbSharingPortalID2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPortalSharing.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPortalSharing.Text") %></label>
				</td>
				<td>
					<asp:ListBox runat="server" ID="lbSharingPortalID2" SelectionMode="Multiple" Style="width: 330px"></asp:ListBox>
					<asp:HiddenField runat="server" ID="hfSelectedSharingPortalID2" />
					<div class="mainActions displayInline noMargin smallActions">
						<asp:Button ID="btnSharingPortal2" runat="server" CssClass="primaryAction" Text="Set portals" resourcekey="btnSharingPortal" OnClick="btnSharingPortal_Click" />
					</div>
				</td>
			</tr>
		</table>
	</asp:Panel>
	<asp:Panel ID="pnlSocialInstance2" runat="server" Style="display: none;">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("socialSettings.Text")%>Social settings</span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5">
			<tr>
				<td class="tdLabel">
					<label for="<%=cbIsSocialInstance2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSocialInstance2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblIsSocialInstance2.Text") %></label>
				</td>
				<td>
					<div class="switchCheckbox">
						<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance2" runat="server" Checked="false" Text=" " />
					</div>
				</td>
			</tr>
		</table>
	</asp:Panel>
	<div id="pnlContentSelection" runat="server">
		<div class="sectionBoxSubtitle highlighted3">
			<span><%=_("ContentSelection")%></span>
		</div>
		<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
			<tr>
				<td class="tdLabel">
					<label for="<%=rblFilterContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterBy.Help", true) %>" data-tooltip-position="top-right"><%=_("lblFilterBy.Text") %></label>
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
					<label for="<%=rblLimitBackEvents2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterByEventsLimit.Help", true) %>" data-tooltip-position="top-right"><%=_("lblFilterByEventsLimit.Text") %></label>
				</td>
				<td>
					<div class="edNews_inputGroup displayInline">
						<asp:RadioButtonList ID="rblLimitBackEvents2" runat="server" CssClass="inlineList smallRadio styledRadio" RepeatLayout="UnorderedList">
							<asp:ListItem class="normalRadioButton" Value="0" Text="Show all" resourcekey="liShowAll" />
							<asp:ListItem class="normalRadioButton" Value="1" Text="Show only past events" resourcekey="liShowOnlyPastEvents" />
							<asp:ListItem class="normalRadioButton" Value="2" Text="Limit to number of days:" resourcekey="liLimitToNumberOfDays" Selected="True" />
						</asp:RadioButtonList>
					</div>
					<asp:TextBox ID="tbPastEventLimit2" runat="server" CssClass="smallCentered" Text="0" />
					<asp:RequiredFieldValidator ID="rfvPastEventLimit2" runat="server" ControlToValidate="tbPastEventLimit2" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgCatMenuSettings2" />
					<asp:CompareValidator ID="cvPastEventLimit2" runat="server" ControlToValidate="tbPastEventLimit2" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgCatMenuSettings2" />
				</td>
			</tr>
		</table>
	</div>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=_("FilterMenuSpecificOptions.Text")%></span>
	</div>
	<table class="optionsList fullWidthTable tablePadding5">
		<tr>
			<td class="tdLabel">
				<label for="<%=ddlOpenDetails2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectModule.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectModule.Text") %></label>
			</td>
			<td>
				<asp:DropDownList ID="ddlOpenDetails2" runat="server" />
			</td>
		</tr>
	</table>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=_("Theme.Text")%></span>
	</div>
	<asp:UpdatePanel ID="upModuleTheme2" runat="server" OnUnload="UpdatePanel_Unload">
		<ContentTemplate>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlTheme2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTheme.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlTheme2" runat="server" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged" AutoPostBack="True" ValidationGroup="vgCatMenuSettings2" />
						<asp:CompareValidator ID="cvThemeSelect2" resourcekey="cvThemeSelect.ErrorMessage" runat="server" ForeColor="Red" ControlToValidate="ddlTheme2" Display="Dynamic" ErrorMessage=" Please select theme." Operator="NotEqual" ValidationGroup="vgCatMenuSettings2"
							ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlThemeStyle2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeStyle2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblThemeStyle2.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlThemeStyle2" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlThemeHTMLTemplate2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeHTMLTemplate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblThemeHTMLTemplate.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlThemeHTMLTemplate2" runat="server" ValidationGroup="vgCatMenuSettings2" />
						<asp:CompareValidator ID="cvThemeHTMLTemplate" runat="server" ForeColor="Red" ControlToValidate="ddlThemeHTMLTemplate2" Display="Dynamic" ErrorMessage=" Please select HTML template" Operator="NotEqual" ValidationGroup="vgCatMenuSettings2" ValueToCompare="" />
					</td>
				</tr>
			</table>
		</ContentTemplate>
	</asp:UpdatePanel>
	<asp:UpdateProgress ID="uppTheme2" runat="server" AssociatedUpdatePanelID="upModuleTheme2" DisplayAfter="100" DynamicLayout="true">
		<ProgressTemplate>
			<img alt="ajaxLoading" src="<%=Regex.Replace(_ControlPath, "EasyDNNnewsWidgets/Controls/FilterMenu/Settings", "EasyDNNnews", RegexOptions.IgnoreCase)%>images/settings/ajaxLoading.gif" />
		</ProgressTemplate>
	</asp:UpdateProgress>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=_("Filter.Text")%></span>
	</div>
	<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
		<tr>
			<td class="tdLabel">
				<label for="<%=cbShowCategoryFilter2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCategoryFilter2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowCategoryFilter2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCategoryFilter2" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
	</table>
	<table runat="server" id="tblCategoryFilter2" class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
		<tr>
			<td class="tdLabel">
				<label for="<%=cbUseAndOperatorByCategory2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUseAndOperatorByCategory2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblUseAndOperatorByCategory2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbUseAndOperatorByCategory2" runat="server" Checked="false" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbExpandAllCategories2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExpandAllCategories2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblExpandAllCategories2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbExpandAllCategories2" runat="server" Checked="false" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbShowCategoryArticleCount2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCategoryArticleCount2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowCategoryArticleCount2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCategoryArticleCount2" runat="server" Checked="false" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectCats.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectCats.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" resourcekey="cbdisplayallcats" runat="server" Checked="True" Text="Display all categories and subcategories" />
				</div>
				<label><%=_("cbdisplayallcats")%></label>
				<div runat="server" id="rowCategoryFilter">
					<div>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds2" resourcekey="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." />
						</div>
						<span><%=_("cbAutoAddCatChilds")%></span>
					</div>
					<asp:PlaceHolder ID="phDinamicTreeView2" runat="server" />
					<asp:CustomValidator ID="cvCategoriesTreeview2" resourcekey="cvCategoriesTreeview.ErrorMessage" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="vgCatMenuSettings2" />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbShowAuthorFilter2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowAuthorFilter2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowAuthorFilter2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbShowAuthorFilter2" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
	</table>
	<table runat="server" id="tblShowAuthorFilter2" class="optionsList fullWidthTable tablePadding5">
		<tr>
			<td class="tdLabel">
				<label for="<%=cbExpandAllAuthors2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExpandAllAuthors2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblExpandAllAuthors2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbExpandAllAuthors2" runat="server" Checked="false" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel">
				<label for="<%=cbShowAuthorsArticleCount2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowAuthorsArticleCount2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowAuthorsArticleCount2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbShowAuthorsArticleCount2" runat="server" Checked="false" Text=" " />
				</div>
			</td>
		</tr>
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=cbDisplayAllAuthors2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorFilter.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorFilter.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllAuthors2" runat="server" Checked="True" Text=" " />
				</div>
				<asp:PlaceHolder ID="phGroupsAndAuthorsTreeView" runat="server" />
				<asp:CustomValidator ID="cvAuthorsTreeview2" resourcekey="cvAuthorsTreeview.ErrorMessage" runat="server" CssClass="smallInfo error" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" ErrorMessage="Please select at least one author." ValidationGroup="vgCatMenuSettings2" />
			</td>
		</tr>
	</table>
	<table class="optionsList fullWidthTable tablePadding5">
		<tr>
			<td class="tdLabel textTop">
				<label for="<%=rblPostBackType2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPostBackType2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPostBackType2.Text") %></label>
			</td>
			<td>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblPostBackType2" runat="server" CssClass="verticalList smallRadio styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem class="normalRadioButton" resourcekey="liPerSelection" Text="Per selection" Value="0" Selected="True" />
						<asp:ListItem class="normalRadioButton" resourcekey="liButtonClick" Text="Button click" Value="1" />
					</asp:RadioButtonList>
				</div>
			</td>
		</tr>
	</table>
	<div class="sectionBoxSubtitle highlighted3">
		<span><%=_("OrderBy.Text")%></span>
	</div>

	<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
		<tr>
			<td class="tdLabel">
				<label for="<%=cbOrderBySection2.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOrderBySection2.Help", true) %>" data-tooltip-position="top-right"><%=_("lblOrderBySection2.Text") %></label>
			</td>
			<td>
				<div class="switchCheckbox">
					<asp:CheckBox CssClass="normalCheckBox" ID="cbOrderBySection2" runat="server" Checked="True" Text=" " />
				</div>
			</td>
		</tr>
		<tr runat="server" id="rowOrderBySelection2">
			<td colspan="2">
				<asp:GridView ID="gvOrderBySelection2" runat="server" ShowHeader="False" AutoGenerateColumns="False" CellPadding="0" GridLines="None" HorizontalAlign="Center">
					<AlternatingRowStyle CssClass="second" />
					<Columns>
						<asp:TemplateField>
							<ItemTemplate>
								<asp:Label ID="lblOrderByName2" runat="server" Text='<%# Eval("OrderByName") %>' />
							</ItemTemplate>
						</asp:TemplateField>
						<asp:TemplateField>
							<ItemTemplate>
								<asp:HiddenField ID="hfOrderByID2" runat="server" Value='<%# Eval("OrderByID") %>' />
								<div class="switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbSelected2" runat="server" Checked='<%# Eval("Selected") %>' Text=" " />
								</div>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
				</asp:GridView>
			</td>
		</tr>
	</table>

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
	<asp:Label ID="lblCategoriesMenuInfo" runat="server" EnableViewState="False" />
</div>
