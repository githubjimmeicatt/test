<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.Administration.CurrencyManager, App_Web_currencymanager.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span>Currency manager</span>
		</div>
		<asp:Literal ID="liAdminNavigation" runat="server"></asp:Literal>
		<asp:Panel ID="pnlFieldsList" class="module_settings" runat="server">
			<asp:Panel ID="pnlFieldsListcss" runat="server" Visible="true" CssClass="sectionBox noPadding sectionBox2">
				<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
					<span><span>1</span><%=titleDefaultCurrencyOnPortal%></span>
				</div>
				<table class="optionsList fullWidthTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlBaseCurrency.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMoneyType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMoneyType.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlBaseCurrency" runat="server" AutoPostBack="false" Enabled="false" EnableViewState="true" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel"></td>
						<td>
							<div class="mainActions textLeft smallActions noMargin">
								<asp:Button ID="btnAddCurrencyToPortal" CssClass="add" runat="server" Text="Add" Enabled="false" OnClick="btnAddCurrencyToPortal_Click" ResourceKey="btnAddCurrencyToPortal" />
							</div>
							<div class="itemActions smallActions">
								<asp:LinkButton ID="lblResetCurency" runat="server" CssClass="refreshAction color4" OnClientClick="return confirm('Are you sure you want to delete base curreny and ALL Values?');" OnClick="lblResetCurency_Click" Text="Reset base currency and delete Exchange rate list" ResourceKey="lblResetCurency" />
							</div>
						</td>
					</tr>
				</table>
				<asp:Label ID="lblBaseCurrency" runat="server" Text="" EnableViewState="false" />
			</asp:Panel>
		</asp:Panel>
		<asp:Panel ID="pnlAllSettings" class="module_settings" runat="server">
			<asp:Panel ID="pnlMainSelect" runat="server" Visible="true" CssClass="sectionBox noPadding sectionBox2">
				<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
					<span><span>2</span><%=titlePortalExchangeRateList%></span>
				</div>
				<table class="optionsList fullWidthTable strippedTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlAddCurrencyToList.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddCurrencyToList.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAddCurrencyToList.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlAddCurrencyToList" runat="server" Width="200px" AutoPostBack="true" Enabled="true" EnableViewState="true" OnSelectedIndexChanged="ddlAddCurrencyToList_SelectedIndexChanged" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxExchangeRate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExchangeRate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExchangeRate.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxExchangeRate" runat="server" EnableViewState="true" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxUnit.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUnit.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUnit.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxUnit" runat="server" EnableViewState="true" Text="1" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel textTop">
							<label for="<%=ddlMainDisplayFormat.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMainDisplayFormat.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMainDisplayFormat.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlMainDisplayFormat" runat="server" Width="200px" AutoPostBack="false" Enabled="true" EnableViewState="true" />
							<div class="mainActions smallActions textLeft">
								<asp:Button ID="btnAddToExchangeRateList" CssClass="add" runat="server" Text="Add to list" OnClick="btnAddToExchangeRateList_Click" ResourceKey="btnAddToExchangeRateList" />
							</div>
						</td>
					</tr>
				</table>
				<asp:Label ID="lblAddCurrencyToListInfo" runat="server" Text="" EnableViewState="false" />
				<div class="sectionBox noPadding">
					<div class="negativeMargins">
						<asp:ObjectDataSource ID="odsExchangeRateList" runat="server" SelectMethod="GetExchangeRateList" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB" UpdateMethod="UpdateExchangeRateListItem" DeleteMethod="RemoveExchangeRateListItem">
							<DeleteParameters>
								<asp:Parameter Name="ACodeBase" Type="String" />
								<asp:Parameter Name="PortalID" Type="Int32" />
								<asp:Parameter Name="ACode" Type="String" />
								<asp:Parameter Name="DisplayFormat" Type="String" />
							</DeleteParameters>
							<SelectParameters>
								<asp:Parameter Name="PortalID" Type="Int32" />
							</SelectParameters>
							<UpdateParameters>
								<asp:Parameter Name="ACodeBase" Type="String" />
								<asp:Parameter Name="PortalID" Type="Int32" />
								<asp:Parameter Name="ACode" Type="String" />
								<asp:Parameter Name="Unit" Type="Int32" />
								<asp:Parameter Name="ExchangeRate" Type="Decimal" />
								<asp:Parameter Name="DisplayFormat" Type="String" />
							</UpdateParameters>
						</asp:ObjectDataSource>
						<asp:GridView ID="gvExchangeRateList" runat="server" CssClass="fullWidthTable strippedTable tablePadding5 textCenter" DataSourceID="odsExchangeRateList" EnableModelValidation="True" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ACodeBase,PortalID,ACode,DisplayFormat" OnRowCommand="gvExchangeRateList_RowCommand" PageSize="15" OnRowDeleted="gvExchangeRateList_RowDeleted" OnRowDataBound="gvExchangeRateList_RowDataBound">
							<Columns>
								<asp:CommandField DeleteText="Remove" ShowDeleteButton="True" ShowEditButton="True">
									<ItemStyle CssClass="textLeft" Width="150px" />
								</asp:CommandField>
								<asp:BoundField DataField="ACodeBase" HeaderText="ACodeBase" Visible="False" />
								<asp:BoundField DataField="PortalID" HeaderText="PortalID" Visible="False" />
								<asp:TemplateField HeaderText="ACode">
									<ItemTemplate>
										<asp:Label ID="lblAcode" runat="server" Text='<%# Bind("ACode") %>' />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:Label ID="lblAcode" runat="server" Text='<%# Eval("ACode") %>' />
									</EditItemTemplate>
									<HeaderStyle HorizontalAlign="Center" Width="60px" />
								</asp:TemplateField>
								<asp:BoundField DataField="Unit" HeaderText="Unit">
									<HeaderStyle HorizontalAlign="Center" Width="50px" />
								</asp:BoundField>
								<asp:BoundField DataField="ExchangeRate" HeaderText="ExchangeRate" />
								<asp:BoundField DataField="DateTime" HeaderText="DateTime" ReadOnly="True" />
								<asp:TemplateField HeaderText="Currency Display Format">
									<ItemTemplate>
										<asp:DropDownList ID="ddlGVMainCurrencySimbol" Width="200px" runat="server" Enabled="false" AppendDataBoundItems="true" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:DropDownList ID="ddlGVMainCurrencySimbol" Width="200px" runat="server" Enabled="false" AppendDataBoundItems="true" />
									</EditItemTemplate>
								</asp:TemplateField>
							</Columns>
							<HeaderStyle CssClass="tableHeader" />
							<PagerStyle CssClass="contentPagination" />
							<EditRowStyle CssClass="editItemState" />
						</asp:GridView>
					</div>
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlAsignLocaleToCurrency" class="sectionBox noPadding sectionBox2" runat="server" Visible="true">
				<div class="sectionBoxSubtitle sectionBoxSubtitleWithNumber">
					<span><span>3</span><%=titleAssignCurrencyExchangeListItems%></span>
				</div>
				<table class="optionsList fullWidthTable strippedTable tablePadding5 noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlEnabledLocales.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnabledLocales.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnabledLocales.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlEnabledLocales" runat="server" Enabled="true" EnableViewState="true" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlCurrencyExchangeList.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCurrencyExchange.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCurrencyExchange.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlCurrencyExchangeList" runat="server" AutoPostBack="True" Enabled="true" EnableViewState="true" OnSelectedIndexChanged="ddlCurrencyExchangeList_SelectedIndexChanged" />
							<asp:DropDownList ID="ddlCurrencySimbol" runat="server" AutoPostBack="false" Enabled="true" EnableViewState="true" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel"></td>
						<td>
							<div class="mainActions smallActions textLeft">
								<asp:Button ID="btnAsignLocaleTo" CssClass="add" runat="server" Text="Asign language to currency" OnClick="btnAsignLocaleTo_Click" ResourceKey="btnAsignLocaleTo" />
							</div>
						</td>
					</tr>
				</table>
				<asp:Label ID="lblAsignLocaleToCurrencyInfo" runat="server" Text="" EnableViewState="false" />
				<div class="sectionBox noPadding">
					<div class="negativeMargins">
						<asp:ObjectDataSource ID="odsAsignLocaleToCurrency" runat="server" DeleteMethod="RemoveLocaleToCurrencyList" SelectMethod="GetLocaleToCurrencyList" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB">
							<DeleteParameters>
								<asp:Parameter Name="ACode" Type="String" />
								<asp:Parameter Name="PortalID" Type="Int32" />
								<asp:Parameter Name="LocaleKey" Type="String" />
							</DeleteParameters>
							<SelectParameters>
								<asp:Parameter Name="PortalID" Type="Int32" />
							</SelectParameters>
						</asp:ObjectDataSource>
						<asp:GridView ID="gvAsignLocaleToCurrency" runat="server" CssClass="fullWidthTable strippedTable tablePadding5 textCenter" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="odsAsignLocaleToCurrency" EnableModelValidation="True" DataKeyNames="ACode,PortalID,LocaleKey" OnRowDeleted="gvAsignLocaleToCurrency_RowDeleted" >
							<Columns>
								<asp:CommandField ShowDeleteButton="True" />
								<asp:BoundField DataField="ACodeBase" HeaderText="Base currency code" />
								<asp:BoundField DataField="Acode" HeaderText="Currency code" />
								<asp:BoundField DataField="PortalID" HeaderText="PortalID" />
								<asp:BoundField DataField="LocaleKey" HeaderText="Locale Key" />
								<asp:BoundField DataField="DisplayFormat" HeaderText="Display Format" />
							</Columns>
							<HeaderStyle CssClass="tableHeader" />
							<PagerStyle CssClass="contentPagination" />
							<EditRowStyle CssClass="editItemState" />
						</asp:GridView>
					</div>
				</div>
			</asp:Panel>
		</asp:Panel>
	</div>
</div>
