<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.Administration.CustomFieldsManager, App_Web_customfields.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
	// <![CDATA[

	eds2_2(function ($) {
		<%=IncludeJavaScript%>

		var treeView = document.getElementById('<%= tvAuthorAndGroupSelection.ClientID %>');
		if (treeView != null) {
			var allNodes = treeView.childNodes;
			for (var i = 0; i < allNodes.length; i++) {
				var tab = allNodes[i];

				var table = $(allNodes[i]).closest("table");

				if (table.next().length > 0 && table.next()[0].tagName == "DIV") {

					var childDiv = table.next();

					$("input[type=checkbox]", table).each(function () {
						var isChecked = $(this).attr('checked');

						if (isChecked) {
							$("input[type=checkbox]", childDiv).each(function () {
								$(this).attr("checked", "checked");
								$(this).attr("disabled", "true");
							});
						}
					})
				}
			}
		}

	});

	function CategoryClientValidate(source, arguments) {
		var treeView = document.getElementById("<%= tvNewsCategories.ClientID %>");
		var checkBoxes = treeView.getElementsByTagName("input");
		var checkedCount = 0;
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
			jQuery('#<%=pnlNewsCategories.ClientID%>').show(0);
		}
	}

	function ClientValidateAuthors(source, arguments) {
		var treeView = document.getElementById("<%= tvAuthorAndGroupSelection.ClientID %>");
		var checkBoxes = treeView.getElementsByTagName("input");
		var checkedCount = 0;
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				checkedCount++;
				break;
			}
		}
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
			jQuery('#<%=pnlAuthorAndGroupSelection.ClientID%>').show(0);
		}
	}

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			<%=IncludeJavaScript%>

			eds2_2('.edNews_tooltip').eds_tooltipster();

			var treeView = document.getElementById('<%= tvAuthorAndGroupSelection.ClientID %>');
			if (treeView != null) {
				var allNodes = treeView.childNodes;
				for (var i = 0; i < allNodes.length; i++) {
					var tab = allNodes[i];

					var table = $(allNodes[i]).closest("table");

					if (table.next().length > 0 && table.next()[0].tagName == "DIV") {

						var childDiv = table.next();

						$("input[type=checkbox]", table).each(function () {
							var isChecked = $(this).attr('checked');

							if (isChecked) {
								$("input[type=checkbox]", childDiv).each(function () {
									$(this).attr("checked", "checked");
									$(this).attr("disabled", "true");
								});
							}
						})
					}
				}
			}
		}
	};

	// ]]>
</script>

