<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Controls.ExcelDataImport, App_Web_dataexportimport.ascx.b9f6810f" %>
<script type="text/javascript">
	/* <![CDATA[ */

	eds3_5_jq(function ($) {
		InitComponents($);
	});

	jQuery(function ($) {
		$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});
	});

	function CategoryClientValidate(source, arguments) {
		if ($('#<%=cbExportAllCategories.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}

		if ($('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function InitComponents($) {

		$('#<%=cbExportAllCategories.ClientID %>').on('change', function () {

			if (this.checked)
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), false);
			else
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), true);

			$('#<%=tblSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
		});

		var $cbExportAllCategories = $('#<%=cbExportAllCategories.ClientID %>');
		if ($cbExportAllCategories.length > 0)
			$('#<%=tblSelectCategories.ClientID%>').css('display', ($cbExportAllCategories[0].checked ? 'none' : ''));

		$('#<%=cbLimitPublishDate.ClientID %>').on('change', function () {
			$('#divLimitPublishDate').css('display', (this.checked ? '' : 'none'));
		});

		var $cbLimitPublishDate = $('#<%=cbLimitPublishDate.ClientID %>');
		if ($cbLimitPublishDate.length > 0)
			$('#divLimitPublishDate').css('display', ($cbLimitPublishDate.checked ? '' : 'none'));


		$('#<%=datePickerSearchFromDate.ClientID%>').datetimepicker({
			sideBySide: false,
			showTodayButton: false,
			showClear: false,
			allowInputToggle: true,
			locale: '<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>',
			format: '<%=System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern.ToUpper()%>'
		});

		$('#<%=datePickerSearchToDate.ClientID%>').datetimepicker({
			sideBySide: false,
			showTodayButton: false,
			showClear: false,
			allowInputToggle: true,
			locale: '<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>',
			format: '<%=System.Threading.Thread.CurrentThread.CurrentCulture.DateTimeFormat.ShortDatePattern.ToUpper()%>'
		});

		$('#<%=datePickerSearchFromDate.ClientID%>').on("dp.change", function (e) {
			if (e.date != null) {
				$('#<%=datePickerSearchToDate.ClientID%>').data("DateTimePicker").minDate(e.date);
			}

		});

		$('#<%=datePickerSearchToDate.ClientID%>').on("dp.change", function (e) {
			if (e.date != null) {
				$('#<%=datePickerSearchFromDate.ClientID%>').data("DateTimePicker").maxDate(e.date);
			}
		});
	}

	var importClicked = false;

	function ImportButtonToggle() {
		if (importClicked)
			return false;

		$('#<%=tblImportFromExistingFile.ClientID%>').css("display", "none");

		importClicked = true;
	}

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			importClicked = false;
			eds3_5_jq(function ($) {
				InitComponents($);
			});

			var $category_menue_items = $('.edn_advanced_tree_view li');

			$category_menue_items.click(function (e) {
				var $target = $(e.target),
					$clicked,
					$child_list,
					$expand_collapse;

				if ($target.is('div') || $target.is('a.expand_collapse')) {
					$clicked = $(this);
					$child_list = $clicked.find('> ul');
					$expand_collapse = $clicked.find('> div > a.expand_collapse');

					if ($child_list.length == 1) {
						if ($child_list.is(':visible')) {
							$child_list.slideUp(200);
							$expand_collapse.removeClass('collapse');
						} else {
							$child_list.slideDown(200);
							$expand_collapse.addClass('collapse');
						}
					}
					return false;
				}
			});
		}
	}
	/* ]]> */
