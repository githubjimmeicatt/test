<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Templates.TemplatesEditor, App_Web_templateseditor.ascx.b9f6810f" %>
<script type="text/javascript">
	//<![CDATA[
	<%=includeCodeMirror%>

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			(function ($) {
				<%=includepartialCodeMirror%>
			})(jQuery);
		}
	}
	//]]>
</script>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=_("TemplateEditor.Text")%></span>
		</div>
		<asp:UpdatePanel ID="upTemplateEditor" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
			<Triggers>
				<asp:PostBackTrigger ControlID="btnUploadTemplate" />
				<asp:PostBackTrigger ControlID="btnDownloadTemplate" />
			</Triggers>
			<ContentTemplate>
				<div class="edNews_adminProgressOverlayWrapper">
					<asp:UpdateProgress ID="uupTemplateEditor" runat="server" AssociatedUpdatePanelID="upTemplateEditor" DisplayAfter="100" DynamicLayout="true">
						<ProgressTemplate>
							<div class="edNews_adminProgressOverlay"></div>
						</ProgressTemplate>
					</asp:UpdateProgress>
					<asp:Literal ID="liTemplateEditorMainFunctions" runat="server" />
					<div class="sectionBox noPadding edNews_popUpContainer">
						<asp:Panel runat="server" ID="pnlTemplateSelection">
							<table class="optionsList fullWidthTable strippedTable noBorder">
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblSelectTheme" runat="server" ControlName="ddlTheme" Text="Theme:" ResourceKey="lblSelectTheme" />
									</td>
									<td>
										<asp:DropDownList ID="ddlTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DdlTheme_SelectedIndexChanged" />
										<div class="mainActions smallActions noMargin displayInline">
											<asp:Button ID="btnCopyTheme" runat="server" CssClass="primaryAction" OnClick="MainThemeButtonsClick" CommandName="copy" Text="Copy" ResourceKey="btnCopyTheme" CausesValidation="false" OnClientClick="return codeMirrorCustom.PreSaveEditor();" /></asp:button>
										</div>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblTemplateSection" runat="server" ControlName="ddlTemplateSection" Text="Section:" ResourceKey="lblTemplateSection" />
									</td>
									<td>
										<asp:DropDownList ID="ddlTemplateSection" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DdlTemplateSection_SelectedIndexChanged">
											<asp:ListItem ResourceKey="liSelect" Value="" Text="Select" Selected="True" />
											<asp:ListItem ResourceKey="liList" Value="List" Text="List templates" />
											<asp:ListItem ResourceKey="liDetails" Value="Details" Text="Details templates" />
											<asp:ListItem ResourceKey="liComments" Value="Comments" Text="Comments" />
											<asp:ListItem ResourceKey="liDocuments" Value="Documents" Text="Documents" />
											<asp:ListItem ResourceKey="liGravityGallery" Value="GravityGallery" Text="Gravity gallery" />
											<asp:ListItem ResourceKey="liLinks" Value="Links" Text="Links" />
											<asp:ListItem ResourceKey="liRelatedArticles" Value="RelatedArticles" Text="Related articles" />
											<asp:ListItem ResourceKey="liCalendar" Value="Calendar" Text="Calendar" />
											<asp:ListItem ResourceKey="liCategoryMenu" Value="CategoryMenu" Text="Category menu" />
											<asp:ListItem ResourceKey="liSearch" Value="Search" Text="Search" />
											<asp:ListItem ResourceKey="liTagCloud" Value="TagCloud" Text="Tag cloud" />
											<asp:ListItem ResourceKey="liMainCss" Value="MainCss" Text="Main CSS" />
											<asp:ListItem ResourceKey="liCssStyles" Value="CssStyles" Text="Styles" />
											<asp:ListItem ResourceKey="liContentBlocks" Value="ContentBlocks" Text="Content blocks" />
											<asp:ListItem ResourceKey="liCalendarTooltip" Value="CalendarTooltip" Text="Calendar tooltip" />
											<asp:ListItem ResourceKey="liUpcomingEventsTooltip" Value="UpcomingEventsTooltip" Text="Upcoming events tooltip" />
											<asp:ListItem ResourceKey="liAMPTemplates" Value="AMPTemplates" Text="AMP templates" />
										</asp:DropDownList>
										<div ID="pnlUploadTemplate" runat="server" Visible="false" class="edNews_inputGroup displayInline">
											<asp:FileUpload ID="fuTemplate" runat="server" CssClass="edNews_fileUpload"/>
										</div>
										<div class="mainActions smallActions noMargin displayInline">
											<asp:Button ID="btnUploadTemplate" runat="server" CssClass="upload" Text="Upload" ResourceKey="btnUploadTemplate" CommandName="showPanel" OnClick="BtnUploadTemplate_Click" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
											<asp:Button ID="btnCloseUploadTemplate" CssClass="cancel" runat="server" Text="Cancel" ResourceKey="btnCloseUploadTemplate" CommandName="close" OnClick="BtnUploadTemplate_Click" Visible="false" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
										</div>
										<asp:Label ID="lblTemplateUploadInfo" runat="server" EnableViewState="false" Visible="false" />
									</td>
								</tr>
								<tr runat="server" id="editSelectTemplate">
									<td class="tdLabel">
										<asp:Label ID="lblSelectTemplate" runat="server" ControlName="ddlTemplate" Text="Template:" ResourceKey="lblSelectTemplate" />
									</td>
									<td>
										<asp:DropDownList ID="ddlTemplate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DdlTemplate_SelectedIndexChanged" />
										<div class="mainActions smallActions noMargin displayInline">
											<asp:Button ID="btnDownloadTemplate" CssClass="download" runat="server" Text="Download" ResourceKey="btnDownloadTemplate" OnClick="BtnDownloadTemplate_Click" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
										</div>
										<asp:Label ID="lblTemplateDownloadInfo" runat="server" EnableViewState="false" Visible="false" />
									</td>
								</tr>
							</table>
							<asp:Label ID="lblTemplateInfo" runat="server" EnableViewState="false" Visible="false" />
						</asp:Panel>
						<fieldset runat="server" id="pnlCopyTemplate" visible="false">
							<legend><%=_("CopyFrom.Text")%></legend>
							<table class="optionsList fullWidthTable">
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblCopyTheme" runat="server" ControlName="ddlCopyTheme" Text="Theme:" ResourceKey="lblCopyTheme" />
									</td>
									<td>
										<asp:DropDownList ID="ddlCopyTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="DdlCopyTheme_SelectedIndexChanged" />
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblCopyTemplateSection" runat="server" ControlName="ddlCopyTemplateSection" Text="Section:" ResourceKey="lblCopyTemplateSection" />
									</td>
									<td>
										<asp:DropDownList ID="ddlCopyTemplateSection" runat="server" AutoPostBack="true">
											<asp:ListItem ResourceKey="liSelect" Value="" Text="Select" Selected="True" />
											<asp:ListItem ResourceKey="liList" Value="List" Text="List templates" />
											<asp:ListItem ResourceKey="liDetails" Value="Details" Text="Details templates" />
											<asp:ListItem ResourceKey="liComments" Value="Comments" Text="Comments" />
											<asp:ListItem ResourceKey="liDocuments" Value="Documents" Text="Documents" />
											<asp:ListItem ResourceKey="liGravityGallery" Value="GravityGallery" Text="Gravity gallery" />
											<asp:ListItem ResourceKey="liLinks" Value="Links" Text="Links" />
											<asp:ListItem ResourceKey="liRelatedArticles" Value="RelatedArticles" Text="Related articles" />
											<asp:ListItem ResourceKey="liCalendar" Value="Calendar" Text="Calendar" />
											<asp:ListItem ResourceKey="liCategoryMenu" Value="CategoryMenu" Text="Category menu" />
											<asp:ListItem ResourceKey="liSearch" Value="Search" Text="Search" />
											<asp:ListItem ResourceKey="liTagCloud" Value="TagCloud" Text="Tag cloud" />
											<asp:ListItem ResourceKey="liMainCss" Value="MainCss" Text="Main CSS" />
											<asp:ListItem ResourceKey="liCssStyles" Value="CssStyles" Text="Styles" />
										</asp:DropDownList>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblCopyTemplate" runat="server" ControlName="ddlCopyTemplate" Text="Template:" ResourceKey="lblCopyTemplate" />
									</td>
									<td>
										<asp:DropDownList ID="ddlCopyTemplate" runat="server" />
										<div class="mainActions smallActions noMargin displayInline">
											<asp:Button ID="btnCopy" CssClass="primaryAction" runat="server" Text="Copy" CausesValidation="false" ResourceKey="btnCopy" />
										</div>
									</td>
								</tr>
							</table>
						</fieldset>
						<div runat="server" id="pnlFirstBackup" visible="false">
							<asp:Label ID="lblFirstBackup" runat="server" Text="Before editing create backup for all temes" ResourceKey="lblFirstBackup" CssClass="infoMessages info" />
							<div class="mainActions">
								<asp:Button ID="btnBackupNow" runat="server" CssClass="primaryAction" OnClick="MainBackupButtonsClick" CommandName="BackupNow" Text="Backup now" CausesValidation="false" ResourceKey="btnBackupNow" />
							</div>
						</div>
						<div runat="server" id="pnlCreateBackup" visible="false">
							<div class="edNews_inputGroup textCenter topMargin">
								<asp:RadioButtonList ID="rblBackupType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RblBackupType_SelectedIndexChanged" RepeatLayout="UnorderedList" CssClass="styledRadio inlineList">
									<asp:ListItem ResourceKey="liAllThemes" class="normalRadioButton" Value="AllThemes" Text="All themes" Selected="True" />
									<asp:ListItem ResourceKey="liOnlyHostThemes" class="normalRadioButton" Value="OnlyHostThemes" Text="Host themes" />
									<asp:ListItem ResourceKey="liOnlyPortalThemes" class="normalRadioButton" Value="OnlyPortalThemes" Text="Portal themes" />
									<asp:ListItem ResourceKey="liOnlySelectedTheme" class="normalRadioButton" Value="OnlySelectedTheme" Text="Select theme" />
								</asp:RadioButtonList>
							</div>
							<div class="edNews_inputGroup textCenter">
								<asp:DropDownList ID="ddlThemeForBackup" runat="server" Visible="false" />
							</div>
							<div class="mainActions">
								<asp:Button ID="btnCreateBackupBySelection" CssClass="primaryAction" runat="server" OnClick="MainBackupButtonsClick" CommandName="BySelection" Text="Backup now" CausesValidation="false" ResourceKey="btnCreateBackupBySelection" />
							</div>
							<asp:label ID="liLastBackup" runat="server" />
						</div>
						<fieldset runat="server" id="pnlBackupDelete" visible="false">
							<legend><%=_("DeleteBackup.Text")%></legend>
							<table class="optionsList fullWidthTable">
								<tr>
									<td class="tdLabel">
										<asp:DropDownList ID="ddlBackupFolders" runat="server" />
									</td>
									<td>
										<div class="mainActions smallActions displayInline noMargin">
											<asp:Button ID="btnDeleteBackup" runat="server" CssClass="delete" OnClick="MainBackupButtonsClick" CommandName="Delete" Text="Delete" CausesValidation="false" ResourceKey="btnDeleteBackup" OnClientClick="return confirm('Are you sure you want to delete selected item?');" />
										</div>
									</td>
								</tr>
							</table>
						</fieldset>
						<div class="edNews_inputGroup inputBorder withMargin">
							<asp:TextBox runat="server" ID="taEditor" Height="500" Width="700" TextMode="MultiLine" />
						</div>
						<div class="mainActions smallActions textRight">
							<asp:HyperLink ID="hlTokenList" runat="server" NavigateUrl="http://eds-url.com/news_token_list" Target="_blank" Text="Token list" ResourceKey="hlTokenList" CssClass="primaryAction" Visible="false" />
						</div>
						<asp:Label ID="lblMainSelectionInfo" runat="server" EnableViewState="false" />
						<asp:Literal ID="liEditingTemplate" runat="server" />
						<div class="mainActions" runat="server" id="pnlEditorActions">
							<asp:Button ID="btnUpdate" runat="server" CssClass="downSave" OnClick="MainButtonsClick" Text="Save" ResourceKey="btnUpdate" CommandName="update" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
							<asp:Button ID="btnSaveAsPopUp" CssClass="downSave" runat="server" OnClick="BtnSaveAsPopUp_Click" Text="Save as" ResourceKey="btnSaveAsPopUp" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
							<asp:Button ID="btnLoadFromBackup" CssClass="upload" runat="server" OnClick="BtnLoadBackupPanel_Click" Text="Load from backup" ResourceKey="btnLoadFromBackup" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
							<asp:Button ID="btnDelete" CssClass="delete" runat="server" OnClick="MainButtonsClick" Text="Delete" ResourceKey="btnDelete" CommandName="delete" />
						</div>
						<div class="mainActions" runat="server" visible="false">
							<asp:HyperLink ID="btnExit" CssClass="cancel" runat="server" Text="Exit" />
						</div>

						<div runat="server" id="pnlSaveAs" visible="false" class="edNews_popUp edNews_modalWindow edNews_bottomPosition">
							<div class="edNews_modalHeader"><%=_("SaveAsHeading.Text")%></div>
							<div class="edNews_inputGroup">
								<asp:Literal ID="liSaveAsPath" runat="server" />
								<asp:TextBox ID="tbxFileName" runat="server" />
							</div>
							<asp:RequiredFieldValidator ID="rfvFileName" runat="server" ControlToValidate="tbxFileName" Display="Dynamic" resourcekey="rfvFileName" ErrorMessage="File name required!" ValidationGroup="vgSaveAs" />
							<div class="mainActions smallActions">
								<asp:Button ID="btnSave" runat="server" CssClass="downSave" OnClick="MainButtonsClick" Text="Save" ResourceKey="btnSave" CommandName="create" ValidationGroup="vgSaveAs" OnClientClick="return codeMirrorCustom.PreSaveEditor();" />
								<asp:Button ID="btnSaveCancel" runat="server" CssClass="cancel" Text="Cancel" OnClick="LoadBackupButtons" CommandName="cancel" ResourceKey="btnSaveCancel" />
							</div>
						</div>

						<div runat="server" id="pnlLoadFromBackup" visible="false" class="edNews_popUp edNews_modalWindow edNews_bottomPosition">
							<div class="edNews_modalHeader"><%=_("LoadFromBackup.Text")%></div>
							<span class="edNews_titleH3"><%=_("SelectBackupFileHeading.Text")%></span>
							<asp:DropDownList ID="ddlLoadFromBackup" runat="server"></asp:DropDownList>
							<div class="mainActions smallActions">
								<asp:Button ID="btnLoadBackup" runat="server" CssClass="upload" Text="Load" OnClick="LoadBackupButtons" CommandName="load" ResourceKey="btnLoadBackup" />
								<asp:Button ID="btnCancelLoadBackup" CssClass="cancel" runat="server" Text="Cancel" OnClick="LoadBackupButtons" CommandName="cancel" ResourceKey="btnCancelLoadBackup" />
							</div>
						</div>
					</div>
				</div>
			</ContentTemplate>
		</asp:UpdatePanel>
	</div>
</div>
