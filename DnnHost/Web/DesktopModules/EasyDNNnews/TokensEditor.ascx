<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.TokensEditor, App_Web_tokenseditor.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<asp:HiddenField ID="hfArticleID" runat="server" />
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=_("TokenEditor")%></span>
		</div>
		<div class="eds_Tabs topMargin">
			<div class="eds_tabsNav">
				<asp:LinkButton ID="lbUserDefinedTokens" runat="server" OnClick="lbUserDefinedTokens_Click" CssClass="edsTabulator_active" resourcekey="lbUserDefinedTokensResource1">User defined tokens</asp:LinkButton>
				<asp:LinkButton ID="lbSystemTokens" runat="server" OnClick="lbSystemTokens_Click" resourcekey="lbSystemTokensResource1">System tokens</asp:LinkButton>
			</div>
			<div class="sectionBox noPadding">
				<asp:GridView ID="gvTokens" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" DataSourceID="odsTokens" OnPreRender="gvTokens_PreRender" DataKeyNames="TokenID" CssClass="strippedTable fullWidthTable noBorder tablePadding5" ShowFooter="True"
					OnDataBound="gvTokens_DataBound" AllowPaging="False">
					<Columns>
						<asp:TemplateField ShowHeader="False">
							<EditItemTemplate>
								<div class="edNews_boxedActions">
									<asp:LinkButton ID="lbTokenUpdateEdit" runat="server" CommandName="Update" CssClass="edNews_aaSave edNews_tooltip" data-tooltip-content='<%#_("lbTokenUpdateEditResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbTokenUpdateEditResource1" />
									<asp:LinkButton ID="lbTokenCancelEdit" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="edNews_aaCancel edNews_tooltip color4" data-tooltip-content='<%#_("lbTokenCancelEditResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbTokenCancelEditResource1" />
								</div>
							</EditItemTemplate>
							<ItemTemplate>
								<div class="edNews_boxedActions">
									<asp:LinkButton ID="lbTokenEditGrid" runat="server" CausesValidation="False" CommandName="Edit" CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("lbTokenEditGridResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbTokenEditGridResource1" />
									<asp:LinkButton ID="lbTokenDeleteGrid" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you certain you want to delete this token?');" CommandName="Delete" CssClass="edNews_aaCancel edNews_tooltip color4" data-tooltip-content='<%#_("lbTokenDeleteGridResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbTokenDeleteGridResource1" />
								</div>
							</ItemTemplate>
							<FooterTemplate>
								<div class="edNews_numberOfRows">
									<div>
										<asp:Label ID="lblNUmberOfTokensperPage" AssociatedControlID="ddlTokensPerPage" runat="server" Text="Number of tokens pre page:" resourcekey="lblNUmberOfTokensperPageResource1" />
										<asp:DropDownList ID="ddlTokensPerPage" runat="server" OnSelectedIndexChanged="dllTokensPerPage_SelectedIndexChanged" AutoPostBack="True" resourcekey="ddlTokensPerPageResource1">
											<asp:ListItem resourcekey="ListItemResource1">10</asp:ListItem>
											<asp:ListItem resourcekey="ListItemResource2">20</asp:ListItem>
											<asp:ListItem resourcekey="ListItemResource3">30</asp:ListItem>
											<asp:ListItem resourcekey="ListItemResource4">50</asp:ListItem>
											<asp:ListItem resourcekey="ListItemResource5">100</asp:ListItem>
										</asp:DropDownList>
									</div>
								</div>
							</FooterTemplate>
							<ItemStyle Width="100px" />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Token" SortExpression="TokenTitle">
							<EditItemTemplate>
								<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("TokenTitle") %>' />
								<dnn:TextEditor ID="txtTokenContentGrid" runat="server" Text='<%# Bind("TokenContent")%>' Height="250" Width="520" />
							</EditItemTemplate>
							<ItemTemplate>
								<p class="labelName"><%# Eval("TokenTitle") %></p>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbCustomToken" runat="server" Text='<%# Eval("TokenTitle", "[EasyDNNnewsToken:{0}]") %>' ReadOnly="True" resourcekey="tbCustomTokenResource1" />
								</div>
								<div class="edNews_inputGroup inputBorder inputWidth100">
									<textarea name="txtTokenContentGridView" cols="4" rows="4" readonly="readonly"><%# Eval("TokenContent") %></textarea>
								</div>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<EditRowStyle CssClass="editItemState" />
					<HeaderStyle CssClass="tableHeader" />
					<PagerStyle CssClass="contentPagination" />
				</asp:GridView>
				<asp:Label ID="lbluserTokens" runat="server" Text="There are no user tokes defined." Visible="False" resourcekey="lbluserTokensResource1"></asp:Label>
				<div class="negativeMargins">
					<asp:GridView ID="gvSystemTokens" runat="server" DataSourceID="odsSystemTokens" EnableModelValidation="True" AutoGenerateColumns="False" OnPreRender="gvSystemTokens_OnPreRender" DataKeyNames="EntryID" GridLines="None" CssClass="strippedTable fullWidthTable" ShowFooter="false" OnRowCommand="gvSystemTokens_RowCommand" Visible="False" resourcekey="gvSystemTokensResource1">
						<Columns>
							<asp:TemplateField HeaderText="Token" SortExpression="TokenTitle">
								<ItemTemplate>
									<p class="labelName"><%# Eval("TokenTitle") %></p>
									<p class="labelType"><%# Eval("Description") %></p>
									<div class="edNews_inputGroup inputWidth40">
										<asp:TextBox ID="tbCustomToken" runat="server" Text='<%# Eval("TokenTitle", "[EasyDNNnewsSystemToken:{0}]") %>' ReadOnly="True" resourcekey="tbCustomTokenResource2" />
									</div>
									<div class="edNews_inputGroup inputBorder inputWidth100">
										<textarea name="txtTokenContentGridView" cols="4" rows="4" readonly="readonly"><%# Eval("TokenContent") %></textarea>
									</div>
									<div class="mainActions smallActions">
										<asp:LinkButton ID="lbAddAsNewToken" runat="server" CssClass="add" CommandArgument='<%# Eval("EntryID") %>' CommandName="AddAsNewToken" resourcekey="lbAddAsNewTokenResource1">Add as new token and edit</asp:LinkButton>
									</div>
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
						<EditRowStyle CssClass="editItemState" />
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
				</div>
			</div>
		</div>
		<asp:Panel ID="pnlAddToken" CssClass="sectionBox" runat="server">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=_("Addnewtoken")%></span>
			</div>
			<div class="edNews_inputGroup inputWidth100 labelBlock">
				<label for="<%=tbTokenTitle.ClientID %>"><%=_("Tokentitle")%></label>
				<asp:TextBox ID="tbTokenTitle" CssClass="text" runat="server" MaxLength="100" ValidationGroup="vgTokenInsert" />
				<asp:RequiredFieldValidator ID="rfvTokenTitle" runat="server" CssClass="smallInfo error" ControlToValidate="tbTokenTitle" ErrorMessage="This field is required." ValidationGroup="vgTokenInsert" resourcekey="rfvTokenTitleResource1" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=tbTokenTitle.ClientID %>"><%=_("Tokencontent") %></label>
				<dnn:TextEditor ID="txtSummary" runat="server" Height="400" />
			</div>
			<asp:Label ID="lblTokenExistError" runat="server" ForeColor="Red" Text="A token with this title already exist. Please enter a new title." Visible="False" resourcekey="lblTokenExistErrorResource1" />
			<asp:Label ID="lblTokenSaved" runat="server" Text="Token saved." Visible="False" resourcekey="lblTokenSavedResource1" />
			<div class="mainActions">
				<asp:LinkButton ID="lbSaveSettings" runat="server" OnClick="lbSaveSettings_Click" ValidationGroup="vgCreateCat" CssClass="downSave" resourcekey="lbSaveSettingsResource1">Save token</asp:LinkButton>
			</div>
		</asp:Panel>
	</div>
</div>
<asp:ObjectDataSource ID="odsTokens" runat="server" SelectMethod="GetAllTokens" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" DeleteMethod="DeleteToken" UpdateMethod="UpdateToken">
	<DeleteParameters>
		<asp:Parameter Name="TokenID" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
	<UpdateParameters>
		<asp:Parameter Name="TokenID" Type="Int32" />
		<asp:Parameter Name="TokenTitle" Type="String" />
		<asp:Parameter Name="TokenContent" Type="String" />
	</UpdateParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsSystemTokens" runat="server" SelectMethod="GetAllSystemTokens" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess"></asp:ObjectDataSource>