</script>
<asp:Panel ID="pnlMain" runat="server" CssClass="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span><%=TopTitle%></span>
		</div>
		<asp:Literal ID="liAdminNavigation" runat="server"></asp:Literal>
		<div class="sectionBox noPadding bottomPadded sectionBox2">
			<asp:Panel ID="tblImportUploadHeader" runat="server" CssClass="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=ImportXMLfile%></span>
			</asp:Panel>
			<asp:Panel ID="tblImportFromExcelHeader" runat="server" Visible="False" class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=ImportdatafromExcel%></span>
				<div class="edNews_titleH2">
					<a href="<%=ControlPath.Replace("Controls","")%>Excel Import Example.xls"><%=DownloadExcelExampleFile%></a>
				</div>
			</asp:Panel>
			<table id="tblImportModeSelect" runat="server" class="optionsList fullWidthTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=rblImportModeSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectImportMethod.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectImportMethod.Text") %></label>
					</td>
					<td>
						<div class="edNews_inputGroup">
							<asp:RadioButtonList ID="rblImportModeSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblImportModeSelect_SelectedIndexChanged" CssClass="styledRadio smallRadio inlineList" RepeatLayout="UnorderedList">
								<asp:ListItem resourcekey="liImportExistingFile" class="normalRadioButton" Selected="True" Value="import">Import existing file</asp:ListItem>
								<asp:ListItem resourcekey="liUpload" class="normalRadioButton" Value="upload">Upload</asp:ListItem>
							</asp:RadioButtonList>
						</div>
					</td>
				</tr>
			</table>
			<table id="tblImportExistingFile" runat="server" class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlImportXMLFile.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectFileToImport.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectFileToImport.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlImportXMLFile" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImportXMLFile_SelectedIndexChanged"></asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label class="edNews_tooltip" data-tooltip-content="<%=_("lblFileOperations.Help", true) %>" data-tooltip-position="top-right"><%=_("lblFileOperations.Text") %></label>
					</td>
					<td>
						<div class="mainActions smallActions displayInline noMargin">
							<asp:Button ID="btnDeleteExistingXML" ResourceKey="btnDeleteExistingXML" CssClass="delete" runat="server" Text="Delete" OnClick="btnDeleteExistingXML_Click" />
							<asp:Button ID="btnDownloadExistingXML" ResourceKey="btnDownloadExistingXML" CssClass="download" runat="server" Text="Download XML file" OnCommand="btnDownloadExistingXML_Command" />
							<asp:Button ID="btnDownloadExistingZIP" ResourceKey="btnDownloadExistingZIP" CssClass="download" runat="server" Text="Download ZIP file" OnClick="btnDownloadExistingZIP_Click" Visible="False" />
						</div>
					</td>
				</tr>
			</table>
			<table id="tblSelectAuthorAdCategory" runat="server" class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlArticlesCategorySelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectDefaultCategory.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectDefaultCategory.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlArticlesCategorySelect" runat="server"></asp:DropDownList>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbImportToExistingCategory.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImportToExistingCategory.Help", true) %>" data-tooltip-position="top-right"><%=_("lblImportToExistingCategory.Text") %></label>
					</td>
					<td>
						<asp:CheckBox ID="cbImportToExistingCategory" runat="server" Checked="false" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectAuthor.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectAuthor.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged" CssClass="ddlgeneral">
							<asp:ListItem ResourceKey="liSelectRole" Value="-1">Select role</asp:ListItem>
						</asp:DropDownList>
						<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True" CssClass="ddlgeneral">
							<asp:ListItem ResourceKey="liSelectAuthor" Value="-1">Select author</asp:ListItem>
						</asp:DropDownList>
					</td>
				</tr>
			</table>
			<div id="tblUplaodXMLFile" runat="server" visible="false">
				<table class="optionsList fullWidthTable strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=fuXMLFileUpload.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectXMLFile.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectXMLFile.Text") %></label>
						</td>
						<td>
							<asp:FileUpload ID="fuXMLFileUpload" runat="server" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=fuZipFileUpload.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectZipResource.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectZipResource.Text") %></label>
						</td>
						<td>
							<asp:FileUpload ID="fuZipFileUpload" runat="server" />
						</td>
					</tr>
				</table>
				<div class="mainActions">
					<asp:Button ID="btnXMLFileUpload" CssClass="upload" ResourceKey="btnXMLFileUpload" runat="server" Text="Upload" OnClick="btnXMLFileUpload_Click" />
				</div>
			</div>
			<asp:UpdatePanel ID="upImport" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
				<Triggers>
					<asp:PostBackTrigger ControlID="btnExcelFileUpload" />
					<asp:PostBackTrigger ControlID="btnCancelImport" />
				</Triggers>
				<ContentTemplate>
					<asp:UpdateProgress ID="upImportOverlay" runat="server" AssociatedUpdatePanelID="upImport" DisplayAfter="300" DynamicLayout="true">
						<ProgressTemplate>
							<div class="edNews_adminProgressOverlay">
								<asp:Label ID="lblExcelImportInfo" CssClass="infoMessages info" ResourceKey="lblExcelImportInfo" runat="server" Text="Importing data may take a few minutes to finish. Please wait." />
							</div>
						</ProgressTemplate>
					</asp:UpdateProgress>
					<div id="tblImportFromExistingFile" runat="server" class="mainActions">
						<asp:Button ID="btnImportFromExistingXML" CssClass="add" ResourceKey="btnImportFromExistingXML" OnClientClick="ImportButtonToggle()" runat="server" Text="Import" OnClick="btnImportFromXML_Click" />
					</div>
					<div id="tblUploadExcelFile" runat="server" visible="false">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=fuExcelFileUpload.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectExcelFile.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectExcelFile.Text") %></label>
								</td>
								<td>
									<asp:FileUpload ID="fuExcelFileUpload" runat="server" />
								</td>
							</tr>
						</table>
						<div class="mainActions">
							<asp:Button ID="btnExcelFileUpload" CssClass="upload" ResourceKey="btnExcelFileUpload" runat="server" Text="Upload" OnClick="btnExcelFileUpload_Click" />
						</div>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder" runat="server" id="tblImport" visible="false">
						<tr>
							<td colspan="2">
								<div class="mainAction smallActions">
									<asp:Button ID="btnImportIntoNews" CssClass="import" ResourceKey="btnImportIntoNews" runat="server" Text="Import" OnClick="btnImportIntoNews_Click" />
									<asp:Button ID="btnCancelImport" CssClass="cancel" ResourceKey="btnCancelImport" runat="server" Text="Cancel" OnClick="btnCancelImport_Click" />
								</div>
							</td>
						</tr>
						<tr id="trExcelScanMessage" runat="server" visible="false">
							<td class="tdLabel textTop">
								<asp:Label runat="server" ResourceKey="lblColumnsToImportTitle" ID="lblColumnsToImportTitle" Text="Columns To Import:"></asp:Label>
							</td>
							<td>
								<asp:Literal runat="server" ID="ltColumnsToImport" EnableViewState="False" />
							</td>
						</tr>
					</table>
					<div runat="server" id="tblImportResults">
						<asp:Label runat="server" ID="lblImportMainMessage" EnableViewState="False"></asp:Label>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
			<asp:UpdatePanel ID="upExportData" runat="server" UpdateMode="Conditional" Visible="False" OnUnload="UpdatePanel_Unload">
				<ContentTemplate>
					<div class="edNews_adminProgressOverlayWrapper">
						<asp:UpdateProgress ID="upExportOverlay" runat="server" AssociatedUpdatePanelID="upExportData" DisplayAfter="300" DynamicLayout="true">
							<ProgressTemplate>
								<div class="edNews_adminProgressOverlay">
									<asp:Label ID="lblExportInfo" ResourceKey="lblExportInfo" runat="server" Text="Exporting files may take a few minutes to finish. Please wait." />
								</div>
							</ProgressTemplate>
						</asp:UpdateProgress>
						<div class="sectionBox noPadding sectionBox2">
							<div class="sectionBoxHeader">
								<span class="sectionBoxHeaderTitle"><%=ExportdatatoXMLfile%></span>
							</div>
							<table class="optionsList fullWidthTable strippedTable noBorder">
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblExportFileName" ResourceKey="lblExportFileName" runat="server" Text="Enter file name:"></asp:Label></td>
									<td>
										<asp:TextBox ID="tbExportFileName" runat="server"></asp:TextBox>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblCreateZipWithData" ResourceKey="lblCreateZipWithData" runat="server" Text="Create zip file with images and document:"></asp:Label>
									</td>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox ID="cbCreateZipFile" CssClass="normalCheckBox" runat="server" Text="Create zip file with images and document" Checked="True" />
										</div>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblExportAllCategories" runat="server" Text="Export all categories:" resourcekey="lblExportAllCategories"></asp:Label>
									</td>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox Style="display: none" ID="cbAutoAddCatChilds" runat="server" Checked="True" Enabled="False" />
											<asp:CheckBox ID="cbExportAllCategories" CssClass="normalCheckBox" runat="server" Text="Export all categories" Checked="True" />
										</div>
									</td>
								</tr>
							</table>
							<table id="tblSelectCategories" runat="server" class="optionsList fullWidthTable tablePadding5" cellpadding="0" cellspacing="0" style="margin-left: auto; margin-right: auto;">
								<tr>
									<td>
										<asp:PlaceHolder ID="phDinamicTreeView" runat="server"></asp:PlaceHolder>
										<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" CssClass="smallInfo error" ClientValidationFunction="CategoryClientValidate" ErrorMessage="Please select at least one category." Display="Dynamic" Enabled="False" resourcekey="cvCategoriesTreeview.ErrorMessage"
											ValidationGroup="vgExport" />
									</td>
								</tr>
							</table>
							<table class="optionsList fullWidthTable strippedTable noBorder">
								<tr>
									<td class="tdLabel textTop">
										<asp:Label ID="lblLimitPublishDate" ResourceKey="lblLimitPublishDate" runat="server" Text="Limit publish date:"></asp:Label>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox ID="cbLimitPublishDate" CssClass="normalCheckBox" runat="server" Text=" " Checked="false" />
										</div>
										<div id="divLimitPublishDate" style="width:300px;">
											<div class="edNews_inputGroup noWidthLabel">
												<label for="<%=datePickerSearchFromDate.ClientID %>" class="edStore_admin_tooltip"><%=_("FromDate")%></label>
												<div class="input-group input-append date" id="datePickerSearchFromDate" runat="server">
													<asp:TextBox ID="tbSearchFromDate" runat="server" CssClass="form-control" />
													<span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
											</div>
											<div class="edNews_inputGroup noWidthLabel">
												<label for="<%=datePickerSearchToDate.ClientID %>" class="edStore_admin_tooltip"><%=_("ToDate")%></label>
												<div class="input-group input-append date" id="datePickerSearchToDate" runat="server">
													<asp:TextBox ID="tbSearchToDate" runat="server" CssClass="form-control" />
													<span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
											</div>
										</div>
									</td>
								</tr>
							</table>
							<div class="mainActions">
								<asp:Button ID="btnExportToXMLFile" CssClass="export" ResourceKey="btnExportToXMLFile" runat="server" Text="Export to XML file" OnClick="btnExportToXMLFile_Click" ValidationGroup="vgExport" />
							</div>
							<asp:Label ID="lblExportInfoMessage" runat="server" EnableViewState="False" /></td>
							<table class="optionsList fullWidthTable noBorder">
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblExportXMLMessage" runat="server" Text="" />
									</td>
									<td>
										<asp:HyperLink ID="hlExportXMLMessage" ResourceKey="hlExportXMLMessage" runat="server" Visible="false" Text="Download file."></asp:HyperLink>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<asp:Label ID="lblExportZipMessage" runat="server" Text="" />
									</td>
									<td>
										<asp:HyperLink ID="hlDownloadZipFile" ResourceKey="hlDownloadZipFile" runat="server" Visible="false" Text="Download file."></asp:HyperLink>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</ContentTemplate>
			</asp:UpdatePanel>
		</div>
	</div>
</asp:Panel>
<asp:HiddenField ID="hfUploadedFile" runat="server" />