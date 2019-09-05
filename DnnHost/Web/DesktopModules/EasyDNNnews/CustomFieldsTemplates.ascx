<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.Administration.CustomFieldsTemplates, App_Web_customfieldstemplates.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span><%=titleOfControle%></span>
		</div>
		<asp:Literal ID="liAdminNavigation" runat="server"></asp:Literal>
		<asp:Panel ID="pnlAllSettings" runat="server">
			<asp:Panel ID="pnlTemplateCreate" runat="server" Visible="true" CssClass="sectionBox sectionBox2">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=titleCreateCFGroup%></span>
				</div>
				<table class="optionsList fullWidthTable tablePadding5">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxcfTemplateName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblcfTemplateName.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblcfTemplateName.Text") %></label>
						</td>
						<td>
							<div class="edNews_inputGroup inputWidth40">
								<asp:TextBox ID="tbxcfTemplateName" runat="server" CausesValidation="True" ValidationGroup="vgSaveFieldTemplate" />
							</div>
							<asp:RequiredFieldValidator ID="rfvcfTemplateName" runat="server" CssClass="smallInfo error" ErrorMessage="Required Field." ControlToValidate="tbxcfTemplateName" Display="Dynamic" SetFocusOnError="true" ValidationGroup="vgSaveFieldTemplate" resourcekey="rfvcfTemplateName.ErrorMessage" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxcfTemplateDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblcfTemplateDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblcfTemplateDescription.Text") %></label>
						</td>
						<td>
							<div class="edNews_inputGroup inputWidth40">
								<asp:TextBox ID="tbxcfTemplateDescription" runat="server" />
							</div>
						</td>
					</tr>
					<%--<tr>
						<td class="tdLabel">
							<dnn:Label ID="lblcfTemplateCssUrl" runat="server" Text="Css URL:" ControlName="tbxcfTemplateCssUrl" HelpText="Css file for template" />
						</td>
						<td>
							<asp:FileUpload ID="fuCss" runat="server" />
							<asp:TextBox ID="tbxcfTemplateCssUrl" runat="server" Visible="false"></asp:TextBox>
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<dnn:Label ID="lblcfTemplateHTML" runat="server" Text="Template HTML URL:" ControlName="tbxcfTemplateHTML" HelpText="HTML file for template" />
						</td>
						<td>
							<asp:FileUpload ID="fuHTML" runat="server" />
							<asp:TextBox ID="tbxcfTemplateHTML" runat="server" CausesValidation="True" ValidationGroup="vgSaveFieldTemplate" Visible="false"></asp:TextBox>
							<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required Field." ControlToValidate="tbxcfTemplateHTML" Display="Dynamic" SetFocusOnError="True"
								ValidationGroup="vgSaveFieldTemplate"></asp:RequiredFieldValidator>
						</td>
					</tr>--%>
				</table>
				<asp:Label ID="lblSaveInfo" runat="server" EnableViewState="False" />
				<div class="mainActions smallActions">
					<asp:Button ID="btnSaveField" runat="server" CssClass="add" Text="Create Group" ValidationGroup="vgSaveFieldTemplate" OnClick="btnSaveField_Click" resourcekey="btnSaveField" />
					<asp:Button ID="btnUpdateField" runat="server" CssClass="downSave" Text="Update Group" ValidationGroup="vgSaveFieldTemplate" Visible="false" OnClick="btnUpdateField_Click" resourcekey="btnUpdateField" />
					<asp:Button ID="btnCancel" runat="server" CssClass="cancel" Text="Close" Visible="false" OnClick="btnCancel_Click" resourcekey="btnCancel" />
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlImportExport" runat="server" Visible="false">
				<div class="sectionBox sectionBox2">
					<div class="sectionBoxHeader">
						<span class="sectionBoxHeaderTitle"><%=titleCFImport %></span>
					</div>
					<table class="optionsList fullWidthTable">
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlImportCustomFieldsGroup.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectImportFile.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectImportFile.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlImportCustomFieldsGroup" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions noMargin displayInline">
									<asp:LinkButton ID="btnImportfromXML" runat="server" CssClass="import" OnClick="btnImportfromXML_Click" Text="Import" resourcekey="btnImportfromXML" />
									<asp:LinkButton ID="btnExportDownload" runat="server" CssClass="download" Text="Download" OnClick="btnExportDownload_Click" resourcekey="btnExportDownload" />
									<asp:LinkButton ID="btnDeleteCFXMLFile" runat="server" CssClass="delete" Text="Delete" OnClick="btnDeleteCFXMLFile_Click" resourcekey="btnDeleteCFXMLFile" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=fuCFXMLfile.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImportFileUpload.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImportFileUpload.Text") %></label>
							</td>
							<td>
								<asp:FileUpload ID="fuCFXMLfile" runat="server" />
								<div class="mainActions smallActions noMargin displayInline">
									<asp:LinkButton ID="btnUploadCFXMLData" runat="server" CssClass="upload" Text="Upload" OnClick="btnUploadCFXMLData_Click" resourcekey="btnUploadCFXMLData" />
								</div>
							</td>
						</tr>
					</table>
				</div>
				<div class="sectionBox sectionBox2 noPadding">
					<div class="sectionBoxHeader">
						<span class="sectionBoxHeaderTitle"><%=titleCFExport %></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlExportCF.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectCFGroup.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectCFGroup.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlExportCF" runat="server"></asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxExportFileName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExportFileName.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExportFileName.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxExportFileName" runat="server" />
								<asp:RequiredFieldValidator ID="rfExportFileName" CssClass="smallInfo error" ValidationGroup="vgExportCF" ControlToValidate="tbxExportFileName" runat="server" ErrorMessage="File name required." Display="Dynamic" resourcekey="rfExportFileName.ErrorMessage" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxExportGroupName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExportGroupName.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExportGroupName.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxExportGroupName" runat="server" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxExportPrefix.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExportPrefix.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExportPrefix.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxExportPrefix" runat="server" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel"></td>
							<td>
								<div class="mainActions smallActions textLeft">
									<asp:LinkButton ID="btnExportToXML" runat="server" CssClass="export" OnClick="btnExportToXML_Click" Text="Export" ValidationGroup="vgExportCF" CausesValidation="true" resourcekey="btnExportToXML" />
								</div>
							</td>
						</tr>
					</table>
				</div>
				<asp:Label ID="lblLinkToExportedFile" runat="server" EnableViewState="false" />
			</asp:Panel>
			<asp:Panel ID="pnlMainSelect" runat="server" Visible="true" CssClass="sectionBox sectionBox2">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=titleCFGgroups%></span>
				</div>
				<asp:Panel ID="pnlAlLTemplates" runat="server">
					<asp:ObjectDataSource ID="odscfTemplates" runat="server" SelectMethod="GetCustomFieldsTemplates" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB">
						<SelectParameters>
							<asp:Parameter Name="PortalID" Type="Int32" />
						</SelectParameters>
					</asp:ObjectDataSource>
					<asp:GridView ID="gvcfTemplates" runat="server" AllowPaging="True" CssClass="strippedTable fullWidthTable tablePadding5" AutoGenerateColumns="False" DataSourceID="odscfTemplates" OnRowCommand="gvcfTemplates_RowCommand" DataKeyNames="FieldsTemplateID" HorizontalAlign="Center"
						PageSize="20" EnableModelValidation="True">
						<Columns>
							<asp:TemplateField ShowHeader="False">
								<ItemTemplate>
									<div class="itemActions smallActions">
										<asp:LinkButton ID="lbEditTemplate" runat="server" CssClass="editAction" CausesValidation="False" CommandName="Select" CommandArgument='<%#Eval("FieldsTemplateID") %>' Text="Edit" resourcekey="lbEditTemplate" />
										<asp:LinkButton ID="lbRemoveTemplate" runat="server" CssClass="deleteAction" CausesValidation="False" CommandArgument='<%#Eval("FieldsTemplateID") %>' CommandName="Remove" Text="Delete" OnClientClick="return confirm('Are you sure you want to delete this item?');" resourcekey="lbRemoveTemplate" />
									</div>
								</ItemTemplate>
								<HeaderStyle Width="200px" />
							</asp:TemplateField>
							<asp:BoundField DataField="FieldsTemplateID" HeaderText="gvcfTemplatesId">
								<HeaderStyle Width="60px" />
								<ItemStyle CssClass="textCenter" />
							</asp:BoundField>
							<asp:BoundField DataField="Name" HeaderText="gvcfTemplatesName" />
							<asp:BoundField DataField="Description" HeaderText="gvcfTemplatesDescription" />
							<asp:BoundField DataField="CssURL" HeaderText="CssURL" Visible="False" />
							<asp:BoundField DataField="HTMLURL" HeaderText="HTMLURL" Visible="False" />
						</Columns>
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
					<asp:Label ID="lblAlLTemplates" runat="server" EnableViewState="False" />
				</asp:Panel>
				<%--<table class="settings_table customfileds" cellpadding="0" cellspacing="0">
					<tr>
						<td class="tdLabel">
							<dnn:Label ID="lblImport" runat="server" Text="Import:"/>
						</td>
						<td></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<dnn:Label ID="lblExport" runat="server" Text="Export:"/>
						</td>
						<td></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<dnn:Label ID="lblEdit" runat="server" Text="Edit:" />
						</td>
						<td></td>
					</tr>
				</table>--%>
			</asp:Panel>
			<asp:Panel ID="pnlAddCustomFieldToTemplate" runat="server" Visible="false" CssClass="sectionBox sectionBox2">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=titleCFGroupAdministration%></span>
				</div>
				<asp:Label ID="lblAddInfo" runat="server" EnableViewState="False" />
				<asp:Panel ID="pnlFieldsList" class="sectionBox noPadding" runat="server">
					<div class="sectionBoxSubtitle">
						<asp:Label ID="lblCustomFieldsList" runat="server" EnableViewState="False" Text="Available custom fields for adding to a group." ResourceKey="lblCustomFieldsList" />
					</div>
					<asp:Label ID="lblCustomFieldsListInfo" runat="server" EnableViewState="False" Visible="false" />
					<asp:ObjectDataSource ID="odsListOfCustomFields" runat="server" DeleteMethod="DeleteCustomField" SelectMethod="GetCustomFieldsForTemplate" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB">
						<DeleteParameters>
							<asp:Parameter Name="CustomFieldID" Type="Int32" />
						</DeleteParameters>
						<SelectParameters>
							<asp:Parameter Name="FieldsTemplateID" Type="Int32" />
							<asp:Parameter Name="PortalID" Type="Int32" />
						</SelectParameters>
					</asp:ObjectDataSource>
					<div class="negativeMargins">
						<asp:GridView ID="gvListOfCustomFields" CssClass="strippedTable fullWidthTable tablePadding5 textCenter" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="odsListOfCustomFields" DataKeyNames="CustomFieldID" HorizontalAlign="Center" AutoGenerateColumns="False" OnRowCommand="gvListOfCustomFields_RowCommand" PageSize="30" EnableModelValidation="True">
							<Columns>
								<asp:TemplateField ShowHeader="False">
									<ItemTemplate>
										<div class="itemActions smallActions">
											<asp:LinkButton ID="lbAddToGroup" CssClass="addAction" runat="server" CausesValidation="False" CommandName="Select" CommandArgument='<%#Eval("CustomFieldID") %>' Text="Add to group" resourcekey="lbAddToGroup" />
											<asp:HyperLink ID="hyEditCustomField" CssClass="editAction" Target="_blank" runat="server" href='<%#GetEditCustomFieldUrl(Convert.ToInt32(Eval("CustomFieldID"))) %>' Text="Edit" resourcekey="hlEdit" />
										</div>
									</ItemTemplate>
									<HeaderStyle Width="200px" />
								</asp:TemplateField>
								<asp:BoundField DataField="CustomFieldID" HeaderText="gvListOfCustomFieldsId">
									<HeaderStyle Width="60px" />
								</asp:BoundField>
								<asp:BoundField DataField="Name" HeaderText="gvListOfCustomFieldsName" />
								<asp:BoundField DataField="Token" DataFormatString="[EDNcf:{0}]" HeaderText="gvListOfCustomFieldsToken" />
							</Columns>
							<HeaderStyle CssClass="tableHeader" />
							<PagerStyle CssClass="contentPagination" />
						</asp:GridView>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlTemplateFieldsList" class="sectionBox noPadding" runat="server">
					<div class="sectionBoxSubtitle">
						<asp:Label ID="lblTemplateFieldsList" runat="server" EnableViewState="False" Text="Present custom fields in this group." ResourceKey="lblTemplateFieldsList" />
					</div>
					<asp:ObjectDataSource ID="odsTemplateCustomFields" runat="server" SelectMethod="GetCustomFieldsOfTemplate" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.CustomFields.CustomFieldsDB">
						<SelectParameters>
							<asp:Parameter Name="FieldsTemplateID" Type="Int32" />
						</SelectParameters>
					</asp:ObjectDataSource>
					<div class="negativeMargins">
						<asp:GridView ID="gvTemplateCustomFields" runat="server" CssClass="strippedTable fullWidthTable tablePadding5 textCenter" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataSourceID="odsTemplateCustomFields" EnableModelValidation="True" DataKeyNames="CustomFieldID"
							HorizontalAlign="Center" OnRowCommand="gvTemplateCustomFields_RowCommand" OnDataBound="gvTemplateCustomFields_DataBound" PageSize="30">
							<Columns>
								<asp:TemplateField>
									<ItemTemplate>
										<div class="itemActions smallActions">
											<asp:LinkButton ID="lbRemoveFromGroup" runat="server" CssClass="deleteAction" CausesValidation="False" CommandArgument='<%#Eval("CustomFieldID") %>' CommandName="Remove" Text="Remove from group" OnClientClick="return confirm('Are you sure you want to remove this item?');" resourcekey="lbRemoveFromGroup" />
											<asp:HyperLink ID="hyEditCustomField" Target="_blank" CssClass="editAction" runat="server" href='<%#GetEditCustomFieldUrl(Convert.ToInt32(Eval("CustomFieldID"))) %>' Text="Edit" resourcekey="hlEdit" />
										</div>
									</ItemTemplate>
									<HeaderStyle Width="250px" />
								</asp:TemplateField>
								<asp:BoundField DataField="CustomFieldID" HeaderText="gvTemplateCustomFieldsCfId">
									<HeaderStyle Width="70px" />
								</asp:BoundField>
								<asp:BoundField DataField="ControlTypeID" HeaderText="gvTemplateCustomFieldsCfTId">
									<HeaderStyle Width="70px" />
								</asp:BoundField>
								<asp:BoundField DataField="Name" HeaderText="gvTemplateCustomFieldsName" />
								<asp:BoundField DataField="Token" DataFormatString="[EDNcf:{0}]" HeaderText="gvTemplateCustomFieldsToken" />
								<asp:TemplateField HeaderText="gvTemplateCustomFieldsIsSearchable">
									<ItemTemplate>
										<asp:Label runat="server" CssClass="edNews_icon edNews_yesIcon" ResourceKey="Yes" Visible='<%#Convert.ToBoolean(Eval("IsSearchable"))%>' />
										<asp:label runat="server" CssClass="edNews_icon edNews_noIcon" ResourceKey="No" Visible='<%#!Convert.ToBoolean(Eval("IsSearchable"))%>' />
									</ItemTemplate>
									<ItemStyle Width="50px" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="gvTemplateCustomFieldsPosition">
									<ItemTemplate>
										<div class="edNews_boxedActions">
											<asp:LinkButton ID="imgBtnUPElement" CssClass="edNews_aaUp" runat="server" CausesValidation="false" CommandArgument='<%#Eval("CustomFieldID") %>' CommandName="imgBtnUPElement" />
											<asp:LinkButton ID="imgBtnDownElement" CssClass="edNews_aaDown" runat="server" CausesValidation="false" CommandArgument='<%#Eval("CustomFieldID") %>' CommandName="imgBtnDownElement" />
										</div>
									</ItemTemplate>
									<HeaderStyle Width="80px" />
								</asp:TemplateField>
							</Columns>
							<HeaderStyle CssClass="tableHeader" />
							<PagerStyle CssClass="contentPagination" />
						</asp:GridView>
					</div>
				</asp:Panel>
			</asp:Panel>
			<asp:Label ID="lblMainInfoMsg" runat="server" EnableViewState="false" />
		</asp:Panel>
	</div>
</div>
