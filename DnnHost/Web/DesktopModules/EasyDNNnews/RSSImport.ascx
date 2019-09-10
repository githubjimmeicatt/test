<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.RSSImport, App_Web_rssimport.ascx.d988a5ac" %>
<script type="text/javascript">
	function ConfirmDelete() {
		return confirm('<%=_("Areyousure.Text")%>');
	}
	function CategoryClientValidate(source, arguments) {
		if ($('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}
</script>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=_("ControlTitle_rssimport")%></span>
		</div>
		<asp:Panel ID="pnlRSSFeedList" runat="server" CssClass="sectionBox noPadding">
			<div class="negativeMargins">
				<asp:GridView ID="gvFeeds" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="odsFeeds" EnableModelValidation="True" DataKeyNames="RSSID" OnRowCommand="gvFeeds_RowCommand" CssClass="strippedTable fullWidthTable tablePadding5 textCenter">
					<Columns>
						<asp:TemplateField ShowHeader="False">
							<ItemTemplate>
								<div class="edNews_boxedActions">
									<asp:HyperLink ID="hlEdit" runat="server" CausesValidation="False" CssClass="edNews_aaEdit edNews_tooltip" resourcekey="LinkButton2Resource1" data-tooltip-content='<%#_("LinkButton2Resource1.ToolTip")%>' data-tooltip-position="top-left" NavigateUrl='<%# EasyDNNSolutions.Modules.EasyDNNNews.LinkManager.UrlResolve.GetUrl(TabId, ModuleId, EasyDNNSolutions.Modules.EasyDNNNews.LinkManager.UrlResolve.RSSImportControlKey, useAdminNoSkinUrl, new List<string> { "editrssid="+Eval("RSSID").ToString() }) %>'></asp:HyperLink>
									<asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandName="Delete" CssClass="edNews_aaDelete color4 edNews_tooltip" data-tooltip-content='<%#_("LinkButton1Resource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="LinkButton1Resource1" OnClientClick="return ConfirmDelete();"></asp:LinkButton>
								</div>
								<div class="itemActions smallActions">
									<asp:LinkButton ID="lbDeleteAllArticlesByFees" CssClass="deleteAction color4" runat="server" CausesValidation="False" CommandArgument='<%# Eval("RSSID") %>' CommandName="DeleteArticlesByFeed" resourcekey="lbDeleteAllArticlesByFeesResource1" OnClientClick="return ConfirmDelete();" Text="Delete all articles added by this feed"></asp:LinkButton>
								</div>
							</ItemTemplate>
							<HeaderStyle Width="100px" />
						</asp:TemplateField>
						<asp:BoundField DataField="RSSID" HeaderText="ID">
							<HeaderStyle Width="50px" />
						</asp:BoundField>
						<asp:BoundField DataField="RSSURL" HeaderText="RSS URL">
							<HeaderStyle Width="200px" />
						</asp:BoundField>
						<asp:TemplateField HeaderText="Author">
							<ItemTemplate>
								<asp:Label ID="lblAuthor" runat="server" resourcekey="lblAuthorResource1" Text='<%# GetUserNameDisplay(Eval("UserID")) %>'></asp:Label>
							</ItemTemplate>
							<HeaderStyle Width="100px" />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Category">
							<ItemTemplate>
								<asp:Label ID="lblCategoryName" runat="server" Text='<%#string.IsNullOrEmpty(Eval("CategoryName").ToString())?"": string.Join(", ", XDocument.Parse(Eval("CategoryName").ToString()).Root.Elements("Category").Select(element => element.Value).ToList().ToArray()) %>' />
							</ItemTemplate>
							<HeaderStyle Width="100px" />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Download Images">
							<ItemTemplate>
								<div class="styledCheckbox noLabel">
									<asp:CheckBox ID="cbDownloadImages" CssClass="normalCheckBox" Text="Download Images" runat="server" Checked='<%# Bind("DownloadImages") %>' Enabled="False" resourcekey="cbDownloadImagesResource1" />
								</div>
							</ItemTemplate>
							<HeaderStyle Width="60px" />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Active">
							<ItemTemplate>
								<div class="styledCheckbox noLabel">
									<asp:CheckBox ID="cbActive" CssClass="normalCheckBox" Text="Active" runat="server" Checked='<%# Bind("Active") %>' Enabled="False" resourcekey="cbActiveResource1" />
								</div>
							</ItemTemplate>
							<HeaderStyle Width="60px" />
						</asp:TemplateField>
					</Columns>
					<HeaderStyle CssClass="tableHeader" />
				</asp:GridView>
			</div>
		</asp:Panel>
		<asp:Label ID="lblSchedulerInfo" runat="server" resourcekey="lblSchedulerInfoResource1"></asp:Label>
		<asp:Panel ID="pnlAddRSSImport" CssClass="sectionBox noPadding sectionBox2" runat="server">
			<div class="sectionBoxHeader">
				<asp:Label ID="lblAddEditRSS" runat="server" CssClass="sectionBoxHeaderTitle" Text="Import RSS" resourcekey="lblAddEditRSSResource1"></asp:Label>
			</div>
			<div class="content">
				<table class="optionsList fullWidthTable strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbFeedURL.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFeedURL.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFeedURL.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbFeedURL" runat="server" Width="350px" ValidationGroup="vgRSSImport"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvFeedURL" CssClass="smallInfo error" runat="server" ControlToValidate="tbFeedURL" ErrorMessage="Please enter feed URL." ValidationGroup="vgRSSImport" Display="Dynamic" resourcekey="rfvFeedURLResource1.ErrorMessage"></asp:RequiredFieldValidator>
							<asp:RegularExpressionValidator ID="revFeedURL" runat="server" ControlToValidate="tbFeedURL" Display="Dynamic" ErrorMessage="Please enter valid URL." ValidationExpression="http(s)?://([\w-])+[\w-]+(/[\w- ./?%&amp;=]*)?" ValidationGroup="vgRSSImport" resourcekey="revFeedURLResource1.ErrorMessage" Enabled="False"></asp:RegularExpressionValidator>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlRoles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectFeedAuthor.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectFeedAuthor.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged">
								<asp:ListItem Value="-1" resourcekey="ListItemResource1">Select role</asp:ListItem>
							</asp:DropDownList>
							<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True">
								<asp:ListItem Value="0" resourcekey="ListItemResource2">Select author</asp:ListItem>
							</asp:DropDownList>
							<asp:CompareValidator ID="cvAuthors" runat="server" CssClass="smallInfo error" ControlToValidate="ddlAuthors" Display="Dynamic" ErrorMessage="Please select Author" Operator="NotEqual" ValidationGroup="vgRSSImport" ValueToCompare="0" resourcekey="CompareValidator1Resource1.ErrorMessage"></asp:CompareValidator>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=phDinamicTreeView.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectFeedCategory.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectFeedCategory.Text") %></label>
						</td>
						<td>
							<asp:PlaceHolder ID="phDinamicTreeView" runat="server"></asp:PlaceHolder>
							<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" ErrorMessage="Please select at least one category." Display="Dynamic" Enabled="True" ValidationGroup="vgRSSImport" resourcekey="CompareValidator2Resource1.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbDownloadImages.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDownloadImages.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDownloadImages.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbDownloadImages" CssClass="normalCheckBox" runat="server" Text="Download images and use them as article image" Checked="True" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbLimitNumberOfArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitNumberofArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitNumberofArticles.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbLimitNumberOfArticles" runat="server" CssClass="smallCentered" resourcekey="tbLimitNumberOfArticlesResource1">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvLimitContent" runat="server" CssClass="smallInfo error" ControlToValidate="tbLimitNumberOfArticles" Display="Dynamic" ErrorMessage="Please enter article limit number." ValidationGroup="vgRSSImport" resourcekey="rfvLimitContentResource1.ErrorMessage"></asp:RequiredFieldValidator>
							<asp:CompareValidator ID="cvLimitNumberOfArticles" runat="server" CssClass="smallInfo error" ControlToValidate="tbLimitNumberOfArticles" Display="Dynamic" ErrorMessage="Please enter number. " Operator="DataTypeCheck" SetFocusOnError="True" Type="Integer" ValidationGroup="vgRSSImport" resourcekey="cvLimitNumberOfArticlesResource1.ErrorMessage"></asp:CompareValidator>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbLimitImportIntoSummary.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitSummaryCharImport.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitSummaryCharImport.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbLimitImportIntoSummary" runat="server" CssClass="smallCentered">0</asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvLimitImportIntoSummary" runat="server" CssClass="smallInfo error" ControlToValidate="tbLimitImportIntoSummary" Display="Dynamic" ErrorMessage="Please enter article limit number." resourcekey="rfvLimitContentResource1.ErrorMessage" ValidationGroup="vgRSSImport"></asp:RequiredFieldValidator>
							<asp:CompareValidator ID="cvLimitImportIntoSummary" runat="server" CssClass="smallInfo error" ControlToValidate="tbLimitImportIntoSummary" Display="Dynamic" ErrorMessage="Please enter number. " Operator="DataTypeCheck" resourcekey="cvLimitNumberOfArticlesResource1.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgRSSImport"></asp:CompareValidator>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=cbFeedActive.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFeedActive.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFeedActive.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbFeedActive" CssClass="normalCheckBox" runat="server" Text="Active" Checked="True" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=ddlFeedType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFeedType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFeedType.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlFeedType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFeedType_SelectedIndexChanged">
								<asp:ListItem resourcekey="liStandard" Value="Standard">Standard</asp:ListItem>
								<asp:ListItem resourcekey="liYouTube" Value="YouTube">YouTube feed</asp:ListItem>
								<asp:ListItem resourcekey="liVimeo" Value="Vimeo">Vimeo feed</asp:ListItem>
								<asp:ListItem resourcekey="liiCalendar" Value="iCalendar">iCalendar Import</asp:ListItem>
								<asp:ListItem Value="custom">Custom RSS import</asp:ListItem>
							</asp:DropDownList>
							<asp:Button ID="btnRefresh" runat="server" Text="Refresh" Visible="False" />
						</td>
					</tr>
					<tr id="trUpdateICalEvents" runat="server" visible="false">
						<td class="tdLabel">
							<label for="<%=cbUpdateICalEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUpdateICalEvents.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUpdateICalEvents.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbUpdateICalEvents" CssClass="normalCheckBox" runat="server" Text="Active" Checked="false" />
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<asp:PlaceHolder runat="server" ID="phCustomRssImport"></asp:PlaceHolder>
						</td>
					</tr>
				</table>
				<asp:Label ID="lblMessage" runat="server"></asp:Label>
				<div class="mainActions">
					<asp:Button ID="btnSaveFeedSettings" CssClass="downSave" runat="server" OnClick="btnSaveFeedSettings_Click" Text="Add RSS import" ValidationGroup="vgRSSImport" resourcekey="btnSaveFeedSettingsResource1" />
					<asp:Button ID="btnUpdateFeed" CssClass="downSave" runat="server" OnClick="btnUpdateFeed_Click" Text="Update RSS import" ValidationGroup="vgRSSImport" Visible="False" resourcekey="btnUpdateFeedResource1" />
					<asp:Button ID="btnCancelEditing" CssClass="cancel" runat="server" OnClick="btnCancelEditing_Click" Text="Cancel" resourcekey="btnCancelEditingResource1" />
				</div>
			</div>
		</asp:Panel>
	</div>
</div>
<asp:ObjectDataSource ID="odsFeeds" runat="server" SelectMethod="GetAllRSSFeedsInPortal" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.RSSFeedImport.RSSImportController" DeleteMethod="DeleteRSSFeed">
	<DeleteParameters>
		<asp:Parameter Name="RSSID" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:HiddenField ID="hfRSSFeedID" runat="server" />