<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span><%=titleOfControle%></span>
		</div>
		<asp:Literal ID="liAdminNavigation" runat="server"></asp:Literal>
		<asp:Panel ID="pnlMainSelect" runat="server" Visible="true" CssClass="sectionBox noPadding bottomPadded sectionBox2">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=titleCreateNEWCF%></span>
			</div>
			<table class="optionsList fullWidthTable tablePadding5 noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlFieldType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFieldType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFieldType.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlFieldType" runat="server" OnSelectedIndexChanged="ddlFieldType_SelectedIndexChanged" AutoPostBack="True">
							<asp:ListItem Value="0" ResourceKey="liSelect" Text="Select" Selected="True" />
							<asp:ListItem Value="1" ResourceKey="liTextBox" Text="TextBox" />
							<asp:ListItem Value="2" ResourceKey="liCheckBox" Text="CheckBox" />
							<asp:ListItem Value="3" ResourceKey="liMultiControls" Text="Multi Controls" />
							<asp:ListItem Value="4" ResourceKey="liSearchFields" Text="Search fields" />
							<%--<asp:ListItem Value="100" Text="Search Portal specific data fields"></asp:ListItem>--%>
							<%--<asp:ListItem Value="50" Text="Range search"></asp:ListItem>--%>
							<asp:ListItem Value="200" ResourceKey="liUploadField" Text="Upload field" />
						</asp:DropDownList>
					</td>
				</tr>
			</table>
			<asp:Panel ID="pnlTextBoxData" runat="server" Visible="false">
				<table class="optionsList fullWidthTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlTextBoxType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDataType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDataType.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlTextBoxType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTextBoxType_SelectedIndexChanged">
								<asp:ListItem Value="" ResourceKey="liSelect" Text="Select" Selected="True" />
								<asp:ListItem Value="1" ResourceKey="liText" Text="Text" />
								<asp:ListItem Value="2" ResourceKey="liRichText" Text="RichText (HTML)" />
								<asp:ListItem Value="3" ResourceKey="liInteger" Text="Integer" />
								<asp:ListItem Value="4" ResourceKey="liDecimal" Text="Decimal" />
								<asp:ListItem Value="5" ResourceKey="liMoney" Text="Money" />
								<asp:ListItem Value="6" ResourceKey="liEmail" Text="Email" />
								<asp:ListItem Value="9" ResourceKey="liDateTime" Text="Date/time" />
								<asp:ListItem Value="10" ResourceKey="liHyperlink" Text="Hyperlink" />
								<%--<asp:ListItem Value="7" Text="Color Picker"></asp:ListItem>
								<asp:ListItem Value="8" Text="Password"></asp:ListItem>
								--%>
							</asp:DropDownList>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<asp:Label ID="lblInfoWhenControlSelected" runat="server" Visible="false" EnableViewState="false" />
			<asp:Panel ID="pnlMultiControlData" runat="server" Visible="false">
				<table class="optionsList fullWidthTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlMultiControlType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMultiControlType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMultiControlType.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlMultiControlType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlMultiControlType_SelectedIndexChanged">
								<asp:ListItem Value="" ResourceKey="liSelect" Text="Select" Selected="True" />
								<asp:ListItem Value="20" ResourceKey="liDropDownList" Text="DropDownList" />
								<asp:ListItem Value="21" ResourceKey="liRadioButtonList" Text="RadioButtonList" />
								<%--<asp:ListItem Value="22" Text="ListBox"></asp:ListItem>--%>
								<asp:ListItem Value="23" ResourceKey="liCheckBoxList" Text="CheckBoxList" />
							</asp:DropDownList>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<asp:Panel ID="pnlPortalSpecificData" runat="server" Visible="false">
				<table class="optionsList fullWidthTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlPortalSpecificData.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMultiControlType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMultiControlType.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlPortalSpecificData" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPortalSpecificData_SelectedIndexChanged">
								<asp:ListItem Value="0" Text="Select" Selected="True" />
								<asp:ListItem Value="101" Text="Categories" />
								<asp:ListItem Value="102" Text="Users" />
							</asp:DropDownList>
						</td>
					</tr>
				</table>
			</asp:Panel>
			<asp:Panel ID="pnlSearchFields" runat="server" Visible="false">
				<table class="optionsList fullWidthTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlSearchFields.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchFields.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchFields.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlSearchFields" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSearchFields_SelectedIndexChanged">
								<asp:ListItem Value="" Text="Select" Selected="True" />
								<asp:ListItem Value="300" ResourceKey="liArticleCategories" Text="Article categories" />
								<asp:ListItem Value="301" ResourceKey="liArticleAuthorAndGroups" Text="Article authors/groups" />
								<asp:ListItem Value="302" ResourceKey="liArticleDate" Text="Article date" />
								<asp:ListItem Value="303" ResourceKey="liSearchField" Text="Search field" />
								<asp:ListItem Value="304" ResourceKey="liSortCriteria" Text="Sort criteria" />
								<%--<asp:ListItem Value="305" Text="Custom SQL field" />--%>
							</asp:DropDownList>
						</td>
					</tr>
				</table>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlFieldsList" runat="server">
			<asp:Panel ID="pnlFieldsListcss" class="sectionBox noPadding sectionBox2" runat="server" Visible="true">
				<div class="sectionBoxHeader clarFix">
					<span class="sectionBoxHeaderTitle"><%=titleExistingCF%></span>
					<div class="edNews_numberOfRows">
						<div>
							<asp:DropDownList ID="ddlgvListOfCustomFieldsPageSize" runat="server" AutoPostBack="True" CssClass="ddlpageitems" OnSelectedIndexChanged="ddlgvListOfCustomFieldsPageSize_SelectedIndexChanged">
								<asp:ListItem Text="10" />
								<asp:ListItem Selected="True" Text="30" />
								<asp:ListItem Text="50" />
								<asp:ListItem Text="80" />
								<asp:ListItem Text="100" />
							</asp:DropDownList>
						</div>
					</div>
				</div>
				<asp:ObjectDataSource ID="odsListOfCustomFields" runat="server" DeleteMethod="DeleteCustomField" SelectMethod="GetCustomFields" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB">
					<DeleteParameters>
						<asp:Parameter Name="CustomFieldID" Type="Int32" />
					</DeleteParameters>
					<SelectParameters>
						<asp:Parameter Name="PortalID" Type="Int32" />
						<asp:Parameter Name="IsSearchable" Type="Boolean" />
					</SelectParameters>
				</asp:ObjectDataSource>
				<asp:GridView ID="gvListOfCustomFields" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="odsListOfCustomFields" EnableModelValidation="True" DataKeyNames="CustomFieldID" OnRowCommand="gvListOfCustomFields_RowCommand" HorizontalAlign="Center"
					AutoGenerateColumns="False" OnRowDeleted="gvListOfCustomFields_RowDeleted" PageSize="30" CssClass="fullWidthTable strippedTable noBorder textLeft tablePadding5"  OnRowDataBound="gvListOfCustomFields_RowDataBound">
					<Columns>
						<asp:TemplateField ShowHeader="True" HeaderText="gvListOfCustomFieldsAction">
							<ItemTemplate>
								<div class="itemActions smallActions">
									<asp:LinkButton ID="lbListOfCustomFieldsEdit" CssClass="editAction" runat="server" CausesValidation="false" CommandArgument='<%#Eval("CustomFieldID") %>' CommandName="Select" Text="Edit" ResourceKey="lbListOfCustomFieldsEdit" />
									<asp:LinkButton ID="lbListOfCustomFieldsDelete" CssClass="deleteAction" runat="server" CausesValidation="false" CommandArgument='<%#Eval("CustomFieldID") %>' CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this item and ALL Values?');" Text="Delete" ResourceKey="lbListOfCustomFieldsDelete" />
								</div>
							</ItemTemplate>
							<HeaderStyle Width="15%" CssClass="textCenter" />
							<ItemStyle CssClass="textCenter" />
						</asp:TemplateField>
						<asp:BoundField DataField="Type" HeaderText="gvListOfCustomFieldsType" />
						<asp:BoundField DataField="Name" HeaderText="gvListOfCustomFieldsName" />
						<asp:BoundField DataField="Token" DataFormatString="[EDNcf:{0}]" HeaderText="gvListOfCustomFieldsToken" />
					</Columns>
					<HeaderStyle CssClass="tableHeader" />
					<PagerStyle CssClass="contentPagination" />
				</asp:GridView>
				<asp:Label ID="lblCustomFieldsInfo" runat="server" Text="" EnableViewState="false" />
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlAllSettings" runat="server">
			<asp:Panel ID="pnlControlOptions" class="sectionBox noPadding sectionBox2" runat="server" Visible="false">
				<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
					<span><span><i class="fa fa-cog"></i></span><%=titleControlBasicSetup%></span>
				</div>
				<asp:Panel ID="pnlBasicOptions" runat="server" Visible="true" CssClass="edNews_adminProgressOverlayWrapper">
					<table class="optionsList fullWidthTable tablePadding5 noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxCustomFieldName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCustomFieldName.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCustomFieldName.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxCustomFieldName" runat="server" CausesValidation="True" MaxLength="300" ValidationGroup="vgSaveField" />
								<asp:RequiredFieldValidator ID="rfvCustomFieldName" CssClass="smallInfo error" runat="server" ErrorMessage="Required field!" ControlToValidate="tbxCustomFieldName" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgSaveField" resourcekey="rfvCustomFieldName.ErrorMessage" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label class="edNews_tooltip" data-tooltip-content="<%=_("lblToken.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblToken.Text") %></label>
							</td>
							<td>
								<asp:UpdatePanel ID="UpdatePanel1" runat="server" OnUnload="UpdatePanel_Unload">
									<ContentTemplate>
										<asp:TextBox ID="tbxToken" runat="server" CausesValidation="True" MaxLength="250" ValidationGroup="vgSaveField" />
										<asp:RequiredFieldValidator ID="rfvToken" CssClass="smallInfo error" runat="server" ErrorMessage="Required field!" ControlToValidate="tbxToken" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgSaveField" resourcekey="rfvCustomFieldName.ErrorMessage" />
										<asp:RequiredFieldValidator ID="rfvTokenExists" CssClass="smallInfo error" runat="server" ErrorMessage="Required field!" ControlToValidate="tbxToken" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgTokenExists" resourcekey="rfvCustomFieldName.ErrorMessage" />
										<div class="mainActions smallActions noMargin displayInline">
											<asp:Button ID="btnCheckToken" runat="server" CssClass="primaryAction" Text="Check availability" OnClick="btnCheckToken_Click" ValidationGroup="vgTokenExists" resourcekey="btnCheckToken" />
										</div>
										<asp:Label ID="lblCheckToken" runat="server" EnableViewState="False" />
									</ContentTemplate>
								</asp:UpdatePanel>
							</td>
						</tr>
					</table>
					<asp:Panel ID="pnlTextBoxDefault" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxDefaultValue.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultValue.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultValue.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbxDefaultValue" runat="server" />
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlTextBoxMoneyDef" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label class="edNews_tooltip" data-tooltip-content="<%=_("lblBasePortalCurrency.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblBasePortalCurrency.Text") %></label>
								</td>
								<td>
									<asp:Label ID="lblBasePortalCurrencyValue" runat="server" Text="" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlMoneyDefSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMoneyDefSelect.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMoneyDefSelect.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlMoneyDefSelect" runat="server" AutoPostBack="true" ValidationGroup="vgSaveField" Enabled="false" OnSelectedIndexChanged="ddlMoneyDefSelect_SelectedIndexChanged" />
									<asp:DropDownList ID="ddlCurrencySimbol" runat="server" AutoPostBack="false" Enabled="true" EnableViewState="true" />
									<asp:RequiredFieldValidator ID="rfvMoneyDefSelect" CssClass="smallInfo error" runat="server" ErrorMessage="Required Field" ControlToValidate="ddlMoneyDefSelect" InitialValue="0" SetFocusOnError="True" ValidationGroup="vgSaveField" Display="Dynamic" resourcekey="rfvCustomFieldName.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxCurrencyDecimalDigits.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCurrencyDecimalDigits.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCurrencyDecimalDigits.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbxCurrencyDecimalDigits" runat="server" CssClass="smallCentered" MaxLength="1" Text="2" />
									<asp:RequiredFieldValidator ID="rfvCurrencyDecimalDigits" CssClass="smallInfo error" runat="server" ErrorMessage="Required Field" ControlToValidate="tbxCurrencyDecimalDigits" SetFocusOnError="True" ValidationGroup="vgSaveField" Display="Dynamic" resourcekey="rfvCustomFieldName.ErrorMessage" />
									<asp:CompareValidator ID="cvCurrencyDecimalDigits" runat="server" ControlToValidate="tbxCurrencyDecimalDigits" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSaveField" resourcekey="cvCurrencyDecimalDigits.ErrorMessage" SetFocusOnError="True" />
									<asp:RangeValidator ID="rvCurrencyDecimalDigits" runat="server" ControlToValidate="tbxCurrencyDecimalDigits" Display="Dynamic" ErrorMessage="Enter value between 0-4." MaximumValue="4" MinimumValue="0" resourcekey="rvCurrencyDecimalDigits.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSaveField" />
								</td>
							</tr>
							<tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlRichTextBoxDefault" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=rtbDefault.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRichTextBoxDefault.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRichTextBoxDefault.Text") %></label>
								</td>
								<td>
									<dnn:TextEditor ID="rtbDefault" runat="server" Height="400" />
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlCheckBoxDefault" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbDefaultValue.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultCheckBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultCheckBox.Text") %></label>
								</td>
								<td>
									<div class="styledCheckbox noLabel">
										<asp:CheckBox ID="cbDefaultValue" CssClass="normalCheckBox" runat="server" Text="Default token value" Checked="false" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlMultiControlsDefault" runat="server" Visible="false">
						<asp:Label ID="lblDefMulticontrol" CssClass="edNews_titleH2" runat="server" Text="Multi elements - ADMINISTRATION" ResourceKey="lblDefMulticontrol" />
						<asp:Label ID="lblInfoMultiPreSave" runat="server" Text="" />
						<asp:Panel ID="pnlIsParentOrChilde" runat="server" Visible="true">
							<table class="optionsList fullWidthTable tablePadding5 noBorder" runat="server" id="tblSelectParentChildeControlType">
								<tr>
									<td class="tdLabel">
										<label for="<%=rblIsParentOrChilde.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsParentOrChilde.Help", true) %>" data-tooltip-position="top-right"><%=_("lblIsParentOrChilde.Text") %></label>
									</td>
									<td>
										<div class="edNews_inputGroup">
											<asp:RadioButtonList ID="rblIsParentOrChilde" runat="server" OnSelectedIndexChanged="rblIsParentOrChilde_SelectedIndexChanged" AutoPostBack="True" RepeatLayout="UnorderedList" CssClass="styledRadio inlineList smallRadio">
												<asp:ListItem resourcekey="liNormal" class="normalRadioButton" Selected="True" Value="0" Text="Normal" />
												<%--<asp:ListItem Value="1" Text="Parent" />--%>
												<asp:ListItem resourcekey="liTriggeredbyparent" class="normalRadioButton" Value="2" Text="Related" />
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
							</table>
							<asp:Label ID="lblMultiElementsMainInfo" runat="server" EnableViewState="true" />
							<asp:Panel ID="pnlStandardTypeSourceSelect" runat="server" Visible="false">
								<table class="optionsList fullWidthTable tablePadding5 noBorder">
									<tr>
										<td class="tdLabel">
											<label for="<%=rblStandardTypeSourceSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStandardTypeSourceSelect.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblStandardTypeSourceSelect.Text") %></label>
										</td>
										<td>
											<div class="edNews_inputGroup">
												<asp:RadioButtonList ID="rblStandardTypeSourceSelect" runat="server" OnSelectedIndexChanged="rblStandardTypeSourceSelect_SelectedIndexChanged" AutoPostBack="True" RepeatLayout="UnorderedList" CssClass="styledRadio inlineList smallRadio">
													<asp:ListItem Selected="True" class="normalRadioButton" Value="0" Text="Manual create elements" />
													<asp:ListItem Value="1" class="normalRadioButton" Text="Automatically populate with common portal items" />
												</asp:RadioButtonList>
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlIsChilde" runat="server" Visible="false">
								<asp:Panel ID="pnlSelectParentID" runat="server" Visible="false" CssClass="edNews_adminProgressOverlayWrapper">
									<asp:UpdatePanel ID="upCreateChildeElement" runat="server" OnUnload="UpdatePanel_Unload">
										<ContentTemplate>
											<table class="optionsList strippedTable fullWidthTable tablePadding5">
												<tr>
													<td class="tdLabel">
														<label for="<%=ddlParentCFSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblParentSelect.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblParentSelect.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlParentCFSelect" runat="server" OnSelectedIndexChanged="ddlParentCFSelect_SelectedIndexChanged" AutoPostBack="True" />
														<%--<asp:LinkButton ID="lbResetParentCF" runat="server" Visible="False" ToolTip="List elements will lose parent link and won't be deleted." Text="Reset parent group" OnClientClick="return confirm('Are you sure you want to reset parent link values?');" OnClick="lbResetParentCF_Click" />--%>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=ddlSelectPerentElement.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectPerentElement.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectPerentElement.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlSelectPerentElement" runat="server" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbxElementWithParentText.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblElementWithParentText.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblElementWithParentText.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbxElementWithParentText" runat="server" ValidationGroup="vgElementWithParentText" />
														<asp:Button ID="btnSaveElementWithParent" resourcekey="btnSaveElementWithParent" runat="server" Text="Create element" OnClick="btnSaveElementWithParent_Click" ValidationGroup="vgElementWithParentText" /><br />
														<asp:RequiredFieldValidator ID="rfvSaveElementWithParent" CssClass="smallInfo error" runat="server" ErrorMessage="Required field!" ControlToValidate="tbxElementWithParentText" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgElementWithParentText" resourcekey="rfvCustomFieldName.ErrorMessage" />
														<asp:Label ID="lblSaveElementWithParentInfo" runat="server" EnableViewState="False" ForeColor="#CC0000" />
													</td>
												</tr>
											</table>
										</ContentTemplate>
									</asp:UpdatePanel>
									<asp:UpdateProgress ID="uppCreateChildeElement" runat="server" AssociatedUpdatePanelID="upCreateChildeElement" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay"></div>
										</ProgressTemplate>
									</asp:UpdateProgress>
								</asp:Panel>
								<asp:Panel ID="pnlChildeAdministration" runat="server" Visible="false" CssClass="edNews_adminProgressOverlayWrapper">
									<asp:ObjectDataSource ID="odsChildeParentElements" runat="server" SelectMethod="GetElementsByFilter" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB" UpdateMethod="IUMultiControlElementNEKORISTITI" DeleteMethod="DeleteMultiControlElement">
										<DeleteParameters>
											<asp:Parameter Name="FieldElementID" Type="Int32" />
											<asp:Parameter Name="CustomFieldID" Type="Int32" />
										</DeleteParameters>
										<SelectParameters>
											<asp:Parameter Name="CustomFieldID" Type="Int32" />
											<asp:Parameter Name="ParentCFID" Type="Int32" />
											<asp:Parameter Name="ParentCFELID" Type="Int32" />
										</SelectParameters>
										<UpdateParameters>
											<asp:Parameter Name="CustomFieldID" Type="Int32" />
											<asp:Parameter Name="FieldElementID" Type="Int32" />
											<asp:Parameter Name="FEParentID" Type="Int32" />
											<asp:Parameter Name="Text" Type="String" />
											<asp:Parameter Name="DefSelected" Type="Boolean" />
											<asp:Parameter Name="Position" Type="Int32" />
										</UpdateParameters>
									</asp:ObjectDataSource>
									<asp:UpdatePanel ID="upMultiElements" runat="server" OnUnload="UpdatePanel_Unload">
										<ContentTemplate>
											<table class="optionsList fullWidthTable tablePadding5">
												<tr>
													<td class="tdLabel">
														<asp:Label ID="lblFilterByParents" runat="server" Text="Filter by:" />
													</td>
													<td>
														<asp:DropDownList ID="ddlFilterByCFParentID" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFilterByCFParentID_SelectedIndexChanged" />
														<asp:DropDownList ID="ddlFilterByCFELParentID" runat="server" OnSelectedIndexChanged="ddlFilterByCFELParentID_SelectedIndexChanged" AutoPostBack="True" />
													</td>
												</tr>
											</table>
											<div class="sectionBox noPadding">
												<div class="negativeMargins">
													<asp:GridView ID="gvChildeParentElements" runat="server" DataSourceID="odsChildeParentElements" EnableModelValidation="True" AutoGenerateColumns="False" OnRowDataBound="gvChildeParentElements_RowDataBound" OnRowCommand="gvChildeParentElements_RowCommand" AllowPaging="True" AllowSorting="True" DataKeyNames="FieldElementID,CustomFieldID" GridLines="None" HorizontalAlign="Center" CssClass="optionsList strippedTable fullWidthTable tablePadding5 textCenter" PageSize="20" OnRowUpdating="gvChildeParentElements_RowUpdating" OnRowEditing="gvChildeParentElements_RowEditing" OnDataBound="gvChildeParentElements_PreRender">
														<Columns>
															<asp:TemplateField ShowHeader="True" HeaderText="gvActionHeaderText">
																<EditItemTemplate>
																	<div class="itemActions diplayInline">
																		<asp:LinkButton ID="lbUpdate" runat="server" CssClass="saveAction" CausesValidation="True" CommandName="Update" Text="Update" />
																		<asp:LinkButton ID="lbCancel" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
																	</div>
																</EditItemTemplate>
																<ItemTemplate>
																	<div class="itemActions diplayInline">
																		<asp:LinkButton ID="lbEdit" runat="server" CssClass="editAction" CausesValidation="False" CommandName="Edit" Text="Edit" />
																		<asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CssClass="deleteAction" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this item and ALL values?');" />
																		<asp:LinkButton ID="lblgvChildeParentElementsLocalize" runat="server" CausesValidation="False" CssClass="localizeAction" CommandName="Localize" Text="Translate" ResourceKey="lbgvMultiControlElementsLocalize" />
																	</div>
																</ItemTemplate>
																<HeaderStyle Width="240px" />
															</asp:TemplateField>
															<asp:BoundField DataField="FieldElementID" HeaderText="gvMultiControlElementsFieldElementID" ReadOnly="True">
																<HeaderStyle Width="60px" />
															</asp:BoundField>
															<asp:BoundField DataField="CustomFieldID" HeaderText="gvMultiControlElementsCustomFieldID" ReadOnly="True">
																<HeaderStyle Width="60px" />
															</asp:BoundField>
															<asp:TemplateField HeaderText="gvRelatedHeaderText">
																<ItemTemplate>
																	<asp:Label ID="lblParentText" runat="server" Text='<%# GetParentName(Eval("ParentText"), Eval("ParentElementCFName"))%>' />
																</ItemTemplate>
																<EditItemTemplate>
																	<asp:HiddenField runat="server" Value='<%#Eval("FEParentID") %>' ID="hfFEParentID" />
																	<asp:DropDownList ID="ddlParentCustomFieldEdit" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlParentCustomFieldEdit_SelectedIndexChanged" />
																	<asp:DropDownList ID="ddlParentElementEdit" runat="server" />
																</EditItemTemplate>
															</asp:TemplateField>
															<asp:TemplateField HeaderText="gvMultiControlElementsText">
																<EditItemTemplate>
																	<asp:TextBox ID="tbxText" runat="server" Text='<%# Bind("Text") %>' />
																</EditItemTemplate>
																<ItemTemplate>
																	<asp:Label ID="lblText" runat="server" Text='<%# Bind("Text") %>' />
																</ItemTemplate>
															</asp:TemplateField>
															<asp:TemplateField ShowHeader="True" HeaderText="gvLocalizeText" Visible="false">
																<ItemTemplate>
																	<asp:DropDownList ID="ddlSelectLocale" runat="server" Visible="false" />
																	<div class="itemActions displayInline smallActions">
																		<asp:LinkButton ID="lbLoadLocale" runat="server" CssClass="loadAction" CausesValidation="False" CommandName="LoadLocale" CommandArgument='<%#Eval("FieldElementID") %>' Text="Load locale" Visible="false" />
																	</div>
																	<asp:TextBox ID="tbxLocalizedText" runat="server" Visible="false" />
																	<div class="itemActions displayInline smallActions">
																		<asp:LinkButton ID="lbSaveLocale" runat="server" CssClass="saveAction" CausesValidation="False" CommandName="SaveLocale" CommandArgument='<%#Eval("FieldElementID") %>' Text="Save" Visible="false" />
																		<asp:LinkButton ID="lbCloseLocale" runat="server" CssClass="closeAction" CausesValidation="False" CommandName="CloseLocale" Text="Close" Visible="false" />
																		<asp:LinkButton ID="lbDeleteLocale" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="DeleteLocale" CommandArgument='<%#Eval("FieldElementID") %>' Text="Delete" Visible="false" />
																	</div>
																</ItemTemplate>
																<ItemStyle CssClass="textLeft" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="gvMultiControlElementsPosition" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
																<ItemTemplate>
																	<div id="Td1" runat="server" visible="false">
																		<asp:TextBox ID="tbxPositionValCategory" runat="server" CssClass="boxposition" Enabled="False" Font-Size="X-Small" Height="14px" ReadOnly="True" Text='<%# Bind("Position")%>' Visible="true" Width="25px" Style="width: 25px; height: 14px;" />
																	</div>
																	<div class="edNews_boxedActions">
																		<asp:LinkButton ID="btnUPElement" runat="server" CssClass="edNews_aaUp" CausesValidation="false" Text="Up" ResourceKey="Up" CommandArgument='<%#Eval("FieldElementID") %>' CommandName="btnUPElement" />
																		<asp:LinkButton ID="btnDownElement" runat="server" CssClass="edNews_aaDown" CausesValidation="false" Text="Down" ResourceKey="Down" CommandArgument='<%#Eval("FieldElementID") %>' CommandName="btnDownElement" />
																	</div>
																</ItemTemplate>
																<ItemStyle Width="100px" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="DefSelected" Visible="false">
																<ItemTemplate>
																	<asp:CheckBox ID="cbSelectedParent" CssClass="normalCheckBox" runat="server" Checked='<%# Bind("DefSelected") %>' Enabled="false" ReadOnly="True" />
																</ItemTemplate>
															</asp:TemplateField>
														</Columns>
														<HeaderStyle CssClass="tableHeader" />
														<EditRowStyle CssClass="editItemState" />
														<PagerStyle CssClass="contentPagination" />
													</asp:GridView>
												</div>
											</div>
										</ContentTemplate>
									</asp:UpdatePanel>
									<asp:UpdateProgress ID="uppMultiElements" runat="server" AssociatedUpdatePanelID="upMultiElements" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay"></div>
										</ProgressTemplate>
									</asp:UpdateProgress>
								</asp:Panel>
							</asp:Panel>
						</asp:Panel>
						<asp:Panel ID="pnlPortalCommonItems" runat="server" Visible="false">
							<table class="optionsList fullWidthTable tablePadding5 noBorder">
								<tr>
									<td class="tdLabel">
										<label for="<%=ddlPortalCommonData.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCustomFieldName.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCustomFieldName.Text") %></label>
									</td>
									<td>
										<asp:DropDownList ID="ddlPortalCommonData" runat="server" AutoPostBack="True">
											<asp:ListItem Selected="True" Value="101">Categories</asp:ListItem>
											<asp:ListItem Value="102">Users</asp:ListItem>
										</asp:DropDownList>
									</td>
								</tr>
							</table>
						</asp:Panel>
						<asp:Panel ID="pnlNormalMultiElementsAdministration" runat="server" Visible="false">
							<table class="optionsList fullWidthTable tablePadding5 noBorder">
								<tr>
									<td class="tdLabel">
										<label for="<%=tbxMultiControlElementText.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMultiControlElementText.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMultiControlElementText.Text") %></label>
									</td>
									<td>
										<asp:TextBox ID="tbxMultiControlElementText" runat="server" />
										<div class="mainActions smallActions displayInline noMargin">
											<asp:Button ID="btnCreateDropDownElement" runat="server" CssClass="add" Text="Create element" ResourceKey="btnCreateDropDownElement" OnClick="btnCreateDropDownElement_Click" /><br />
										</div>
										<div>
											<asp:Label ID="lblCreateMultiElementInfo" runat="server" EnableViewState="False" />
										</div>
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlDropDownListDefault" runat="server" Visible="false">
								<table class="optionsList fullWidthTable tablePadding5 noBorder">
									<tr>
										<td class="tdLabel">
											<label for="<%=ddlDropDownListDefault.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDropDownListDefault.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDropDownListDefault.Text") %></label>
										</td>
										<td>
											<asp:DropDownList ID="ddlDropDownListDefault" runat="server" OnDataBound="ddlDropDownListDefault_DataBound" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlRadioButtonListDefault" runat="server" Visible="false">
								<table class="optionsList fullWidthTable tablePadding5 noBorder">
									<tr>
										<td class="tdLabel">
											<label for="<%=rblRadioButtonListDefault.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("rblRadioButtonListDefault.HelpText", true) %>" data-tooltip-position="top-right"><%=_("rblRadioButtonListDefault.Text") %></label>
										</td>
										<td>
											<div class="edNews_inputGroup">
												<asp:RadioButtonList CssClass="styledRadio smallRadio inlineList normalRadioButton" ID="rblRadioButtonListDefault" runat="server" RepeatLayout="UnorderedList" />
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlCheckBoxListDefault" runat="server" Visible="false">
								<table class="optionsList fullWidthTable tablePadding5 noBorder">
									<tr>
										<td class="tdLabel textTop">
											<label for="<%=cblCheckBoxListDefault.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCheckBoxListDefault.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCheckBoxListDefault.Text") %></label>
										</td>
										<td>
											<div class="edNews_inputGroup">
												<asp:CheckBoxList CssClass="normalCheckBox styledCheckbox inlineList" ID="cblCheckBoxListDefault" runat="server" />
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel ID="pnlMultiControlElements" runat="server" Visible="false" CssClass="sectionBox noPadding">
								<div class="negativeMargins">
									<asp:ObjectDataSource ID="odsMultiControlElements" runat="server" SelectMethod="GetMultiControlsElementsLoc" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB" DeleteMethod="DeleteMultiControlElement" UpdateMethod="IUMultiControlElementNEKORISTITI">
										<DeleteParameters>
											<asp:Parameter Name="FieldElementID" Type="Int32" />
											<asp:Parameter Name="CustomFieldID" Type="Int32" />
										</DeleteParameters>
										<SelectParameters>
											<asp:Parameter Name="CustomFieldID" Type="Int32" />
											<asp:Parameter DefaultValue="" ConvertEmptyStringToNull="false" Name="LocaleCode" Type="String" />
										</SelectParameters>
										<UpdateParameters>
											<asp:Parameter Name="CustomFieldID" Type="Int32" />
											<asp:Parameter Name="FieldElementID" Type="Int32" />
											<asp:Parameter Name="FEParentID" Type="Int32" />
											<asp:Parameter Name="Text" Type="String" />
											<asp:Parameter Name="DefSelected" Type="Boolean" />
											<asp:Parameter Name="Position" Type="Int32" />
										</UpdateParameters>
									</asp:ObjectDataSource>
									<asp:GridView ID="gvMultiControlElements" runat="server" AllowPaging="True" DataSourceID="odsMultiControlElements" EnableModelValidation="True" AllowSorting="True" DataKeyNames="FieldElementID,CustomFieldID" AutoGenerateColumns="False" GridLines="None" OnRowDataBound="gvMultiControlElements_RowDataBound" OnRowUpdating="gvMultiControlElements_RowUpdating" OnDataBound="gvMultiControlElements_PreRender" OnRowCommand="gvMultiControlElements_RowCommand" HorizontalAlign="Center" CssClass="optionsList strippedTable fullWidthTable tablePadding5 textCenter" OnRowUpdated="gvMultiControlElements_RowUpdated">
										<Columns>
											<asp:TemplateField ShowHeader="True" HeaderText="gvActionHeaderText">
												<ItemTemplate>
													<div class="itemActions displayInline smallActions">
														<asp:LinkButton ID="lbgvMultiControlElementsEdit" runat="server" CssClass="editAction" CausesValidation="False" CommandName="Edit" Text="Edit" ResourceKey="lbgvMultiControlElementsEdit" />
														<asp:LinkButton ID="lbgvMultiControlElementsDelete" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="Delete" Text="Delete" ResourceKey="lbgvMultiControlElementsDelete" OnClientClick="return confirm('Are you sure you want to delete this item and ALL values?');" />
														<asp:LinkButton ID="lbgvMultiControlElementsLocalize" runat="server" CssClass="localizeAction" CausesValidation="False" CommandName="Localize" Text="Translate" ResourceKey="lbgvMultiControlElementsLocalize" />
													</div>
												</ItemTemplate>
												<EditItemTemplate>
													<div class="itemActions displayInline smallActions">
														<asp:LinkButton ID="lbgvMultiControlElementsUpdate" runat="server" CssClass="saveAction" CausesValidation="True" CommandName="Update" Text="Update" ResourceKey="lbgvMultiControlElementsUpdate" />
														<asp:LinkButton ID="lbgvMultiControlElementsCancel" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="Cancel" Text="Cancel" ResourceKey="lbgvMultiControlElementsCancel" />
													</div>
												</EditItemTemplate>
												<HeaderStyle Width="240px" />
											</asp:TemplateField>
											<asp:BoundField DataField="FieldElementID" HeaderText="gvMultiControlElementsFieldElementID" ReadOnly="True">
												<HeaderStyle Width="60px" />
											</asp:BoundField>
											<asp:BoundField DataField="CustomFieldID" HeaderText="gvMultiControlElementsCustomFieldID" ReadOnly="True">
												<HeaderStyle Width="60px" />
											</asp:BoundField>
											<asp:TemplateField HeaderText="gvMultiControlElementsText">
												<EditItemTemplate>
													<asp:TextBox ID="tbxText" runat="server" Text='<%# Bind("Text") %>' />
												</EditItemTemplate>
												<ItemTemplate>
													<asp:Label ID="tbxText" runat="server" Text='<%# Bind("Text") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField ShowHeader="True" HeaderText="gvLocalizeText" Visible="false">
												<ItemTemplate>
													<asp:DropDownList ID="ddlSelectLocale" runat="server" Visible="false" />
													<div class="itemActions displayInline smallActions">
														<asp:LinkButton ID="lbLoadLocale" runat="server" CssClass="loadAction" CausesValidation="False" CommandName="LoadLocale" CommandArgument='<%#Eval("FieldElementID") %>' Text="Load locale" Visible="false" />
													</div>
													<asp:TextBox ID="tbxLocalizedText" runat="server" Visible="false" />
													<div class="itemActions displayInline smallActions">
														<asp:LinkButton ID="lbSaveLocale" runat="server" CssClass="saveAction" CausesValidation="False" CommandName="SaveLocale" CommandArgument='<%#Eval("FieldElementID") %>' Text="Save" Visible="false" />
														<asp:LinkButton ID="lbCloseLocale" runat="server" CssClass="closeAction" CausesValidation="False" CommandName="CloseLocale" Text="Close" Visible="false" />
														<asp:LinkButton ID="lbDeleteLocale" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="DeleteLocale" CommandArgument='<%#Eval("FieldElementID") %>' Text="Delete" Visible="false" />
													</div>
												</ItemTemplate>
												<ItemStyle CssClass="textLeft" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Selected (Default)" Visible="False">
												<ItemTemplate>
													<div class="styledCheckbox">
														<asp:CheckBox ID="cbSelected" CssClass="normalCheckBox" runat="server" Text="" Checked='<%# Bind("DefSelected") %>' Enabled="false" />
													</div>
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="gvMultiControlElementsPosition" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
												<ItemTemplate>
													<div runat="server" visible="false">
														<asp:TextBox ID="tbxPositionValCategory" runat="server" CssClass="boxposition" Enabled="False" Font-Size="X-Small" Height="14px" ReadOnly="True" Text='<%# Bind("Position")%>' Visible="true" Width="25px" Style="width: 25px; height: 14px;" />
													</div>
													<div class="edNews_boxedActions">
														<asp:LinkButton ID="btnUPElement" runat="server" CssClass="edNews_aaUp" CausesValidation="false" Text="Up" ResourceKey="Up" CommandArgument='<%#Eval("FieldElementID") %>' CommandName="btnUPElement" />
														<asp:LinkButton ID="btnDownElement" runat="server" CssClass="edNews_aaDown" CausesValidation="false" Text="Down" ResourceKey="Down" CommandArgument='<%#Eval("FieldElementID") %>' CommandName="btnDownElement" />
													</div>
												</ItemTemplate>
												<ItemStyle Width="100px" />
											</asp:TemplateField>
										</Columns>
										<EditRowStyle CssClass="editItemState" />
										<HeaderStyle CssClass="tableHeader" />
										<PagerStyle CssClass="contentpagination" />
									</asp:GridView>
								</div>
							</asp:Panel>
						</asp:Panel>
					</asp:Panel>
					<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
						<span><span><i class="fa fa-tag"></i></span><%=titleControlLabelOptions%></span>
					</div>
					<table class="optionsList strippedTable fullWidthTable tablePadding5 noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=cbLabelVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLabelVisible.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLabelVisible.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cbLabelVisible" CssClass="normalCheckBox" runat="server" Text="Show label" Checked="true" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxLabelOfTheFeild.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLabelOfTheFeild.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLabelOfTheFeild.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxLabelOfTheFeild" runat="server" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxLabelHelp.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("tbxLabelHelp.HelpText", true) %>" data-tooltip-position="top-right"><%=_("tbxLabelHelp.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxLabelHelp" runat="server" />
								</div>
							</td>
						</tr>
					</table>
					<div runat="server" id="rowLabelLocalization" visible="false">
						<asp:UpdatePanel ID="uplbLabelLocalization" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="mainActions smallActions">
									<asp:Button ID="lbLabelLocalization" CssClass="primaryAction" runat="server" Text="Translate" OnClick="lbLabelLocalization_Click" />
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</div>
					<asp:UpdatePanel ID="upLabelLocalization" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
						<ContentTemplate>
							<asp:Panel ID="pnlLabelLocalization" runat="server" Visible="false">
								<span class="edNews_titleH2"><%=labelLocalization%><%=_("labelLocalization.Text", true) %></span>
								<table class="optionsList strippedTable fullWidthTable tablePadding5 noBorder">
									<tr>
										<td class="tdLabel">
											<label for="<%=ddlLabelSelectLanguage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectLanguage.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectLanguage.Text") %></label>
										</td>
										<td>
											<asp:DropDownList ID="ddlLabelSelectLanguage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlLabelSelectLanguage_SelectedIndexChanged" />
										</td>
									</tr>
									<tr>
										<td class="tdLabel">
											<label for="<%=tbxLabelOfTheFeildLoc.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLabelOfTheFeild.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLabelOfTheFeild.Text") %></label>
										</td>
										<td>
											<asp:TextBox ID="tbxLabelOfTheFeildLoc" runat="server" />
										</td>
									</tr>
									<tr>
										<td class="tdLabel">
											<label for="<%=tbxLabelHelpLoc.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("tbxLabelHelp.HelpText", true) %>" data-tooltip-position="top-right"><%=_("tbxLabelHelp.Text") %></label>
										</td>
										<td>
											<asp:TextBox ID="tbxLabelHelpLoc" runat="server" />
										</td>
									</tr>
								</table>
								<asp:Label ID="lblLabelLocalizationInfo" runat="server" EnableViewState="False" />
								<div class="mainActions">
									<asp:Button ID="lbSaveLabelLocalization" CssClass="downSave" runat="server" Text="Save locale" OnClick="lbSaveLabelLocalization_Click" />
									<asp:Button ID="lbCloseLabelLocalization" CssClass="cancel" runat="server" Text="Close" OnClick="lbCloseLabelLocalization_Click" />
									<asp:Button ID="lbDeleteLabelLocalization" CssClass="delete" runat="server" Text="Delete" OnClick="lbDeleteLabelLocalization_Click" />
									<asp:Button ID="lbCopyLabelLocalization" CssClass="copy" runat="server" Text="Copy original" OnClick="lbCopyLabelLocalization_Click" />
								</div>
							</asp:Panel>
						</ContentTemplate>
					</asp:UpdatePanel>
					<asp:UpdateProgress ID="uppLabelLocalization" runat="server" AssociatedUpdatePanelID="upLabelLocalization" DisplayAfter="100" DynamicLayout="true">
						<ProgressTemplate>
							<div class="edNews_adminProgressOverlay"></div>
						</ProgressTemplate>
					</asp:UpdateProgress>
				</asp:Panel>
				<asp:Panel ID="pnlValidation" runat="server" Visible="true">
					<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
						<span><span><i class="fa fa-exclamation-circle"></i></span></span><%=titleValidation%></span>
					</div>
					<asp:Panel ID="pnlValidationOptions" runat="server" Visible="true" CssClass="edNews_adminProgressOverlayWrapper">
						<table class="optionsList strippedTable fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbRequired.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequired.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRequired.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbRequired" CssClass="normalCheckBox" Text="Field is required" runat="server" Checked="false" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxRequiredErrorMsg.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequiredErrorMsg.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRequiredErrorMsg.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth40">
										<asp:TextBox ID="tbxRequiredErrorMsg" runat="server" />
									</div>
								</td>
							</tr>
						</table>
						<div runat="server" id="rowValidationLocalization" visible="false">
							<asp:UpdatePanel ID="uplbValidationLocalization" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
								<ContentTemplate>
									<div class="mainActions smallActions">
										<asp:Button ID="lbValidationLocalization" CssClass="primaryAction" runat="server" Text="Translate" OnClick="lbValidationLocalization_Click" />
									</div>
								</ContentTemplate>
							</asp:UpdatePanel>
						</div>
						<table class="optionsList strippedTable fullWidthTable tablePadding5 noBorder" runat="server" visible="false">
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlValidationType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblValidationType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblValidationType.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlValidationType" runat="server">
										<asp:ListItem Value="0" Text="None" Selected="True"></asp:ListItem>
										<asp:ListItem Value="1" Text="Currency"></asp:ListItem>
										<asp:ListItem Value="2" Text="Date"></asp:ListItem>
										<asp:ListItem Value="3" Text="Double"></asp:ListItem>
										<asp:ListItem Value="4" Text="Integer"></asp:ListItem>
										<asp:ListItem Value="5" Text="Email"></asp:ListItem>
										<asp:ListItem Value="6" Text="Regular Expression"></asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label class="edNews_tooltip" data-tooltip-content="<%=_("lblRangeValidation.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRangeValidation.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbxRangeFrom" runat="server" CssClass="smallCenter" />
									<asp:TextBox ID="tbxRangeTo" runat="server" CssClass="smallCenter" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxRegularExpression.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRegularExpression.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRegularExpression.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth40">
										<asp:TextBox ID="tbxRegularExpression" runat="server" />
									</div>
								</td>
							</tr>
						</table>
						<asp:UpdatePanel ID="upValidationLocalization" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<asp:Panel ID="pnlValidationLocalization" runat="server" Visible="false">
									<span class="edNews_titleH2">Validation localization</span>
									<table class="optionsList fullWidthTable tablePadding5 noBorder">
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlValidationSelectLanguage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblValidationSelectLanguage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblValidationSelectLanguage.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlValidationSelectLanguage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlValidationSelectLanguage_SelectedIndexChanged" />
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=tbxRequiredErrorMsgLoc.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequiredErrorMsg.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRequiredErrorMsg.Text") %></label>
											</td>
											<td>
												<div class="edNews_inputGroup inputWidth40">
													<asp:TextBox ID="tbxRequiredErrorMsgLoc" runat="server" />
												</div>
											</td>
										</tr>
									</table>
									<asp:Label ID="lblValidationLocalizationInfo" runat="server" EnableViewState="False" ForeColor="Red" /><br />
									<div class="mainActions">
										<asp:Button ID="lbSaveValidationLocalization" CssClass="downSave" runat="server" Text="Save locale" OnClick="lbSaveValidationLocalization_Click" />
										<asp:Button ID="lbCloseValidationLocalization" CssClass="cancel" runat="server" Text="Close" OnClick="lbCloseValidationLocalization_Click" />
										<asp:Button ID="lbDeleteValidationLocalization" CssClass="cancel" runat="server" Text="Delete" OnClick="lbDeleteValidationLocalization_Click" />
										<asp:Button ID="lbCopyValidationLocalization" CssClass="copy" runat="server" Text="Copy original" OnClick="lbCopyValidationLocalization_Click" />
									</div>
								</asp:Panel>
							</ContentTemplate>
						</asp:UpdatePanel>
						<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="upLabelLocalization" DisplayAfter="100" DynamicLayout="true">
							<ProgressTemplate>
								<div class="edNews_adminProgressOverlay"></div>
							</ProgressTemplate>
						</asp:UpdateProgress>
					</asp:Panel>
				</asp:Panel>
				<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
					<span><span><i class="fa fa-cogs"></i></span></span><%=titleOtherOptions%></span>
				</div>
				<asp:Panel ID="pnlOtherSettings" runat="server" Visible="true">
					<table class="optionsList fullWidthTable strippedTable tablePadding5 noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=cbIsPublished.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsPublished.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsPublished.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cbIsPublished" CssClass="normalCheckBox" Text="Field is active" runat="server" Checked="true" />
								</div>
							</td>
						</tr>
						<tr runat="server" id="rowOptionIsHidden">
							<td class="tdLabel">
								<label for="<%=cbIsHidden.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsHidden.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsHidden.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cbIsHidden" CssClass="normalCheckBox" Text="Field is hidden" runat="server" Checked="false" />
								</div>
							</td>
						</tr>
					</table>
					<asp:Panel ID="pnlCBLOtherOptions" runat="server" Visible="true">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowAllMultiElements.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowAllMultiElements.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowAllMultiElements.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbShowAllMultiElements" CssClass="normalCheckBox" Text=" " runat="server" Checked="true" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlSearchable" runat="server" Visible="true" CssClass="sectionBox noBorder noMargin noPadding">
					<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
						<span><span><i class="fa fa-search"></i></span></span><%=searchableOptions%></span>
					</div>
					<asp:Panel ID="pnlIsSearchable" runat="server" Visible="true">
						<table class="optionsList fullWidthTable strippedTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbIsSearchable.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSearchable.Help", true) %>" data-tooltip-position="top-right"><%=_("lblIsSearchable.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbIsSearchable" CssClass="normalCheckBox" runat="server" Text="Field is searchable" Checked="false" OnCheckedChanged="cbIsSearchable_CheckedChanged" AutoPostBack="true" />
									</div>
								</td>
							</tr>
							<tr runat="server" id="rowSearchLogicalOperator" visible="false">
								<td class="tdLabel">
									<label for="<%=rblSearchLogicalOperator.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchLogicalOperator.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSearchLogicalOperator.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblSearchLogicalOperator" runat="server" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList">
											<asp:ListItem class="normalRadioButton" Value="1" Text="AND" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="8" Text="OR" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr runat="server" id="trSearchMultiCheckBoxViewType" visible="false">
								<td class="tdLabel">
									<label for="<%=rblSearchMultiCheckBoxViewType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchMultiCheckBoxViewType.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSearchMultiCheckBoxViewType.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblSearchMultiCheckBoxViewType" runat="server" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList">
											<asp:ListItem class="normalRadioButton" Value="0" Text="Default" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="1" Text="Dropdown" />
											<asp:ListItem class="normalRadioButton" Value="2" Text="Multiselect Dropdown" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlIsSearchableExtensions" runat="server" Visible="true">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=rblSearchExtensionType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchExtensionType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchExtensionType.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblSearchExtensionType" runat="server" OnSelectedIndexChanged="rblSearchExtensionType_SelectedIndexChanged" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList" AutoPostBack="true">
											<asp:ListItem class="normalRadioButton" Value="0" Text="Normal box" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="1" Text="Range search" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
						<asp:Panel ID="pnlRangeSearch" runat="server" Visible="false">
							<table class="optionsList fullWidthTable tablePadding5 noBorder">
								<tr>
									<td class="tdLabel">
										<label for="<%=rblCalculateFromDB.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCalculateFromDB.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCalculateFromDB.Text") %></label>
									</td>
									<td>
										<div class="edNews_inputGroup">
											<asp:RadioButtonList ID="rblCalculateFromDB" runat="server" AutoPostBack="True" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList" OnSelectedIndexChanged="rblCalculateFromDB_SelectedIndexChanged">
												<asp:ListItem class="normalRadioButton" Selected="True" Value="0">Automatic</asp:ListItem>
												<asp:ListItem class="normalRadioButton" Value="1">Manual</asp:ListItem>
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
							</table>
							<asp:Panel ID="pnlRangeSearchFromToManual" runat="server" Visible="false">
								<table class="optionsList fullWidthTable tablePadding5 noBorder">
									<tr>
										<td class="tdLabel">
											<label class="edNews_tooltip" data-tooltip-content="<%=_("lblFromToValues.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFromToValues.Text") %></label>
										</td>
										<td>
											<asp:TextBox ID="tbxFromValue" runat="server" />
											<asp:TextBox ID="tbxToValue" runat="server" />
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Label ID="lblRangeSearchFromToManualInfo" runat="server" EnableViewState="false" />
						</asp:Panel>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlOrderable" runat="server" Visible="true" CssClass="sectionBox noBorder noMargin noPadding">
					<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
						<span><span><i class="fa fa-sort-amount-asc"></i></span></span><%=orderableTitle%></span>
					</div>
					<div class="settings_category_container">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbIsOrderable.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsOrderable.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsOrderable.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbIsOrderable" CssClass="normalCheckBox" Text="Field is 'order by'" runat="server" Checked="false" />
									</div>
								</td>
							</tr>
						</table>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlSpecificOptions" runat="server" Visible="false" CssClass="sectionBox noBorder noMargin noPadding">
					<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
						<span><span><i class="fa fa-wrench"></i></span></span><%=specificOptions%></span>
					</div>
					<asp:Panel ID="pnlDateTimePickerOptions" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowTimePicker.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowTimePicker.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowTimePicker.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbShowTimePicker" CssClass="normalCheckBox" Text="Show time" runat="server" Checked="false" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlNewsCategories" runat="server" Visible="false">
						<asp:UpdatePanel ID="upCategorySelection" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppCategorySelection" runat="server" AssociatedUpdatePanelID="upCategorySelection" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay"></div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList fullWidthTable tablePadding5 noBorder">
										<tr>
											<td class="tdLabel textTop">
												<label class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectNewsCategories.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectNewsCategories.Text") %></label>
											</td>
											<td>
												<div class="itemActions smallActions">
													<asp:LinkButton ID="lblCategorySelectionExpandAll" CssClass="expandAction" runat="server" Text="Expand all" OnClick="TreeViewExpandAll_Click" resourcekey="lblCategorySelectionExpandAll" />
													<asp:LinkButton ID="lblCategorySelectionCollapseAll" CssClass="collapseAction" runat="server" Text="Collapse all" OnClick="TreeViewCollapseAll_Click" resourcekey="lblCategorySelectionCollapseAll" />
													<asp:LinkButton ID="lbCategorySelectionSelectAll" CssClass="checkAction" runat="server" Text="Select all" OnClick="TreeViewSelectAll_Click" resourcekey="lbCategorySelectionSelectAll" />
													<asp:LinkButton ID="lbCategorySelectionDeselectAll" CssClass="unCheckAction" runat="server" Text="Deselect all" OnClick="TreeViewDeselectAll_Click" resourcekey="lbCategorySelectionDeselectAll" />
												</div>
												<asp:TreeView ID="tvNewsCategories" runat="server" EnableViewState="true" ForeColor="Black" NodeWrap="True" ShowCheckBoxes="All" ShowLines="True" CssClass="category_tree_view" />
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
					<asp:Panel ID="pnlAuthorAndGroupSelection" runat="server" Visible="false">
						<asp:UpdatePanel ID="upAuthorAndGroupSelection" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppAuthorAndGroupSelection" runat="server" AssociatedUpdatePanelID="upAuthorAndGroupSelection" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay"></div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList fullWidthTable tablePadding5 noBorder">
										<tr>
											<td class="tdLabel textTop">
												<label class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorAndGroupSelection.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorAndGroupSelection.Text") %></label>
											</td>
											<td>
												<div class="itemActions smallActions">
													<asp:LinkButton ID="lblAuthorAndGroupExpandAll" CssClass="expandAction" runat="server" Text="Expand all" OnClick="TreeViewExpandAll_Click" resourcekey="lblCategorySelectionExpandAll" />
													<asp:LinkButton ID="lblAuthorAndGroupCollapseAll" CssClass="collapseAction" runat="server" Text="Collapse all" OnClick="TreeViewCollapseAll_Click" resourcekey="lblCategorySelectionCollapseAll" />
													<asp:LinkButton ID="lbAuthorAndGroupSelectAll" CssClass="checkAction" runat="server" Text="Select all" OnClick="TreeViewSelectAll_Click" resourcekey="lbCategorySelectionSelectAll" />
													<asp:LinkButton ID="lbAuthorAndGroupDeselectAll" CssClass="unCheckAction" runat="server" Text="Deselect all" OnClick="TreeViewDeselectAll_Click" resourcekey="lbCategorySelectionDeselectAll" />
												</div>
												<asp:TreeView ID="tvAuthorAndGroupSelection" runat="server" ExpandDepth="0" ImageSet="Contacts" ShowCheckBoxes="All" NodeIndent="25">
													<HoverNodeStyle Font-Underline="False" />
													<NodeStyle Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px" NodeSpacing="0px" VerticalPadding="0px" />
													<ParentNodeStyle Font-Bold="True" ForeColor="#5555DD" />
													<SelectedNodeStyle Font-Underline="True" HorizontalPadding="0px" VerticalPadding="0px" />
												</asp:TreeView>
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
					<asp:Panel ID="pnlNewsDate" runat="server" Visible="false">
						<asp:UpdatePanel ID="upNewsDate" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppNewsDate" runat="server" AssociatedUpdatePanelID="upNewsDate" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay"></div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList fullWidthTable tablePadding5 noBorder">
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlNewsDateField.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewsDate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNewsDate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList runat="server" ID="ddlNewsDateField">
													<asp:ListItem Value="PublishDate" ResourceKey="liPublishDate" Text="Publish date" />
													<asp:ListItem Value="DateAdded" ResourceKey="liDateAdded" Text="Date added" />
													<asp:ListItem Value="ExpireDate" ResourceKey="liExpireDate" Text="Expire date" />
													<asp:ListItem Value="LastModified" ResourceKey="liLastModified" Text="Last modified" />
													<asp:ListItem Value="StartDate" ResourceKey="liStartDate" Text="Event start date" />
												</asp:DropDownList>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=cbNewsDateShowTime.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewsDateShowTime.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNewsDateShowTime.Text") %></label>
											</td>
											<td>
												<div class="switchCheckbox">
													<asp:CheckBox ID="cbNewsDateShowTime" Text="Show time" CssClass="normalCheckBox" runat="server" Checked="false" />
												</div>
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
					<asp:Panel ID="pnlSearchField" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbSearchFieldAutocomplete.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSearchFieldAutocomplete.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSearchFieldAutocomplete.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbSearchFieldAutocomplete" CssClass="normalCheckBox" Text="Autocomplete" runat="server" Checked="false" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlSortField" runat="server" Visible="false">
						<asp:UpdatePanel ID="upSortField" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppSortField" runat="server" AssociatedUpdatePanelID="upSortField" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay"></div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<asp:Label ID="lblSaveBeforeInsert" runat="server" Text="Must save field before administration of order by items." Visible="false" />
									<asp:Panel ID="pnlOrderByAdministration" runat="server" Visible="false">
										<span class="edNews_titleH2">Sort field</span>
										<table class="optionsList fullWidthTable tablePadding5 noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=tbxOrderByName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOrderByName.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOrderByName.Text") %></label>
												</td>
												<td>
													<asp:TextBox ID="tbxOrderByName" runat="server" />
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label class="edNews_tooltip" data-tooltip-content="<%=_("lblSortField.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSortField.Text") %></label>
												</td>
												<td>
													<asp:DropDownList ID="ddlSortFieldBy" runat="server"></asp:DropDownList>
													<asp:DropDownList ID="ddlSortFieldAscDesc" runat="server">
														<asp:ListItem Value="DESC" Text="Descending" Selected="True" />
														<asp:ListItem Value="ASC" Text="Ascending" />
													</asp:DropDownList>
													<div class="mainActions displayInline smallActions noMargin">
														<asp:Button ID="btnAddSortField" runat="server" CssClass="add" Text="CREATE ELEMENT" OnClick="btnAddSortField_Click" ResourceKey="btnAddSortField" />
													</div>
												</td>
											</tr>
										</table>
										<asp:ListBox ID="listSortFields" runat="server" Visible="false"></asp:ListBox>
										<asp:Label ID="lblInfoAddOrderBy" runat="server" EnableViewState="false" />
										<asp:ObjectDataSource ID="odsOrderByItems" runat="server" SelectMethod="GetOrderByItems" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB" UpdateMethod="IUOrderByItemNEKORISTITI" DeleteMethod="DeleteOrderByItem">
											<DeleteParameters>
												<asp:Parameter Name="Id" Type="Int32" />
											</DeleteParameters>
											<SelectParameters>
												<asp:Parameter Name="CustomFieldID" Type="Int32" />
											</SelectParameters>
											<UpdateParameters>
												<asp:Parameter Name="Id" Type="Int32" />
												<asp:Parameter Name="CustomFieldID" Type="Int32" />
												<asp:Parameter Name="Name" Type="String" />
												<asp:Parameter Name="Position" Type="Int32" />
											</UpdateParameters>
										</asp:ObjectDataSource>
										<div class="sectionBox noBorder">
											<asp:GridView ID="gvOrderByItems" runat="server" DataSourceID="odsOrderByItems" EnableModelValidation="True" AutoGenerateColumns="False" OnRowDataBound="gvOrderByItems_RowDataBound" OnRowCommand="gvOrderByItems_RowCommand" AllowPaging="True" AllowSorting="True" DataKeyNames="Id,CustomFieldID" GridLines="None" HorizontalAlign="Center" CssClass="optionsList strippedTable fullWidthTable tablePadding5 textCenter" PageSize="20" OnRowUpdating="gvOrderByItems_RowUpdating" OnRowEditing="gvOrderByItems_RowEditing" OnDataBound="gvOrderByItems_PreRender">
												<Columns>
													<asp:TemplateField ShowHeader="True" HeaderText="gvActionHeaderText">
														<EditItemTemplate>
															<div class="itemActions displayInline smallActions">
																<asp:LinkButton ID="lbUpdate" runat="server" CssClass="saveAction" CausesValidation="True" CommandName="Update" Text="Update" />
																<asp:LinkButton ID="lbCancel" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
															</div>
														</EditItemTemplate>
														<ItemTemplate>
															<div class="itemActions displayInline smallActions">
																<asp:LinkButton ID="lbEdit" runat="server" CssClass="editAction" CausesValidation="False" CommandName="Edit" Text="Edit" />
																<asp:LinkButton ID="lbDelete" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?');" />
																<asp:LinkButton ID="lblgvChildeParentElementsLocalize" CssClass="localizeAction" runat="server" CausesValidation="False" CommandName="Localize" Text="Translate" ResourceKey="lbgvMultiControlElementsLocalize" />
															</div>
														</ItemTemplate>
														<HeaderStyle Width="240px" />
													</asp:TemplateField>
													<asp:BoundField DataField="Id" HeaderText="gvMultiControlElementsFieldElementID" ReadOnly="True">
														<HeaderStyle Width="60px" />
													</asp:BoundField>
													<asp:BoundField DataField="CustomFieldID" HeaderText="gvMultiControlElementsCustomFieldID" ReadOnly="True">
														<HeaderStyle Width="60px" />
													</asp:BoundField>
													<asp:TemplateField HeaderText="gvMultiControlElementsText">
														<EditItemTemplate>
															<asp:TextBox ID="tbxText" runat="server" Text='<%# Bind("Name") %>' />
														</EditItemTemplate>
														<ItemTemplate>
															<asp:Label ID="lblText" runat="server" Text='<%# Bind("Name") %>' />
														</ItemTemplate>
													</asp:TemplateField>
													<asp:TemplateField HeaderText="Sort by">
														<ItemTemplate>
															<asp:Label ID="lblSortBy" runat="server" Text='<%# GetSortByDefinitionValue(Eval("OrderByDefinition"),Eval("SysIdOrderable"),Eval("SortOrder"),Eval("OrderByDefinition"))%>' />
														</ItemTemplate>
													</asp:TemplateField>
													<asp:TemplateField ShowHeader="True" HeaderText="gvLocalizeText" Visible="false">
														<ItemTemplate>
															<asp:DropDownList ID="ddlSelectLocale" runat="server" Visible="false" />
															<div class="itemActions displayInline smallActions">
																<asp:LinkButton ID="lbLoadLocale" runat="server" CssClass="loadAction" CausesValidation="False" CommandName="LoadLocale" CommandArgument='<%#Eval("Id") %>' Text="Load locale" Visible="false" />
															</div>
															<asp:TextBox ID="tbxLocalizedText" runat="server" Visible="false" />
															<div class="itemActions displayInline smallActions">
																<asp:LinkButton ID="lbSaveLocale" runat="server" CssClass="saveAction" CausesValidation="False" CommandName="SaveLocale" CommandArgument='<%#Eval("Id") %>' Text="Save" Visible="false" />
																<asp:LinkButton ID="lbCloseLocale" runat="server" CssClass="closeAction" CausesValidation="False" CommandName="CloseLocale" Text="Close" Visible="false" />
																<asp:LinkButton ID="lbDeleteLocale" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="DeleteLocale" CommandArgument='<%#Eval("Id") %>' Text="Delete" Visible="false" />
															</div>
														</ItemTemplate>
													</asp:TemplateField>
													<asp:TemplateField HeaderText="gvMultiControlElementsPosition" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="60px">
														<ItemTemplate>
															<div id="Td1" runat="server" visible="false">
																<asp:TextBox ID="tbxPositionValCategory" runat="server" CssClass="boxposition" Enabled="False" Font-Size="X-Small" Height="14px" ReadOnly="True" Text='<%# Bind("Position")%>' Visible="true" Width="25px" Style="width: 25px; height: 14px;" />
															</div>
															<div class="edNews_boxedActions">
																<asp:LinkButton ID="btnUPElement" CssClass="edNews_aaUp" runat="server" CausesValidation="false" Text="Up" ResourceKey="Up" CommandArgument='<%#Eval("Id") %>' CommandName="btnUPElement" />
																<asp:LinkButton ID="btnDownElement" CssClass="edNews_aaDown" runat="server" CausesValidation="false" Text="Down" ResourceKey="Down" CommandArgument='<%#Eval("Id") %>' CommandName="btnDownElement" />
															</div>
														</ItemTemplate>
														<ItemStyle Width="100px" />
													</asp:TemplateField>
												</Columns>
												<EditRowStyle CssClass="editItemState" />
												<HeaderStyle CssClass="tableHeader" />
												<PagerStyle CssClass="contentPagination" />
											</asp:GridView>
										</div>
									</asp:Panel>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
					<asp:Panel ID="pnlUploadField" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=rblUploadContentType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUploadContentType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUploadContentType.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblUploadContentType" runat="server" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList">
											<asp:ListItem class="normalRadioButton" Value="0" ResourceKey="liFile" Text="File" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="1" ResourceKey="liImage" Text="Image" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxUploadFileSizeLimit.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUploadFileSizeLimit.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUploadFileSizeLimit.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbxUploadFileSizeLimit" runat="server" Text="3" />
									<asp:RequiredFieldValidator ID="rfvUploadFileSizeLimit" CssClass="smallInfo error" runat="server" ErrorMessage="Required field!" ControlToValidate="tbxUploadFileSizeLimit" Display="Dynamic" SetFocusOnError="True" ValidationGroup="vgSaveField" resourcekey="rfvCustomFieldName.ErrorMessage" />
									<asp:CompareValidator ID="cvUploadFileSizeLimit" runat="server" CssClass="smallInfo error" ControlToValidate="tbxUploadFileSizeLimit" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSaveField" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxFileTypes.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFileTypes.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFileTypes.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth40">
										<asp:TextBox ID="tbxFileTypes" runat="server" Text="jpg,jpeg,jpe,gif,bmp,png,doc,docx,xls,xlsx,ppt,pptx,pdf,txt,zip,mpg,mpeg,mp3" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlTextBox_Text" runat="server" Visible="false">
						<table class="optionsList fullWidthTable tablePadding5 noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbMultiLineTextBox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMultiLineTextBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMultiLineTextBox.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox runat="server" ID="cbMultiLineTextBox" Text="MultiLine textBox" CssClass="normalCheckBox" Checked="false" />
									<div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:CustomValidator ID="cvCategoriesTreeView" runat="server" ClientValidationFunction="CategoryClientValidate" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="vgSaveField"></asp:CustomValidator>
				<asp:CustomValidator ID="cvAuthorsTreeView" runat="server" ClientValidationFunction="ClientValidateAuthors" Enabled="False" ErrorMessage="Please select at least one author." resourcekey="cvAuthorsTreeview.ErrorMessage" ValidationGroup="vgSaveField"></asp:CustomValidator>
				<div class="mainActions">
					<asp:Button ID="btnSaveField" runat="server" CssClass="add" Text="Create Field" OnClick="btnSaveField_Click" ValidationGroup="vgSaveField" ResourceKey="btnSaveField" />
					<asp:Button ID="btnUpdateField" runat="server" CssClass="downSave" Text="Update Field" ValidationGroup="vgSaveField" Visible="false" OnClick="btnUpdateField_Click" ResourceKey="btnUpdateField" />
					<asp:Button ID="btnCancel" runat="server" CssClass="cancel" Text="Close" Visible="false" OnClick="btnCancel_Click" ResourceKey="btnCancel" />
					<asp:Button ID="btnClose" runat="server" CssClass="downClose" Text="Cancel" OnClick="btnCancel_Click" ResourceKey="btnClose" />
				</div>
			</asp:Panel>
		</asp:Panel>
		<asp:Label ID="lblSaveInfo" runat="server" EnableViewState="False" />
	</div>
</div>
