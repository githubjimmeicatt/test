<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.WorkflowEditor, App_Web_workfloweditor.ascx.b9f6810f" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<asp:HiddenField ID="hfSelectedWorkflow" runat="server" />
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=_("WorkflowEditor")%></span>
		</div>
		<asp:Panel runat="server" ID="pnlWorkflowList">
			<div class="sectionBox noPadding">
				<asp:GridView ID="gvWorkflows" runat="server" AutoGenerateColumns="False" DataSourceID="odsWorkFlows" CssClass="strippedTable fullWidthTable noBorder tablePadding5" ShowFooter="True" DataKeyNames="Id" OnRowCommand="gvWorkflows_RowCommand">
					<Columns>
						<asp:TemplateField ShowHeader="False">
							<EditItemTemplate>
								<div class="edNews_boxedActions">
									<asp:LinkButton ID="lbWorkflowUpdateEdit" runat="server" CommandName="Update" CssClass="edNews_aaSave edNews_tooltip" data-tooltip-content='<%#_("lbWorkflowUpdateEdit.ToolTip")%>' data-tooltip-position="top-left" />
									<asp:LinkButton ID="lbWorkflowCancelEdit" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="edNews_aaCancel edNews_tooltip color4" data-tooltip-content='<%#_("lbWorkflowCancelEdit.ToolTip")%>' data-tooltip-position="top-left" />
								</div>
							</EditItemTemplate>
							<ItemTemplate>
								<div class="edNews_boxedActions">
									<asp:LinkButton ID="lbWorkflowEdit" runat="server" CausesValidation="False" CommandName="Edit" CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("lbWorkflowEdit.ToolTip")%>' data-tooltip-position="top-left" Visible='<%#(EasyDNNSolutions.Modules.EasyDNNNews.Workflows.Workflowtype)Eval("WorkflowType") == EasyDNNSolutions.Modules.EasyDNNNews.Workflows.Workflowtype.UserDefind%>' />
									<asp:LinkButton ID="lbWorkflowDelete" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you certain you want to delete this workflow?');" CommandName="Delete" CssClass="edNews_aaCancel edNews_tooltip color4" data-tooltip-content='<%#_("lbWorkflowDelete.ToolTip")%>' data-tooltip-position="top-left" Visible='<%#!Convert.ToBoolean(Eval("InUse")) && (EasyDNNSolutions.Modules.EasyDNNNews.Workflows.Workflowtype)Eval("WorkflowType") == EasyDNNSolutions.Modules.EasyDNNNews.Workflows.Workflowtype.UserDefind %>' />
									<asp:LinkButton ID="lbWorkflowEditStates" runat="server" CausesValidation="False" CommandArgument='<%# Eval("Id") %>' CommandName="EditStates" CssClass="edNews_aaEdit2 edNews_tooltip" data-tooltip-content='<%#_("lbWorkflowEditStates.ToolTip")%>' data-tooltip-position="top-left" Text="Edit states" />
								</div>
							</ItemTemplate>
							<ItemStyle Width="100px" />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Workflow" SortExpression="TokenTitle">
							<EditItemTemplate>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbWorkflowName" CssClass="bottomMargin" runat="server" Text='<%# Bind("Name") %>' />
									<asp:TextBox ID="tbWorkflowDescription" runat="server" Text='<%# Bind("Description")%>' Height="150" TextMode="MultiLine" Wrap="True" MaxLength="2000" />
								</div>
							</EditItemTemplate>
							<ItemTemplate>
								<p class="labelName"><%# Eval("Name") %></p>
								<div class="edNews_inputGroup inputBorder inputWidth100">
									<div><%# Eval("Description") %></div>
								</div>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<EditRowStyle CssClass="editItemState" />
					<HeaderStyle CssClass="tableHeader" />
					<PagerStyle CssClass="contentPagination" />
				</asp:GridView>
			</div>
			<asp:Panel ID="pnlAddWorkflow" CssClass="sectionBox" runat="server">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=_("AddNewWorkflow")%></span>
				</div>
				<div class="edNews_inputGroup inputWidth100 labelBlock">
					<label for="<%=tbWorkflowName.ClientID %>"><%=_("Name")%></label>
					<asp:TextBox ID="tbWorkflowName" CssClass="text" runat="server" MaxLength="100" ValidationGroup="vgAddWorkflow" />
					<asp:RequiredFieldValidator ID="rfvWorkflowName" runat="server" CssClass="smallInfo error" ControlToValidate="tbWorkflowName" ErrorMessage="This field is required." ValidationGroup="vgAddWorkflow" resourcekey="rfvWorkflowName.ErrorMessage" />
				</div>
				<div class="edNews_inputGroup inputWidth100 labelBlock">
					<label for="<%=tbWorkflowDescription.ClientID %>"><%=_("Description") %></label>
					<asp:TextBox ID="tbWorkflowDescription" runat="server" Height="50px" MaxLength="2000" TextMode="MultiLine" />
				</div>
				<asp:Label ID="lblWorkflowAdded" runat="server" Text="Workflow added" Visible="False" resourcekey="lblWorkflowAdded" EnableViewState="False" />
				<div class="mainActions">
					<asp:LinkButton ID="lbAddWorkflow" runat="server" ValidationGroup="vgAddWorkflow" CssClass="downSave" resourcekey="lbAddWorkflow" OnClick="lbAddWorkflow_Click">Add workflow</asp:LinkButton>
				</div>
			</asp:Panel>
		</asp:Panel>
		<asp:Panel runat="server" ID="pnlStatesList" Visible="false">
			<div class="sectionBox noPadding">
				<asp:GridView ID="gvStatesList" runat="server" AutoGenerateColumns="False" DataSourceID="odsStates" CssClass="strippedTable fullWidthTable noBorder tablePadding5" ShowFooter="True" DataKeyNames="StateId" OnRowCommand="gvStatesList_RowCommand">
					<Columns>
						<asp:TemplateField ShowHeader="False">
							<%--<EditItemTemplate>
								<div class="edNews_boxedActions">
									<asp:LinkButton ID="lbWorkflowStateUpdateEdit" runat="server" CommandName="Update" CssClass="edNews_aaSave edNews_tooltip" data-tooltip-content='<%#_("lbWorkflowStateUpdateEdit.ToolTip")%>' data-tooltip-position="top-left" />
									<asp:LinkButton ID="lbWorkflowStateCancelEdit" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="edNews_aaCancel edNews_tooltip color4" data-tooltip-content='<%#_("lbWorkflowStateCancelEdit.ToolTip")%>' data-tooltip-position="top-left" />
								</div>
							</EditItemTemplate>--%>
							<ItemTemplate>
								<div class="edNews_boxedActions">
									<asp:LinkButton ID="lbWorkflowEdit" runat="server" CausesValidation="False" CommandName="EditThisState" CommandArgument='<%#Eval("StateId")%>' CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("lbWorkflowEdit.ToolTip")%>' data-tooltip-position="top-left" Visible='<%#(EasyDNNSolutions.Modules.EasyDNNNews.Workflows.WorkflowStateType)Eval("WorkflowStateType")== EasyDNNSolutions.Modules.EasyDNNNews.Workflows.WorkflowStateType.UserDefind%>' />
									<asp:LinkButton ID="lbWorkflowDelete" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you certain you want to delete this workflow?');" CommandName="Delete" CssClass="edNews_aaCancel edNews_tooltip color4" data-tooltip-content='<%#_("lbWorkflowDelete.ToolTip")%>' data-tooltip-position="top-left" Visible='<%#(EasyDNNSolutions.Modules.EasyDNNNews.Workflows.WorkflowStateType)Eval("WorkflowStateType") == EasyDNNSolutions.Modules.EasyDNNNews.Workflows.WorkflowStateType.UserDefind && !Convert.ToBoolean(Eval("WorkflowInUse")) && !Convert.ToBoolean(Eval("WorkflowStateInUse")) %>' />
								</div>
							</ItemTemplate>
							<ItemStyle Width="100px" />
						</asp:TemplateField>
						<asp:TemplateField HeaderText="Workflow states">
							<%--<EditItemTemplate>
								<asp:TextBox ID="tbWorkflowName" runat="server" Text='<%# Bind("Title") %>' />
							</EditItemTemplate>--%>
							<ItemTemplate>
								<p class="labelName"><%# Eval("Title") %></p>
							</ItemTemplate>
						</asp:TemplateField>
					</Columns>
					<EditRowStyle CssClass="editItemState" />
					<HeaderStyle CssClass="tableHeader" />
					<PagerStyle CssClass="contentPagination" />
				</asp:GridView>
			</div>
			<asp:Panel ID="pnlAddWorkflowState" CssClass="sectionBox" runat="server">
				<div class="sectionBoxHeader">
					<asp:Label class="sectionBoxHeaderTitle" runat="server" ID="spnAddNewWorkflowState"></asp:Label>
				</div>
				<div class="edNews_inputGroup inputWidth100 labelBlock">
					<label for="<%=tbWorkflowStateName.ClientID %>"><%=_("Name")%></label>
					<asp:TextBox ID="tbWorkflowStateName" CssClass="text" runat="server" MaxLength="100" ValidationGroup="vgAddWorkflowState" />
					<asp:RequiredFieldValidator ID="rfvWorkflowStateName" runat="server" CssClass="smallInfo error" ControlToValidate="tbWorkflowStateName" ErrorMessage="This field is required." ValidationGroup="vgAddWorkflowState" resourcekey="rfvWorkflowStateName" />
				</div>
				<label for="<%=cbAllRolesApprove.ClientID %>" class="edNews_tooltip" data-tooltip-content="All roles" data-tooltip-position="top-right"><%=_("lblAllRolesApprove.Text") %></label>
				<div class="switchCheckbox">
					<asp:CheckBox ID="cbAllRolesApprove" runat="server" Text="All Roles" CssClass="normalCheckBox" AutoPostBack="True" Checked="True" OnCheckedChanged="cbAllRolesApprove_CheckedChanged" />
				</div>
				<asp:Panel ID="pnlRoleApproveSelection" runat="server" Visible="False">
					<asp:GridView ID="gvRolePremissions" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="strippedTable fullWidthTable textCenter edNews_permissionsTable edNews_addEditPermissions" EnableModelValidation="True" GridLines="None" OnRowDataBound="gvRolePremissions_RowDataBound">
						<Columns>
							<asp:TemplateField HeaderText="Role name">
								<ItemTemplate>
									<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' />:
								</ItemTemplate>
								<ItemStyle CssClass="subjectTd textLeft" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Approve articles">
								<ItemTemplate>
									<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
									<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableApproval" runat="server" Checked='<%# Eval("Selected") %>' />
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
						<EditRowStyle CssClass="editItemState" />
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
					<asp:GridView ID="gvUserPermissions" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="strippedTable fullWidthTable textCenter edNews_permissionsTable edNews_addEditPermissions" EnableModelValidation="True" GridLines="None" OnRowDataBound="gvRolePremissions_RowDataBound" OnRowCommand="gvUserPermissions_RowCommand">
						<Columns>
							<asp:TemplateField HeaderText="User">
								<ItemTemplate>
									<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
									<asp:HiddenField ID="hfUserName" runat="server" Value='<%# Eval("UserName") %>' />
									<asp:HiddenField ID="hfDisplayName" runat="server" Value='<%# Eval("DisplayName") %>' />
									<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("DisplayName") %>' />
									<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>' />
								</ItemTemplate>
								<ItemStyle CssClass="subjectTd textLeft" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Approve articles">
								<ItemTemplate>
									<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableApproval" Checked="true" runat="server" Enabled="False" />
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField>
								<ItemTemplate>
									<div class="itemActions">
										<asp:LinkButton ID="lbUserPremissionRemove" CssClass="deleteAction color4" runat="server" CausesValidation="false" CommandArgument='<%# Eval("UserID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user permissions?');" Text="Remove"></asp:LinkButton>
									</div>
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
						<EditRowStyle CssClass="editItemState" />
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
					<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="false" ForeColor="Red" />
					<div class="edNews_inputGroup">
						<asp:Label ID="lblUsernameToAdd" runat="server" Text="Add user by username:" />
						<asp:TextBox ID="tbUserNameToAdd" runat="server" />
						<div class="mainActions smallActions noMargin displayInline">
							<asp:LinkButton ID="lbUsernameAdd" runat="server" CssClass="add" Text="Add" OnClick="lbUsernameAdd_Click" />
						</div>
					</div>
				</asp:Panel>
				<asp:Label ID="lblWorkflowStateAdded" runat="server" Text="Workflow state added" Visible="False" EnableViewState="False" />
				<div class="mainActions">
					<asp:LinkButton ID="lbAddWorkflowState" runat="server" ValidationGroup="vgAddWorkflowState" CssClass="downSave" OnClick="lbAddWorkflowState_Click">Add workflow state</asp:LinkButton>
					<asp:LinkButton ID="btnClose" runat="server" CssClass="cancel" Text="Close" resourcekey="btnClose" OnClick="btnClose_Click" />
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlCloseStatesEditor" CssClass="sectionBox" runat="server">
				<div class="mainActions">
					<asp:Label ID="lblDefaultWorkflowState" resourcekey="lblDefaultWorkflowState" runat="server" Text="Workflow state added" Visible="False" EnableViewState="False" />
					<asp:LinkButton ID="lbCloseStatesEditor" runat="server" CssClass="cancel" Text="Close" resourcekey="btnClose" OnClick="btnClose_Click" />
				</div>
			</asp:Panel>
		</asp:Panel>
		<asp:HiddenField ID="hfEditSateId" runat="server" Value="" />
	</div>
</div>

<asp:ObjectDataSource ID="odsWorkFlows" runat="server" SelectMethod="GetAllWorkflows" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.WorkFlows.WorkflowsController" DeleteMethod="DeleteWorkflow" UpdateMethod="UpdateWorkflow">
	<DeleteParameters>
		<asp:Parameter Name="Id" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
	<UpdateParameters>
		<asp:Parameter Name="id" Type="Int32" />
		<asp:Parameter Name="name" Type="String" />
		<asp:Parameter Name="description" Type="String" />
	</UpdateParameters>
</asp:ObjectDataSource>

<asp:ObjectDataSource ID="odsStates" runat="server" SelectMethod="GetAllWorkflowStates" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.Workflows.WorkflowsController" DeleteMethod="DeleteWorkflowState" UpdateMethod="UpdateWorkflowState">
	<DeleteParameters>
		<asp:Parameter Name="StateId" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:ControlParameter ControlID="hfSelectedWorkflow" Name="WorkflowId" PropertyName="Value" Type="Int32" />
	</SelectParameters>
	<UpdateParameters>
		<asp:Parameter Name="StateId" Type="Int32" />
		<asp:Parameter Name="Title" Type="String" />
	</UpdateParameters>
</asp:ObjectDataSource>

