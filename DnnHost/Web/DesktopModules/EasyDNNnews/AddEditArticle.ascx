<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.AddEditArticle, App_Web_addeditarticle.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="Portal" TagName="URL" Src="~/controls/URLControl.ascx" %>

<style type="text/css">
	.styleDisplayNone {
		display: none;
	}
</style>

<asp:Label ID="lblEditMessage" runat="server" Visible="false" />
<asp:HiddenField ID="hfUploadedDocs" runat="server" />
<asp:HiddenField ID="hfGUID" runat="server" />
<asp:Panel ID="pnlMainWrapper" runat="server">
	<asp:Panel ID="pnlEditArticle" runat="server" CssClass="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
		<div id="EDNadmin" class="contentSection">
			<div class="titleWrapper">
				<asp:Literal ID="liAdminNavigation" runat="server" />
				<span><%=EditArticleTitle%></span>
			</div>
			<asp:Panel ID="pnlImagelocalization" CssClass="main_content" runat="server" Visible="false">
				<asp:HiddenField ID="hfImageLocaPicID" runat="server" />
				<table class="settings_table" cellpadding="0" cellspacing="0">
					<tr>
						<td class="left">
							<asp:Label ID="lblContentLocalizationMediaTitle" runat="server" Font-Bold="True" Text="Media title:" resourcekey="lblContentLocalizationMediaTitleResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblContentLocalizationMediaTitleOriginal" runat="server" resourcekey="lblContentLocalizationMediaTitleOriginalResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:Label ID="lblContentLocalizationMediaDescription" runat="server" Font-Bold="True" Text="Media description:" resourcekey="lblContentLocalizationMediaDescriptionResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblContentLocalizationMediaDescriptionOriginal" runat="server" resourcekey="lblContentLocalizationMediaDescriptionOriginalResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:Label ID="lblPortalDefLanguage" runat="server" Text="Portal default language:" resourcekey="lblPortalDefLanguageResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblDefaultPortalLangugageImage" runat="server" resourcekey="lblDefaultPortalLangugageImageResource1" />
						</td>
					</tr>
					<tr>
						<td class="left">
							<asp:Label ID="lblContentLocalizationLocalizedLanguages" runat="server" Text="Localized languages:" resourcekey="lblContentLocalizationLocalizedLanguagesResource1" />
						</td>
						<td class="right">
							<asp:Label ID="lblContentLocalizationLocalizedLanguagesList" runat="server" resourcekey="lblContentLocalizationLocalizedLanguagesListResource1" />
						</td>
					</tr>
				</table>
				<div class="text_input_set">
					<label for="<%=ddlContentLocalizationSelectLanguage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationSelectLanguage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationSelectLanguage.Text") %></label>
					<asp:DropDownList ID="ddlContentLocalizationSelectLanguage" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlImageEditorContentLocalizationSelectLanguage_SelectedIndexChanged" />
					<asp:LinkButton ID="btnContentLocalizationCopyDefault" CssClass="silver_button" Style="float: right;" runat="server" OnClick="btnContentLocalizationCopyDefault_Click" resourcekey="lbCLCopyDefaultsResource1" />
				</div>
				<div class="text_input_set overflow_visible">
					<label for="<%=tbContentLocalizationTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationTitle.Text") %></label>
					<asp:TextBox ID="tbContentLocalizationTitle" runat="server" CssClass="text s18" MaxLength="250" />
				</div>
				<div class="text_input_set">
					<label for="<%=txtGalleryDescriptionLocalized.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationDescription.Text") %></label>
					<dnn:TextEditor ID="txtGalleryDescriptionLocalized" runat="server" Height="300px" />
				</div>
				<div class="text_input_set">
					<asp:LinkButton ID="btnContentLocalizationUpdate" CssClass="silver_button" runat="server" OnClick="btnImageEditorContentLocalizationUpdate_Click">
						<span>
							<%=Savelocalization%></span></asp:LinkButton>
					<asp:LinkButton ID="btnContentLocalizationClose" CssClass="silver_button" runat="server" OnClick="btnContentLocalizationClose_Click">
						<span>
							<%=Close%></span></asp:LinkButton>
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlContentLocalizationDetails" CssClass="main_content topPadded" runat="server" Visible="false">
				<div class="negativeMargins">
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel textTop">
								<strong><%=Defaultportallanguage%></strong>
							</td>
							<td>
								<asp:Label ID="lblDefaultPortalLangugage" runat="server" resourcekey="lblDefaultPortalLangugageResource1" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=cbHideDefaultLocale.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideDefaultLocale.Help", true) %>" data-tooltip-position="top-right"><%=_("lblHideDefaultLocale.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbHideDefaultLocale" runat="server" Text="Do not display this article on the default language" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<strong>
									<asp:Label ID="lblLocLangArticle" runat="server" resourcekey="lblLocLangArticleResource1" Text="Localized languages for this article:" /></strong>
							</td>
							<td>
								<asp:Label ID="lblLocalizedLanguages" runat="server" Text="None" />
							</td>
						</tr>
					</table>
				</div>
				<div class="text_input_set">
					<asp:Label ID="lblCLSelectLanguage" runat="server" resourcekey="lblCLSelectLanguageResource1" Text="Select language:" />
					<asp:DropDownList ID="ddlCLLanguageSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCLLanguageSelect_SelectedIndexChanged" />
					<div class="mainActions smallActions noMargin floatRight">
						<asp:LinkButton ID="lbCLCopyDefaults" runat="server" CssClass="primaryAction" OnClick="lbCLCopyDefaults_Click" resourcekey="lbCLCopyDefaultsResource1" />
						<asp:LinkButton ID="btnDeleteLocalization" runat="server" CssClass="delete" OnClick="btnDeleteLocalization_Click" resourcekey="btnDeleteLocalization" />
					</div>
				</div>
				<div class="text_input_set overflow_visible">
					<label for="<%=tbCLArticleTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCLTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCLTitle.Text") %></label>
					<asp:TextBox ID="tbCLArticleTitle" runat="server" CssClass="text s18" />
					<asp:RequiredFieldValidator ID="rfvCLArticleTitle" runat="server" ControlToValidate="tbCLArticleTitle" CssClass="input_validation_error" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvTitleResource1" SetFocusOnError="True" ValidationGroup="vgCLEditArticle" />
				</div>
				<div class="text_input_set overflow_visible">
					<label for="<%=tbCLArticleSubtitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCLSubtitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCLSubtitle.Text") %></label>
					<asp:TextBox ID="tbCLArticleSubtitle" runat="server" CssClass="text" />
				</div>
				<div class="collapsible_box">
					<h1 class="collapsible_box_title">
						<%=SEOsettings%></h1>
					<div id="collapsible_CLseo_box_content" class="content">
						<div class="text_input_set">
							<div>
								<label for="<%=tbxCLArticleURL.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleURL.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleURL.Text") %></label>
							</div>
							<asp:TextBox ID="tbxCLArticleURL" runat="server" CssClass="text narrow left" />
							<a id="EDN_btnCLReGenerateURL" class="main_action_button reset_url_btn grey" href="#"><span>
								<%=ResetarticleURL%></span></a>
						</div>
						<div class="text_input_set">
							<div>
								<label for="<%=tbxCLTitleTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTitleTag.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTitleTag.Text") %></label>
							</div>
							<asp:TextBox ID="tbxCLTitleTag" runat="server" CssClass="text narrow left" />
						</div>
						<div class="text_input_set">
							<label for="<%=tbxCLMetaDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMetaDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMetaDescription.Text") %></label>
							<asp:TextBox ID="tbxCLMetaDescription" runat="server" TextMode="MultiLine" />
						</div>
						<div class="text_input_set">
							<label for="<%=tbxCLMetaKeywords.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMetaKeywords.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMetaKeywords.Text") %></label>
							<asp:TextBox ID="tbxCLMetaKeywords" runat="server" TextMode="MultiLine" />
						</div>
					</div>
				</div>
				<div class="text_input_set">
					<label for="<%=txtSummaryLocalized.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCLSummary.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCLSummary.Text") %></label>
					<dnn:TextEditor ID="txtSummaryLocalized" runat="server" Height="300px" Visible="false" />
					<asp:TextBox ID="tbxSummaryLocalized" runat="server" TextMode="MultiLine" Height="300" Visible="false" />
					<asp:Label ID="lblSummaryLocalizedCountMaxChar" runat="server" Style="float: right;" />
				</div>
				<asp:Panel ID="pnlDetailTypeTextLocalization" CssClass="text_input_set edNews_textEditorDetails" runat="server">
					<label for="<%=txtContentLocalized.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCLArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCLArticle.Text") %></label>
					<dnn:TextEditor ID="txtContentLocalized" runat="server" Height="600px" Visible="false" />
					<asp:TextBox ID="tbxContentLocalized" runat="server" TextMode="MultiLine" Height="600" Visible="false" />
					<asp:Label ID="lblContentLocalizedCountMaxChar" runat="server" Style="float: right;" />
				</asp:Panel>
				<asp:Panel ID="pnlDetailTypePageLocalization" CssClass="text_input_set" Style="width: 500px; margin: 15px auto 0;" runat="server" Visible="false">
					<asp:Panel runat="server" ID="pnlArticleDetailTypePageLoc" Visible="false">
						<span><%=_("Page") %></span>
						<asp:DropDownList ID="ddlDetailTypePageLoc" runat="server" DataTextField="IndentedTabName" DataValueField="TabId" />
					</asp:Panel>
					<Portal:URL ID="ctlURLLoc" runat="server" Width="250" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U" />
				</asp:Panel>
				<asp:Panel ID="pnlMainImageLocalization" runat="server">
					<div class="text_input_set">
						<label for="<%=tbMainImageTitleLozalization.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMainImageTitleLozalization.Help", true) %>" data-tooltip-position="top-right"><%=_("lblMainImageTitleLozalization.Text") %></label>
						<asp:TextBox ID="tbMainImageTitleLozalization" runat="server" CssClass="text s18" MaxLength="500" Width="300px" />
					</div>
					<div class="text_input_set">
						<label for="<%=tbMainImageDescriptionLozalization.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMainImageDescriptionLozalization.Help", true) %>" data-tooltip-position="top-right"><%=_("lblMainImageDescriptionLozalization.Text") %></label>
						<asp:TextBox ID="tbMainImageDescriptionLozalization" runat="server" Height="50px" MaxLength="2000" TextMode="MultiLine" Width="450px" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlCustomFieldsLocalization" runat="server" Style="margin-top: 30px;" CssClass="collapsible_box" Visible="false">
					<div class="text_input_set">
						<div class="text s18" style="margin-bottom: 20px;">
							<label class="edNews_tooltip" data-tooltip-content="<%=_("lblCustomFieldsLocalization.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCustomFieldsLocalization.Text") %></label>
						</div>
						<asp:PlaceHolder ID="phCustomFieldsLocalization" runat="server" />
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlEventPaymentLocalization" runat="server" Style="margin-top: 30px;" CssClass="collapsible_box" Visible="false">
					<div class="text_input_set">
						<div class="text s18" style="margin-bottom: 20px;">
							<label class="edNews_tooltip" data-tooltip-content="<%=_("lblByAttendeesCost.Help", true) %>" data-tooltip-position="top-right"><%=_("lblByAttendeesCost.Text") %></label>
						</div>
						<asp:PlaceHolder ID="phEventPaymentByAttendees" runat="server"></asp:PlaceHolder>
					</div>
				</asp:Panel>
				<asp:Label ID="lblErrorInfoMsg" runat="server" EnableViewState="false" Visible="false" />
				<div class="mainActions">
					<asp:LinkButton ID="lbCLSaveLocalization" runat="server" Text="Save localization" CausesValidation="true" CssClass="downSave" OnClick="lbCLSaveLocalization_Click" resourcekey="lbCLSaveLocalizationResource1" ValidationGroup="vgCLEditArticle" />
					<asp:LinkButton ID="lbCancelLocalization" runat="server" Text="Close" CssClass="cancel" OnClick="lbCancelLocalization_Click" resourcekey="lbCancelLocalizationResource1" />
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlMainEdit" runat="server" CssClass="main_content">
				<div class="mainActions smallActions noMargin textRight" runat="server" id="divContentLocalization" style="position: relative; margin-bottom: -20px">
					<asp:LinkButton ID="lbLocalizeContent" runat="server" OnClick="lbLocalizeContent_Click" CssClass="primaryAction" resourcekey="lbLocalizeContentResource1">Content localization</asp:LinkButton>
				</div>
				<div class="text_input_set overflow_visible no_margin">
					<label for="<%=tbArticleTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleTitle.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblArticleTitle.Text") %></label>
					<asp:RequiredFieldValidator ID="rfvTitle" runat="server" ErrorMessage="This field is required." ValidationGroup="vgEditArticle" ControlToValidate="tbArticleTitle" SetFocusOnError="True" CssClass="input_validation_error" Display="Dynamic" resourcekey="rfvTitleResource1.ErrorMessage" />
					<asp:RequiredFieldValidator CssClass="input_validation_error" ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbArticleTitle" Display="Dynamic" ErrorMessage="This field is required." SetFocusOnError="True" ValidationGroup="vgCreateGallery"
						resourcekey="rfvTitleResource1.ErrorMessage" />
					<asp:TextBox ID="tbArticleTitle" runat="server" CssClass="text s18" MaxLength="200" />
				</div>
				<div id="pnlSubTitle" runat="server" class="text_input_set overflow_visible">
					<label for="<%=txtSubtitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSubtitle.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblSubtitle.Text") %></label>
					<asp:TextBox ID="txtSubtitle" runat="server" CssClass="text" MaxLength="4000" />
				</div>
				<div id="pnlSEO" runat="server" class="collapsible_box">
					<h1 class="collapsible_box_title">
						<%=SEOsettings%></h1>
					<div class="content eds_Tabs eds_whiteTabs" id="collapsible_seo_box_content">
						<div class="edsTabulator">
							<ul class="eds_tabsNav">
								<li class="edsTabGeneral edsTabulator_tabTrigger"><%=_("General.Text") %></li>
								<li class="edsTabOpenGraph edsTabulator_tabTrigger"><%=_("OpenGraph.Text") %></li>
								<li class="edsTabTwitterCards edsTabulator_tabTrigger"><%=_("TwitterCards.Text") %></li>
								<li class="edsTabStructuredData edsTabulator_tabTrigger"><%=_("StructuredData.Text") %></li>
							</ul>
							<div class="edsTabulator_tabsWrapper">
								<div class="edsTabulator_tab">
									<div class="text_input_set">
										<div>
											<label for="<%=tbArticleURL.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleURL.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblArticleURL.Text") %></label>
										</div>
										<asp:TextBox ID="tbArticleURL" runat="server" CssClass="text narrow left" />
										<a id="EDN_btnReGenerateURL" class="reset_url_btn main_action_button grey" href="#"><span><%=ResetarticleURL%></span></a>
									</div>
									<div class="text_input_set">
										<div>
											<label for="<%=tbTitleTag.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTitleTag.Help", true) %>" data-tooltip-position="top-left"><%=_("lblTitleTag.Text") %></label>
										</div>
										<asp:TextBox ID="tbTitleTag" runat="server" CssClass="text left" />
									</div>
									<div class="text_input_set">
										<label for="<%=tbMetaDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMetaDescription.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblMetaDescription.Text") %></label>
										<asp:TextBox ID="tbMetaDescription" runat="server" TextMode="MultiLine" />
									</div>
									<div class="text_input_set">
										<label for="<%=tbMetaKeywords.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMetaKeywords.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblMetaKeywords.Text") %></label>
										<asp:TextBox ID="tbMetaKeywords" runat="server" TextMode="MultiLine" />
									</div>
								</div>
								<div class="edsTabulator_tab text_input_set overflow_visible">
									<asp:Panel ID="pnlOpenGraphMetaTagsTemplateSelection" runat="server" CssClass="edNews_seoTemplates" Visible="false">
										<label for="<%=ddlOpenGraphTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenGraphTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenGraphTemplate.Text") %></label>
										<asp:DropDownList ID="ddlOpenGraphTemplate" runat="server" />
									</asp:Panel>
									<label for="<%=tbOpenGraphMetaTags.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenGraphMetaTags.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblOpenGraphMetaTags.Text") %></label>
									<asp:TextBox ID="tbOpenGraphMetaTags" runat="server" CssClass="text" Style="height: 200px;" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>
								</div>
								<div class="edsTabulator_tab text_input_set overflow_visible">
									<asp:Panel ID="pnlTwitterCardsTemplateSelection" runat="server" CssClass="edNews_seoTemplates" Visible="false">
										<label for="<%=ddlTwitterCardsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTwitterCardsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTwitterCardsTemplate.Text") %></label>
										<asp:DropDownList ID="ddlTwitterCardsTemplate" runat="server" />
									</asp:Panel>
									<label for="<%=tbTwitterCardMetaTags.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTwitterCardsMetaTags.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblTwitterCardsMetaTags.Text") %></label>
									<asp:TextBox ID="tbTwitterCardMetaTags" runat="server" CssClass="text" Style="height: 200px;" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>
								</div>
								<div class="edsTabulator_tab text_input_set overflow_visible">
									<asp:Panel ID="pnlStructuredDataTemplateSelection" runat="server" CssClass="edNews_seoTemplates" Visible="false">
										<label for="<%=ddlStructuredDataTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStructuredDataTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblStructuredDataTemplate.Text") %></label>
										<asp:DropDownList ID="ddlStructuredDataTemplate" runat="server" />
									</asp:Panel>
									<label for="<%=tbStructuredDataJSON.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStructuredDataJson.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblStructuredDataJson.Text") %></label>
									<asp:TextBox ID="tbStructuredDataJSON" runat="server" CssClass="text" Style="height: 400px;" MaxLength="4000" TextMode="MultiLine"></asp:TextBox>
									<asp:CustomValidator ID="cvStructuredDataJSON" CssClass="EDN_error" runat="server" ClientValidationFunction="ClientValidateStructuredDataTemplate" Display="Dynamic" ErrorMessage="Invalid data. Please replace Placeholder values with real data." resourcekey="cvStructuredDataJSON.ErrorMessage" ValidationGroup="vgEditArticle" ControlToValidate="tbStructuredDataJSON" SetFocusOnError="True"></asp:CustomValidator>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div id="pnlCategoriesSelection" class="section_box white_border_1 categoriespanel" runat="server">
					<h1 class="section_box_title">
						<span><%=Categories%></span>
					</h1>
					<div class="content category_selection">
						<asp:UpdatePanel ID="upCategorySelection" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edn_admin_progress_overlay_container">
									<asp:UpdateProgress ID="uppCategorySelection" runat="server" AssociatedUpdatePanelID="upCategorySelection" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edn_admin_progress_overlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<asp:Label ID="lblCategoryPermissionsInfo" runat="server" ForeColor="Red" Visible="false" resourcekey="lblCategoryPermissionsInfoResource1" />
									<asp:Label ID="lblCategorySelectError" runat="server" EnableViewState="false" ForeColor="Red" Text="Please select category." Visible="false" />
									<p class="expand_collapse_container">
										<asp:LinkButton ID="lblCategorySelectionExpandAll" runat="server" Text="Expand all" OnClick="lblCategorySelectionExpandAll_Click" resourcekey="lblCategorySelectionExpandAll" />
										|
										<asp:LinkButton ID="lblCategorySelectionCollapseAll" runat="server" Text="Collapse all" OnClick="lblCategorySelectionCollapseAll_Click" resourcekey="lblCategorySelectionCollapseAll" />
									</p>
									<asp:TreeView ID="tvCatAndSubCat" runat="server" EnableViewState="true" ForeColor="Black" NodeWrap="True" ShowCheckBoxes="All" ShowLines="True" CssClass="category_tree_view" />
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</div>
				</div>

				<div id="pnlSummary" runat="server" class="section_box grey white_border_1 summarypanel">
					<h1 class="section_box_title">
						<span><%=Summary%></span>
					</h1>
					<div class="summaryhtmleditor text_input_set">
						<label for="<%=txtSummary.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleSummary.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblArticleSummary.Text") %></label>
						<dnn:TextEditor ID="txtSummary" runat="server" Height="300px" Visible="false" />
						<asp:TextBox ID="tbxSummary" runat="server" TextMode="MultiLine" Height="300" Visible="false" />
						<asp:Label ID="lblSummaryCountMaxChar" runat="server" class="edn_countMaxChar" />
					</div>
				</div>

				<div id="pnlDetailTypeSelection" runat="server" class="section_box grey white_border_1 detailtypepanel" style="border-bottom: 0;">
					<h1 class="section_box_title">
						<span><%=Articledetailtype %></span>
					</h1>
					<div class="edNews_inputGroup displayInline">
						<asp:RadioButtonList ID="rblDetailType" CssClass="styledRadio inlineList smallRadio" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblDetailType_SelectedIndexChanged" RepeatLayout="UnorderedList">
							<asp:ListItem Value="Text" class="normalRadioButton" resourcekey="ListItemResource1" Text="Text/HTML" Selected="True" />
							<asp:ListItem Value="Page" class="normalRadioButton" resourcekey="ListItemResource2" Text="Page" />
							<asp:ListItem Value="File" class="normalRadioButton" resourcekey="ListItemResource3" Text="File" />
							<asp:ListItem Value="Link" class="normalRadioButton" resourcekey="ListItemResource4" Text="Link" />
							<asp:ListItem Value="None" class="normalRadioButton" resourcekey="ListItemResource5" Text="None" />
						</asp:RadioButtonList>
					</div>
				</div>
				<div id="pnlDetailTypePanels" runat="server" class="section_box white_border_1" style="border-top: 0; margin: 0; padding: 15px;">
					<asp:Panel ID="pnlDetailTypeText" CssClass="text_input_set edNews_textEditorDetails detailshtmleditor" runat="server">
						<div style="margin-left: 5px;">
							<label for="<%=txtContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContent.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblContent.Text") %></label>
						</div>
						<div class="contenthtmleditor">
							<dnn:TextEditor ID="txtContent" runat="server" Height="700px" Visible="false" />
							<asp:TextBox ID="tbxContent" runat="server" TextMode="MultiLine" Height="700" Visible="false" />
							<asp:Label ID="lblContentCountMaxChar" runat="server" class="edn_countMaxChar" />
						</div>
						<p class="article_content_bottom_actions">
							<a href="#" onclick="jQuery(this).parent().siblings('div.avalible_article_tokens').toggle(200); return false;"><%=_("ShowHideTokenList")%></a>
						</p>
						<div class="avalible_article_tokens">
							<asp:TextBox ID="tbTokenList" runat="server" ReadOnly="True" TextMode="MultiLine" Height="93px" Width="97%" />
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlDetailTypePage" Style="margin: 15px auto 0;" runat="server" Visible="false">
						<asp:Panel runat="server" ID="pnlArticleDetailTypePage" Visible="false" CssClass="edNews_inputGroup labelBlock">
							<label><%=_("Page") %></label>
							<asp:DropDownList ID="ddlDetailTypePage" runat="server" DataTextField="IndentedTabName" DataValueField="TabId" />
						</asp:Panel>
						<div class="edNews_inputGroup labelBlock inputWidth40">
							<Portal:URL ID="ctlURL" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U" />
						</div>
						<div class="edNews_inputGroup noWidthLabel textCenter">
							<asp:Label ID="lblSelectDetailTarget" runat="server" Text="Select target:" AssociatedControlID="ddlDetailTarget" resourcekey="lblSelectDetailTargetResource1" />
							<asp:DropDownList ID="ddlDetailTarget" runat="server">
								<asp:ListItem resourcekey="ListItemResource6" Value="_self" Text="_self" />
								<asp:ListItem resourcekey="ListItemResource7" Value="_blank" Text="_blank" />
								<asp:ListItem resourcekey="ListItemResource8" Value="_parent" Text="_parent" />
								<asp:ListItem resourcekey="ListItemResource9" Value="_top" Text="_top" />
							</asp:DropDownList>
						</div>
					</asp:Panel>
				</div>
				<asp:UpdatePanel ID="upArticleTags" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
					<ContentTemplate>
						<div class="section_box grey white_border_1 tagspanel">
							<h1 class="section_box_title">
								<span><%=_("Tags.Text") %></span>
							</h1>
							<div class="edn_admin_progress_overlay_container tagsupdatepanel">
								<asp:UpdateProgress ID="uppArticleTags" runat="server" AssociatedUpdatePanelID="upArticleTags" DisplayAfter="100" DynamicLayout="true">
									<ProgressTemplate>
										<div class="edn_admin_progress_overlay">
										</div>
									</ProgressTemplate>
								</asp:UpdateProgress>
								<div class="text_input_set">
									<label for="<%=tbTags.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleTags.HelpText", true) %>" data-tooltip-position="top-left"><%=_("lblArticleTags.Text") %></label>
									<asp:TextBox ID="tbTags" runat="server" CssClass="text" />
								</div>
								<asp:Panel ID="pnlAddTags" runat="server">
									<div class="collapsible_box no_margin visible" id="add_existing_tags_box">
										<h1 class="collapsible_box_title close">
											<%=ADDEXISTINGTAGS%></h1>
										<div class="content">
											<div class="tag_collection">
												<ul class="tag_selection_menu">
													<li class="spaced">
														<asp:LinkButton ID="lbAllAddedTags" runat="server" OnClick="lbAllAddedTags_Click"><%=AllTags%></asp:LinkButton></li>
													<li class="spaced">
														<asp:LinkButton ID="lbMostPopularTags" runat="server" OnClick="lbMostPopularTags_Click" resourcekey="lbMostPopularTagsResource1">MOST POPULAR FIRST</asp:LinkButton></li>
													<li class="spaced">
														<asp:LinkButton ID="lbLastAddedTags" runat="server" OnClick="lbLastAddedTags_Click" resourcekey="lbLastAddedTagsResource1">LAST ADDED FIRST</asp:LinkButton></li>
												</ul>
												<asp:DataList ID="dlListOfExistingTags" runat="server" RepeatColumns="5" OnItemCommand="dlListOfExistingTags_ItemCommand" RepeatDirection="Horizontal" CssClass="existing_tag_list">
													<ItemTemplate>
														<asp:LinkButton ID="lbAddTag" runat="server" CommandName="AddTag" CommandArgument='<%# Eval("Name") %>' resourcekey="lbAddTagResource1" CssClass="tag_link"><%#Eval("Name")%><span class="addtag"></span></asp:LinkButton>
													</ItemTemplate>
												</asp:DataList>
												<asp:GridView ID="gvTagsPaging" runat="server" AllowPaging="True" AutoGenerateColumns="false" CellPadding="0" CssClass="existing_tag_list_pagination article_pager" DataSourceID="odsGetTagsByName" EnableModelValidation="True" GridLines="None" OnPageIndexChanged="gvTagsPaging_PageIndexChanged" PageSize="50">
													<Columns>
														<asp:BoundField DataField="Name" Visible="false" />
													</Columns>
												</asp:GridView>
											</div>
										</div>
									</div>
								</asp:Panel>
								<asp:Panel ID="pnlYouCanNotAddMoreTags" runat="server" Visible="False">
									<asp:Label ID="lblYouCanNotAddMoreTags" runat="server" />
								</asp:Panel>
							</div>
						</div>
					</ContentTemplate>
				</asp:UpdatePanel>
				<div class="content_token_generator gallery_item">
				</div>
				<asp:UpdatePanel ID="upArticleImages" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
					<ContentTemplate>
						<div class="edn_admin_progress_overlay_container">
							<asp:Panel ID="pnlArticleImage" CssClass="section_box white_border_1 main_article_panel" runat="server" Visible="false">
								<h1 class="section_box_title">
									<span><%=Mainarticleimage %></span>
								</h1>
								<div class="content main_article_image">
									<div class="left_col">
										<asp:Image ID="imgArticleImage" runat="server" resourcekey="imgArticleImageResource1" />
									</div>
									<div class="right_col">
										<div style="padding-top: 20px;">
											<div class="styledCheckbox">
												<asp:CheckBox CssClass="normalCheckBox" ID="cbShowMainArticleImageList" runat="server" Checked="True" Text="Show article image on article list" resourcekey="cbShowMainArticleImageListResource1" />
											</div>
											<div>
												<div class="styledCheckbox">
													<asp:CheckBox ID="cbShowMainArticleImage" runat="server" Checked="True" CssClass="normalCheckBox" resourcekey="cbShowMainArticleImageResource1" Text="Show main article image" />
												</div>
											</div>
										</div>

										<div id="rblSelectMainImageEmbedTypeDiv" runat="server" visible="false" class="edNews_inputGroup displayInline" style="margin-left: 15px;">
											<asp:RadioButtonList ID="rblSelectMainImageEmbedType" runat="server" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList">
												<asp:ListItem class="normalRadioButton" resourcekey="liImage" Selected="True" Value="Image">Image</asp:ListItem>
												<asp:ListItem class="normalRadioButton" resourcekey="liVideo" Value="Video">Video</asp:ListItem>
											</asp:RadioButtonList>
										</div>

										<div class="info_box check_sign">
											<asp:LinkButton ID="btnRemoveArticleImage" runat="server" CssClass="action remove_btn" OnClick="btnRemoveArticleImage_Click" resourcekey="btnRemoveArticleImageResource1" Text="Remove" />
											<p>
												<%=ThisImage%>
											</p>
										</div>
									</div>
									<asp:Panel ID="pnlImageTitleDescription" CssClass="section_actions_mainimage" Style="clear: left;" runat="server">
										<asp:HyperLink ID="hlOpenImageTitleDescriptionOptions" runat="server" CssClass="icon down_arrows" NavigateUrl="#"><%=ImgeTitleDescriptionSettings%></asp:HyperLink>
										<asp:Panel ID="pnlImageTitleDescriptionOptions" runat="server" Style="display: none;">
											<div style="text-align: left; padding-left: 30px; padding-bottom: 20px;" class="edit_fields">
												<span style="display: block; padding-top: 5px;">
													<%=_("MainImageTitle")%>:</span>
												<asp:TextBox ID="tbMainImageTitle" runat="server" MaxLength="500" Width="300px" />
												<span style="display: block; padding-top: 10px;">
													<%=_("MainImageDescription")%>:</span>
												<asp:TextBox ID="tbMainImageDescription" runat="server" Height="50px" MaxLength="2000" TextMode="MultiLine" Width="450px" />
											</div>
										</asp:Panel>
									</asp:Panel>
								</div>
							</asp:Panel>
							<asp:Panel ID="pnlIncludedGalleries" CssClass="section_box white_border_1 galleries_included" runat="server" Visible="false">
								<h1 class="section_box_title">
									<span><%=Galleriesincluded%></span>
								</h1>
								<div class="content included_galleries">
									<ul id="EDN_admin_included_galleries">
										<asp:Repeater ID="repIncludedGalleries" runat="server" OnItemCommand="repIncludedGalleries_ItemCommand">
											<ItemTemplate>
												<li>
													<div class="left">
													</div>
													<div class="middle">
														<p class='gallery_title <%# GetDotClass(Convert.ToInt32(Eval("GalleryID"))) %>'>
															<%#Eval("GalleryName")%>
															<asp:Label ID="lblIntGalCategoryName" runat="server" Text='<%# GetCategoryName(Convert.ToInt32(Eval("GalleryID"))) %>' />
														</p>
														<p class="gallery_actions">
															<asp:HiddenField ID="hfGalIntID" runat="server" Value='<%# Eval("GalleryID") %>' />
															<asp:LinkButton ID="lbOpenIntegratedGallery" CssClass="gallery_settings" CommandName="OpenIntGallery" CommandArgument='<%# Eval("GalleryID") %>' ToolTip="Open this gallery" runat="server" resourcekey="lbOpenIntegratedGalleryResource1" />
															<span class="border"></span><a href="#" class="up_down_arrows" title="Rearange this gallery's position by dragging and droping it"></a><span class="border"></span>
															<asp:LinkButton ID="imbDeleteIntegratedArticle" CssClass="remove" CommandName="DeleteRow" CommandArgument='<%# Container.ItemIndex %>' ToolTip="Remove the gallery from this article" runat="server" resourcekey="imbDeleteIntegratedArticleResource1" />
															<input type="hidden" name="EDN_Included_Gals" value='<%# Eval("GalleryID") %>' />
														</p>
													</div>
													<div class="right">
													</div>
												</li>
											</ItemTemplate>
										</asp:Repeater>
									</ul>
									<asp:Panel ID="pnlViewGallerySettings" CssClass="section_actions" runat="server" Visible="false">
										<asp:HyperLink ID="lbGallerySettings" runat="server" CssClass="icon down_arrows" NavigateUrl="#" resourcekey="lbGallerySettingsResource1">View settings</asp:HyperLink>
										<asp:Panel ID="pnlGallerySettings" runat="server" Style="display: none;">
											<table class="settings_table">
												<tr>
													<td class="left">
														<label for="<%=tbUserNameToAdd.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIGalleryType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIGalleryType.Text") %></label>
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlGalleryDisplayType" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlGalleryDisplayType_SelectedIndexChanged">
															<asp:ListItem Value="chameleon">Chameleon gallery</asp:ListItem>
															<asp:ListItem Value="lightbox" resourcekey="ListItemResource10">Lightbox gallery</asp:ListItem>
															<asp:ListItem Value="audio" resourcekey="ListItemResource11">Audio gallery</asp:ListItem>
															<asp:ListItem resourcekey="ListItemResource12" Value="video">Video gallery</asp:ListItem>
														</asp:DropDownList>
													</td>
												</tr>
											</table>
											<table runat="server" id="tblCommonGallerySettings" class="settings_table">
												<tr>
													<td class="left">
														<label for="<%=ddlGalleryPosition.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIGalleryPosition.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIGalleryPosition.Text") %></label>
													</td>
													<td class="right">
														<asp:DropDownList ID="ddlGalleryPosition" runat="server">
															<asp:ListItem Value="bottom" resourcekey="ListItemResource13" Selected="True">Bottom position</asp:ListItem>
															<asp:ListItem Value="top" resourcekey="ListItemResource14">Top position</asp:ListItem>
														</asp:DropDownList>
													</td>
												</tr>
												<tr>
													<td class="left">
														<label for="<%=rblFixedResponsiveLayoutTypeSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFixedResponsiveLayout.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFixedResponsiveLayout.Text") %></label>
													</td>
													<td class="right">
														<div class="edNews_inputGroup">
															<asp:RadioButtonList ID="rblFixedResponsiveLayoutTypeSelect" CssClass="styledRadio inlineList smallRadio" runat="server" AutoPostBack="True" RepeatLayout="UnorderedList" OnSelectedIndexChanged="rblFixedResponsiveLayoutTypeSelect_SelectedIndexChanged">
																<asp:ListItem resourcekey="liFixed" class="normalRadioButton" Selected="True" Value="fixed">Fixed Layout</asp:ListItem>
																<asp:ListItem resourcekey="liResponsive" class="normalRadioButton" Value="responsive">Responsive Layout</asp:ListItem>
															</asp:RadioButtonList>
														</div>
													</td>
												</tr>
											</table>
											<table class="settings_table">
												<tr runat="server" id="trGalleryLightboxSelection">
													<td class="left textTop">
														<label for="<%=rblGalleryLightbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryLightbox.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryLightbox.Text") %></label>
													</td>
													<td class="right">
														<div class="edNews_inputGroup">
															<asp:RadioButtonList ID="rblGalleryLightbox" CssClass="styledRadio verticalList smallRadio" runat="server" RepeatLayout="UnorderedList">
																<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liSocialMediaBoxLite" Selected="True">SocialMediaBox Lite</asp:ListItem>
																<asp:ListItem Value="5" class="normalRadioButton" resourcekey="liSocialMediaBoxPlus">SocialMediaBox Plus</asp:ListItem>
																<asp:ListItem Value="2" class="normalRadioButton" resourcekey="liSocialMediaBox">SocialMediaBox Advanced</asp:ListItem>
																<asp:ListItem Value="4" class="normalRadioButton" resourcekey="liOpenDetailsInGravityGallery">Open details in Gravity gallery</asp:ListItem>
																<asp:ListItem Value="3" class="normalRadioButton" resourcekey="liNone">None</asp:ListItem>
															</asp:RadioButtonList>
														</div>
													</td>
												</tr>
											</table>
											<asp:Panel ID="pnlChameleonGallery" runat="server" Visible="false">
												<table class="settings_table">
													<tr>
														<td class="left">
															<label for="<%=tbxGalleryWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryWidth.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbxGalleryWidth" runat="server" CssClass="smallCentered" Text="700" />
															<asp:Label ID="lblChamMainPanelWidthType" runat="server" Text="%" Visible="false" />
															<asp:RequiredFieldValidator ID="rfvRhumbImageWidth" runat="server" ControlToValidate="tbxGalleryWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgEditArticle" resourcekey="rfvRhumbImageWidth0Resource1" Display="Dynamic" />
															<asp:CompareValidator ID="cvtbxGalleryWidth" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="cvLightBoxGalleryNumberOfItemsResource1"
																SetFocusOnError="True" />
															<asp:RangeValidator ID="rvtbxGalleryWidth" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" Enabled="false" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvChameleonWidthPerct.ErrorMessage"
																SetFocusOnError="True" Type="Integer" ValidationGroup="vgEditArticle" Visible="false" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbxGalleryHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryHeight.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbxGalleryHeight" runat="server" CssClass="smallCentered">500</asp:TextBox>
															<asp:Label ID="lblChamMainPanelHeightType" runat="server" Text="px" Visible="False" />
															<asp:DropDownList ID="ddlChameleonGalleryHeightType" runat="server" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryHeightType_SelectedIndexChanged">
																<asp:ListItem Value="0">px</asp:ListItem>
																<asp:ListItem Value="1">%</asp:ListItem>
															</asp:DropDownList>
															<asp:RequiredFieldValidator ID="rfvtbxGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgEditArticle" resourcekey="rfvRhumbImageWidth1Resource1.ErrorMessage"
																Display="Dynamic" />
															<asp:CompareValidator ID="cvtbxGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1.ErrorMessage" SetFocusOnError="True" />
															<asp:RangeValidator ID="rvtbxGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvtbxGalleryHeight.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgEditArticle" CssClass="smallInfo warning"></asp:RangeValidator>
														</td>
													</tr>
													<tr id="trChameleonResponsiveMainImageWidth" runat="server">
														<td class="left">
															<label for="<%=tbxChameleonResponsiveMainImageWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonResponsiveMainImageWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonResponsiveMainImageWidth.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbxChameleonResponsiveMainImageWidth" runat="server" CssClass="smallCentered" Text="600" />
															<asp:Label ID="lblChameleonResponsiveMainImageWidthPX" runat="server" Text="px" />
															<asp:RequiredFieldValidator ID="rfvtbxChameleonResponsiveMainImageWidth" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageWidth" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvRhumbImageWidth1Resource1.ErrorMessage"
																SetFocusOnError="True" ValidationGroup="vgEditArticle" />
															<asp:CompareValidator ID="cvChameleonResponsiveMainImageWidth" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1.ErrorMessage"
																Type="Integer" ValidationGroup="vgTGSettings" SetFocusOnError="True" />
														</td>
													</tr>
													<tr id="trChameleonResponsiveMainImageHeight" runat="server">
														<td class="left">
															<label for="<%=tbxChameleonResponsiveMainImageHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonResponsiveMainImageHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonResponsiveMainImageHeight.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbxChameleonResponsiveMainImageHeight" runat="server" CssClass="smallCentered">500</asp:TextBox>
															<asp:Label ID="lblChameleonResponsiveMainImageHeightPX" runat="server" Text="px" />
															<asp:RequiredFieldValidator ID="rfvtbxChameleonResponsiveMainImageHeight" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageHeight" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvtbxChameleonResponsiveMainImageHeight.ErrorMessage"
																SetFocusOnError="True" ValidationGroup="vgEditArticle" />
															<asp:CompareValidator ID="cvChameleonResponsiveMainImageHeight" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvChameleonResponsiveMainImageHeight.ErrorMessage"
																Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbChameleonJpegQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbChameleonJpegQuality.Help", true) %>" data-tooltip-position="top-right"><%=_("lbChameleonJpegQuality.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbChameleonJpegQuality" runat="server" CssClass="smallCentered">97</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvChameleonJpegQuality" runat="server" ControlToValidate="tbChameleonJpegQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgEditArticle" resourcekey="rfvChameleonJpegQuality.ErrorMessage" />
															<asp:RangeValidator ID="rvChameleonJpegQuality" runat="server" ControlToValidate="tbChameleonJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="rvChameleonJpegQuality.ErrorMessage" />
														</td>
													</tr>
													<tr>
														<td class="left textTop">
															<label for="<%=rblChameleonResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonResizeMethod.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonResizeMethod.Text") %></label>
														</td>
														<td class="right">
															<div class="edNews_inputGroup">
																<asp:RadioButtonList ID="rblChameleonResizeMethod" CssClass="styledRadio verticalList smallRadio" runat="server" RepeatLayout="UnorderedList">
																	<asp:ListItem resourcekey="liCrop" class="normalRadioButton" Selected="True" Value="Crop">Resize and crop</asp:ListItem>
																	<asp:ListItem resourcekey="liPropotional" class="normalRadioButton" Value="Proportional">Proportional resize</asp:ListItem>
																	<asp:ListItem resourcekey="liCropAndPropotional" class="normalRadioButton" Value="CropHorizontalProportionalVertical">Resize and crop horizontal, proportionally resize vertical images</asp:ListItem>
																</asp:RadioButtonList>
															</div>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlChameleonLayout.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonLayout.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonLayout.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlChameleonLayout" runat="server"></asp:DropDownList>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlChameleonGalleryThemeSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonLayoutTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonLayoutTheme.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlChameleonGalleryThemeSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryThemeSelect_SelectedIndexChanged"></asp:DropDownList>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlChameleonGalleryThemeSelectStyling.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonLayoutThemeStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonLayoutThemeStyle.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlChameleonGalleryThemeSelectStyling" runat="server"></asp:DropDownList>
														</td>
													</tr>
													<tr runat="server" id="trChameleonShowLinkToGravityGallery" visible="false">
														<td class="left">
															<label for="<%=cbChameleonOpenDetailsInGravityGallery.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonOpenDetailsInGravityGallery.Help", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonOpenDetailsInGravityGallery.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbChameleonOpenDetailsInGravityGallery" Text="Open media details in Gravity gallery" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonOpenDetailsInGravityGallery_CheckedChanged" />
															</div>
														</td>
													</tr>
													<tr runat="server" id="trChameleonGravityGalleryInstances" visible="false">
														<td class="left">
															<label for="<%=ddlChameleonGravityGalleryInstances.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonGravityGalleryInstances.Help", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonGravityGalleryInstances.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlChameleonGravityGalleryInstances" runat="server">
																<asp:ListItem Value="0" resourcekey="liSelectGravityGalleryModuleInstance">Select Gravity gallery module instance</asp:ListItem>
															</asp:DropDownList>
															<asp:RequiredFieldValidator ID="rfvChameleonGravityGalleryInstances" runat="server" ErrorMessage="You must select Gravity gallery module" ControlToValidate="ddlChameleonGravityGalleryInstances" InitialValue="0" ValidationGroup="vgEditArticle" Display="Dynamic" SetFocusOnError="True" Enabled="False" />
														</td>
													</tr>
												</table>
											</asp:Panel>
											<asp:Panel ID="pnlLightboxGallery" runat="server">
												<table class="settings_table">
													<tr>
														<td class="left">
															<label for="<%=ddlGalleryTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIGalleryTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIGalleryTheme.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlGalleryTheme" runat="server" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbGIThumbnailWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIThumbWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIThumbWidth.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGIThumbnailWidth" runat="server" CssClass="smallCentered" Text="100" />
															<asp:RequiredFieldValidator ID="rfvGIThumbanilWidth" runat="server" ControlToValidate="tbGIThumbnailWidth" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvGIThumbanilWidthResource1" SetFocusOnError="True" ValidationGroup="vgEditArticle" />
															<asp:CompareValidator ID="cvGIThumbnailWidth" runat="server" ControlToValidate="tbGIThumbnailWidth" ErrorMessage="Please enter number." Operator="DataTypeCheck" resourcekey="cvGIThumbnailWidthResource1" Type="Integer" ValidationGroup="vgEditArticle"></asp:CompareValidator>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbGIThumbnailHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIThumbHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIThumbHeight.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGIThumbnailHeight" runat="server" CssClass="smallCentered" Text="100" />
															<asp:RequiredFieldValidator ID="rfvGIThumbanilHeight" runat="server" ControlToValidate="tbGIThumbnailHeight" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgEditArticle" resourcekey="rfvGIThumbanilHeightResource1" />
															<asp:CompareValidator ID="cvGIThumbnailHeight" runat="server" ControlToValidate="tbGIThumbnailHeight" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="cvGIThumbnailHeightResource1"></asp:CompareValidator>
														</td>
													</tr>
													<tr runat="server" id="trGIJpegQuality">
														<td class="left">
															<label for="<%=tbGIJpegQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbGIJpegQuality.Help", true) %>" data-tooltip-position="top-right"><%=_("lbGIJpegQuality.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGIJpegQuality" runat="server" CssClass="smallCentered">97</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvGIJpegQuality" runat="server" ControlToValidate="tbGIJpegQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgEditArticle" resourcekey="rfvGIJpegQuality.ErrorMessage" />
															<asp:RangeValidator ID="rvGIJpegQuality" runat="server" ControlToValidate="tbGIJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="rvGIJpegQuality.ErrorMessage" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbGIItemsPerPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIItemsPerPage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIItemsPerPage.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGIItemsPerPage" runat="server" CssClass="smallCentered" resourcekey="tbGIItemsPerPageResource1" Text="4" />
															<asp:RequiredFieldValidator ID="rfvGIItemsPerPage" runat="server" ControlToValidate="tbGIItemsPerPage" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgEditArticle" resourcekey="rfvGIItemsPerPageResource1" />
															<asp:CompareValidator ID="cvGINumber" runat="server" ControlToValidate="tbGIItemsPerPage" ErrorMessage="Please enter number." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="cvGINumberResource1"></asp:CompareValidator>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbNumberOfColumns.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGINumberOfColumns.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGINumberOfColumns.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbNumberOfColumns" runat="server" resourcekey="tbNumberOfColumnsResource1" CssClass="smallCentered" Text="4" />
															<asp:RequiredFieldValidator ID="rfvGIItemsPerPage0" runat="server" ControlToValidate="tbNumberOfColumns" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvGIItemsPerPage0Resource1" SetFocusOnError="True" ValidationGroup="vgEditArticle" />
															<asp:CompareValidator ID="cvGINumber0" runat="server" ControlToValidate="tbNumberOfColumns" ErrorMessage="Please enter number." Operator="DataTypeCheck" resourcekey="cvGINumber0Resource1" Type="Integer" ValidationGroup="vgEditArticle"></asp:CompareValidator>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=rblLightboxGalleryResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLightboxGalleryResizeMethod.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLightboxGalleryResizeMethod.Text") %></label>
														</td>
														<td class="right">
															<div class="edNews_inputGroup">
																<asp:RadioButtonList ID="rblLightboxGalleryResizeMethod" CssClass="styledRadio inlineList smallRadio" runat="server" AutoPostBack="False" RepeatLayout="UnorderedList">
																	<asp:ListItem resourcekey="liCrop" class="normalRadioButton" Selected="True" Value="Crop">Resize and crop</asp:ListItem>
																	<asp:ListItem resourcekey="liPropotional" class="normalRadioButton" Value="Proportional">Proportional resize</asp:ListItem>
																</asp:RadioButtonList>
															</div>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=cbGIDisplayItemTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemTitle.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" Text="Display item title" ID="cbGIDisplayItemTitle" runat="server" />
															</div>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=cbGIDisplayItemDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemDescription.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" Text="Display item description" ID="cbGIDisplayItemDescription" runat="server" />
															</div>
														</td>
													</tr>
													<tr id="rowOldGalleryTitleLightbox" runat="server">
														<td class="left">
															<label for="<%=cbGIDisplayItemTitleLightBox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemTitleLightBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemTitleLightBox.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" Text="Display item title in Lightbox" ID="cbGIDisplayItemTitleLightBox" runat="server" />
															</div>
														</td>
													</tr>
													<tr id="rowOldGalleryDescriptionLightbox" runat="server">
														<td class="left">
															<label for="<%=cbGIDisplayItemDescriptionLightBox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemDescriptionLightBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemDescriptionLightBox.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbGIDisplayItemDescriptionLightBox" Text="Display item description in Lightbox" runat="server" />
															</div>
														</td>
													</tr>
												</table>
											</asp:Panel>
											<asp:Panel ID="pnlGravityGallerySettings" runat="server">
												<table class="settings_table">
													<tr>
														<td class="left">
															<label for="<%=tbGravityGalleryThumbnailWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryThumbnailWidth.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryThumbnailWidth.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGravityGalleryThumbnailWidth" runat="server" CssClass="smallCentered">160</asp:TextBox>
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=tbGravityGalleryThumbnailHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryThumbnailHeight.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryThumbnailHeight.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGravityGalleryThumbnailHeight" runat="server" CssClass="smallCentered">130</asp:TextBox>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=tbGravityGalleryItemsPerPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryItemsPerPage.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryItemsPerPage.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGravityGalleryItemsPerPage" runat="server" CssClass="smallCentered" Text="12" />
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=tbGravityGalleryJpegQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbGravityGalleryJpegQuality.Help", true) %>" data-tooltip-position="top-right"><%=_("lbGravityGalleryJpegQuality.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbGravityGalleryJpegQuality" runat="server" CssClass="smallCentered">97</asp:TextBox>
															<asp:RequiredFieldValidator ID="rfvGravityGalleryJpegQuality" runat="server" ControlToValidate="tbGravityGalleryJpegQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgEditArticle" resourcekey="rfvGravityGalleryJpegQuality.ErrorMessage" />
															<asp:RangeValidator ID="rvGravityGalleryJpegQuality" runat="server" ControlToValidate="tbGravityGalleryJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgEditArticle" resourcekey="rvGravityGalleryJpegQuality.ErrorMessage" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=cbGravityGalleryEnablePagination.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryEnablePagination.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryEnablePagination.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryEnablePagination" Text="Enable pagination" runat="server" Checked="True" />
															</div>
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=rblGravityGalleryResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryResizeMethod.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryResizeMethod.Text") %></label>
														</td>
														<td class="right">
															<div class="edNews_inputGroup">
																<asp:RadioButtonList ID="rblGravityGalleryResizeMethod" CssClass="styledRadio inlineList smallRadio" runat="server" AutoPostBack="False" RepeatLayout="UnorderedList">
																	<asp:ListItem Selected="True" class="normalRadioButton" Value="1" resourcekey="liResizeAndCrop">Resize and crop</asp:ListItem>
																	<asp:ListItem Value="2" class="normalRadioButton" resourcekey="liProportionalResize">Proportional resize</asp:ListItem>
																</asp:RadioButtonList>
															</div>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=cbGravityGalleryDisplayTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryDisplayTitle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryDisplayTitle.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayTitle" Text="Display item title" runat="server" />
															</div>
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=cbGravityGalleryDisplayDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryDisplayDescription.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryDisplayDescription.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayDescription" Text="Display item description" runat="server" />
															</div>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=cbGravityGalleryDisplayTitleInLightbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryDisplayTitleInLightbox.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryDisplayTitleInLightbox.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayTitleInLightbox" Text="Display item title in Lightbox" runat="server" />
															</div>
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=cbGravityGalleryDisplayDescriptionInLightbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryDisplayDescriptionInLightbox.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryDisplayDescriptionInLightbox.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayDescriptionInLightbox" Text="Display item description in Lightbox" runat="server" />
															</div>
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=cbShowLinkToGravityGallery.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowLinkToGravityGallery.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowLinkToGravityGallery.Text") %></label>
														</td>
														<td class="right">
															<div class="styledCheckbox noLabel">
																<asp:CheckBox CssClass="normalCheckBox" ID="cbShowLinkToGravityGallery" Text="Show link to Gravity gallery" runat="server" AutoPostBack="True" OnCheckedChanged="cbShowLinkToGravityGallery_CheckedChanged" />
															</div>
														</td>
													</tr>
													<tr runat="server" id="trGravityGalleryInstances" visible="false">
														<td class="left">
															<label for="<%=ddlGravityGalleryInstances.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbllGravityGalleryInstances.Help", true) %>" data-tooltip-position="top-right"><%=_("lbllGravityGalleryInstances.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlGravityGalleryInstances" runat="server">
																<asp:ListItem Value="0" resourcekey="liSelectGravityGalleryModuleInstance">Select Gravity gallery module instance</asp:ListItem>
															</asp:DropDownList>
															<asp:RequiredFieldValidator ID="rfvGravityGalleryInstances" runat="server" ErrorMessage="You must select Gravity gallery module" ControlToValidate="ddlGravityGalleryInstances" InitialValue="0" ValidationGroup="vgEditArticle" Display="Dynamic" SetFocusOnError="True" Enabled="False" />
														</td>
													</tr>
												</table>
											</asp:Panel>
										</asp:Panel>
									</asp:Panel>
								</div>
							</asp:Panel>
							<div class="section_box tabbed gallery_panel">
								<h1 class="section_box_title edNews_tooltip" data-tooltip-content="<%=_("galleryPanelTooltip.Text", true) %>" data-tooltip-position="top-left">
									<span><%=GalleryPanel%></span>
								</h1>
								<ul class="tabs">
									<li>
										<asp:LinkButton ID="lbArticleGalleryImages" runat="server" CssClass="btnArticleimages" OnClick="lbArticleGallery_Click" resourcekey="lbArticleGalleryImagesResource1">ARTICLE<span class="blue dot"></span></asp:LinkButton></li>
									<li>
										<asp:LinkButton ID="lbSharedArticleGalleryImages" runat="server" CssClass="btnArticleimages" OnClick="lbSharedArticleGallery_Click" resourcekey="lbSharedArticleGalleryImagesResource1">SHARED</asp:LinkButton></li>
									<li>
										<asp:LinkButton ID="lbCustomGallery" runat="server" CssClass="btnArticleimages" OnClick="lbCustomGallery_Click" resourcekey="lbCustomGalleryResource1">CUSTOM<span class="yellow dot"></span></asp:LinkButton></li>
								</ul>
								<div class="content tabbed">
									<asp:Panel ID="pnlCustomIntegrationAndUpload" runat="server" Visible="false">
										<div class="edg_gallery_selection_container">
											<div class="category_and_gallery_selection">
												<div class="category selection">
													<asp:Label ID="lblCategorySelect" runat="server" Text="Select category:" resourcekey="lblCategorySelectResource1" />
													<asp:DropDownList ID="ddlCategories" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="CategoryName" DataValueField="CategoryID" OnDataBound="ddlCategories_DataBound" OnSelectedIndexChanged="ddlCategories_SelectedIndexChanged">
														<asp:ListItem Value="0" resourcekey="ListItemResource18">Select category</asp:ListItem>
													</asp:DropDownList>
												</div>
												<div class="gallery selection">
													<asp:Label ID="lblGallerySelect" runat="server" Text="Select gallery: " resourcekey="lblGallerySelectResource1" />
													<asp:DropDownList ID="ddlGaleries" runat="server" AppendDataBoundItems="True" AutoPostBack="True" DataTextField="GalleryName" DataValueField="GalleryID" OnDataBound="ddlGaleries_DataBound" OnSelectedIndexChanged="ddlGaleries_SelectedIndexChanged">
														<asp:ListItem Value="-2" resourcekey="ListItemResource19">Select gallery</asp:ListItem>
													</asp:DropDownList>
												</div>
												<asp:LinkButton ID="btnRefrehsData" runat="server" CssClass="refresh" OnClick="btnRefrehsData_Click" resourcekey="btnRefrehsDataResource1" />
											</div>
											<div class="mainActions floatLeft" style="margin: 7px 0 0 30px;">
												<asp:LinkButton ID="btnIntegGallery" runat="server" CssClass="add" OnClick="btnIntegGallery_Click" Text="Add gallery to article" resourcekey="btnIntegGalleryResource1" />
											</div>
										</div>
										<asp:Panel ID="pnlGalleryMediaUpload" runat="server" Visible="false">
											<div class="edNews_inputGroup textCenter">
												<asp:RadioButtonList ID="rblCustomGalleryUploadType" CssClass="styledRadio inlineList" runat="server" RepeatLayout="UnorderedList" AutoPostBack="True" OnSelectedIndexChanged="rblCustomGalleryUploadType_SelectedIndexChanged">
													<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liUpload" Selected="True">Upload</asp:ListItem>
													<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liServer">Add from server</asp:ListItem>
												</asp:RadioButtonList>
											</div>
											<asp:Panel ID="pnlCustomGalleryUploadImages" runat="server">
												<div id="galleryUploadifyContainer" class="uploadify_container" runat="server">
													<div style="display: block; float: left; margin-left: 30px;">
														<asp:FileUpload ID="GalfileInput" runat="server" resourcekey="GalfileInputResource1" />
													</div>
													<div style="display: block; float: left; margin-left: 15px;">
														<a class="start_upload" href="javascript:$('#<%=GalfileInput.ClientID%>').uploadifySettings('scriptData', { 'galleryId': '<%=ddlGaleries.SelectedValue%>','resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});$('#<%=GalfileInput.ClientID%>').uploadifyUpload();">
															<%=StartUpload%></a>
													</div>
												</div>
												<div id="galleryFineUploaderContainer" class="EDS_simpleFineUploader galleryFineUploader" visible="false" runat="server">
													<div class="uploader">
													</div>
													<div class="uploadControls">
														<div class="infomsg"><%=_("DragAndDropImagesHereOrClickOnSelectImagesButton.Text") %></div>
														<div class="actions">
															<span class="action fileSelection">
																<asp:Label ID="galleryFineUploaderSelectFiles" runat="server" resourcekey="fineUploaderSelectFiles" Text="Select images" />
																<span class="dnnInputFileWrapper">
																	<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
																		<asp:Label ID="galleryFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
																	</span>
														</div>
														<div class="dndContainer">
															<p>
																<asp:Label ID="galleryFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
															</p>
														</div>
													</div>
													<div class="uploadDetails">
														<ol class="fileUploadList">
														</ol>
													</div>
												</div>
											</asp:Panel>
											<asp:Panel ID="pnlCustomGalleryAddImagesFromServer" class="EDS_simpleFineUploader" runat="server" Visible="False">
												<div class="edNews_inputGroup labelBlock inputWidth40 uploadControls textCenter">
													<Portal:URL ID="urlAddCustomGalleryImagesFromServer" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="true" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="F" FileFilter="jpg,jpeg,png,gif" />
													<asp:Label ID="lblAddCustomGalleryImagesFromServerMessage" runat="server" EnableViewState="false" Visible="False" />
													<asp:LinkButton runat="server" ID="lbAddCustomGalleryImageFromServer" resourcekey="lbAddCustomGalleryImageFromServer" CssClass="addfromserver" OnClick="lbAddCustomGalleryImageFromServer_Click">Add image</asp:LinkButton>
												</div>
											</asp:Panel>
											<div class="add_video_by_url">
												<p>
													<asp:Label runat="server" resourcekey="addVideoFromYouTube" Text="Add video from YouTube or Vimeo:" ID="lblCustomAddEmbedToGallery" />
													<asp:TextBox runat="server" ID="tbCustomEmbedVideoURL" ValidationGroup="vgCustomAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" />
													<asp:LinkButton runat="server" ID="lbCustomAddEmedVideoToGallery" resourcekey="lbCustomAddEmedVideoToGallery" CssClass="add_video" ValidationGroup="vgCustomAddEmbedVideo" OnClick="lbCustomAddEmedVideoToGallery_Click">Add video</asp:LinkButton>
												</p>
												<p class="validators">
													<asp:CustomValidator ID="cvCustomAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgCustomAddEmbedVideo" ControlToValidate="tbCustomEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
													<asp:RequiredFieldValidator ID="rfvCustomAddEmbedVideoURL" runat="server" ControlToValidate="tbCustomEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgCustomAddEmbedVideo"></asp:RequiredFieldValidator>
												</p>
											</div>
										</asp:Panel>
									</asp:Panel>
									<asp:Panel ID="pnlArticleGalleryUpload" runat="server" Visible="false">
										<asp:Panel ID="pnlEmptyGallery" runat="server" CssClass="info_box attention add_gallery">
											<asp:LinkButton ID="ibAddImages" runat="server" OnClick="ibAddImages_Click" CssClass="action add_gallery" ValidationGroup="vgCreateGallery" resourcekey="ibAddImagesResource1">Add gallery</asp:LinkButton>
											<p>
												<%=Thegalleryisempty %>
											</p>
										</asp:Panel>
										<asp:Panel ID="pnlYouCanNotAddMedia" runat="server" CssClass="info_box attention add_gallery" Visible="False">
											<asp:Label ID="lblYouCanNotAddMedia" resourcekey="lblYouCanNotAddMedia" runat="server" />
										</asp:Panel>
										<asp:Panel ID="pnlArticleGalleryAddMedia" runat="server">
											<asp:Panel ID="pnlDisplayArticleGallery" runat="server" CssClass="info_box warning add_gallery">
												<asp:LinkButton ID="ibDisplayArticleGallery" runat="server" OnClick="lbDisplayArticleGallery_Click" CssClass="action add_gallery" resourcekey="ibDisplayArticleGalleryResource1">Display this gallery</asp:LinkButton>
												<p>
													<%=NotWithArticle %>
												</p>
											</asp:Panel>
											<asp:Panel ID="pnlRemoveArticleGallery" runat="server" CssClass="info_box attention add_gallery" Visible="false">
												<asp:LinkButton ID="lbRemoveDisplayArticleGallery" runat="server" CssClass="action remove_btn" OnClick="lbRemoveDisplayArticleGallery_Click" resourcekey="lbRemoveDisplayArticleGalleryResource1">Do not display gallery</asp:LinkButton>
												<p>
													<%=GalleryWithArticle%>
												</p>
											</asp:Panel>
											<asp:Panel ID="pnlArticleGalleryImageUpload" runat="server">
												<div class="edNews_inputGroup textCenter" style="margin-top: 20px;">
													<asp:RadioButtonList ID="rblArticleGalleryUploadType" CssClass="styledRadio inlineList" runat="server" RepeatLayout="UnorderedList" OnSelectedIndexChanged="rblArticleGalleryUploadType_SelectedIndexChanged" AutoPostBack="True">
														<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liUpload" Selected="True">Upload</asp:ListItem>
														<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liServer">Add from server</asp:ListItem>
													</asp:RadioButtonList>
												</div>
												<asp:Panel ID="pnlArticleGalleryUploadImages" runat="server">
													<div id="articleUploadifyContainer" class="uploadify_container" runat="server">
														<div style="display: block; float: left; margin-left: 30px;">
															<asp:FileUpload ID="fileInput" runat="server" resourcekey="fileInputResource2" />
														</div>
														<div style="display: block; float: left; margin-left: 15px;">
															<a class="start_upload" href="javascript:$('#<%=fileInput.ClientID%>').uploadifySettings('scriptData', {'resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});$('#<%=fileInput.ClientID%>').uploadifyUpload();">
																<%=StartUpload %></a>
														</div>
													</div>
													<div id="articleFineUploaderContainer" class="EDS_simpleFineUploader galleryFineUploader" visible="false" runat="server">
														<div class="uploader">
														</div>
														<div class="uploadControls">
															<div class="infomsg"><%=_("DragAndDropImagesHereOrClickOnSelectImagesButton.Text") %></div>
															<div class="actions">
																<span class="action fileSelection">
																	<asp:Label ID="lblArticleFineUploaderSelectFiles" runat="server" resourcekey="fineUploaderSelectFiles" Text="Select images" />
																	<span class="dnnInputFileWrapper">
																		<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
																			<asp:Label ID="lblArticleFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
																		</span>
															</div>
															<div class="dndContainer">
																<p>
																	<asp:Label ID="lblArticleFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
																</p>
															</div>
														</div>
														<div class="uploadDetails">
															<ol class="fileUploadList">
															</ol>
														</div>
													</div>
												</asp:Panel>
												<asp:Panel ID="pnlArticleGalleryAddImagesFromServer" class="EDS_simpleFineUploader" runat="server" Visible="False">
													<div class="edNews_inputGroup labelBlock inputWidth40 uploadControls textCenter">
														<Portal:URL ID="urlAddGalleryImagesFromServer" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="true" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="F" FileFilter="jpg,jpeg,png,gif" />
														<asp:Label ID="lblAddGalleryImagesFromServerMessage" runat="server" EnableViewState="false" Visible="False" />
														<asp:LinkButton runat="server" ID="lbAddGalleryImageFromServer" resourcekey="lbAddGalleryImageFromServer" OnClick="lbAddGalleryImageFromServer_Click" CssClass="addfromserver">Add image</asp:LinkButton>
													</div>
												</asp:Panel>
											</asp:Panel>
											<div class="uploadify_container" runat="server" id="divYouCanNotUploadMoreImages" visible="false">
												<asp:Label ID="lblYouCanNotUploadMoreImages" runat="server" />
											</div>
											<asp:Panel runat="server" ID="pnlArticleGalleryAddVideo">
												<div class="add_video_by_url">
													<p>
														<asp:Label runat="server" resourcekey="addVideoFromYouTube" Text="Add video from YouTube, Vimeo or Wistia:" ID="lblAddEmbedToGallery" />
														<asp:TextBox runat="server" ID="tbEmbedVideoURL" ValidationGroup="vgAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" />
														<asp:LinkButton runat="server" ID="lbAddEmedVideoToGallery" resourcekey="lbAddEmedVideoToGallery" ValidationGroup="vgAddEmbedVideo" OnClick="lbAddEmedVideoToGallery_Click" CssClass="add_video">Add video</asp:LinkButton>
													</p>
													<p class="validators">
														<asp:CustomValidator ID="cvMainGalleryAddEmbedVideo" runat="server" resourcekey="cvMainGalleryAddEmbedVideo.ErrorMessage" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgAddEmbedVideo" ControlToValidate="tbEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
														<asp:RequiredFieldValidator ID="rfvAddEmbedVideoURL" runat="server" resourcekey="rfvAddEmbedVideoURL.ErrorMessage" ControlToValidate="tbEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgAddEmbedVideo"></asp:RequiredFieldValidator>
													</p>
												</div>
												<div runat="server" id="divUploadToWistiaService" class="add_video_by_url" visible="False">
													<p>
														<asp:Label runat="server" Text="Upload video to Wistia service:" ID="lblUploadToWistiaService" resourcekey="lblUploadToWistiaService" />
														<asp:FileUpload ID="fuWistiaVideoFileInput" runat="server" EnableTheming="True" />
														<asp:Button ID="btnWistiaSingleUpload" runat="server" resourcekey="btnWistiaSingleUpload" Text="Upload" OnClick="btnWistiaSingleUpload_Click" />
													</p>
													<p class="validators">
														<asp:Label ID="lblWistiaSingleUploadMessage" runat="server" EnableViewState="False"></asp:Label>
													</p>
												</div>
												<div runat="server" id="divUploadToVimeoService" class="add_video_by_url" visible="False">
													<p>
														<asp:Label runat="server" Text="Upload video to Vimeo service:" ID="lblUploadToVimeoService" resourcekey="lblUploadToVimeoService" />
														<asp:FileUpload ID="fuVimeoVideoFileInput" runat="server" EnableTheming="True" />
														<asp:Button ID="btnVimeoSingleUpload" resourcekey="btnVimeoSingleUpload" runat="server" Text="Upload" OnClick="btnVimeoSingleUpload_Click" />
													</p>
													<p class="validators">
														<asp:Label ID="lblVimeoSingleUploadMessage" runat="server" EnableViewState="False"></asp:Label>
													</p>
												</div>
											</asp:Panel>
											<div class="uploadify_container" runat="server" id="divYouCanNotAddMoreVideos" visible="false">
												<asp:Label ID="lblYouCanNotAddMoreVideos" runat="server" />
											</div>
										</asp:Panel>
									</asp:Panel>
									<asp:Panel ID="pnlSharedGalleryUpload" runat="server" Visible="false">
										<div class="edNews_inputGroup textCenter" style="margin-top: 20px">
											<asp:RadioButtonList ID="rblSharedGalleryUploadType" CssClass="styledRadio inlineList" runat="server" RepeatLayout="UnorderedList" AutoPostBack="True" OnSelectedIndexChanged="rblSharedGalleryUploadType_SelectedIndexChanged">
												<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liUpload" Selected="True">Upload</asp:ListItem>
												<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liServer">Add from server</asp:ListItem>
											</asp:RadioButtonList>
										</div>
										<asp:Panel ID="pnlSharedGalleryUploadImages" runat="server">
											<div id="sharedUploadifyContainer" class="uploadify_container" runat="server">
												<div style="display: block; float: left; margin-left: 30px;">
													<asp:FileUpload ID="SharedfileInput" runat="server" />
												</div>
												<div style="display: block; float: left; margin-left: 15px;">
													<a class="start_upload" href="javascript:$('#<%=SharedfileInput.ClientID%>').uploadifySettings('scriptData', {'resize':document.getElementById('<%=hfResize.ClientID%>').value, 'width': document.getElementById('<%=hfResizeWidth.ClientID%>').value,'height':document.getElementById('<%=hfResizeHeight.ClientID%>').value});$('#<%=SharedfileInput.ClientID%>').uploadifyUpload();">
														<%=StartUpload %></a>
												</div>
											</div>
											<div id="sharedFineUploaderContainer" class="EDS_simpleFineUploader galleryFineUploader" visible="false" runat="server">
												<div class="uploader">
												</div>
												<div class="uploadControls">
													<div class="infomsg"><%=_("DragAndDropImagesHereOrClickOnSelectImagesButton.Text") %></div>
													<div class="actions">
														<span class="action fileSelection">
															<asp:Label ID="sharedFineUploaderSelectFiles" runat="server" resourcekey="fineUploaderSelectFiles" Text="Select images" />
															<span class="dnnInputFileWrapper">
																<input type="file" value="" multiple="multiple" /></span> </span><span class="action upload">
																	<asp:Label ID="sharedFineUploaderStartUpload" runat="server" resourcekey="fineUploaderStartUpload" Text="Start upload" />
																</span>
													</div>
													<div class="dndContainer">
														<p>
															<asp:Label ID="sharedFineUploaderDragImagesHere" runat="server" resourcekey="fineUploaderDragImagesHere" Text="Drag images here" />
														</p>
													</div>
												</div>
												<div class="uploadDetails">
													<ol class="fileUploadList">
													</ol>
												</div>
											</div>
										</asp:Panel>
										<asp:Panel ID="pnlSharedGalleryAddImagesFromServer" class="EDS_simpleFineUploader" runat="server" Visible="False">
											<div class="edNews_inputGroup labelBlock inputWidth40 uploadControls textCenter">
												<Portal:URL ID="urlAddSharedGalleryImagesFromServer" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="true" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="F" FileFilter="jpg,jpeg,png,gif" />
												<asp:Label ID="lblAddSharedGalleryImagesFromServerMessage" runat="server" EnableViewState="false" Visible="False" />
												<asp:LinkButton runat="server" ID="lbSharedAddGalleryImageFromServer" resourcekey="lbSharedAddGalleryImageFromServer" CssClass="addfromserver" OnClick="lbSharedAddGalleryImageFromServer_Click">Add image</asp:LinkButton>
											</div>
										</asp:Panel>
										<div class="add_video_by_url">
											<p>
												<asp:Label runat="server" resourcekey="addVideoFromYouTube" Text="Add a video from YouTube or Vimeo:" ID="lblSharedAddEmbedToGallery" />
												<asp:TextBox runat="server" ID="tbSharedEmbedVideoURL" ValidationGroup="vgSharedAddEmbedVideo" onblur="if(this.value=='') {this.value=this.defaultValue;}" onfocus="if(this.defaultValue==this.value) {this.value = '';}" />
												<asp:LinkButton runat="server" ID="lbSharedAddEmedVideoToGallery" resourceky="lbSharedAddEmedVideoToGallery" ValidationGroup="vgSharedAddEmbedVideo" OnClick="lbSharedAddEmedVideoToGallery_Click" CssClass="add_video">Add video</asp:LinkButton>
											</p>
											<p class="validators">
												<asp:CustomValidator ID="cvSharedAddEmbedVideo" runat="server" ClientValidationFunction="ClientValidateEmbedURL" Display="Dynamic" ErrorMessage="Invalid URL." ValidationGroup="vgSharedAddEmbedVideo" ControlToValidate="tbSharedEmbedVideoURL" SetFocusOnError="True"></asp:CustomValidator>
												<asp:RequiredFieldValidator ID="rfvSharedAddEmbedVideoURL" runat="server" ControlToValidate="tbSharedEmbedVideoURL" Display="Dynamic" ErrorMessage="Please enter valid URL." SetFocusOnError="True" ValidationGroup="vgSharedAddEmbedVideo"></asp:RequiredFieldValidator>
											</p>
										</div>
									</asp:Panel>
									<asp:Button ID="galleryUploadComplete" runat="server" OnClick="galleryUploadComplete_Click" Text="Button" Style="display: none;" />
								</div>
							</div>
							<div class="section_box no_top_margin">
								<div class="content grey">
									<div class="gallery_items_container">
										<asp:GridView ID="gvArticleMediaList" runat="server" AllowPaging="True" AutoGenerateColumns="false" Border="0" CellPadding="0" CssClass="gallery_items_table" DataKeyNames="PictureID" EnableModelValidation="True" HorizontalAlign="Center" OnDataBound="gvArticleMediaList_DataBound" OnRowCommand="gvArticleMediaList_RowCommand" OnRowDeleted="gvArticleMediaList_RowDeleted" OnRowDeleting="gvArticleMediaList_RowDeleting" ShowFooter="False" GridLines="None">
											<AlternatingRowStyle CssClass="main_row second" />
											<Columns>
												<asp:TemplateField HeaderText="Media list" SortExpression="Position">
													<EditItemTemplate>
														<table cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td class="action">
																	<asp:LinkButton ID="lbMediaUpdate" runat="server" CommandName="Update" CssClass="action_btn update" resourcekey="LinkButton5Resource1"></asp:LinkButton>
																	<asp:LinkButton ID="lbMediaCancelUpdate" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton6Resource1"></asp:LinkButton>
																</td>
																<td class="edit_fields">
																	<asp:TextBox ID="tbEditMediaTitle" runat="server" Text='<%# Bind("Title") %>' />
																</td>
																<td class="edit_fields">
																	<asp:TextBox ID="tbEditMediaDescription" runat="server" Text='<%# Bind("Description") %>' TextMode="MultiLine" />
																</td>
															</tr>
														</table>
													</EditItemTemplate>
													<HeaderTemplate>
														<table cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td class="header_field action">
																	<%=Action %>
																</td>
																<td class="header_field image"></td>
																<td class="header_field title">
																	<%=Title%>
																</td>
																<td class="header_field description">
																	<%=Description %>
																</td>
																<td class="header_field" style="width: 90px;"></td>
															</tr>
														</table>
													</HeaderTemplate>
													<ItemTemplate>
														<table cellpadding="0" cellspacing="0" width="100%">
															<tr>
																<td class="action">
																	<asp:LinkButton ID="lbSetArticleImageArtGallery" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="SetArticleImage" CssClass="action_btn article_img" resourcekey="lbSetArticleImageArtGalleryResource1">Set as main article image</asp:LinkButton>
																	<asp:LinkButton ID="lbEditImage" runat="server" CausesValidation="false" CommandName="Edit" CssClass="action_btn edit" resourcekey="LinkButton3Resource1" Visible='<%#!EditingSharedCustomGallery%>'></asp:LinkButton>
																	<asp:LinkButton ID="lbDeleteImage" runat="server" CausesValidation="false" CommandName="Delete" CssClass="action_btn delete" OnClientClick="return confirm('Are you sure you want to delete this image?');" resourcekey="LinkButton4Resource1" Visible='<%#!EditingSharedCustomGallery%>'></asp:LinkButton>
																	<asp:LinkButton ID="lbLocalizeimage" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="LocalizeImage" CssClass="image_localization" resourcekey="lbLocalizeimageResource1" Visible='<%# LocalizationEnabled && !IS_ARTICLE_REVISION%>'>Localize content</asp:LinkButton>
																</td>
																<td class="image">
																	<div class="wrapper">
																		<a href='<%#Eval("MediaType").ToString()=="Image"?Eval("FileName").ToString():"#"%>' target="_blank">
																			<asp:Image ID="imgImageThumbnail" runat="server" ImageUrl='<%#FixImageUrl(Eval("ThumbUrl").ToString())%>' />
																		</a>
																	</div>
																</td>
																<td class="title">
																	<asp:Label ID="lblImageTitle" runat="server" Text='<%# Bind("Title") %>' />
																</td>
																<td class="description">
																	<asp:Label ID="lblImageDescription" runat="server" Text='<%# Bind("Description") %>' />
																</td>
																<td class="position_show_type" style="width: 90px;">
																	<div class="action_box" style='<%=!EditingSharedCustomGallery?"": "display:none"%>'>
																		<div class="action_wrapper">
																			<asp:ImageButton ID="imbMediaUp" runat="server" CausesValidation="false" CommandArgument='<%# Eval("PictureID") %>' CommandName="Up" CssClass="position_btn up" ImageUrl="~/DesktopModules/EasyDNNnews/images/icons/arrow_up_green.png" />
																			<asp:ImageButton ID="imbMediaDown" runat="server" CausesValidation="false" CommandArgument='<%# Eval("PictureID") %>' CommandName="Down" CssClass="position_btn down" ImageUrl="~/DesktopModules/EasyDNNnews/images/icons/arrow_down_orange.png" />
																		</div>
																		<span class="text">
																			<%=Position%></span>
																	</div>
																	<div class="action_box" style='<%=!EditingSharedCustomGallery?"": "display:none"%>'>
																		<div class="action_wrapper">
																			<asp:HiddenField ID="hfPictureShowMedia" runat="server" Value='<%# Bind("ShowMedia") %>' />
																			<asp:LinkButton ID="lbArticleGalleryItemState" runat="server" CommandArgument='<%# Eval("PictureID") %>' CommandName="ChangeShow" CssClass='<%# GetShowMediaClass(Convert.ToBoolean(Eval("ShowMedia"))) %>'></asp:LinkButton>
																		</div>
																		<span class="text">
																			<%=Show%></span>
																	</div>
																	<div class="action_box">
																		<div class="action_wrapper">
																			<asp:Label ID="imgMediaType" runat="server" CssClass='<%# GetMediaTypeClass(Eval("MediaType").ToString()) %>' />
																		</div>
																		<span class="text">
																			<%=Media %></span>
																	</div>
																</td>
															</tr>
															<tr>
																<td class="token_wrapper" colspan="5">
																	<asp:TextBox ID="lblGalleryInsertArtGallery" runat="server" CssClass="token_box" ReadOnly="True" Text='<%# GenerateTokens(Convert.ToInt32(Eval("PictureID"))) %>' />
																	<span class="start_token_generator"><%=Customtoken %></span>
																</td>
															</tr>
														</table>
														<asp:HiddenField ID="hvPictureID" runat="server" Value='<%# Bind("PictureID") %>' />
													</ItemTemplate>
												</asp:TemplateField>
											</Columns>
											<HeaderStyle CssClass="main_table_header" />
											<PagerStyle CssClass="pagination" HorizontalAlign="Center" />
											<RowStyle CssClass="main_row" />
											<SelectedRowStyle CssClass="categorygridselected" />
										</asp:GridView>
									</div>
									<div class="padded textCenter">
										<div id="divGalleryOrderBy" runat="server" visible="false" style="display: inline; padding-left: 20px">
											<asp:Label ID="lblGalleryOrderBy" runat="server" Text="Sort:" resourcekey="lblGalleryOrderBy" />
											&nbsp;
												<asp:DropDownList ID="ddlGalleryOrderBy" runat="server" AutoPostBack="True" CssClass="ddlpageitems" OnSelectedIndexChanged="ddlGalleryOrderBy_SelectedIndexChanged">
													<asp:ListItem resourcekey="liAscending" Text="Ascending" Value="0" />
													<asp:ListItem resourcekey="liDescending" Text="Descending" Value="1" />
												</asp:DropDownList>
										</div>
										<div id="mediaPageManagment" runat="server" visible="false" style="display: inline; padding-left: 20px">
											<asp:Label ID="lblGalSetThenumberOfItems" runat="server" Text="Set the number of items per page:" resourcekey="lblGalSetThenumberOfItems0Resource1" />
											&nbsp;<asp:DropDownList ID="ddlArticleViewNumberOfItems" runat="server" AutoPostBack="True" CssClass="ddlpageitems" OnSelectedIndexChanged="ddlArticleViewNumberOfItems_SelectedIndexChanged">
												<asp:ListItem resourcekey="ListItemResource20" Text="10" Value="10" />
												<asp:ListItem resourcekey="ListItemResource21" Text="20" Value="20" />
												<asp:ListItem resourcekey="ListItemResource22" Text="30" Value="30" />
												<asp:ListItem resourcekey="ListItemResource23" Text="50" Value="50" />
												<asp:ListItem resourcekey="ListItemResource24" Text="100" Value="100" />
											</asp:DropDownList>
										</div>
									</div>
									<asp:HiddenField ID="hfGalID" runat="server" />
									<asp:HiddenField ID="hfResizeHeight" runat="server" />
									<asp:HiddenField ID="hfResizeWidth" runat="server" />
									<asp:HiddenField ID="hfResize" runat="server" />
									<asp:HiddenField ID="hfSharedGalID" runat="server" />
									<asp:HiddenField ID="hfImageChanged" runat="server" Value="false" />
									<asp:HiddenField ID="hfMainArticlePictureID" runat="server" Value="0" />
									<asp:HiddenField ID="curentActiveGalleryId" runat="server" Value="1" />
								</div>
							</div>
							<asp:Panel runat="server" ID="pnlCustomGalleryManager" CssClass="section_box no_top_margin" Visible="false">
								<div class="content dark_blue">
									<div class="section_actions">
										<asp:HyperLink ID="hlOpenGallery" runat="server" CssClass="icon laptop" Target="_blank" resourcekey="hlOpenGalleryResource1">Open Media manager</asp:HyperLink>
									</div>
								</div>
							</asp:Panel>
							<asp:UpdateProgress ID="upArticleImagesProgress" runat="server" AssociatedUpdatePanelID="upArticleImages" DisplayAfter="200" DynamicLayout="true">
								<ProgressTemplate>
									<div class="edn_admin_progress_overlay">
									</div>
								</ProgressTemplate>
							</asp:UpdateProgress>
						</div>
					</ContentTemplate>
					<Triggers>
						<asp:PostBackTrigger ControlID="btnWistiaSingleUpload" />
						<asp:PostBackTrigger ControlID="btnVimeoSingleUpload" />
					</Triggers>
				</asp:UpdatePanel>
				<asp:Panel ID="pnlDocumentUpload" CssClass="section_box white_border_1 dark_grey document_upload" runat="server">
					<h1 class="section_box_title edNews_tooltip" data-tooltip-content="<%=_("documentsIncludedTooltip.Text", true) %>" data-tooltip-position="top-left">
						<span><%=DOCUMENTSincluded%></span>
					</h1>
					<div class="edNews_inputGroup displayInline">
						<asp:RadioButtonList ID="rblAddDocumentType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" onclick="toogleDocumentPanels()">
							<asp:ListItem Value="0" class="normalRadioButton" Text="Upload new documents" Selected="True" resourcekey="rblAddDocumentType-newDocument" />
							<asp:ListItem Value="1" class="normalRadioButton" Text="Add existing document" resourcekey="rblAddDocumentType-existingDocument" />
						</asp:RadioButtonList>
					</div>
					<div class="content document_upload">
						<div class="rounded3dBox" runat="server" id="divAddDocuments" style="margin-top: 0">
							<asp:Panel ID="pnlAddDocument" runat="server">
								<div class="edNews_inputGroup textCenter" style="margin-bottom: 10px">
									<asp:RadioButtonList ID="rblDocumentUploadType" CssClass="styledRadio inlineList" runat="server" RepeatLayout="UnorderedList" onclick="toogleDocumentUploadPanels()">
										<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liUpload" Selected="True">Upload</asp:ListItem>
										<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liServer">Add from server</asp:ListItem>
									</asp:RadioButtonList>
								</div>
								<asp:Panel ID="pnlUploadDocuments" runat="server">
									<div id="divAddDocumentFineUploader" runat="server" visible="false" class="EDS_simpleFineUploader documents_fine_uploader">
										<div class="uploader">
										</div>
										<div class="uploadControls">
											<div class="infomsg"><%=_("DragAndDropDocumentsHere")%></div>
											<div class="actions">
												<span class="action fileSelection rounded_button gradient icon document_in_folder">
													<asp:Label ID="lblDocumentFineUploaderSelect" runat="server" resourcekey="fineUploaderSelectDocuments" Text="Select documents" />
													<span class="dnnInputFileWrapper">
														<input type="file" value="" multiple="multiple" />
													</span></span><span class="action upload rounded_button gradient icon orange_plus">
														<asp:Label ID="lblDocumentFineUploaderStart" runat="server" resourcekey="fineUploaderUpload" Text="Upload" />
													</span>
											</div>
											<div class="dndContainer">
												<p>
													<asp:Label ID="lblDocumentFineUploaderDrag" runat="server" resourcekey="fineUploaderDragFilesHere" Text="Drag files here" />
												</p>
											</div>
										</div>
										<div class="uploadDetails">
											<ol class="fileUploadList">
											</ol>
										</div>
									</div>
									<div id="divAddDocumentStandardUploader" runat="server" visible="true" class="documents_standard_uploader">
										<asp:Label ID="lblDocUploadmessage" CssClass="upload_message" Visible="false" EnableViewState="false" runat="server" />
										<span class="file_selection rounded_button gradient icon document_in_folder">
											<asp:FileUpload ID="fuDocFileUpload" runat="server" />
										</span>
										<asp:LinkButton ID="btnDocUpload" runat="server" OnClick="btnDocUpload_Click" ValidationGroup="vgArticleDocs" resourcekey="btnDocUploadResource1" CssClass="action upload rounded_button gradient icon orange_plus"><span>Upload</span></asp:LinkButton>
									</div>
								</asp:Panel>
								<asp:Panel ID="pnlAddDocumentsFromServer" class="EDS_simpleFineUploader" runat="server" Style="display: none;">
									<div class="edNews_inputGroup labelBlock inputWidth40 uploadControls textCenter">
										<Portal:URL ID="urlAddDocumentsFromServer" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="true" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="F" />
										<asp:Label ID="lblAddDocumentsFromServerMessage" runat="server" EnableViewState="False" Visible="False" />
										<asp:LinkButton runat="server" ID="lbAddDocumentsFromServer" resourcekey="lbAddDocumentsFromServer" OnClick="lbAddDocumentsFromServer_Click" CssClass="addfromserver">Add document</asp:LinkButton>
									</div>
								</asp:Panel>
							</asp:Panel>
							<asp:Panel ID="pnlAddExistingDocument" runat="server" CssClass="documents_add_existing_container" Style="display: none;">
								<div class="messages">
									<asp:Label runat="server" ID="lblAddDocumentInfo" EnableViewState="false" Visible="false" CssClass="error" />
									<p>
										<asp:RequiredFieldValidator ID="rfvExistingDocumentID" resourcekey="rfvExistingDocumentID.ErrorMessage" runat="server" ControlToValidate="tbxExistingDocumentID" ErrorMessage="Document ID must be set" ValidationGroup="vgDocumentLinks" Display="Dynamic"
											CssClass="error" />
									</p>
									<p>
										<asp:CompareValidator ID="cvExistingDocumentID" resourcekey="cvExistingDocumentID.ErrorMessage" runat="server" ControlToValidate="tbxExistingDocumentID" ErrorMessage="Document ID must be an integer" Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgDocumentLinks"
											Display="Dynamic" CssClass="error" />
									</p>
								</div>
								<div class="search_by_document_title">
									<p>
										<%=Searchdocuments%>
									</p>
									<asp:TextBox ID="tbxDocumentText" runat="server" AutoCompleteType="Search" CausesValidation="False" EnableViewState="false" CssClass="rounded_text_box" />
								</div>
								<div class="search_by_document_id">
									<p>
										<%=Documentid%>
									</p>
									<asp:TextBox ID="tbxExistingDocumentID" runat="server" CausesValidation="False" EnableViewState="false" CssClass="rounded_text_box grey" />
								</div>
								<asp:LinkButton ID="btnAddExistingDocument" runat="server" OnClick="lbAddExistingDocument_Click" ValidationGroup="vgDocumentLinks" CssClass="add_button rounded_button gradient icon orange_plus"><span><%=Add%></span></asp:LinkButton>
								<div class="clear_float">
								</div>
							</asp:Panel>
						</div>
						<div class="rounded3dBox" runat="server" id="divYouCanNotAddMoreDocuments" visible="false">
							<asp:Label ID="lblYouCanNotAddMoreDocuments" runat="server" />
						</div>
						<asp:GridView ID="gvArticleDocuments" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="grid_view_table" DataKeyNames="DocEntryID" EnableModelValidation="True" GridLines="None" OnRowCommand="gvArticleDocuments_RowCommand" OnRowEditing="gvArticleDocuments_RowEditing"
							OnRowCancelingEdit="gvArticleDocuments_RowCancelingEdit" OnRowUpdating="gvArticleDocuments_RowUpdating" OnRowUpdated="gvArticleDocuments_RowUpdated" OnRowDeleting="gvArticleDocuments_RowDeleting" OnRowDataBound="gvArticleDocuments_RowDataBound" OnPreRender="gvArticleDocuments_PreRender" OnPageIndexChanged="gvArticleDocuments_PageIndexChanged" OnPageIndexChanging="gvArticleDocuments_PageIndexChanging">
							<AlternatingRowStyle CssClass="second" />
							<Columns>
								<asp:TemplateField HeaderText="Actions">
									<EditItemTemplate>
										<asp:LinkButton ID="lbDocUpdate" runat="server" CausesValidation="true" CommandName="Update" CssClass="action_btn save" resourcekey="lbDocUpdateResource1" ToolTip='<%#_("SaveChanges")%>' CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
										<asp:LinkButton ID="lbDocCancel" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton2Resource1" ToolTip='<%#_("DiscardChanges")%>' />
									</EditItemTemplate>
									<ItemTemplate>
										<asp:LinkButton ID="lbDocEdit" runat="server" CausesValidation="false" CommandName="Edit" CssClass="action_btn edit" resourcekey="LinkButton1Resource1" ToolTip="<%#Editthisdocument %>" />
										<asp:LinkButton ID="lbDocDelete" runat="server" CausesValidation="false" CommandName="Delete" CssClass="action_btn red_x" OnClientClick="return AlertConfirm('document');" resourcekey="lbDeleteDocResource1" ToolTip="<%#Deletethisdocument%>" CommandArgument='<%# Eval("DocEntryID") %>' />
									</ItemTemplate>
									<HeaderStyle CssClass="actions" />
									<ItemStyle CssClass="actions" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="TitleDescription">
									<EditItemTemplate>
										<asp:TextBox ID="tbDocTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="light" />
										<asp:TextBox ID="tbDocDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="light" />
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblDocUploadTitle" runat="server" CssClass="title" Text='<%# Bind("Title") %>' />
										<asp:Label ID="lblDocUploadDesc" runat="server" CssClass="description" Text='<%#Bind("Description") %>' />
										<%if (IsArticleEditMode)
											{ %>
										<input type="text" class="token light" value="<%# GenerateDocumentToken(Convert.ToString(Eval("DocEntryID"))) %>" />
										<% } %>
									</ItemTemplate>
									<HeaderStyle CssClass="title_dscription" />
									<ItemStyle CssClass="title_dscription" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Info">
									<ItemTemplate>
										<p class="document_link <%#PrintAlreadyInUseClass((bool) Eval("InUseByOther")) %>">
											<%#GetDocumentDownloadLink(Convert.ToString(Eval("DocEntryID")), Convert.ToString(Eval("Filename")), Convert.ToString(Eval("FileExtension")))%>
										</p>
										<p>
											<asp:Label ID="lblDateUploaded" runat="server" Text='<%# Convert.ToDateTime(Eval("DateUploaded")).ToShortDateString() %>' />
											-
											<asp:Label ID="lblDocUploadAuthor" runat="server" Text='<%#Eval("DisplayName")%>' />
										</p>
										<p>
											<asp:Label ID="lblFileSize" runat="server" Text='<%# EasyDNNSolutions.Modules.EasyDNNNews.StringHelpers.HumanReadableFileSize(Convert.ToDouble(Eval("FileSize"))) %>' />
										</p>
										<%if (IsArticleEditMode)
											{ %>
										<p>
											<asp:Label ID="lblDownloads" runat="server" Text='<%# NumberOfDownloadsText(Convert.ToString(Eval("NumberOfDownloads"))) %>' />
										</p>
										<% } %>
									</ItemTemplate>
									<EditItemTemplate>
										<p>
											<asp:Label ID="lbFilenameEdit" runat="server" Text='<%# GetDocumentFilename(Convert.ToString(Eval("Filename")),Convert.ToString(Eval("FileExtension"))) %>' />
										</p>
										<div id="divReplaceFileContainer" runat="server" class="replace_file">
											<p>
												<asp:Label ID="lblReplaceFile" runat="server" Text="Replace existing file:" resourcekey="lblDocumentsReplaceFile" />
											</p>
											<asp:FileUpload ID="fuReplaceFile" runat="server" />
										</div>
									</EditItemTemplate>
									<HeaderStyle CssClass="info" />
									<ItemStyle CssClass="info" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="PermissionsToDownload">
									<ItemTemplate>
										<asp:Label ID="lblPermissionsToDownload" runat="server" Text='<%# GetDocumentPermissions(Convert.ToString(Eval("SelectedRolePermissions")), Convert.ToString(Eval("SelectedRolePermissionsText"))) %>' />
									</ItemTemplate>
									<EditItemTemplate>
										<div class="language_selection_container">
											<asp:ListBox ID="lbEditPermissionsToDownload" runat="server" SelectionMode="Multiple" />
										</div>
									</EditItemTemplate>
									<HeaderStyle CssClass="language" />
									<ItemStyle CssClass="language" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Lang">
									<ItemTemplate>
										<asp:Label ID="lblLang" runat="server" Text='<%# GetDocumentLocalization(Convert.ToString(Eval("SelectedLocales"))) %>' />
									</ItemTemplate>
									<EditItemTemplate>
										<div class="language_selection_container">
											<asp:ListBox ID="lbEditDocUploadLanguage" runat="server" SelectionMode="Multiple" />
										</div>
									</EditItemTemplate>
									<HeaderStyle CssClass="language" />
									<ItemStyle CssClass="language" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Target">
									<EditItemTemplate>
										<asp:DropDownList ID="ddlLinkTarget" runat="server">
											<asp:ListItem Value="0" Text="_self" Selected="True" />
											<asp:ListItem Value="1" Text="_blank" />
											<asp:ListItem Value="2" Text="_parent" />
											<asp:ListItem Value="3" Text="_top" />
										</asp:DropDownList>
									</EditItemTemplate>
									<ItemTemplate>
										<asp:Label ID="lblTarget" runat="server" Text='<%# TargetToString(Convert.ToByte(Eval("Target")))%>' />
									</ItemTemplate>
									<HeaderStyle CssClass="tdShow" />
									<ItemStyle CssClass="tdShow" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Show">
									<ItemTemplate>
										<asp:CheckBox CssClass="normalCheckBox" ID="CheckBox1" runat="server" Enabled="false" Checked='<%#Convert.ToBoolean(Eval("Visible"))%>' />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:CheckBox CssClass="normalCheckBox" runat="server" ID="cbDocumentVisible" Enabled="true" Checked='<%#Convert.ToBoolean(Eval("Visible"))%>' />
									</EditItemTemplate>
									<HeaderStyle CssClass="tdShow" />
									<ItemStyle CssClass="tdShow" />
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="false">
									<ItemTemplate>
										<asp:Label ID="lblPosition" runat="server" Text='<%# Bind("Position") %>' CssClass="rounded_inset_text_box" />
									</ItemTemplate>
									<EditItemTemplate>
										<asp:TextBox ID="tbxPosition" runat="server" Text='<%# Bind("Position") %>' CssClass="light" />
									</EditItemTemplate>
									<HeaderStyle CssClass="position" />
									<ItemStyle CssClass="position" />
								</asp:TemplateField>
								<asp:TemplateField ShowHeader="false">
									<ItemTemplate>
										<asp:LinkButton ID="lbDocMoveDown" CommandArgument='<%# Bind("DocEntryID") %>' CommandName="Down" runat="server" CssClass="arrow down" resourcekey="lbDocMoveDownResource1" />
										<asp:LinkButton ID="lbDocMoveUp" CommandArgument='<%# Bind("DocEntryID") %>' CommandName="Up" runat="server" CssClass="arrow up" resourcekey="lbDocMoveUpResource1" />
									</ItemTemplate>
									<HeaderStyle CssClass="arrows" />
									<ItemStyle CssClass="arrows" />
								</asp:TemplateField>
							</Columns>
							<HeaderStyle CssClass="header_row" />
						</asp:GridView>
					</div>
					<asp:Button ID="btnDocUploadRefresh" runat="server" Text="refresf" Style="display: none;" OnClick="btnDocUploadRefresh_Click" />
				</asp:Panel>
				<asp:Panel ID="pnlLinksIncluded" CssClass="section_box white_border_1 dark_grey olive_green" runat="server">
					<asp:UpdatePanel ID="upLinksIncluded" runat="server" OnUnload="UpdatePanel_Unload">
						<ContentTemplate>
							<div class="edn_admin_progress_overlay_container">
								<asp:UpdateProgress ID="uppLinksIncluded" runat="server" AssociatedUpdatePanelID="upLinksIncluded" DisplayAfter="100" DynamicLayout="true">
									<ProgressTemplate>
										<div class="edn_admin_progress_overlay">
										</div>
									</ProgressTemplate>
								</asp:UpdateProgress>
								<asp:PlaceHolder ID="phincludeAutoComplete" runat="server" />
								<h1 class="section_box_title edNews_tooltip" data-tooltip-content="<%=_("linksTooltip.Text", true) %>" data-tooltip-position="top-left">
									<span><%=Links%></span>
								</h1>
								<div class="edNews_inputGroup displayInline">
									<asp:RadioButtonList ID="rblCreateLinkType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblCreateLinkType_SelectedIndexChanged">
										<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liCustomlink" Text="External link" Selected="True" />
										<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liPage" Text="Page link" />
										<asp:ListItem Value="2" class="normalRadioButton" resourcekey="liNewsarticle" Text="Article link" />
										<asp:ListItem Value="3" class="normalRadioButton" resourcekey="liExistinglink" Text="Existing link" />
									</asp:RadioButtonList>
								</div>
								<div class="content links_manager">
									<p class="user_messages">
										<asp:Label ID="lblLinksInfo" runat="server" EnableViewState="false" />
										<asp:RequiredFieldValidator ID="rfvtbxCustomLink" resourcekey="rfvtbxCustomLink.ErrorMessage" runat="server" ControlToValidate="tbxCustomLink" ErrorMessage="Please enter a URL." ValidationGroup="vgArticleLinks" Display="Dynamic" Visible="true" />
										<asp:RequiredFieldValidator ID="rfvNewsArticleID" resourcekey="rfvNewsArticleID.ErrorMessage" runat="server" ControlToValidate="tbxExistingArticleID" ErrorMessage="Please select a news article." ValidationGroup="vgArticleLinks" Display="Dynamic" Visible="false" />
										<asp:RequiredFieldValidator ID="rfvExistingLinksID" resourcekey="rfvExistingLinksID.ErrorMessage" runat="server" ControlToValidate="tbxExistingLinksID" ErrorMessage="Please specify an existing document ID." ValidationGroup="vgArticleLinks" Display="Dynamic"
											Visible="false" />
										<asp:CompareValidator ID="cvExistingLinksID" runat="server" resourcekey="cvExistingLinksID.ErrorMessage" ControlToValidate="tbxExistingLinksID" ErrorMessage="The existing link ID must be an integer." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgArticleLinks"
											Display="Dynamic" Visible="false" />
									</p>
									<div class="rounded3dBox" runat="server" id="divAddLinks">
										<div class="new_link_settings">
											<asp:Panel ID="pnlLinksCreateNewWrapper" runat="server" Visible="true" CssClass="custom">
												<asp:Panel ID="pnlAddCustomLink" runat="server" Visible="true" CssClass="field urllink">
													<asp:Label ID="lblCustomLink" resourcekey="lblCustomLink" AssociatedControlID="tbxCustomLink" runat="server" Text="URL:" />
													<asp:TextBox ID="tbxCustomLink" runat="server" Text="" />
												</asp:Panel>
												<asp:Panel ID="pnlAddLinkPage" runat="server" Visible="false" CssClass="field">
													<Portal:URL ID="urlLinksIncluded" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U" />
												</asp:Panel>
												<asp:Panel ID="pnlAddNewsArticleLink" runat="server" Visible="false" CssClass="field urllink">
													<asp:Label ID="lblSearchArticleText" resourcekey="lblSearchArticleText" AssociatedControlID="tbxSearchText" runat="server" Text="Search news articles:" />
													<asp:TextBox ID="tbxSearchText" runat="server" AutoCompleteType="Search" CausesValidation="False" EnableViewState="false" />
													<asp:TextBox ID="tbxExistingArticleID" runat="server" CausesValidation="False" EnableViewState="false" Style="display: none;" />
												</asp:Panel>
												<div class="field title">
													<asp:Label ID="lblLinkTitle" resourcekey="lblLinkTitle" AssociatedControlID="tbxLinkTitle" runat="server" Text="Link title:" />
													<asp:TextBox ID="tbxLinkTitle" runat="server" />
												</div>
												<div class="field description">
													<asp:Label ID="lblLinkDescription" resourcekey="lblLinkDescription" AssociatedControlID="tbxLinkDescription" runat="server" Text="Link description:" />
													<asp:TextBox ID="tbxLinkDescription" runat="server" />
												</div>
											</asp:Panel>
											<asp:Panel ID="pnlLinksAddExistingLink" runat="server" Visible="false" CssClass="existing_link">
												<div class="field searchlink">
													<asp:Label ID="lblSearchLinkText" resourcekey="lblSearchLinkText" AssociatedControlID="tbxSearchLinkText" runat="server" Text="Search links:" />
													<asp:TextBox ID="tbxSearchLinkText" runat="server" AutoCompleteType="Search" CausesValidation="False" EnableViewState="false" />
												</div>
												<div class="field title">
													<asp:Label ID="lblExistingLinksID" resourcekey="lblExistingLinksID" AssociatedControlID="tbxExistingLinksID" runat="server" Text="Link id:" />
													<asp:TextBox ID="tbxExistingLinksID" runat="server" CausesValidation="true" EnableViewState="false" />
												</div>
											</asp:Panel>
											<asp:LinkButton ID="lbAddLink" runat="server" ValidationGroup="vgArticleLinks" OnClick="lbAddLink_Click" CausesValidation="true" CssClass="rounded_button gradient olive_green icon orange_plus"><span><%=Add%></span></asp:LinkButton>
										</div>

										<div style="clear: both;">
										</div>
									</div>
									<div class="rounded3dBox" runat="server" id="divYouCanNotAddMoreLinks" visible="false">
										<asp:Label ID="lblYouCanNotAddMoreLinks" runat="server" />
									</div>
									<asp:GridView ID="gvArticleLinks" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="grid_view_table olive_green" DataKeyNames="LinkID, Position" EnableModelValidation="True" GridLines="None" OnRowCancelingEdit="gvArticleLinks_RowCancelingEdit"
										OnRowCommand="gvArticleLinks_RowCommand" OnRowEditing="gvArticleLinks_RowEditing" OnRowUpdating="gvArticleLinks_RowUpdating" OnRowUpdated="gvArticleLinks_RowUpdated" OnRowDeleting="gvArticleLinks_RowDeleting" OnRowDataBound="gvArticleLinks_RowDataBound"
										OnPreRender="gvArticleLinks_PreRender">
										<Columns>
											<asp:TemplateField HeaderText="Actions">
												<EditItemTemplate>
													<asp:LinkButton ID="lbLinkUpdate" runat="server" CausesValidation="true" CommandName="Update" CssClass="action_btn save" resourcekey="lbDocUpdateResource1" ToolTip='<%#_("SaveChanges")%>' CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
													<asp:LinkButton ID="lbLinkCancel" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton2Resource1" ToolTip='<%#_("DiscardChanges")%>' />
												</EditItemTemplate>
												<ItemTemplate>
													<asp:LinkButton ID="lbLinkEdit" CssClass="action_btn edit" runat="server" CausesValidation="false" CommandName="Edit" ToolTip="<%#Editthislink%>" />
													<asp:LinkButton ID="lbDeleteLink" CssClass="action_btn red_x" runat="server" CausesValidation="false" CommandName="Delete" ToolTip="<%#Deletethislink%>" OnClientClick="return AlertConfirm('link');" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
												</ItemTemplate>
												<HeaderStyle CssClass="actions" />
												<ItemStyle CssClass="actions" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="TitleDescription">
												<EditItemTemplate>
													<asp:TextBox ID="tbxLinkTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="light" />
													<asp:TextBox ID="tbxLinkDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="light" />
												</EditItemTemplate>
												<ItemTemplate>
													<asp:Label ID="lblLinkUploadTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="title" />
													<asp:Label ID="lblLinkUploadDesc" runat="server" Text='<%# Bind("Description") %>' CssClass="description" />
													<input type="text" class="token light" value="<%# GenerateLinkToken(Convert.ToInt32(Eval("LinkID"))) %>" />
												</ItemTemplate>
												<HeaderStyle CssClass="title_description" />
												<ItemStyle CssClass="title_description" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Link">
												<EditItemTemplate>
													<asp:TextBox ID="tbxLink" runat="server" Text='<%# GetGeneratedLinkForEdit(Eval("Type"),Eval("URL"),Eval("Protocol"),Eval("ArticleID"),Eval("TabID")) %>' Visible="false" CssClass="light" />
													<Portal:URL ID="urlLinksIncluded" runat="server" Width="250" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" ShowTabs="false" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U"
														Visible="false" />
												</EditItemTemplate>
												<ItemTemplate>
													<p class="link <%# PrintAlreadyInUseClass((bool) Eval("InUseByOther")) %>">
														<%# GetGeneratedLink(Eval("Type"),Eval("URL"),Eval("Protocol"),Eval("ArticleID"),Eval("TabID"),Eval("ExistingArticleData")) %>
													</p>
												</ItemTemplate>
												<HeaderStyle CssClass="link" />
												<ItemStyle CssClass="link" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Lang">
												<ItemTemplate>
													<asp:Label ID="lblLang" runat="server" Text='<%# GetDocumentLocalization(Convert.ToString(Eval("SelectedLocales"))) %>' />
												</ItemTemplate>
												<EditItemTemplate>
													<div class="language_selection_container">
														<asp:ListBox ID="lbEditListUploadLanguage" runat="server" SelectionMode="Multiple" />
													</div>
												</EditItemTemplate>
												<HeaderStyle CssClass="language" />
												<ItemStyle CssClass="language" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Target">
												<EditItemTemplate>
													<asp:DropDownList ID="ddlLinkTarget" runat="server">
														<asp:ListItem Value="0" Text="_self" Selected="True" />
														<asp:ListItem Value="1" Text="_blank" />
														<asp:ListItem Value="2" Text="_parent" />
														<asp:ListItem Value="3" Text="_top" />
													</asp:DropDownList>
												</EditItemTemplate>
												<ItemTemplate>
													<asp:Label ID="lblTarget" runat="server" Text='<%# TargetToString(Convert.ToByte(Eval("Target")))%>' />
												</ItemTemplate>
												<HeaderStyle CssClass="target" />
												<ItemStyle CssClass="target" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Show">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="CheckBox1" runat="server" Enabled="false" Checked='<%#Convert.ToBoolean(Eval("Visible"))%>' />
												</ItemTemplate>
												<EditItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" runat="server" ID="cbLinkVisible" Enabled="true" Checked='<%#Convert.ToBoolean(Eval("Visible"))%>' />
												</EditItemTemplate>
												<HeaderStyle CssClass="tdShow" />
												<ItemStyle CssClass="tdShow" />
											</asp:TemplateField>
											<asp:TemplateField ShowHeader="false">
												<ItemTemplate>
													<asp:Label ID="lblPosition" runat="server" Text='<%# Bind("Position") %>' CssClass="rounded_inset_text_box" />
												</ItemTemplate>
												<EditItemTemplate>
													<asp:TextBox ID="tbxPosition" runat="server" Text='<%# Bind("Position") %>' CssClass="light" />
												</EditItemTemplate>
												<HeaderStyle CssClass="position" />
												<ItemStyle CssClass="position" />
											</asp:TemplateField>
											<asp:TemplateField ShowHeader="false">
												<ItemTemplate>
													<asp:LinkButton ID="lbLinkMoveDown" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Down" runat="server" CssClass="arrow down" resourcekey="lbDocMoveDownResource1" />
													<asp:LinkButton ID="lbLinkMoveUp" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Up" runat="server" CssClass="arrow up" resourcekey="lbDocMoveUpResource1" />
												</ItemTemplate>
												<HeaderStyle CssClass="arrows" />
												<ItemStyle CssClass="arrows" />
											</asp:TemplateField>
										</Columns>
										<AlternatingRowStyle CssClass="second" />
										<HeaderStyle CssClass="header_row" />
									</asp:GridView>
								</div>
							</div>
						</ContentTemplate>
					</asp:UpdatePanel>
				</asp:Panel>
				<asp:Panel ID="google_maps_main" CssClass="section_box white_border_1 light_green green_globe google_maps_main" runat="server">
					<h1 class="section_box_title">
						<span>
							<%=Mainarticlemap %></span></h1>
					<div class="content google_maps">
						<div class="content_token_generator google_maps">
						</div>
						<asp:HiddenField ID="hfGooglemapTokenGenerated" runat="server" />
						<div id="idAddGmap" runat="server" class="info_box red_cross no_map">
							<a href="#" class="action add open_map_editor <%=hasGapiKey%>">
								<%=Addmap%></a>
							<p>
								<%=Mainarticlemapisnotset%>
							</p>
						</div>
						<div id="idRemoveGmap" runat="server" class="info_box check_sign map_set">
							<a href="#" class="action remove_btn remove_article_map">
								<%=Remove%></a> <a href="#" class="action edit open_map_editor <%=hasGapiKey%>"><%=_("EditMap")%></a>
							<p>
								<%=Mainarticlemapisset%>
							</p>
						</div>
						<div class="section_actions">
							<a class="icon green_globe open_map_editor <%=hasGapiKey%>" href="#">
								<%=Mapeditor%></a>
						</div>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlEventManager" runat="server" CssClass="section_box white_border_1 dark_grey orange eventmanagerpanel">
					<div class="edn_admin_progress_overlay_container">
						<h1 class="section_box_title edNews_tooltip" data-tooltip-content="<%=_("isArticleEventTooltip.Text", true) %>" data-tooltip-position="top-left">
							<asp:Label ID="lblIsArticleEvent" runat="server" Text="Add as event:" resourcekey="lblIsArticleEventResource1" />
						</h1>
						<div id="tblIsArticleEvent" runat="server">
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbIsArticleEvent" runat="server" CssClass="normalCheckBox" Text="Add as event" AutoPostBack="True" OnCheckedChanged="cbIsArticleEvent_CheckedChanged" />
							</div>
						</div>
						<asp:Panel ID="pnlEventsData" runat="server" Visible="false" CssClass="content links_manager">
							<asp:Panel ID="pnlSimpleEvents" runat="server">
								<table class="settings_table no_margin">
									<tr>
										<td colspan="3" style="text-align: center;">
											<asp:Label ID="lblEventDateError" runat="server" ForeColor="Red" Visible="false" EnableViewState="false" />
										</td>
									</tr>
									<tr>
										<td class="left" style="vertical-align: top; padding-top: 2px;">
											<label for="<%=tbEventStartDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventStartDateTime.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEventStartDateTime.Text") %></label>
										</td>
										<td class="right" style="width: 245px;">
											<asp:TextBox ID="tbEventStartDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" />
											<%--<img src="<%=_ControlPath%>images/icons/calendar.png" alt="" style="position: relative; top: 2px" />--%>
											<span class="calendaricon"></span>
											<asp:RequiredFieldValidator ID="rfvEventStartDate" runat="server" ControlToValidate="tbEventStartDate" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvEventStartDateResource1" />
											<asp:Label ID="lblEvStartDateError" runat="server" ForeColor="Red" resourcekey="lblPubDateErrorResource1" Text="Invalid date." Visible="false" />
											<asp:TextBox ID="tbEventStartTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="55px" />
											<img style="position: relative; top: 1px" />
											<span id="tbEventStartTimeIcon" runat="server" class="clockicon"></span>
											&nbsp;<asp:RegularExpressionValidator ID="revEventStartTime" runat="server" ControlToValidate="tbEventStartTime" Enabled="false" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" Display="Dynamic"
												resourcekey="revEventStartTimeResource1" />
											<asp:RequiredFieldValidator ID="rfvEventStartTime" runat="server" ControlToValidate="tbEventStartTime" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Time required." ValidationGroup="vgEditArticle" resourcekey="rfvEventStartTimeResource1" />
										</td>
										<td rowspan="2" class="textTop">
											<p style="position: relative; top: 5px; margin-bottom: 10px;">
												<div class="styledCheckbox">
													<asp:CheckBox CssClass="normalCheckBox" ID="cbAllDayEvent" runat="server" AutoPostBack="True" OnCheckedChanged="cbAllDayEvent_CheckedChanged" Text="All day event" resourcekey="cbAllDayEventResource1" />
												</div>
											</p>
											<p style="position: relative; top: 5px; margin-bottom: 10px;">
												<div class="styledCheckbox">
													<asp:CheckBox CssClass="normalCheckBox" ID="cbShowEndDate" resourcekey="cbShowEndDate" runat="server" Checked="True" Text="Show end date" />
												</div>
											</p>
										</td>
									</tr>
									<tr>
										<td class="left" style="vertical-align: top; padding-top: 2px;">
											<label for="<%=tbEventEndDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventEndDateTime.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEventEndDateTime.Text") %></label>
										</td>
										<td class="right">
											<asp:TextBox ID="tbEventEndDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" />
											<%--<img src="<%=_ControlPath%>images/icons/calendar.png" alt="" style="position: relative; top: 2px" />--%>
											<span class="calendaricon"></span>
											<asp:RequiredFieldValidator ID="rfvEventEndDate" runat="server" ControlToValidate="tbEventEndDate" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvEventEndDateResource1" />
											<asp:Label ID="lblEvEndDateError" runat="server" ForeColor="Red" resourcekey="lblExpireDateErrorResource1" Text="Invalid date." Visible="false" />
											<asp:TextBox ID="tbEventEndTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="55px" />
											<span id="tbEventEndTimeIcon" runat="server" class="clockicon"></span>
											&nbsp;<asp:RegularExpressionValidator ID="revEventEndTIme" runat="server" ControlToValidate="tbEventEndTime" Enabled="false" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" Display="Dynamic"
												resourcekey="revEventEndTImeResource1" />
											<asp:RequiredFieldValidator ID="rfvEventEnd" runat="server" ControlToValidate="tbEventEndTime" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Time required." ValidationGroup="vgEditArticle" resourcekey="rfvEventEndResource1" />
										</td>
									</tr>
									<tr id="trRecurringEvent" runat="server">
										<td class="left">
											<label for="<%=cbRecurringEvent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblrecurringEvent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblrecurringEvent.Text") %></label>
										</td>
										<td class="right">

											<div class="styledCheckbox">
												<asp:CheckBox CssClass="normalCheckBox" ID="cbRecurringEvent" resourcekey="cbRecurringEvent" runat="server" Text="Recurrence" AutoPostBack="True" OnCheckedChanged="cbRecurringEvent_CheckedChanged" />
											</div>
										</td>
									</tr>
								</table>
							</asp:Panel>
							<asp:Panel runat="server" ID="pnlEventInfoAndData">
								<asp:Panel runat="server" ID="pnlRecurringEvent" Visible="false">
									<div class="rounded3dBox">

										<div runat="server" id="divEventRecurringOptionsPanel">

											<asp:Panel ID="pnlRecurringEditsSettings" runat="server">
												<table class="settings_table no_margin" runat="server">
													<tr>
														<td class="left">
															<label for="<%=rblRecurringEventType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRecurrenceType.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRecurrenceType.Text") %></label>
														</td>
														<td class="right">
															<div class="edNews_inputGroup displayInline">
																<asp:RadioButtonList ID="rblRecurringEventType" CssClass="styledRadio inlineList smallRadio" runat="server" OnSelectedIndexChanged="rblRecurringEventType_SelectedIndexChanged" AutoPostBack="true" RepeatLayout="UnorderedList">
																	<asp:ListItem resourcekey="liDaily" class="normalRadioButton" Value="0" Text="Daily" Selected="True" />
																	<asp:ListItem resourcekey="liWeekly" class="normalRadioButton" Value="1" Text="Weekly" />
																	<asp:ListItem resourcekey="liMonthly" class="normalRadioButton" Value="2" Text="Monthly" />
																	<asp:ListItem resourcekey="liYearly" class="normalRadioButton" Value="3" Text="Yearly" />
																</asp:RadioButtonList>
															</div>
														</td>
													</tr>
													<tr>
														<td class="left"></td>
														<td class="right">
															<asp:Panel runat="server" ID="pnlDailyRecurringEvent" Visible="false">
																<asp:Label ID="lblRecurringEvery" resourcekey="lblRecurringEvery" runat="server" Text="Every:" />
																<asp:TextBox ID="tbxDailyRecurringEventDays" runat="server" Width="30px" Text="2" />
																<asp:Label ID="lblRecurringDays" resourcekey="lblRecurringDays" runat="server" Text="day(s)" />
																<asp:RequiredFieldValidator ID="rfvDailyRecurringEventDays" runat="server" ControlToValidate="tbxDailyRecurringEventDays" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Days required." resourcekey="rfvDailyRecurringEventDays.ErrorMessage" ValidationGroup="vgEditArticle"
																	SetFocusOnError="True" />
																<asp:CompareValidator ID="cvDailyRecurringEventDays" runat="server" ControlToValidate="tbxDailyRecurringEventDays" Display="Dynamic" resourcekey="cvDailyRecurringEventDays.ErrorMessage" ErrorMessage="Please enter number only." Operator="DataTypeCheck"
																	Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlWeeklyRecurringEvent" Visible="false">
																<asp:Label ID="lblWeeklyRecurringEvery" resourcekey="lblWeeklyRecurringEvery" runat="server" Text="Recur every:" />
																<asp:TextBox ID="tbxWeeklyRecurringEventWeeks" runat="server" Width="30px" Text="1" />
																<asp:RequiredFieldValidator ID="rfvWeeklyRecurringEventWeeks" runat="server" resourcekey="rfvWeeklyRecurringEventWeeks.ErrorMessage" ControlToValidate="tbxWeeklyRecurringEventWeeks" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Week required."
																	ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																<asp:CompareValidator ID="cvWeeklyRecurringEventWeeks" runat="server" resourcekey="cvWeeklyRecurringEventWeeks.ErrorMessage" ControlToValidate="tbxWeeklyRecurringEventWeeks" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck"
																	Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																<asp:Label ID="lblRecurringWeeks" resourcekey="lblRecurringWeeks" runat="server" Text="weeks(s) on" />
																<div class="edNews_inputGroup">
																	<asp:CheckBoxList ID="cblWeeklyRecurringEvent" CssClass="styledCheckbox inlineList" runat="server" RepeatLayout="UnorderedList">
																		<asp:ListItem class="normalCheckBox" resourcekey="liMonday" Value="1" Text="Monday" />
																		<asp:ListItem class="normalCheckBox" resourcekey="liThuesday" Value="2" Text="Tuesday" />
																		<asp:ListItem class="normalCheckBox" resourcekey="liWednesday" Value="3" Text="Wednesday" />
																		<asp:ListItem class="normalCheckBox" resourcekey="liThursday" Value="4" Text="Thursday" />
																		<asp:ListItem class="normalCheckBox" resourcekey="liFriday" Value="5" Text="Friday" />
																		<asp:ListItem class="normalCheckBox" resourcekey="liSaturday" Value="6" Text="Saturday" />
																		<asp:ListItem class="normalCheckBox" resourcekey="liSunday" Value="7" Text="Sunday" />
																	</asp:CheckBoxList>
																</div>
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlMonthlyRecurringEvent" Visible="false">
																<div class="edNews_inputGroup displayInline">
																	<asp:RadioButtonList ID="rblMonthlyRecurringEventType" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList" runat="server" OnSelectedIndexChanged="rblMonthlyRecurringEventType_SelectedIndexChanged" AutoPostBack="true">
																		<asp:ListItem resourcekey="liRepeatedon" class="normalRadioButton" Value="0" Text="Repeated on:" Selected="True" />
																		<asp:ListItem resourcekey="liRepeatedonday" class="normalRadioButton" Value="1" Text="Repeated on day:" />
																	</asp:RadioButtonList>
																</div>
																<div style="float: left;">
																	<asp:Panel runat="server" ID="pnlRepeatedOn" Visible="true">
																		<asp:DropDownList ID="ddlRepeatedOnEvery" runat="server">
																			<asp:ListItem resourcekey="liFirst" Value="1" Text="First" Selected="True" />
																			<asp:ListItem resourcekey="liSecond" Value="2" Text="Second" />
																			<asp:ListItem resourcekey="liThird" Value="3" Text="Third" />
																			<asp:ListItem resourcekey="liFourth" Value="4" Text="Fourth" />
																			<asp:ListItem resourcekey="liLast" Value="5" Text="Last" />
																		</asp:DropDownList>
																		<asp:DropDownList ID="ddlRepeatedOnDay" runat="server">
																			<asp:ListItem resourcekey="liMonday" Value="1" Text="Monday" />
																			<asp:ListItem resourcekey="liThuesday" Value="2" Text="Tuesday" />
																			<asp:ListItem resourcekey="liWednesday" Value="3" Text="Wednesday" />
																			<asp:ListItem resourcekey="liThursday" Value="4" Text="Thursday" />
																			<asp:ListItem resourcekey="liFriday" Value="5" Text="Friday" />
																			<asp:ListItem resourcekey="liSaturday" Value="6" Text="Saturday" />
																			<asp:ListItem resourcekey="liSunday" Value="7" Text="Sunday" />
																		</asp:DropDownList>
																	</asp:Panel>
																	<asp:Panel runat="server" ID="pnlRepeatedOnDay" Visible="false" Style="margin-top: 3px">
																		<asp:TextBox ID="tbxRepeatedOnDay" runat="server" Width="30px" Text="1" />
																		<asp:RequiredFieldValidator ID="rfvRepeatedOnDay" resourcekey="rfvRepeatedOnDay.ErrorMessage" runat="server" ControlToValidate="tbxRepeatedOnDay" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Day required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																		<asp:CompareValidator ID="cvtbxRepeatedOnDay" resourcekey="cvtbxRepeatedOnDay.ErrorMessage" runat="server" ControlToValidate="tbxRepeatedOnDay" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																		<asp:RangeValidator ID="rvRepeatedOnDay" resourcekey="rvRepeatedOnDay.ErrorMessage" runat="server" MinimumValue="1" MaximumValue="31" ControlToValidate="tbxRepeatedOnDay" Display="Dynamic" ErrorMessage="Please enter number between 1-31." ValidationGroup="vgEditArticle" SetFocusOnError="True" Type="Integer" />
																	</asp:Panel>
																</div>
																<div style="margin-top: 2px">
																	<asp:Label ID="lblRecurringMonthEvery" resourcekey="lblRecurringMonthEvery" runat="server" Text="of every:" Style="margin-left: 5px;" />
																	<asp:TextBox ID="tbxOfEveryMonth" runat="server" Width="30px" Text="1" />
																	<asp:Label ID="lblRecurringMonth" resourcekey="lblRecurringMonth" runat="server" Text=" month(s)" />
																</div>
																<asp:RequiredFieldValidator ID="rfvOfEveryMonth" resourcekey="rfvOfEveryMonth.ErrorMessage" runat="server" ControlToValidate="tbxOfEveryMonth" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Day required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																<asp:CompareValidator ID="cvOfEveryMonth" resourcekey="cvOfEveryMonth.ErrorMessage" runat="server" ControlToValidate="tbxOfEveryMonth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlYearlyRecurringEvent" Visible="false">
																<div class="edNews_inputGroup displayInline">
																	<asp:RadioButtonList ID="rblYearlyRecurringEventType" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList" runat="server" OnSelectedIndexChanged="rblYearlyRecurringEventType_SelectedIndexChanged" AutoPostBack="true">
																		<asp:ListItem resourcekey="liEvery" class="normalRadioButton" Value="0" Text="Every:" Selected="True" />
																		<asp:ListItem resourcekey="liThe" class="normalRadioButton" Value="1" Text="The:" />
																	</asp:RadioButtonList>
																</div>
																<asp:Panel runat="server" ID="pnlYearlyRecurringEventSimple" Visible="true">
																	<asp:DropDownList ID="ddlSimpleMonthOfYear" runat="server">
																		<asp:ListItem resourcekey="liJanuary" Value="1" Text="January" Selected="True" />
																		<asp:ListItem resourcekey="liFebruary" Value="2" Text="February" />
																		<asp:ListItem resourcekey="liMarch" Value="3" Text="March" />
																		<asp:ListItem resourcekey="liApril" Value="4" Text="April" />
																		<asp:ListItem resourcekey="liMay" Value="5" Text="May" />
																		<asp:ListItem resourcekey="liJune" Value="6" Text="June" />
																		<asp:ListItem resourcekey="liJuly" Value="7" Text="July" />
																		<asp:ListItem resourcekey="liAugust" Value="8" Text="August" />
																		<asp:ListItem resourcekey="liSeptember" Value="9" Text="September" />
																		<asp:ListItem resourcekey="liOctober" Value="10" Text="October" />
																		<asp:ListItem resourcekey="liNovember" Value="11" Text="November" />
																		<asp:ListItem resourcekey="liDecember" Value="12" Text="December" />
																	</asp:DropDownList>
																	<asp:TextBox ID="tbxYearlyDayOfMonth" runat="server" Width="30px" Text="1" />
																	<asp:RequiredFieldValidator ID="rfvDayOfMonth" resourcekey="rfvDayOfMonth.ErrorMessage" runat="server" ControlToValidate="tbxYearlyDayOfMonth" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Day required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																	<asp:CompareValidator ID="cvDayOfMonth" resourcekey="cvDayOfMonth.ErrorMessage" runat="server" ControlToValidate="tbxYearlyDayOfMonth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																	<asp:RangeValidator ID="rvDayOfMonth" resourcekey="rvDayOfMonth.ErrorMessage" runat="server" MinimumValue="1" MaximumValue="31" ControlToValidate="tbxYearlyDayOfMonth" Display="Dynamic" ErrorMessage="Please enter number between 1-31." ValidationGroup="vgEditArticle" SetFocusOnError="True" Type="Integer" />
																</asp:Panel>
																<asp:Panel runat="server" ID="pnlYearlyRecurringEventComplex" Visible="false">
																	<asp:DropDownList ID="ddlYearlyRepeatedOnEvery" runat="server">
																		<asp:ListItem resourcekey="liFirst" Value="1" Text="First" Selected="True" />
																		<asp:ListItem resourcekey="liSecond" Value="2" Text="Second" />
																		<asp:ListItem resourcekey="liThird" Value="3" Text="Third" />
																		<asp:ListItem resourcekey="liFourth" Value="4" Text="Fourth" />
																		<asp:ListItem resourcekey="liLast" Value="5" Text="Last" />
																	</asp:DropDownList>
																	<asp:DropDownList ID="ddlYearlyRepeatedOnDay" runat="server">
																		<asp:ListItem resourcekey="liMonday" Value="1" Text="Monday" />
																		<asp:ListItem resourcekey="liThuesday" Value="2" Text="Tuesday" />
																		<asp:ListItem resourcekey="liWednesday" Value="3" Text="Wednesday" />
																		<asp:ListItem resourcekey="liThursday" Value="4" Text="Thursday" />
																		<asp:ListItem resourcekey="liFriday" Value="5" Text="Friday" />
																		<asp:ListItem resourcekey="liSaturday" Value="6" Text="Saturday" />
																		<asp:ListItem resourcekey="liSunday" Value="7" Text="Sunday" />
																	</asp:DropDownList>
																	of
																<asp:DropDownList ID="ddlComplexMonthOfYear" runat="server">
																	<asp:ListItem resourcekey="liJanuary" Value="1" Text="January" Selected="True" />
																	<asp:ListItem resourcekey="liFebruary" Value="2" Text="February" />
																	<asp:ListItem resourcekey="liMarch" Value="3" Text="March" />
																	<asp:ListItem resourcekey="liApril" Value="4" Text="April" />
																	<asp:ListItem resourcekey="liMay" Value="5" Text="May" />
																	<asp:ListItem resourcekey="liJune" Value="6" Text="June" />
																	<asp:ListItem resourcekey="liJuly" Value="7" Text="July" />
																	<asp:ListItem resourcekey="liAugust" Value="8" Text="August" />
																	<asp:ListItem resourcekey="liSeptember" Value="9" Text="September" />
																	<asp:ListItem resourcekey="liOctober" Value="10" Text="October" />
																	<asp:ListItem resourcekey="liNovember" Value="11" Text="November" />
																	<asp:ListItem resourcekey="liDecember" Value="12" Text="December" />
																</asp:DropDownList>
																</asp:Panel>
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlUpcomingOccurrences" Style="clear: both; margin-top: 10px; margin-bottom: 10px;">
																<asp:TextBox ID="tbxUpcomingOccurrences" runat="server" Width="30px" Text="1" />
																<asp:Label ID="lblUpcomingOccurrences" resourcekey="lblUpcomingOccurrences" runat="server" Text="Display upcoming occurrences" />
																<asp:RequiredFieldValidator ID="rfvUpcomingOccurrences" resourcekey="rfvUpcomingOccurrences.ErrorMessage" runat="server" ControlToValidate="tbxUpcomingOccurrences" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Upcoming occurrences required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																<asp:CompareValidator ID="cvUpcomingOccurrences" resourcekey="cvUpcomingOccurrences.ErrorMessage" runat="server" ControlToValidate="tbxUpcomingOccurrences" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																<asp:RegularExpressionValidator ID="revUpcomingOccurrences" resourcekey="revUpcomingOccurrences.ErrorMessage" runat="server" ErrorMessage="Only positive numbers. Zero is not allowed." ValidationExpression="^[1-9]([0-9]+)?" ControlToValidate="tbxUpcomingOccurrences" Display="Dynamic" ValidationGroup="vgEditArticle"
																	SetFocusOnError="True" ForeColor="Red" />
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlRecurringEndType">
																<div class="edNews_inputGroup displayInline">
																	<asp:RadioButtonList ID="rblRecurringEndType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblRecurringEndType_SelectedIndexChanged">
																		<asp:ListItem resourcekey="liEndsafterocurrences" class="normalRadioButton" Value="1" Text="Ends after occurrences" Selected="True" />
																		<asp:ListItem resourcekey="liEndbydate" class="normalRadioButton" Value="2" Text="End by date" />
																	</asp:RadioButtonList>
																</div>
																<asp:Panel runat="server" ID="pnlRecurringEndsAfterOcurrences">
																	<asp:TextBox ID="tbxEndsAfterOcurrences" runat="server" Width="30px" Text="5" />
																	<asp:RequiredFieldValidator ID="rfvEndsAfterOcurrences" resourcekey="rfvEndsAfterOcurrences.ErrorMessage" runat="server" ControlToValidate="tbxEndsAfterOcurrences" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Occurrences required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																	<asp:CompareValidator ID="cvEndsAfterOcurrences" resourcekey="cvEndsAfterOcurrences.ErrorMessage" runat="server" ControlToValidate="tbxEndsAfterOcurrences" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
																	<asp:RegularExpressionValidator ID="revEndsAfterOcurrences" resourcekey="revEndsAfterOcurrences.ErrorMessage" runat="server" ErrorMessage="Only positive numbers. Zero is not allowed." ValidationExpression="^[1-9]([0-9]+)?" ControlToValidate="tbxEndsAfterOcurrences" Display="Dynamic" ValidationGroup="vgEditArticle"
																		SetFocusOnError="True" ForeColor="Red" />
																</asp:Panel>
																<asp:Panel runat="server" ID="pnlRecurringEndByDate" Visible="false">
																	<asp:TextBox ID="tbxRecurringEndByDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" />
																	<asp:RequiredFieldValidator ID="rfvRecurringEndByDate" resourcekey="rfvRecurringEndByDate.ErrorMessage" runat="server" ControlToValidate="tbxRecurringEndByDate" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Date required." ValidationGroup="vgEditArticle" />
																</asp:Panel>
															</asp:Panel>
														</td>
													</tr>
												</table>
											</asp:Panel>

											<asp:Label ID="lblInfoEventLock" runat="server"></asp:Label>

											<table class="settings_table no_margin" runat="server" id="tblEnableEditOccurances">
												<tr>
													<td class="left">
														<label for="<%=cbReccuringInEditMode.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblReccuringInEditMode.Help", true) %>" data-tooltip-position="top-right"><%=_("lblReccuringInEditMode.Text") %></label>
													</td>
													<td class="right">
														<div class="styledCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbReccuringInEditMode" resourcekey="cbReccuringInEditMode" runat="server" AutoPostBack="True" Text="Edit single reccuring event" OnCheckedChanged="cbReccuringInEditMode_CheckedChanged" />
														</div>
													</td>
												</tr>
											</table>

											<asp:Label ID="lblReccuringInEditModeInfo" CssClass="textCenter" runat="server"></asp:Label>

										</div>

										<asp:Panel runat="server" ID="pnlAddEditRecurringEvents" Visible="false">
											<asp:GridView ID="gvRecurringEvents"
												runat="server"
												AutoGenerateColumns="false"
												CellPadding="0" CssClass="grid_view_table row_editing" EnableModelValidation="True" GridLines="None" OnRowCommand="gvRecurringEvents_RowCommand" OnRowEditing="gvRecurringEvents_RowEditing" OnRowDeleting="gvRecurringEvents_RowDeleting">
												<Columns>
													<asp:TemplateField HeaderText="Actions" ItemStyle-Width="100px">
														<EditItemTemplate>
															<asp:LinkButton ID="lbRecurringEventUpdate" runat="server" CausesValidation="true" Text="Update" CommandName="Update" CssClass="action_btn save" resourcekey="lbDocUpdateResource1" ToolTip="Save changes" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
															<asp:LinkButton ID="lbRecurringEventCancel" runat="server" CausesValidation="false" Text="Cancel" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton2Resource1" ToolTip="Discard changes" />
														</EditItemTemplate>
														<ItemTemplate>
															<asp:LinkButton ID="lbRecurringEventEdit" runat="server" CausesValidation="false" CommandName="Edit" CssClass="action_btn tripple edit" ToolTip='<%#_("EditContent")%>' CommandArgument='<%# Eval("RecurringID") %>' />
															<asp:LinkButton ID="lbEditRecurringDateTime" runat="server" CausesValidation="false" CommandName="EditDateTime" CssClass="action_btn tripple edittime" ToolTip='<%#_("EditDateTime")%>' CommandArgument='<%# Eval("RecurringID") %>' />
															<asp:LinkButton ID="lbEditDateRestrictionPayment" runat="server" CausesValidation="false" CommandName="EditDateRestrictionPayment" CssClass="action_btn tripple editDateRestrictionPayment" ToolTip='<%#_("EditDateRestrictionPayment")%>' CommandArgument='<%# Eval("RecurringID") %>' Visible="<%#IsEventRegistrationByDateRestrictionPayment%>" />
															<asp:LinkButton ID="lbRecurringEventDelete" runat="server" CausesValidation="false" CommandName="Delete" CssClass="action_btn tripple delete" ToolTip='<%#_("DeleteThisRecurringEvent")%>' CommandArgument='<%# Eval("RecurringID") %>' OnClientClick="return confirm('Are you sure you want to remove this recurring event?');" />
														</ItemTemplate>
														<HeaderStyle CssClass="actions reccuring" />
														<ItemStyle CssClass="actions reccuring" />
													</asp:TemplateField>
													<asp:TemplateField HeaderText="ID" Visible="false">
														<ItemTemplate>
															<asp:Label ID="lblRecurringID" runat="server" Text='<%# Bind("RecurringID") %>' CssClass="light" />
														</ItemTemplate>
														<HeaderStyle CssClass="title_description" />
														<ItemStyle CssClass="title_description" />
													</asp:TemplateField>
													<asp:TemplateField HeaderText="StartDateTime">
														<ItemTemplate>
															<asp:Label ID="lblLinkUploadTitle" runat="server" Text='<%# ConvertDateTimeFromUTCToPortalTimeZone(Eval("StartDateTime")) %>' CssClass="title" />
														</ItemTemplate>
														<HeaderStyle CssClass="title_description" />
														<ItemStyle CssClass="title_description" />
													</asp:TemplateField>
													<asp:TemplateField HeaderText="EndDateTime">
														<ItemTemplate>
															<asp:Label ID="lblLinkUploadDesc" runat="server" Text='<%# ConvertDateTimeFromUTCToPortalTimeZone(Eval("EndDateTime")) %>' CssClass="title" />
														</ItemTemplate>
														<HeaderStyle CssClass="title_description" />
														<ItemStyle CssClass="title_description" />
													</asp:TemplateField>
													<asp:TemplateField HeaderText="Attendees">
														<ItemTemplate>
															<asp:Label ID="lblAttendees" runat="server" Text='<%# Bind("Attendees") %>' CssClass="light" />
														</ItemTemplate>
														<HeaderStyle CssClass="title_description" />
														<ItemStyle CssClass="title_description" />
													</asp:TemplateField>
													<asp:TemplateField HeaderText="CustomContent">
														<ItemTemplate>
															<asp:Label ID="lblCustomContent" runat="server" Text='<%# GetRecurringEventLocalization(Eval("SelectedLocales")) %>' />
														</ItemTemplate>
														<HeaderStyle CssClass="language" />
														<ItemStyle CssClass="language" />
													</asp:TemplateField>
												</Columns>
												<AlternatingRowStyle CssClass="second" />
												<HeaderStyle CssClass="header_row" />
											</asp:GridView>
											<div style="text-align: center; margin: 10px;">
												<asp:Button ID="btnShowAddRecuringEvent" runat="server" resourcekey="btnShowAddRecuringEvent" Text="Add event" OnClick="btnShowAddRecuringEvent_Click" />
											</div>
											<asp:Panel runat="server" ID="pnlAddRecurringEvent" Visible="false">
												<table class="settings_table no_margin" runat="server" id="tblRecurringDatesEdit" visible="false">
													<tr>
														<td class="left" style="vertical-align: top; padding-top: 2px;">
															<label for="<%=tbxRecurringEventStartDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventStartDateTime.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventStartDateTime.Text") %></label>
														</td>
														<td class="right" style="width: 225px;">
															<asp:TextBox ID="tbxRecurringEventStartDate" runat="server" CssClass="text_generic center" ValidationGroup="vgAddRecurringEvent" Width="90px" />
															<img src="<%=_ControlPath%>images/icons/calendar.png" alt="RecurringEventStartDate" style="position: relative; top: 2px" />
															<asp:RequiredFieldValidator ID="rfvRecurringEventStartDate" runat="server" ControlToValidate="tbxRecurringEventStartDate" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Date required." ValidationGroup="vgAddRecurringEvent" resourcekey="rfvEventStartDateResource1" />
															<asp:Label ID="lblRecurringEvStartDateError" runat="server" ForeColor="Red" resourcekey="lblPubDateErrorResource1" Text="Invalid date." Visible="false" />
															<asp:TextBox ID="tbxRecurringEventStartTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="55px" />
															<span id="tbxRecurringEventStartTimeIcon" runat="server" class="clockicon"></span>
															&nbsp;<asp:RegularExpressionValidator ID="revRecurringEventStartTime" runat="server" ControlToValidate="tbxRecurringEventStartTime" Enabled="false" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgAddRecurringEvent" Display="Dynamic"
																resourcekey="revEventStartTimeResource1" />
															<asp:RequiredFieldValidator ID="rfvRecurringEventStartTime" runat="server" ControlToValidate="tbxRecurringEventStartTime" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Time required." ValidationGroup="vgAddRecurringEvent" resourcekey="rfvEventStartTimeResource1" />
														</td>
													</tr>
													<tr>
														<td class="left" style="vertical-align: top; padding-top: 2px;">
															<label for="<%=tbxRecurringEventEndDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventEndDateTime.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventEndDateTime.Text") %></label>
														</td>
														<td class="right">
															<asp:TextBox ID="tbxRecurringEventEndDate" runat="server" CssClass="text_generic center" ValidationGroup="vgAddRecurringEvent" Width="90px" />
															<img src="<%=_ControlPath%>images/icons/calendar.png" alt="RecurringEventEndDate" style="position: relative; top: 2px" />
															<asp:RequiredFieldValidator ID="rfvRecurringEventEndDate" runat="server" ControlToValidate="tbxRecurringEventEndDate" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Date required." ValidationGroup="vgAddRecurringEvent" resourcekey="rfvEventEndDateResource1" />
															<asp:Label ID="lblRecurringEvEndDateError" runat="server" ForeColor="Red" resourcekey="lblExpireDateErrorResource1" Text="Invalid date." Visible="false" />
															<asp:TextBox ID="tbxRecurringEventEndTime" runat="server" CssClass="text_generic center" ValidationGroup="vgAddRecurringEvent" Width="55px" />
															<span id="tbxRecurringEventEndTimeIcon" runat="server" class="clockicon"></span>
															&nbsp;<asp:RegularExpressionValidator ID="revRecurringEventEndTime" runat="server" ControlToValidate="tbxRecurringEventEndTime" Enabled="false" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgAddRecurringEvent" Display="Dynamic"
																resourcekey="revEventEndTImeResource1" />
															<asp:RequiredFieldValidator ID="rfvRecurringEventEndTime" runat="server" ControlToValidate="tbxRecurringEventEndTime" CssClass="NormalRed" Display="Dynamic" Enabled="false" ErrorMessage="Time required." ValidationGroup="vgAddRecurringEvent" resourcekey="rfvEventEndResource1" />
														</td>
													</tr>
												</table>
												<table class="settings_table no_margin" runat="server" id="tblRecurringDateRestrictionPayment" visible="false">
													<tr>
														<td>
															<asp:Literal runat="server" ID="litRecurringEventDateInfo"></asp:Literal>
														</td>
													</tr>
													<tr>
														<td>
															<asp:HiddenField runat="server" ID="hfRecurringDateCostMatrix" />
															<asp:HiddenField runat="server" ID="hfRecurringDateCostMatrixViewSpecific" />
															<div id="eds__RecurringCostByDateRestriction" class="edNews_manipulatingTable"></div>
															<asp:TextBox ID="tbRecurringValidateDecimal" runat="server" Style="display: none"></asp:TextBox>
															<asp:CompareValidator ID="CompareValidator1" ControlToValidate="tbRecurringValidateDecimal" runat="server" ErrorMessage="" Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="false" ValidationGroup="vgAddRecurringEvent"></asp:CompareValidator>
														</td>
													</tr>
												</table>
												<div style="text-align: center; margin: 10px;">
													<asp:Button ID="btnSaveRecuringEvent" runat="server" CommandName="SaveEventDates" Text="Save" OnClientClick="return EdsSaveButtonClick('vgAddRecurringEvent');" OnClick="EditRecuringEventButtonsClick" ValidationGroup="vgAddRecurringEvent" />
													<asp:Button ID="btnUpdateRecuringEvent" runat="server" CommandName="UpdateEventDates" Text="Save" OnClientClick="return EdsSaveButtonClick('vgAddRecurringEvent');" OnClick="EditRecuringEventButtonsClick" ValidationGroup="vgAddRecurringEvent" Visible="false" />
													<asp:Button ID="btnCloseRecuringEvent" runat="server" Text="Close" OnClick="btnCloseRecuringEvent_Click" />
													<asp:Label ID="lblSaveRecuringEventInfo" runat="server"></asp:Label>
												</div>
											</asp:Panel>
										</asp:Panel>

										<asp:Panel runat="server" ID="pnlRecurringContentEdit" Visible="false">
											<table class="settings_table" cellpadding="0" cellspacing="0">
												<tr>
													<td class="left">
														<asp:Label ID="lblRecurringPortalDefLanguage" runat="server" Text="Portal default language:" resourcekey="lblPortalDefLanguageResource1" />
													</td>
													<td class="right">
														<asp:Label ID="lblRecurringDefaultPortalLangugageImage" runat="server" resourcekey="lblDefaultPortalLangugageImageResource1" />
													</td>
												</tr>
												<tr>
													<td class="left">
														<asp:Label ID="lblRecurringContentLocalizationLocalizedLanguages" runat="server" Text="Localized languages:" resourcekey="lblContentLocalizationLocalizedLanguagesResource1" />
													</td>
													<td class="right">
														<asp:Label ID="lblRecurringContentLocalizationLocalizedLanguagesList" runat="server" resourcekey="lblContentLocalizationLocalizedLanguagesListResource1" />
													</td>
												</tr>
											</table>
											<div class="text_input_set">
												<label for="<%=ddlRecurringEventsLocales.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContentLocalizationSelectLanguage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblContentLocalizationSelectLanguage.Text") %></label>
												<asp:DropDownList ID="ddlRecurringEventsLocales" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRecurringEventsLocales_SelectedIndexChanged" />
												<asp:LinkButton ID="lbRecurringEventsDeleteContent" CssClass="silver_button" Style="float: right;" runat="server" OnClick="lbRecurringEventsDeleteContent_Click" OnClientClick="return confirm('Are you sure you want to delete selected content?');"><span><%=RecurringEventsDeleteContent%></span></asp:LinkButton>
												<asp:LinkButton ID="lbRecurringEventsCopyContent" CssClass="silver_button" Style="float: right;" runat="server" OnClick="lbRecurringEventsCopyContent_Click"> <span><%=RecurringEventsCopyContent%></span></asp:LinkButton>
											</div>
											<div class="text_input_set">
												<label for="<%=teRecurringEventSummary.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRecurringEventSummary.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRecurringEventSummary.Text") %></label>
												<dnn:TextEditor ID="teRecurringEventSummary" runat="server" Height="250px" Visible="false" />
												<asp:TextBox ID="tbxRecurringEventSummary" runat="server" TextMode="MultiLine" Height="250" Width="700" Visible="false" />
												<asp:Label ID="lblRecurringEventSummaryCountMaxChar" runat="server" Style="float: right;" />
											</div>
											<div class="text_input_set">
												<label for="<%=teRecurringEventArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRecurringEventArticle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRecurringEventArticle.Text") %></label>
												<dnn:TextEditor ID="teRecurringEventArticle" runat="server" Height="500px" Visible="false" />
												<asp:TextBox ID="tbxRecurringEventArticle" runat="server" TextMode="MultiLine" Height="500" Width="732" Visible="false" />
												<asp:Label ID="lblRecurringEventArticleCountMaxChar" runat="server" Style="float: right;" />
											</div>

											<asp:Label ID="lblAddEventContentInfo" runat="server"></asp:Label>

											<asp:Panel ID="pnlRecurringEventDocumentUpload" CssClass="section_box white_border_1 dark_grey document_reccuring_upload" runat="server">
												<h1 class="section_box_title">
													<span><%=DOCUMENTSincluded%></span></h1>
												<div class="edNews_inputGroup displayInline">
													<asp:RadioButtonList ID="rblRecurringEventAddDocumentType" CssClass="styledRadio inlineList" runat="server" RepeatLayout="UnorderedList" onclick="toogleRecurringEventDocumentPanels()">
														<asp:ListItem Value="0" class="normalRadioButton" Text="Upload new documents" Selected="True" resourcekey="rblAddDocumentType-newDocument" />
														<asp:ListItem Value="1" class="normalRadioButton" Text="Add existing document" resourcekey="rblAddDocumentType-existingDocument" />
													</asp:RadioButtonList>
												</div>
												<div class="content document_upload">
													<div class="rounded3dBox" runat="server" id="divRecurringEventAddDocuments">
														<asp:Panel ID="pnlRecurringEventAddDocument" runat="server">
															<div id="divRecurringEventAddDocumentFineUploader" runat="server" visible="false" class="EDS_simpleFineUploader documents_fine_uploader">
																<div class="uploader">
																</div>
																<div class="uploadControls">
																	<div class="infomsg">Drag and drop documents here or click on Select documents button</div>
																	<div class="actions">
																		<span class="action fileSelection rounded_button gradient icon document_in_folder">
																			<asp:Label ID="lblRecurringEventDocumentFineUploaderSelect" runat="server" resourcekey="fineUploaderSelectDocuments" Text="Select documents" />
																			<span class="dnnInputFileWrapper">
																				<input type="file" value="" multiple="multiple" />
																			</span></span><span class="action upload rounded_button gradient icon orange_plus">
																				<asp:Label ID="lblRecurringEventDocumentFineUploaderStart" runat="server" resourcekey="fineUploaderUpload" Text="Upload" />
																			</span>
																	</div>
																	<div class="dndContainer">
																		<p>
																			<asp:Label ID="lblRecurringEventDocumentFineUploaderDrag" runat="server" resourcekey="fineUploaderDragFilesHere" Text="Drag files here" />
																		</p>
																	</div>
																</div>
																<div class="uploadDetails">
																	<ol class="fileUploadList">
																	</ol>
																</div>
															</div>
															<div id="divRecurringEventAddDocumentStandardUploader" runat="server" visible="true" class="documents_standard_uploader">
																<asp:Label ID="lblRecurringEventDocUploadmessage" CssClass="upload_message" Visible="false" EnableViewState="false" runat="server" />
																<span class="file_selection rounded_button gradient icon document_in_folder">
																	<asp:FileUpload ID="fuRecurringEventDocFileUpload" runat="server" />
																</span>
																<asp:LinkButton ID="btnRecurringEventDocUpload" runat="server" ValidationGroup="vgRecurringEventDocs" resourcekey="btnDocUploadResource1" CssClass="action upload rounded_button gradient icon orange_plus" OnClick="btnRecurringEventDocUpload_Click"><span>Upload</span></asp:LinkButton>
															</div>
														</asp:Panel>
														<asp:Panel ID="pnlRecurringEventAddExistingDocument" runat="server" CssClass="documents_add_existing_container" Style="display: none;">
															<div class="messages">
																<asp:Label runat="server" ID="lblRecurringEventAddDocumentInfo" EnableViewState="false" Visible="false" CssClass="error" />
																<p>
																	<asp:RequiredFieldValidator ID="rfvRecurringEventExistingDocumentID" resourcekey="rfvExistingDocumentID.ErrorMessage" runat="server" ControlToValidate="tbxRecurringEventExistingDocumentID" ErrorMessage="Document ID must be set" ValidationGroup="vgRecurringEventDocumentLinks" Display="Dynamic"
																		CssClass="error" />
																</p>
																<p>
																	<asp:CompareValidator ID="cvRecurringEventExistingDocumentID" resourcekey="cvExistingDocumentID.ErrorMessage" runat="server" ControlToValidate="tbxRecurringEventExistingDocumentID" ErrorMessage="Document ID must be an integer" Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgRecurringEventDocumentLinks"
																		Display="Dynamic" CssClass="error" />
																</p>
															</div>
															<div class="search_by_document_title">
																<p>
																	<%=Searchdocuments%>
																</p>
																<asp:TextBox ID="tbxRecurringEventDocumentText" runat="server" AutoCompleteType="Search" CausesValidation="False" EnableViewState="false" CssClass="rounded_text_box" />
															</div>
															<div class="search_by_document_id">
																<p>
																	<%=Documentid%>
																</p>
																<asp:TextBox ID="tbxRecurringEventExistingDocumentID" runat="server" CausesValidation="False" EnableViewState="false" CssClass="rounded_text_box grey" />
															</div>
															<asp:LinkButton ID="btnRecurringEventAddExistingDocument" runat="server" OnClick="lbRecurringEventAddExistingDocument_Click" ValidationGroup="vgRecurringEventDocumentLinks" CssClass="add_button rounded_button gradient icon orange_plus"><span><%=Add%></span></asp:LinkButton>
															<div class="clear_float">
															</div>
														</asp:Panel>
													</div>
													<div class="rounded3dBox" runat="server" id="divRecurringEventYouCanNotAddMoreDocuments" visible="false">
														<asp:Label ID="lblRecurringEventYouCanNotAddMoreDocuments" runat="server" />
													</div>
													<asp:GridView ID="gvRecurringEventDocuments" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="grid_view_table" DataKeyNames="DocEntryID,RecurringID" EnableModelValidation="True" GridLines="None" OnRowCommand="gvRecurringEventDocuments_RowCommand" OnRowEditing="gvRecurringEventDocuments_RowEditing"
														OnRowCancelingEdit="gvRecurringEventDocuments_RowCancelingEdit" OnRowUpdating="gvRecurringEventDocuments_RowUpdating" OnRowUpdated="gvRecurringEventDocuments_RowUpdated" OnRowDeleting="gvRecurringEventDocuments_RowDeleting" OnRowDataBound="gvRecurringEventDocuments_RowDataBound" OnPreRender="gvRecurringEventDocuments_PreRender" OnPageIndexChanged="gvRecurringEventDocuments_PageIndexChanged" OnPageIndexChanging="gvRecurringEventDocuments_PageIndexChanging">
														<AlternatingRowStyle CssClass="second" />
														<Columns>
															<asp:TemplateField HeaderText="Actions">
																<EditItemTemplate>
																	<asp:LinkButton ID="lbDocUpdate" runat="server" CausesValidation="true" CommandName="Update" CssClass="action_btn save" resourcekey="lbDocUpdateResource1" ToolTip="Save changes" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
																	<asp:LinkButton ID="lbDocCancel" runat="server" CausesValidation="false" CommandName="Cancel" CssClass="action_btn cancel" resourcekey="LinkButton2Resource1" ToolTip="Discard changes" />
																</EditItemTemplate>
																<ItemTemplate>
																	<asp:LinkButton ID="lbDocEdit" runat="server" CausesValidation="false" CommandName="Edit" CssClass="action_btn edit" resourcekey="LinkButton1Resource1" ToolTip="<%#Editthisdocument %>" />
																	<asp:LinkButton ID="lbDocDelete" runat="server" CausesValidation="false" CommandName="Delete" CssClass="action_btn red_x" resourcekey="lbDeleteDocResource1" ToolTip="<%#Deletethisdocument%>" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' />
																</ItemTemplate>
																<HeaderStyle CssClass="actions" />
																<ItemStyle CssClass="actions" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="TitleDescription">
																<EditItemTemplate>
																	<asp:TextBox ID="tbDocTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="light" />
																	<asp:TextBox ID="tbDocDescription" runat="server" Text='<%# Bind("Description") %>' CssClass="light" />
																</EditItemTemplate>
																<ItemTemplate>
																	<asp:Label ID="lblDocUploadTitle" runat="server" CssClass="title" Text='<%# Bind("Title") %>' />
																	<asp:Label ID="lblDocUploadDesc" runat="server" CssClass="description" Text='<%#Bind("Description") %>' />
																	<input type="text" class="token light" value="<%# GenerateDocumentToken(Convert.ToString(Eval("DocEntryID"))) %>" />
																</ItemTemplate>
																<HeaderStyle CssClass="title_dscription" />
																<ItemStyle CssClass="title_dscription" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Info">
																<ItemTemplate>
																	<p class="document_link <%#PrintAlreadyInUseClass((bool) Eval("InUseByOther")) %>">
																		<%#GetDocumentDownloadLink(Convert.ToString(Eval("DocEntryID")), Convert.ToString(Eval("Filename")), Convert.ToString(Eval("FileExtension")))%>
																	</p>
																	<p>
																		<asp:Label ID="lblDateUploaded" runat="server" Text='<%# Convert.ToDateTime(Eval("DateUploaded")).ToShortDateString() %>' />
																		-
																			<asp:Label ID="lblDocUploadAuthor" runat="server" Text='<%#Eval("DisplayName")%>' />
																	</p>
																	<p>
																		<asp:Label ID="lblFileSize" runat="server" Text='<%# EasyDNNSolutions.Modules.EasyDNNNews.StringHelpers.HumanReadableFileSize(Convert.ToDouble(Eval("FileSize"))) %>' />
																	</p>
																	<p>
																		<asp:Label ID="lblDownloads" runat="server" Text='<%# NumberOfDownloadsText(Convert.ToString(Eval("NumberOfDownloads"))) %>' />
																	</p>
																</ItemTemplate>
																<EditItemTemplate>
																	<p>
																		<asp:Label ID="lbFilenameEdit" runat="server" Text='<%# GetDocumentFilename(Convert.ToString(Eval("Filename")),Convert.ToString(Eval("FileExtension"))) %>' />
																	</p>
																	<div id="divReplaceFileContainer" runat="server" class="replace_file">
																		<p>
																			<asp:Label ID="lblReplaceFile" runat="server" Text="Replace existing file:" resourcekey="lblDocumentsReplaceFile" />
																		</p>
																		<asp:FileUpload ID="fuReplaceFile" runat="server" />
																	</div>
																</EditItemTemplate>
																<HeaderStyle CssClass="info" />
																<ItemStyle CssClass="info" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Lang">
																<ItemTemplate>
																	<asp:Label ID="lblLang" runat="server" Text='<%# GetDocumentLocalization(Convert.ToString(Eval("SelectedLocales"))) %>' />
																</ItemTemplate>
																<EditItemTemplate>
																	<div class="language_selection_container">
																		<asp:ListBox ID="lbEditDocUploadLanguage" runat="server" SelectionMode="Multiple" />
																	</div>
																</EditItemTemplate>
																<HeaderStyle CssClass="language" />
																<ItemStyle CssClass="language" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Target">
																<EditItemTemplate>
																	<asp:DropDownList ID="ddlLinkTarget" runat="server">
																		<asp:ListItem Value="0" Text="_self" Selected="True" />
																		<asp:ListItem Value="1" Text="_blank" />
																		<asp:ListItem Value="2" Text="_parent" />
																		<asp:ListItem Value="3" Text="_top" />
																	</asp:DropDownList>
																</EditItemTemplate>
																<ItemTemplate>
																	<asp:Label ID="lblTarget" runat="server" Text='<%# TargetToString(Convert.ToByte(Eval("Target")))%>' />
																</ItemTemplate>
																<HeaderStyle CssClass="target" />
																<ItemStyle CssClass="target" />
															</asp:TemplateField>
															<asp:TemplateField HeaderText="Show">
																<ItemTemplate>
																	<asp:CheckBox CssClass="normalCheckBox" ID="CheckBox1" runat="server" Enabled="false" Checked='<%#Convert.ToBoolean(Eval("Visible"))%>' />
																</ItemTemplate>
																<EditItemTemplate>
																	<asp:CheckBox CssClass="normalCheckBox" runat="server" ID="cbDocumentVisible" Enabled="true" Checked='<%#Convert.ToBoolean(Eval("Visible"))%>' />
																</EditItemTemplate>
																<HeaderStyle CssClass="tdShow" />
																<ItemStyle CssClass="tdShow" />
															</asp:TemplateField>
															<asp:TemplateField ShowHeader="false">
																<ItemTemplate>
																	<asp:Label ID="lblPosition" runat="server" Text='<%# Bind("Position") %>' CssClass="rounded_inset_text_box" />
																</ItemTemplate>
																<EditItemTemplate>
																	<asp:TextBox ID="tbxPosition" runat="server" Text='<%# Bind("Position") %>' CssClass="light" />
																</EditItemTemplate>
																<HeaderStyle CssClass="position" />
																<ItemStyle CssClass="position" />
															</asp:TemplateField>
															<asp:TemplateField ShowHeader="false">
																<ItemTemplate>
																	<asp:LinkButton ID="lbDocMoveDown" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Down" runat="server" CssClass="arrow down" resourcekey="lbDocMoveDownResource1" />
																	<asp:LinkButton ID="lbDocMoveUp" CommandArgument='<%# ((GridViewRow) Container).RowIndex %>' CommandName="Up" runat="server" CssClass="arrow up" resourcekey="lbDocMoveUpResource1" />
																</ItemTemplate>
																<HeaderStyle CssClass="arrows" />
																<ItemStyle CssClass="arrows" />
															</asp:TemplateField>
														</Columns>
														<HeaderStyle CssClass="header_row" />
													</asp:GridView>
												</div>
												<asp:Button ID="btnRecurringEventDocUploadRefresh" runat="server" Text="refresf" Style="display: none;" OnClick="btnRecurringEventDocUploadRefresh_Click" />
											</asp:Panel>
											<br />
											<asp:Button ID="btnSaveRecurringEventContent" runat="server" Text="Save" OnClick="btnSaveRecurringEventContent_Click" />
											<asp:Button ID="btnSaveAndCloseRecurringEventContent" runat="server" Text="Save & Close" OnClick="btnSaveAndCloseRecurringEventContent_Click" />
											<asp:Button ID="btnCloseRecurringEventContent" runat="server" Text="Close" OnClick="btnCloseRecurringEventContent_Click" />
										</asp:Panel>
									</div>
								</asp:Panel>

								<table runat="server" id="tblEventRegistration" class="settings_table no_margin">
									<tr>
										<td class="left">
											<label for="<%=cbRegistrationOnEvent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRegistrationOnEvent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRegistrationOnEvent.Text") %></label>
										</td>
										<td class="right">
											<div class="styledCheckbox">
												<asp:CheckBox CssClass="normalCheckBox" ID="cbRegistrationOnEvent" resourcekey="cbRegistrationOnEvent" runat="server" Text="Enable registrations" AutoPostBack="True" OnCheckedChanged="cbRegistrationOnEvent_CheckedChanged" />

												<asp:Label ID="lblRegistrationInfo" runat="server" EnableViewState="false" ResourceKey="lbMustSaveBeforeEnable"></asp:Label>
											</div>
										</td>
									</tr>
								</table>

								<asp:Panel runat="server" ID="pnlPostSettings" Visible="true">
									<table class="settings_table no_margin eventregistration">
										<tr>
											<td class="left">
												<label for="<%=cbSendInvitations.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendInvitations.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendInvitations.Text") %></label>
											</td>
											<td class="right">
												<div class="styledCheckbox">
													<asp:CheckBox CssClass="normalCheckBox" ID="cbSendInvitations" resourcekey="cbSendInvitations" Text="Use default invitations" runat="server" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="left">
												<label for="<%=cbSendReminders.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendReminders.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendReminders.Text") %></label>
											</td>
											<td class="right">
												<div class="styledCheckbox">
													<asp:CheckBox CssClass="normalCheckBox" ID="cbSendReminders" resourcekey="cbSendReminders" Text="Use default reminders" runat="server" />
												</div>
											</td>
										</tr>
									</table>
								</asp:Panel>

								<asp:Panel runat="server" ID="pnlEventRegistration" Visible="false">
									<div class="rounded3dBox">

										<table class="settings_table no_margin eventregistration">
											<tr>
												<td class="left">
													<label for="<%=rblEventRegistrationType.ClientID %>"><%=_("liRegistrationType.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline">
														<asp:RadioButtonList ID="rblEventRegistrationType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblEventRegistrationType_SelectedIndexChanged">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liRegistrationTypeClassinc" Text="Classic" Selected="True" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liRegistrationTypeSocial" Text="Social (only for registered users)" />
														</asp:RadioButtonList>
													</div>
												</td>
											</tr>
											<tr runat="server" id="rowEventMaxNumberOfTickets">
												<td class="left">
													<label for="<%=tbxMaxNumberOfTickets.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventMaxNumberOfTickets.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventMaxNumberOfTickets.Text") %></label>
												</td>
												<td class="right">
													<asp:TextBox ID="tbxMaxNumberOfTickets" runat="server" CssClass="smallCentered" Text="0" /><asp:Label ID="lblNumberofseatsunlimited" resourcekey="lblNumberofseatsunlimited.Text" runat="server" Text="(0 is unlimited)"></asp:Label>
													<asp:RequiredFieldValidator ID="rfvMaxNumberOfTickets" resourcekey="rfvMaxNumberOfTickets.ErrorMessage" runat="server" ControlToValidate="tbxMaxNumberOfTickets" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
													<asp:CompareValidator ID="cvMaxNumberOfTickets" resourcekey="cvMaxNumberOfTickets.ErrorMessage" runat="server" ControlToValidate="tbxMaxNumberOfTickets" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
													<asp:RegularExpressionValidator ID="revMaxNumberOfTickets" resourcekey="revMaxNumberOfTickets.ErrorMessage" runat="server" ControlToValidate="tbxMaxNumberOfTickets" ErrorMessage="Only positive numbers. Zero is for all." ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="vgEditArticle"
														SetFocusOnError="True" ForeColor="Red" />
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=rblEnableRegistrationType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableRegistration.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableRegistration.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline floatLeft" style="margin-right: 5px;">
														<asp:RadioButtonList ID="rblEnableRegistrationType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblEnableRegistrationType_SelectedIndexChanged">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liAfterpublishdate" Text="After publish date" Selected="True" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liNumberofdaysbeforeeventstartdate" Text="Number of days before event start date" />
														</asp:RadioButtonList>
													</div>
													<asp:Panel runat="server" ID="pnlEnableRegistrationType" Visible="false">
														<asp:TextBox ID="tbxEnableDaysBeforeStartDate" runat="server" Width="30px" Text="10" />
														<asp:RequiredFieldValidator ID="rfvEnableDaysBeforeStartDate" resourcekey="rfvEnableDaysBeforeStartDate.ErrorMessage" runat="server" ControlToValidate="tbxEnableDaysBeforeStartDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:CompareValidator ID="cvEnableDaysBeforeStartDate" resourcekey="cvEnableDaysBeforeStartDate.ErrorMessage" runat="server" ControlToValidate="tbxEnableDaysBeforeStartDate" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:RegularExpressionValidator ID="revEnableDaysBeforeStartDate" resourcekey="revEnableDaysBeforeStartDate.ErrorMessage" runat="server" ControlToValidate="tbxEnableDaysBeforeStartDate" ErrorMessage="Only positive numbers. Zero is for all." ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="vgEditArticle"
															SetFocusOnError="True" ForeColor="Red" />
													</asp:Panel>
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=rblDisableRegistrationType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisableRegistration.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDisableRegistration.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline floatleft" style="margin-right: 5px;">
														<asp:RadioButtonList ID="rblDisableRegistrationType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblDisableRegistrationType_SelectedIndexChanged">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liWheneventstarts" Text="When event starts" Selected="True" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liNumberofdaysbeforeeventstartdate" Text="Number of days before event start date" />
														</asp:RadioButtonList>
													</div>
													<asp:Panel runat="server" ID="pnlDisableRegistrationType" Visible="false">
														<asp:TextBox ID="tbxDisableDaysBeforeStartDate" runat="server" Width="30px" Text="10" />
														<asp:RequiredFieldValidator ID="rfvDisableDaysBeforeStartDate" resourcekey="rfvDisableDaysBeforeStartDate.ErrorMessage" runat="server" ControlToValidate="tbxDisableDaysBeforeStartDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:CompareValidator ID="cvDisableDaysBeforeStartDate" resourcekey="cvDisableDaysBeforeStartDate.ErrorMessage" runat="server" ControlToValidate="tbxDisableDaysBeforeStartDate" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:RegularExpressionValidator ID="revDisableDaysBeforeStartDate" resourcekey="revDisableDaysBeforeStartDate.ErrorMessage" runat="server" ControlToValidate="tbxDisableDaysBeforeStartDate" ErrorMessage="Only positive numbers. Zero is for all." ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="vgEditArticle" SetFocusOnError="True" ForeColor="Red" />
													</asp:Panel>
												</td>
											</tr>
											<tr runat="server" id="rowTicketsUserCanRegister">
												<td class="left">
													<label for="<%=rblTicketsUserCanRegister.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTicketsUserCanRegister.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTicketsUserCanRegister.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline floatLeft" style="margin-right: 5px;">
														<asp:RadioButtonList ID="rblTicketsUserCanRegister" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblTicketsUserCanRegister_SelectedIndexChanged">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liUnlimited" Text="Unlimited" Selected="True" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liMinMaxvalue" Text="Min - Max value" />
														</asp:RadioButtonList>
													</div>
													<asp:Panel runat="server" ID="pnlTicketsUserCanRegister" Visible="false">
														<asp:TextBox ID="tbxEventRegisterMinTickets" runat="server" Width="30px" Text="1" />
														<asp:RequiredFieldValidator ID="rfvEventRegisterMinTickets" resourcekey="rfvEventRegisterMinTickets.ErrorMessage" runat="server" ControlToValidate="tbxEventRegisterMinTickets" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:CompareValidator ID="cvEventRegisterMinTickets" resourcekey="cvEventRegisterMinTickets.ErrorMessage" runat="server" ControlToValidate="tbxEventRegisterMinTickets" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:RegularExpressionValidator ID="revEventRegisterMinTickets" resourcekey="revEventRegisterMinTickets.ErrorMessage" runat="server" ControlToValidate="tbxEventRegisterMinTickets" ErrorMessage="Only positive numbers. Zero is for all." ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="vgEditArticle" SetFocusOnError="True" ForeColor="Red" />
														<asp:TextBox ID="tbxEventRegisterMaxTickets" runat="server" Width="30px" Text="1" />
														<asp:RequiredFieldValidator ID="rfEventRegisterMaxTickets" resourcekey="rfEventRegisterMaxTickets.ErrorMessage" runat="server" ControlToValidate="tbxEventRegisterMaxTickets" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Required." ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:CompareValidator ID="cvEventRegisterMaxTickets" resourcekey="cvEventRegisterMaxTickets.ErrorMessage" runat="server" ControlToValidate="tbxEventRegisterMaxTickets" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgEditArticle" SetFocusOnError="True" />
														<asp:RegularExpressionValidator ID="revEventRegisterMaxTickets" resourcekey="revEventRegisterMaxTickets.ErrorMessage" runat="server" ControlToValidate="tbxEventRegisterMaxTickets" ErrorMessage="Only positive numbers. Zero is for all." ValidationExpression="^[0-9]*$" Display="Dynamic" ValidationGroup="vgEditArticle" SetFocusOnError="True" ForeColor="Red" />
													</asp:Panel>
												</td>
											</tr>
											<tr runat="server" id="rowRegistrationType">
												<td class="left">
													<label for="<%=rblRegistrationType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRegistrationType.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRegistrationType.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline">
														<asp:RadioButtonList ID="rblRegistrationType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liRegistrationonsiteisnecessary" Text="Registration on site is necessary" Selected="True" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liRegistrationonsiteisnotnecessary" Text="Registration on site is not necessary" />
														</asp:RadioButtonList>
													</div>
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=rblEventRegistrationRole.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventRegistrationRole.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventRegistrationRole.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline">
														<asp:RadioButtonList ID="rblEventRegistrationRole" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblEventRegistrationRole_SelectedIndexChanged">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liNone" Text="None" Selected="True" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liSelectrole" Text="Select role" />
														</asp:RadioButtonList>
													</div>
													<asp:Panel runat="server" ID="pnlEventRegistrationRole" Visible="false">
														<asp:DropDownList ID="ddlEventRegistrationRoles" runat="server"></asp:DropDownList>
													</asp:Panel>
												</td>
											</tr>
											<tr runat="server" id="rowRegistrationApproval">
												<td class="left">
													<label for="<%=cbRegistrationApproval.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRegistrationApproval.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRegistrationApproval.Text") %></label>
												</td>
												<td class="right">
													<div class="styledCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbRegistrationApproval" resourcekey="cbRegistrationApproval" Text="Required approval" runat="server" />
													</div>
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=cbDisableFurtherRegistration.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisableFurtherRegistration.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDisableFurtherRegistration.Text") %></label>
												</td>
												<td class="right">
													<div class="styledCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbDisableFurtherRegistration" resourcekey="cbDisableFurtherRegistration" Text="Disable further registrations" runat="server" />
													</div>
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=cbEnableCancelRegistrations.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableCancelRegistrations.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableCancelRegistrations.Text") %></label>
												</td>
												<td class="right">
													<div class="styledCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableCancelRegistrations" resourcekey="cbEnableCancelRegistrations" Text="Enable cancel registrations" runat="server" />
													</div>
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=rblShowRegistredUsersTo.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowRegistredUsersRole.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowRegistredUsersRole.Text") %></label>
												</td>
												<td class="right">
													<div class="edNews_inputGroup displayInline">
														<asp:RadioButtonList ID="rblShowRegistredUsersTo" runat="server" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList" AutoPostBack="true" OnSelectedIndexChanged="rblShowRegistredUsersTo_SelectedIndexChanged">
															<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liNone" Text="None" />
															<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liAll" Text="All" Selected="True" />
															<asp:ListItem Value="2" class="normalRadioButton" resourcekey="liSelectrole" Text="Select role" />
														</asp:RadioButtonList>
													</div>
													<asp:DropDownList ID="ddlShowRegistredUsersRole" runat="server"></asp:DropDownList>
												</td>
											</tr>
											<tr runat="server" id="rowRegistrationCFtemplateID">
												<td class="left">
													<label for="<%=ddlRegistrationCFtemplateID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRegistrationCFtemplateID.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRegistrationCFtemplateID.Text") %></label>
												</td>
												<td class="right">
													<asp:DropDownList ID="ddlRegistrationCFtemplateID" runat="server"></asp:DropDownList>
												</td>
											</tr>

										</table>

										<asp:Panel runat="server" ID="pnlEventPayment" Visible="false">

											<asp:HiddenField ID="hfCostPerAttendee" runat="server" />
											<asp:HiddenField ID="hfAttendeesDiscount" runat="server" />

											<asp:UpdatePanel ID="upEventPayment" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
												<ContentTemplate>
													<div class="edn_admin_progress_overlay_container">
														<asp:UpdateProgress ID="uppEventPayment" runat="server" AssociatedUpdatePanelID="upEventPayment" DisplayAfter="100" DynamicLayout="true">
															<ProgressTemplate>
																<div class="edn_admin_progress_overlay">
																</div>
															</ProgressTemplate>
														</asp:UpdateProgress>

														<table class="settings_table no_margin eventregistration">
															<tr>
																<td class="left">
																	<label for="<%=rblEventPayment.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventPayment.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventPayment.Text") %></label>
																</td>
																<td class="right">
																	<div class="edNews_inputGroup displayInline">
																		<asp:RadioButtonList ID="rblEventPayment" runat="server" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList" OnSelectedIndexChanged="rblEventPayment_SelectedIndexChanged" AutoPostBack="true">
																			<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liFree" Text="Free" Selected="True" />
																			<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liPaid" Text="Paid" />
																		</asp:RadioButtonList>
																	</div>
																</td>
															</tr>
														</table>

														<div runat="server" id="pnlEventPaymentSettings" visible="false">
															<table class="settings_table no_margin eventregistration">
																<tr>
																	<td class="left">
																		<label for="<%=rblEventPaymentType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventChargeBy.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventChargeBy.Text") %></label>
																	</td>
																	<td class="right">
																		<div class="edNews_inputGroup displayInline">
																			<asp:RadioButtonList ID="rblEventPaymentType" CssClass="styledRadio inlineList smallRadio" runat="server" RepeatLayout="UnorderedList" OnSelectedIndexChanged="rblEventPaymentType_SelectedIndexChanged" AutoPostBack="true">
																				<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liFixedPrice" Text="Fixed price" Selected="True" />
																				<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liAttendee" Text="Attendee" />
																				<asp:ListItem Value="2" class="normalRadioButton" resourcekey="liDateRestriction" Text="Date restriction" />
																			</asp:RadioButtonList>
																		</div>
																	</td>
																</tr>
																<tr>
																	<td class="left"></td>
																	<td class="right">
																		<asp:Label ID="lblPortalCurrency" runat="server" />
																	</td>
																</tr>
															</table>

															<asp:Panel runat="server" ID="pnlEventCostByBooking" Visible="false">
																<table class="settings_table no_margin eventregistration">
																	<tr>
																		<td class="left">
																			<label for="<%=tbxEventCost.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCostPerBooking.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCostPerBooking.Text") %></label>
																		</td>
																		<td class="right">
																			<asp:TextBox ID="tbxEventCost" runat="server"></asp:TextBox>
																			<asp:RequiredFieldValidator ID="rfvEventCost" runat="server" ControlToValidate="tbxEventCost" CssClass="input_validation_error" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvTaxRate" SetFocusOnError="True" ValidationGroup="vgEditArticle" />
																			<asp:CompareValidator ID="cvEventCost" ControlToValidate="tbxEventCost" runat="server" ErrorMessage="Please add valid decimal." Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="true" ValidationGroup="vgEditArticle"></asp:CompareValidator>
																		</td>
																	</tr>
																</table>
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlEventCostByAttendee" Visible="false">
																<table class="settings_table no_margin eventregistration">
																	<tr>
																		<td class="left">
																			<label class="edNews_tooltip" data-tooltip-content="<%=_("lblCostPerAttendee.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCostPerAttendee.Text") %></label>
																		</td>
																		<td class="right">
																			<table runat="server" class="tblCostPerAttendee" id="tblCostPerAttendee">
																				<thead>
																					<tr>
																						<th><%=_("Name.Text") %></th>
																						<th><%=_("Cost.Text") %></th>
																						<th></th>
																					</tr>
																				</thead>
																				<tr valign="top">
																					<td>
																						<input runat="server" id="eds_costid" name="eds_costid" type="hidden" />
																						<input runat="server" id="eds_CostRowName" type="text" class="eds_table_cell_input" name="eds_CostRowName" value="" placeholder="Name" />
																					</td>
																					<td>
																						<input runat="server" id="eds_CostRowValue" type="text" class="eds_table_cell_input" name="eds_CostRowValue" value="" placeholder="Cost" />
																						<asp:CompareValidator ID="cv_eds_CostRowValue" ControlToValidate="eds_CostRowValue" runat="server" ErrorMessage="Please add valid decimal." Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="true" ValidationGroup="vgEditArticle"></asp:CompareValidator>
																					</td>
																					<td>
																						<a href="javascript:void(0);" id="eds_add_cost_per_attendee">Add</a>
																					</td>
																				</tr>
																			</table>

																			<span id="s_eds_CostPerAttendeeInfo" style="color: red;"></span>

																		</td>
																	</tr>
																	<tr>
																		<td class="left">
																			<label for="<%=tblAttendeesDiscount.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblBulkDiscount.Help", true) %>" data-tooltip-position="top-right"><%=_("lblBulkDiscount.Text") %></label>
																		</td>
																		<td class="right">
																			<table runat="server" class="tblAttendeesDiscount" id="tblAttendeesDiscount">
																				<thead>
																					<tr>
																						<th><%=_("Attendees.Text") %></th>
																						<th><%=_("Discount.Text") %></th>
																						<th></th>
																						<th></th>
																					</tr>
																				</thead>
																				<tr valign="top">
																					<td>
																						<input runat="server" id="eds_RowName" type="text" class="eds_table_cell_input" name="eds_RowName" value="" placeholder="Min number +" />
																					</td>
																					<td>
																						<input runat="server" id="eds_RowValue" type="text" class="eds_table_cell_input" name="eds_RowValue" value="" placeholder="Discount" />
																					</td>
																					<td>
																						<select runat="server" id="eds_valueTypeID" name="eds_valueType" class="eds_table_cell_select">
																							<option value="0">Unit</option>
																							<option value="1">Percent</option>
																						</select>
																					</td>
																					<td>
																						<a href="javascript:void(0);" id="eds_add_attendees_discount">Add</a>
																					</td>
																				</tr>
																			</table>

																			<span id="s_eds_AttendeesDiscount" style="color: red;"></span>
																		</td>
																	</tr>
																</table>
																<asp:TextBox ID="tbxCheckDecimal" runat="server" Style="display: none"></asp:TextBox>
																<asp:CompareValidator ID="cvCheckDecimal" ControlToValidate="tbxCheckDecimal" runat="server" ErrorMessage="" Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="false" ValidationGroup="vgCheckDecimal"></asp:CompareValidator>
															</asp:Panel>
															<asp:Panel runat="server" ID="pnlEventCostByDateRestriction" Visible="false">
																<asp:HiddenField runat="server" ID="hfDateCostMatrix" />
																<asp:HiddenField runat="server" ID="hfDateCostMatrixViewSpecific" />
																<div id="eds__CostByDateRestriction" class="edNews_manipulatingTable"></div>
																<asp:TextBox ID="tbValidateDecimal" runat="server" Style="display: none"></asp:TextBox>
																<asp:CompareValidator ID="cvValidateDecimal" ControlToValidate="tbValidateDecimal" runat="server" ErrorMessage="" Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="false" ValidationGroup="vgValidateDecimal"></asp:CompareValidator>
															</asp:Panel>
														</div>
													</div>
												</ContentTemplate>
											</asp:UpdatePanel>

										</asp:Panel>

									</div>
								</asp:Panel>
							</asp:Panel>

						</asp:Panel>
					</div>
					<%--						</ContentTemplate>
					</asp:UpdatePanel>--%>
				</asp:Panel>

				<asp:Panel ID="pnlCustomFieldsSelect" runat="server" Visible="false" CssClass="section_box white_border_1 dark_grey green customfieldpanel">
					<%--				<asp:UpdatePanel ID="upCustomFieldsSelect" runat="server" OnUnload="UpdatePanel_Unload">
						<ContentTemplate>
							<div class="edn_admin_progress_overlay_container">
								<asp:UpdateProgress ID="uppCustomFieldsSelect" runat="server" AssociatedUpdatePanelID="upCustomFieldsSelect" DisplayAfter="100" DynamicLayout="true">
									<ProgressTemplate>
										<div class="edn_admin_progress_overlay">
										</div>
									</ProgressTemplate>
								</asp:UpdateProgress>--%>
					<div runat="server" id="tblShowHideCustomFields" visible="false">
						<h1 class="section_box_title">

							<asp:Label ID="lblShowCustomFields" runat="server" Text="Custom fields:" ResourceKey="lblShowCustomFields" />
						</h1>
						<div class="switchCheckbox">
							<asp:CheckBox ID="cbShowCustomFields" runat="server" CssClass="normalCheckBox" Text="Custom fields" AutoPostBack="True" OnCheckedChanged="cbShowCustomFields_CheckedChanged" />
						</div>


					</div>


					<%--<table class="settings_table" >
						<tr>
							<td class="left textLeft">
								<img src="<%=_ControlPath%>images/icons/customfields_small.png" alt="" style="position: relative; top: 4px;" />


							</td>
						</tr>
					</table>--%>
					<asp:Panel ID="pnlCustomFieldsDisplay" runat="server" Visible="false" CssClass="content cfpanel">
						<table runat="server" id="tblCFGroupSelection" visible="false" class="customfields-group">
							<tr>
								<td class="leftcol">
									<label for="<%=ddlCFgroup.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCFGroupSelection.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCFGroupSelection.Text") %></label>
								</td>
								<td class="rightcol">
									<asp:DropDownList ID="ddlCFgroup" runat="server" AutoPostBack="true" />
								</td>
							</tr>
						</table>
						<asp:PlaceHolder ID="phCustomFields" runat="server" Visible="false">
							<asp:HiddenField runat="server" ID="hfParenSelectedValue" />
							<asp:HiddenField runat="server" ID="hfLastSelectedIndexChanged" />
							<asp:HiddenField runat="server" ID="hfCFLastTriggerdByList" />
							<asp:HiddenField runat="server" ID="hfPreviousCFTemplateID" />
							<asp:HiddenField runat="server" ID="hfUploadFieldState" />
						</asp:PlaceHolder>

					</asp:Panel>
					<%--</div>
						</ContentTemplate>
					</asp:UpdatePanel>--%>
				</asp:Panel>

				<div id="divAdvancedSettings" runat="server" class="collapsible_box advanced_settings">
					<h1 class="collapsible_box_title edNews_tooltip" data-tooltip-content="<%=_("advancedSettingsTooltip.Text", true) %>" data-tooltip-position="top-left">
						<%=AdvancedSettings %>
					</h1>
					<div class="content">
						<asp:UpdatePanel ID="upAdvancedSettings" runat="server" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<asp:Panel runat="server" ID="pnlAdvancedSettingsContent">
									<div class="edn_admin_progress_overlay_container">
										<asp:UpdateProgress ID="uppAdvancedSettings" runat="server" AssociatedUpdatePanelID="upAdvancedSettings" DisplayAfter="100" DynamicLayout="true">
											<ProgressTemplate>
												<div class="edn_admin_progress_overlay">
												</div>
											</ProgressTemplate>
										</asp:UpdateProgress>
										<table class="settings_table" id="tblChangeOwner" runat="server" visible="false">
											<tr>
												<td class="left edn_articleOwner">
													<label class="edNews_tooltip" data-tooltip-content="<%=_("lblowner.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblowner.Text") %></label>
												</td>
												<td class="right">
													<asp:Label ID="tbArticleAuthorName" runat="server" />
												</td>
											</tr>
											<tr>
												<td class="left">
													<label for="<%=ddlRoles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChOwner.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChOwner.Text") %></label>
												</td>
												<td class="right">
													<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged" Visible="false">
														<asp:ListItem Value="-1" resourcekey="ListItemResource25">Select role</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlAuthors_SelectedIndexChanged" Visible="false">
														<asp:ListItem Value="-1" resourcekey="ListItemResource26">Select author</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
										</table>
										<asp:Panel ID="pnlAuthorAlias" runat="server">
											<table class="settings_table" id="tblAuthorAlias" runat="server" visible="false">
												<tr>
													<td class="left">
														<label for="<%=tbAuthorAliasName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorAlias.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorAlias.Text") %></label>
													</td>
													<td class="right">
														<asp:TextBox ID="tbAuthorAliasName" runat="server" MaxLength="100" Width="200px" />
													</td>
												</tr>
											</table>
										</asp:Panel>
										<asp:Panel ID="pnlContactEmail" runat="server">
											<table class="settings_table" id="tblContactEmail" runat="server" visible="false">
												<tr>
													<td class="left">
														<label for="<%=tbxContactEmail.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactEmail.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactEmail.Text") %></label>
													</td>
													<td class="right">
														<asp:TextBox ID="tbxContactEmail" runat="server" MaxLength="256" Width="200px" />
													</td>
												</tr>
											</table>
										</asp:Panel>
										<asp:Panel ID="pnlChangeTheme" runat="server">
											<table id="tblUseDefaultTemplate" runat="server" class="settings_table">
												<tr>
													<td class="left" style="width: 250px;">
														<label for="<%=cbUseDefaultTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUseDefaultTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUseDefaultTemplate.Text") %></label>
													</td>
													<td class="right">
														<div class="styledCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbUseDefaultTemplate" runat="server" Text=" " AutoPostBack="True" Checked="True" OnCheckedChanged="cbUseDefaultTemplate_CheckedChanged" />
														</div>
													</td>
												</tr>
											</table>
											<asp:Panel ID="pnlSelectThemes" runat="server" Visible="false">
												<table class="settings_table no_margin">
													<tr>
														<td class="left" style="width: 250px;">
															<label for="<%=ddlArticleDetailsTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleDetailsTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleDetailsTheme.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlArticleDetailsTheme" runat="server" AutoPostBack="True" CausesValidation="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlArticleDetailsFolder_SelectedIndexChanged" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleCSSStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleCSSStyle.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlDisplayStyle" runat="server" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlArticleDetailsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleDetailsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleDetailsTemplate.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlArticleDetailsTemplate" runat="server" CssClass="ddlgeneral" />
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=ddlDetailsDocumentsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDetailsDocumentsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDetailsDocumentsTemplate.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlDetailsDocumentsTemplate" runat="server" />
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=ddlDetailsLinksTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDetailsLinksTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDetailsLinksTemplate.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlDetailsLinksTemplate" runat="server" />
														</td>
													</tr>
													<tr class="second">
														<td class="left">
															<label for="<%=ddlDetailsRelatedArticlesTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDetailsRelatedArticlesTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDetailsRelatedArticlesTemplate.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlDetailsRelatedArticlesTemplate" runat="server" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlCommentsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleCommentsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleCommentsTemplate.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlCommentsTemplate" runat="server" CssClass="ddlgeneral" />
														</td>
													</tr>
													<tr>
														<td class="left">
															<label for="<%=ddlGravityGallerySelectTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGallerySelectTemplate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGallerySelectTemplate.Text") %></label>
														</td>
														<td class="right">
															<asp:DropDownList ID="ddlGravityGallerySelectTemplate" runat="server"></asp:DropDownList>
														</td>
													</tr>
												</table>
											</asp:Panel>
										</asp:Panel>
									</div>
								</asp:Panel>
							</ContentTemplate>
						</asp:UpdatePanel>
					</div>
				</div>

				<table class="optionsList noWidthLabel" style="margin-top: 20px">
					<tr id="rowAllowComents" runat="server">
						<td class="tdLabel width180">
							<label for="<%=cbAllowComments.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAllowComments.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAllowComments.Text") %></label>
						</td>
						<td>
							<div class="styledCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbAllowComments" resourcekey="cbAllowComments" Text="Allow comments" runat="server" />
							</div>
						</td>
					</tr>
					<tr id="rowFeaturedArticle" runat="server">
						<td class="tdLabel width180">
							<label for="<%=cbFeaturedArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFeaturedArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFeaturedArticle.Text") %></label>
						</td>
						<td>
							<div class="styledCheckbox">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbFeaturedArticle" Text="Featured article" runat="server" resourcekey="cbFeaturedArticle" />
							</div>
						</td>
					</tr>
					<tr id="rowPublishDate" runat="server">
						<td class="tdLabel width180">
							<label for="<%=tbPublishDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPublishDate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPublishDate.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbPublishDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" />
							<span class="calendaricon"></span>
							<asp:RequiredFieldValidator ID="rfvArchiveDate" runat="server" ControlToValidate="tbPublishDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvArchiveDateResource1" />
							<asp:CompareValidator ID="cvPublishDate" runat="server" ControlToValidate="tbPublishDate" Display="Dynamic" Enabled="false" ErrorMessage="Invalid date." Operator="DataTypeCheck" Type="Date" ValidationGroup="vgEditArticle" resourcekey="cvPublishDateResource1" />
							<asp:Label ID="lblPubDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="false" resourcekey="lblPubDateErrorResource1" />
							<asp:TextBox ID="tbPublishTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="55px" />
							<span class="clockicon"></span>
							<asp:RegularExpressionValidator ID="revPublishTime" runat="server" ControlToValidate="tbPublishTime" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" resourcekey="revPublishTImeResource1" />
						</td>
					</tr>
					<tr id="rowExpireDate" runat="server">
						<td class="tdLabel width180">
							<label for="<%=tbExpireDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExpireDate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExpireDate.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbExpireDate" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="90px" />
							<span class="calendaricon"></span>
							<asp:RequiredFieldValidator ID="rfvExpireDate" runat="server" ControlToValidate="tbExpireDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvArchiveDate0Resource1" />
							<asp:CompareValidator ID="cvExpireDate" runat="server" ControlToValidate="tbExpireDate" CultureInvariantValues="True" Display="Dynamic" Enabled="false" ErrorMessage="Invalid date." Operator="DataTypeCheck" Type="Date" ValidationGroup="vgEditArticle"
								resourcekey="cvPublishDate0Resource1" />
							<asp:Label ID="lblExpireDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="false" resourcekey="lblExpireDateErrorResource1" />
							<asp:TextBox ID="tbExpireTime" runat="server" CssClass="text_generic center" ValidationGroup="vgEditArticle" Width="55px" />
							<span class="clockicon"></span>
							<asp:RegularExpressionValidator ID="revExpireTime" runat="server" ControlToValidate="tbExpireTime" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgEditArticle" resourcekey="revPublishTIme0Resource1" />
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<p class="smallInfo info">
								<%=Timezone%>
								<asp:Label ID="lblTimeZone" CssClass="smallText" runat="server" Text="" />
							</p>
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
				<asp:Panel ID="pnlPerArticlePermissions" runat="server" Visible="false">
					<asp:UpdatePanel ID="upPerArticlePermissions" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
						<ContentTemplate>
							<div class="edn_admin_progress_overlay_container">
								<asp:UpdateProgress ID="uppPerArticlePermissions" runat="server" AssociatedUpdatePanelID="upPerArticlePermissions" DisplayAfter="100" DynamicLayout="true">
									<ProgressTemplate>
										<div class="edn_admin_progress_overlay">
										</div>
									</ProgressTemplate>
								</asp:UpdateProgress>
								<div style="margin: 0 0 3px;">
									<img src="<%=_ControlPath%>images/icons/lock.png" alt="" style="position: relative; top: 4px; margin: 0 3px 0 0" />
									<asp:Label ID="lblAddPerArticlePermission" runat="server" Text="Permissions per article" Style="font-size: 13px; line-height: 16px; font-weight: bold;" resourcekey="lblAddPerArticlePermissionResource1" />
									<div class="styledCheckbox noLabel">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAddPerArticlePermissions" Text="Permissions per article" runat="server" AutoPostBack="True" OnCheckedChanged="cbAddPerArticlePermissions_CheckedChanged" />
									</div>
								</div>
								<asp:Panel ID="pnlAddPerArticlePermissions" runat="server" Visible="false" CssClass="rounded_box grey per_article_permissions">
									<p class="permission_warning">
										<%=Permissionsperarticleoverride%>
									</p>
									<asp:GridView ID="gvPermissionDefault" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="strippedTable fullWidthTable textCenter edNews_permissionsTable edNews_addEditPermissions" EnableModelValidation="True" GridLines="None">
										<Columns>
											<asp:TemplateField HeaderText="Roles">
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("Name") %>' />:
												</ItemTemplate>
												<ItemStyle CssClass="subjectTd textLeft" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Viewarticle">
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
													<asp:CheckBox CssClass="normalCheckBox" ID="cbShowArticle" runat="server" Checked='<%# Eval("Show") %>' Enabled="false" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Editarticle">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEditArticle" runat="server" Checked='<%# Eval("Edit") %>' Enabled="false" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="EventRegistration">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEventRegistration" runat="server" Checked='<%# Eval("EventRegistration") %>' Enabled="false" />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="DocumentDownload">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbDocumentDownload" runat="server" Checked='<%# Eval("DocumentDownload") %>' Enabled="false" />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
										<HeaderStyle CssClass="tableHeader" />
									</asp:GridView>
									<asp:GridView ID="gvRolePremissions" runat="server" AutoGenerateColumns="false" CellPadding="0" ShowHeader="False" CssClass="strippedTable fullWidthTable textCenter edNews_permissionsTable edNews_addEditPermissions" EnableModelValidation="True" GridLines="None">
										<Columns>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("Name") %>' />:
												</ItemTemplate>
												<ItemStyle CssClass="subjectTd textLeft" />
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
													<asp:CheckBox CssClass="normalCheckBox" ID="cbShowArticle" runat="server" Checked='<%# Eval("Show") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEditArticle" runat="server" Checked='<%# Eval("Edit") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEventRegistration" runat="server" Checked='<%# Eval("EventRegistration") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbDocumentDownload" runat="server" Checked='<%# Eval("DocumentDownload") %>' />
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
									</asp:GridView>
									<div>
										<table class="strippedTable fullWidthTable textCenter edNews_permissionsTable edNews_addEditPermissions" cellspacing="0" cellpadding="0" border="0" style="position: relative; margin-bottom: 15px;">
											<tr>
												<td class="subjectTd textLeft">
													<asp:Label ID="lblShowToUnauthorizedUser" runat="server" Text="Unauthorized users:" resourcekey="lblShowToUnauthorizedUserResource1" />
												</td>
												<td>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbShowToUnauthorizedUser" runat="server" Style="position: relative;" />
												</td>
												<td></td>
												<td>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEventRegistrationToUnauthorizedUser" runat="server" Style="position: relative;" /></td>
												<td>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbDocumentDownloadToUnauthorizedUser" runat="server" Checked='<%# Eval("DocumentDownload") %>' />
												</td>
											</tr>
										</table>
									</div>
									<asp:GridView ID="gvUserPermissions" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="strippedTable fullWidthTable textCenter edNews_permissionsTable edNews_addEditPermissions edNews_userPermissionsTable" EnableModelValidation="True" GridLines="None" OnRowCommand="gvUserPermissions_RowCommand">
										<Columns>
											<asp:TemplateField HeaderText="Users">
												<ItemTemplate>
													<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("Name") %>' />:
												</ItemTemplate>
												<ItemStyle CssClass="subjectTd textLeft" />
											</asp:TemplateField>
											<asp:TemplateField HeaderText="View article">
												<ItemTemplate>
													<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
													<asp:CheckBox CssClass="normalCheckBox" ID="cbShowArticle" runat="server" Checked='<%# Eval("Show") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="Edit article">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEditArticle" runat="server" Checked='<%# Eval("Edit") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="EventRegistration">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbEventRegistration" runat="server" Checked='<%# Eval("EventRegistration") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField HeaderText="DocumentDownload">
												<ItemTemplate>
													<asp:CheckBox CssClass="normalCheckBox" ID="cbDocumentDownload" runat="server" Checked='<%# Eval("DocumentDownload") %>' />
												</ItemTemplate>
											</asp:TemplateField>
											<asp:TemplateField>
												<ItemTemplate>
													<div class="itemActions">
														<asp:LinkButton ID="lbUserPremissionRemove" CssClass="deleteAction color4" runat="server" CausesValidation="false" CommandArgument='<%# Eval("UserID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user permissions?');" Text="Remove" resourcekey="lbUserPremissionRemoveResource1"></asp:LinkButton>
													</div>
												</ItemTemplate>
											</asp:TemplateField>
										</Columns>
										<HeaderStyle CssClass="tableHeader" />
									</asp:GridView>
									<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="false" ForeColor="Red" resourcekey="lblAdduserMessageResource1" />
									<div class="edNews_inputGroup">
										<asp:Label ID="lblUsernameToAdd" runat="server" Text="Add user by username:" resourcekey="lblUsernameToAddResource1" />
										<asp:TextBox ID="tbUserNameToAdd" runat="server" />
										<div class="mainActions smallActions noMargin displayInline">
											<asp:LinkButton ID="lbUsernameAdd" runat="server" CssClass="add" OnClick="lbUsernameAdd_Click" Text="Add" resourcekey="lbUsernameAddResource1" />
										</div>
									</div>
								</asp:Panel>
							</div>
						</ContentTemplate>
					</asp:UpdatePanel>
				</asp:Panel>
				<div class="section_box white_border_1 dark_grey workFlowInfo">
					<div runat="server" id="divWorkflowinfo">
						<h1 class="section_box_title">
							<span><%=_("Workflow")%></span>
							<span id="spnCurrentWorkFlow" runat="server"></span>
						</h1>
						<div class="clearFix"></div>
						<div class="content">
							<div class="clearFix"></div>
							<div class="edNews_inputGroup">
								<asp:Literal runat="server" ID="ltWorkflowStatesList"></asp:Literal>
							</div>
						</div>
					</div>
					<div class="content">
						<div class="topPadded bottomPadded">
							<div class="edNews_inputGroup noWidthLabel textCenter">
								<label runat="server" id="lblApprove">
									<label for="<%=cbApproveArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content='<%=_("Approve.HelpText")%>' data-tooltip-position="top-right"><%=_("Approve")%></label>
								</label>
								<label runat="server" id="lblApproveDirectPublish">
									<label for="<%=cbApproveArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content='<%=_("Publish.HelpText")%>' data-tooltip-position="top-right" visible="False"><%=_("Publish")%></label>
								</label>
								<div class="eds__approveArticle switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbApproveArticle" runat="server" Text="Approve article" />
								</div>
							</div>
							<div id="divRejectArticle" runat="server" visible="false" class="edNews_inputGroup noWidthLabel textCenter">
								<label for="<%=cbRejectArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("Reject.HelpText")%>" data-tooltip-position="top-right"><%=_("Reject")%></label>
								<div class="eds__rejectArticle switchCheckbox">
									<asp:CheckBox CssClass="normalCheckBox" ID="cbRejectArticle" runat="server" Text="Reject article" />
								</div>
								<div class="eds__rejectArticleMessageText text_input_set" style="display: none">
									<div style="padding: 0 20px;">
										<label for="<%=tbRejectMessage.ClientID %>" class="edNews_tooltip" data-tooltip-content="Please enter reject message" data-tooltip-position="top-right"><%=_("PleaseEnterRejectMessage") %></label>
										<asp:TextBox ID="tbRejectMessage" runat="server" MaxLength="2000" TextMode="MultiLine" />
									</div>
								</div>
							</div>
						</div>
						<label runat="server" class="infoMessages edNews_smallerInlineBlock info" id="spnIsRevision" visible="false"><%=_("YouAreEditingArticleRevision")%></label>
					</div>
					<div id="divCurrentWorkflowStateList" runat="server" class="collapsible_box" visible="false">
						<asp:Literal runat="server" ID="liCurrentWorkFlowState"></asp:Literal>
					</div>
				</div>
				<div class="main_action_buttons">
					<div id="pnlSocialSharing" class="social_sharing_box social_media" runat="server" visible="false">
						<p id="lblSocialSharingTitle" runat="server" style="font-weight: bold;">
							<span style="color: red;">
								<%=Post%></span>
							<%= Articleto %>
						</p>
						<p id="pnlPostToFacebook" runat="server" visible="false">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbPostToFacebook" runat="server" /><asp:Label ID="lblPostToFacebook" runat="server" Text="Facebook" />
							<asp:DropDownList ID="ddlPostToFacebook" runat="server" CssClass="custom_drop_down_style" />
						</p>
						<p id="pnlPostToLinkedIn" runat="server" visible="false">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbPostToLinkedIn" runat="server" /><asp:Label ID="lblPostToLinkedIn" runat="server" Text="LinkedIn" />
							<asp:DropDownList ID="ddlPostToLinkedIn" runat="server" CssClass="custom_drop_down_style" />
						</p>
						<p id="pnlPostToTwitter" runat="server" visible="false">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbPostToTwitter" runat="server" /><asp:Label ID="lblPostToTwitter" runat="server" Text="Twitter" />
							<asp:DropDownList ID="ddlPostToTwitter" runat="server" CssClass="custom_drop_down_style" />
						</p>
					</div>
					<div id="pnlSocialSecurity" class="social_sharing_box" runat="server" visible="true" style="right: 100px;">
						<p id="lblSocialSecurityTitle" runat="server" style="font-weight: bold;">
							<%=Social%>
							<span style="color: red;">
								<%=Security%></span>
						</p>
						<p id="pnlSocialSecuritySelect" runat="server">
							<asp:Label ID="lblSocialSecuritySelect" resourcekey="lblSocialSecuritySelect" runat="server" Text="View:" />
							<asp:DropDownList ID="ddlSocialSecuritySelect" runat="server" CssClass="custom_drop_down_style" />
						</p>
						<p>
							<asp:Label ID="lblSocialSecurityGroups" resourcekey="lblSocialSecurityGroups" runat="server" Text="Groups:" />
							<asp:ListBox ID="lbSocialSecurityGroups" runat="server" SelectionMode="Multiple" />
						</p>
						<p id="pnlPostToJournal" runat="server" style="display: none">
							<span style="width: 100%; height: 1px; background-color: #d1d0d0; border-bottom: 1px; border-bottom-color: #ffffff; border-bottom-style: solid; display: block; margin-bottom: 3px;"></span><span style="display: block;">
								<asp:CheckBox CssClass="normalCheckBox" ID="cbPostToJournal" runat="server" /><asp:Label ID="lblPostToJournal" resourcekey="lblPostToJournal" runat="server" Text="Post to Journal" /></span>
						</p>
					</div>
					<div class="mainActions">
						<asp:LinkButton ID="btnAddNewArticle" CssClass="add" Visible="false" runat="server" OnClick="AddNewArticle_Click" Text="Save article" OnClientClick="return EdsSaveButtonClick('vgEditArticle');" ValidationGroup="vgEditArticle" resourcekey="btnAddNewArticle" />
						<asp:LinkButton ID="btnAddAndClose" CssClass="downSaveClose" Visible="false" runat="server" OnClick="AddAndClose_Click" Text="Save and close" UseSubmitBehavior="false" OnClientClick="return EdsSaveButtonClick('vgEditArticle');" ValidationGroup="vgEditArticle" resourcekey="btnAddAndClose" />
						<asp:LinkButton ID="btnAddAndView" CssClass="saveView" Visible="false" runat="server" OnClick="AddAndView_Click" Text="Save and view" OnClientClick="return EdsSaveButtonClick('vgEditArticle');" ValidationGroup="vgEditArticle" resourcekey="btnAddAndView" />
						<asp:LinkButton ID="btnUpdateArticle" CssClass="downSave" Visible="false" runat="server" OnClick="UpdateArticle_Click" Text="Update article" OnClientClick="return EdsSaveButtonClick('vgEditArticle');" ValidationGroup="vgEditArticle" resourcekey="btnUpdateArticleResource1" />
						<asp:LinkButton ID="btnUpdateClose" CssClass="downSaveClose" Visible="false" runat="server" OnClick="UpdateClose_Click" Text="Update &amp;amp; Close" OnClientClick="return EdsSaveButtonClick('vgEditArticle');" ValidationGroup="vgEditArticle" resourcekey="btnUpdateCloseResource1" />
						<asp:LinkButton ID="btnUpdateAndView" CssClass="saveView" Visible="false" runat="server" OnClick="UpdateAndView_Click" Text="Update &amp;amp; View" OnClientClick="return EdsSaveButtonClick('vgEditArticle');" ValidationGroup="vgEditArticle" resourcekey="btnGoArticleResource1" />
						<asp:LinkButton ID="btnCancel" CssClass="cancel" runat="server" OnClick="Cancel_Click" Text="Cancel" CausesValidation="false" resourcekey="btnCancel" />
					</div>
					<div class="mainActions smallActions textRight noMargin" runat="server" id="divDeleteArticle">
						<asp:LinkButton ID="lbDeleteArticle" runat="server" CssClass="delete" OnClick="lbDeleteArticle_Click" resourcekey="lbDeleteArticleResource1" ToolTip="Delete article" />
					</div>
					<asp:Label ID="lblMainEditMessage" runat="server" EnableViewState="false" />
				</div>
			</asp:Panel>
			<asp:Literal ID="containerSocialSharingHistory" runat="server" />
			<asp:Panel ID="pnlPreviousVersions" runat="server" CssClass="collapsible_box no_margin" Visible="false">
				<h1 class="collapsible_box_title">
					<%=History%></h1>
				<div class="content article_history">
					<asp:Repeater ID="repPreviousVersions" runat="server" OnItemCommand="repPreviousVersions_ItemCommand">
						<ItemTemplate>
							<p>
								<strong>
									<%=Previousversionsaved%></strong>
								<%#Eval("LastModified")%>
								<asp:LinkButton ID="lbVersionRestore" runat="server" CssClass="icon load_version" Text="Restore article to this version" CommandName="RestoreVersion" CommandArgument='<%# Eval("HistoryEntryID") %>' resourcekey="lbVersionRestoreResource1" />
								<asp:LinkButton ID="lbDeleteThisVersion" runat="server" CssClass="icon delete_version" Text="Delete this version" OnClientClick="return confirm('Are you certain you want to delete this version?');" CommandName="DeleteVersion" CommandArgument='<%# Eval("HistoryEntryID") %>'
									resourcekey="lbDeleteThisVersionResource1" />
							</p>
						</ItemTemplate>
					</asp:Repeater>
				</div>
			</asp:Panel>
		</div>
		<asp:ObjectDataSource ID="odsArticleImages" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" SelectMethod="GetImageListFromGallery" UpdateMethod="UpdatePictureTitleDescription" DeleteMethod="DeleteImage">
			<DeleteParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
			</DeleteParameters>
			<SelectParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
				<asp:Parameter Name="orderByDesc" Type="Boolean" />
				<asp:Parameter Name="RevisionId" Type="Int32" />
			</SelectParameters>
			<UpdateParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
				<asp:Parameter Name="RevisionId" Type="Int32" />
			</UpdateParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGetTagsByName" runat="server" EnablePaging="True" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="odsGetCloudTagsSortByName" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.TagCloudDB" MaximumRowsParameterName="To"
			StartRowIndexParameterName="From">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:Parameter Name="From" Type="Int32" />
				<asp:Parameter Name="To" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGetTagsByModified" runat="server" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="odsGetCloudTagsSortByModified" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.TagCloudDB" EnablePaging="True" MaximumRowsParameterName="To"
			StartRowIndexParameterName="From">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:Parameter Name="From" Type="Int32" />
				<asp:Parameter Name="To" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsGetTagsByPopularity" runat="server" SelectCountMethod="GetCloudTagsSortByNameCount" SelectMethod="odsGetCloudTagsSortByPopular" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.TagCloudDB" EnablePaging="True" MaximumRowsParameterName="To"
			StartRowIndexParameterName="From">
			<SelectParameters>
				<asp:Parameter Name="PortalID" Type="Int32" />
				<asp:Parameter Name="From" Type="Int32" />
				<asp:Parameter Name="To" Type="Int32" />
			</SelectParameters>
		</asp:ObjectDataSource>
		<asp:ObjectDataSource ID="odsSharedImages" runat="server" DeleteMethod="DeleteImage" SelectMethod="GetImagesFromGalleryByUserID" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdatePictureTitleDescription">
			<DeleteParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
			</DeleteParameters>
			<SelectParameters>
				<asp:Parameter Name="GalleryID" Type="Int32" />
				<asp:Parameter Name="ByUserID" Type="Boolean" />
				<asp:Parameter Name="UserID" Type="Int32" />
			</SelectParameters>
			<UpdateParameters>
				<asp:Parameter Name="PictureID" Type="Int32" />
				<asp:Parameter Name="Title" Type="String" />
				<asp:Parameter Name="Description" Type="String" />
			</UpdateParameters>
		</asp:ObjectDataSource>
	</asp:Panel>
</asp:Panel>
<asp:Panel ID="pnlErrorInfo" runat="server" Visible="false" EnableViewState="false">
	<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
		<div id="EDNadmin" class="contentSection">
			<div class="titleWrapper">
				<span>Error</span>
			</div>
			<div class="main_content">
				<div class="section_box white_border_1">
					<h1 class="section_box_title">
						<span><%=Youdonothavepermision%></span>
					</h1>
					<div class="content">
						<div class="section_box">
							<span id="lblErrorReasonMessage" class="infoMessages error" runat="server" visible="false" enableviewstate="False" />
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</asp:Panel>
<script type="text/javascript">

	// <![CDATA[
	<%=alertConfirm%>
	<%=initTextEditorCountMaxChar%>
	var isEdsSaveButtonClicked = false;
	function closingCode() {
		$.ajax({
			type: 'GET',
			url: '<%=_ControlPath%>/ashx/ArticleEditAction.ashx',
			dataType: 'json',
			data: {
				portalId: <%=PortalId%>,
				moduleId: <%=ModuleId%>,
				tabid: <%=TabId%>,
				articleid:<%=editArticleId%>,
				action: 'releaselock'
			},
			success: function (response) {
			},
			complete: function () {
			}
		});
	};

	function cleararticleCacheLock() {
		$.ajax({
			type: 'GET',
			url: '<%=_ControlPath%>/ashx/ArticleEditAction.ashx',
			dataType: 'json',
			data: {
				portalId: <%=PortalId%>,
				moduleId: <%=ModuleId%>,
				tabid: <%=TabId%>,
				articleid:<%=editArticleId%>,
				action: 'clearlock'
			},
			success: function (response) {
			},
			complete: function () {
			}
		});
	};

	function EdsSaveButtonClick(validationGroup) {
		if (typeof (Page_ClientValidate) == 'function') {
			if (Page_ClientValidate(validationGroup) == false)
				return false;
		}

		if (validationGroup === 'vgAddRecurringEvent') {
			var costByRestriction = eds2_2('#eds__RecurringCostByDateRestriction');
			if (costByRestriction.length !== 0) {
				if (!eds2_2('#eds__RecurringCostByDateRestriction').eds2_2_DateRestrictionPayment_Edit_1_0_0.Validate('eds__RecurringCostByDateRestriction')) {
					return false;
				}
			}
		}
		else {
			var costByRestriction = eds2_2('#eds__CostByDateRestriction');
			if (costByRestriction.length !== 0) {
				if (!eds2_2('#eds__CostByDateRestriction').eds2_2_DateRestrictionPayment_Edit_1_0_0.Validate('eds__CostByDateRestriction'))
					return false;
			}
		}
		if (!isEdsSaveButtonClicked) {
			isEdsSaveButtonClicked = true;
			<%--if ('<%=IS_ARTICLE_REVISION%>' == 'True')
				eds2_2("#<%=pnlCustomFieldsSelect.ClientID%> :input").attr("disabled", false);--%>
			return true;
		}
		return false;
	}

	function ClearCFFileUpload(clearFuID) {
		var input = $('#' + clearFuID);
		input.replaceWith(input.val('').clone(true));
	}

	function ToggleCFFileUpload(CustomFieldID, divHideID, divShowID, action) {
		var divToHide = document.getElementById(divHideID);
		if (divToHide != null)
			divToHide.style.display = "none";

		var divToShow = document.getElementById(divShowID);
		if (divToShow != null)
			divToShow.style.display = "";

		var hfUploadFieldStateValue = document.getElementById('<%=hfUploadFieldState.ClientID%>').value;
		if (hfUploadFieldStateValue.length != 0) {
			var indexOd = hfUploadFieldStateValue.indexOf('|' + CustomFieldID + ':')
			if (indexOd != -1) {

				var newState = 'change';

				if (action == 'change')
					newState = 'cancel';

				var pocetak = hfUploadFieldStateValue.substring(indexOd + CustomFieldID.length + 2); // cut
				var indexOdBroja = pocetak.indexOf('|');
				var fuState = pocetak.substring(0, indexOdBroja);

				document.getElementById('<%=hfUploadFieldState.ClientID%>').value = hfUploadFieldStateValue.replace('|' + CustomFieldID + ':' + fuState + '|', '|' + CustomFieldID + ':' + newState + '|');
			}
		}
	}

	function InitCFDateTimePickers(id) {
		eds2_2(id).datepick({ dateFormat: "<%=dateFormat%>" });
	}

	function FillEventAttendeesDiscountHf() {
		$("#s_eds_AttendeesDiscount").html("");
		document.getElementById('<%=hfAttendeesDiscount.ClientID%>').value = "";

		$('#<%=tblAttendeesDiscount.ClientID%> tr').each(function () {
			var attendees = $(this).find('input[name*="eds_RowName"]').val();
			var value = $(this).find('input[name*="eds_RowValue"]').val();
			var valueType = $(this).find('select.eds_table_cell_select').val();

			if (value != null && attendees != null && valueType != null) {

				var decimalCheck = true;

				if (value.length > 0) {

					var textbox = document.getElementById('<%=tbxCheckDecimal.ClientID%>');
					textbox.value = value;

					if (Page_ClientValidate('vgCheckDecimal')) {
					}
					else {
						decimalCheck = false;
						$("#s_eds_AttendeesDiscount").html("Enter valid decimal value.");
					}
				}
				if (attendees.length > 0) {
					if (!isNaN(attendees) && (attendees % 1) === 0) {
						if (attendees < 2)
							$("#s_eds_AttendeesDiscount").html("At least 2 attendees!");
					}
					else
						$("#s_eds_AttendeesDiscount").html("Enter valid integer. (e.g. >=2)!");
				}

				if ((!isNaN(attendees) || attendees.length == 0) && (decimalCheck || value.length == 0)) {
					document.getElementById('<%=hfAttendeesDiscount.ClientID%>').value += '<discount attendees="' + attendees + '" value="' + value + '" type="' + valueType + '"/>'
				}
			}
		});

		var hfvalue = document.getElementById('<%=hfAttendeesDiscount.ClientID%>').value;

		if (hfvalue.value !== "") {
			document.getElementById('<%=hfAttendeesDiscount.ClientID%>').value = "<discounts>" + hfvalue + "</discounts>";
		}
	}

	function FillEventAttendeesCostHf() {
		$("#s_eds_CostPerAttendeeInfo").html("");
		document.getElementById('<%=hfCostPerAttendee.ClientID%>').value = "";

		$('#<%=tblCostPerAttendee.ClientID%> tr').each(function () {
			var name = $(this).find('input[name*="eds_CostRowName"]').val();
			var value = $(this).find('input[name*="eds_CostRowValue"]').val();
			var costId = $(this).find('input[name*="eds_costid"]').val();

			if (value != null && name != null && costId != null) {
				if (value.length > 0) {

					var textbox = document.getElementById('<%=tbxCheckDecimal.ClientID%>');
					textbox.value = value;

					if (Page_ClientValidate('vgCheckDecimal'))
						document.getElementById('<%=hfCostPerAttendee.ClientID%>').value += '<cost id="' + costId + '"><name><![CDATA[' + name + ']]></name><value>' + value + '</value></cost>';
					else
						$("#s_eds_CostPerAttendeeInfo").html("Enter valid decimal value.");
				}
				else if (name.trim().length > 0)
					document.getElementById('<%=hfCostPerAttendee.ClientID%>').value += '<cost id="' + costId + '"><name><![CDATA[' + name + ']]></name><value>' + value + '</value></cost>'
			}
		});

		var hfvalue = document.getElementById('<%=hfCostPerAttendee.ClientID%>').value;

		if (hfvalue.value !== "") {
			document.getElementById('<%=hfCostPerAttendee.ClientID%>').value = "<costs>" + hfvalue + "</costs>";
		}
	}

	function ddlOnSelectedIndexChange(ControlClientID, cfid) {
		if (document.getElementById('<%=hfParenSelectedValue.ClientID%>') != null) {
			var e = document.getElementById(ControlClientID);
			var ParentElementID = e.options[e.selectedIndex].value;
			var hfValue = document.getElementById('<%=hfParenSelectedValue.ClientID%>').value;
			if (hfValue.length != 0) {
				var indexOd = hfValue.indexOf(ControlClientID + ';')
				if (indexOd != -1) {
					var pocetak = hfValue.substring(indexOd + ControlClientID.length + 1); // cut
					var indexOdBroja = pocetak.indexOf('|');
					var kraj = pocetak.substring(0, indexOdBroja);
					hfValue = hfValue.replace(ControlClientID + ';' + kraj + '|', ''); // remove existing value
				}
				document.getElementById('<%=hfParenSelectedValue.ClientID%>').value = hfValue + ControlClientID + ';' + ParentElementID + '|';
				document.getElementById('<%=hfLastSelectedIndexChanged.ClientID%>').value = cfid;
			}
			else {
				document.getElementById('<%=hfParenSelectedValue.ClientID%>').value = ControlClientID + ';' + ParentElementID + '|';
				document.getElementById('<%=hfLastSelectedIndexChanged.ClientID%>').value = cfid;
			}
		}
	}

	function cblOnSelectedIndexChange(ControlClientID, cfid) {
		if (document.getElementById('<%=hfParenSelectedValue.ClientID%>') != null) {
			var chkBox = document.getElementById(ControlClientID);
			var options = chkBox.getElementsByTagName('input');
			var checkedValues = '';

			for (var i = 0; i < options.length; i++) {
				if (options[i].checked)
					checkedValues += options[i].value + ',';
			}

			if (checkedValues.length > 0) {
				checkedValues = checkedValues.substring(0, checkedValues.length - 1);
				var hfValue = document.getElementById('<%=hfParenSelectedValue.ClientID%>').value;
				if (hfValue.length != 0) {
					var indexOd = hfValue.indexOf(ControlClientID + ';')
					if (indexOd != -1) {
						var pocetak = hfValue.substring(indexOd + ControlClientID.length + 1); // cut
						var indexOdBroja = pocetak.indexOf('|');
						var kraj = pocetak.substring(0, indexOdBroja);
						hfValue = hfValue.replace(ControlClientID + ';' + kraj + '|', ''); // remove existing value
					}
					document.getElementById('<%=hfParenSelectedValue.ClientID%>').value = hfValue + ControlClientID + ';' + checkedValues + '|';
					document.getElementById('<%=hfLastSelectedIndexChanged.ClientID%>').value = cfid;
				}
				else {
					document.getElementById('<%=hfParenSelectedValue.ClientID%>').value = ControlClientID + ';' + checkedValues + '|';
					document.getElementById('<%=hfLastSelectedIndexChanged.ClientID%>').value = cfid;
				}
			}
			else {
				var hfValue = document.getElementById('<%=hfParenSelectedValue.ClientID%>').value;
				if (hfValue.length != 0) {
					var indexOd = hfValue.indexOf(ControlClientID + ';')
					if (indexOd != -1) {
						var pocetak = hfValue.substring(indexOd + ControlClientID.length + 1); // cut
						var indexOdBroja = pocetak.indexOf('|');
						var kraj = pocetak.substring(0, indexOdBroja);
						hfValue = hfValue.replace(ControlClientID + ';' + kraj + '|', ''); // remove existing value
						document.getElementById('<%=hfParenSelectedValue.ClientID%>').value = hfValue
						document.getElementById('<%=hfLastSelectedIndexChanged.ClientID%>').value = cfid;
					}
				}
			}
		}
	}

	var edn_admin_localization = {
		image_token_editor_title: '<%=Customizegalleryitemtoken%>',
		image_token_editor_close: '<%=Close%>',
		gmaps_token_editor_add_map: '<%=Addasarticlemap%>',
		gmaps_token_editor_close: '<%=Close%>',
		gmaps_token_editor_title: '<%=AddGoogleMapslocation%>',
		gmaps_token_editor_edit_marker: '<%=Edit%>',
		gmaps_token_editor_edit_marker_editor_title: '<%=Addmapmarker%>',
		gmaps_token_editor_edit_marker_latitude: '<%=Latitude%>:',
		gmaps_token_editor_edit_marker_langitude: '<%=Longitude%>',
		gmaps_token_editor_edit_marker_center: '<%=Centeronmap%>',
		gmaps_token_editor_edit_marker_title_required_warning: '<%=Atitleisrequired%>',
		gmaps_token_editor_edit_marker_marker_title: '<%=Title%>',
		gmaps_token_editor_edit_marker_marker_html: '<%=HTMoptional%>',
		gmaps_token_editor_edit_marker_button_confirm: '<%=Confirm%>',
		gmaps_token_editor_edit_marker_button_cancel: '<%=Cancel%>'
	},
		fineUploaderLocalization = function () {
			return <%=FineUploaderLocalizationJs()%>;
		},
		galleryFineUploaderSettings = function () {
			return {
				endpoint: '<%=_ControlPath%>htmluploader.ashx?portalid=<%=PortalId%>',
				params: {
					moduleId: '<%=ModuleId%>',
					galleryId: document.getElementById('<%=curentActiveGalleryId.ClientID%>').value,
					resize: document.getElementById('<%=hfResize.ClientID%>').value,
					width: document.getElementById('<%=hfResizeWidth.ClientID%>').value,
					height: document.getElementById('<%=hfResizeHeight.ClientID%>').value,
					revisionid: <%=RevisionHistoryEntryID%>,
					articleId: <%=editArticleId%>,
					jsonResponse: true
				},
				onAllUploadsComplete: function () {
					document.getElementById('<%=galleryUploadComplete.ClientID%>').click();
				},
				localization: fineUploaderLocalization(),
				allowedExtensions: [
					'jpg',
					'jpeg',
					'gif',
					'png',
					'bmp'
				],
				allowPreviewThumbnails: true
			}
		},
		documentsFineUploaderSettings = function () {
			var uploadedDocumentsJson = [],
				hfUploadedDocs = document.getElementById('<%=hfUploadedDocs.ClientID%>');

			return {
				endpoint: '<%=_ControlPath%>htmldocumentuploader.ashx?portalid=<%=PortalId%>',
				params: {
					articleid:'<%=Article_EDITING == null ? 0 : Article_EDITING.ArticleID%>',
					moduleId:'<%=ModuleId%>',
					guid: '<%=hfGUID.Value%>',
					revisionid: <%=RevisionHistoryEntryID%>,
					jsonResponse: true
				},
				onEachUploadComplete: function (response) {
					if ('<%=Article_EDITING == null ? 0 : Article_EDITING.ArticleID%>' == '0')
						uploadedDocumentsJson.push(response.document);
				},
				onAllUploadsComplete: function () {
					hfUploadedDocs.value = JSON.stringify(uploadedDocumentsJson);
					document.getElementById('<%=btnDocUploadRefresh.ClientID%>').click();
				},
				localization: fineUploaderLocalization(),
				allowedExtensions: [],
				allowPreviewThumbnails: true
			}
		},
		recurringDocumentsFineUploaderSettings = function () {
			return {
				endpoint: '<%=_ControlPath%>htmldocumentuploader.ashx?portalid=<%=PortalId%>',
				params: {
					articleid:'<%=Article_EDITING == null ? 0 : Article_EDITING.ArticleID%>',
					recurringId: '<%=EditEventRecurringID%>',
					moduleId: '<%=ModuleId%>',
					jsonResponse: true
				},
				onAllUploadsComplete: function () {
					document.getElementById('<%=btnRecurringEventDocUploadRefresh.ClientID%>').click();
				},
				localization: fineUploaderLocalization(),
				allowedExtensions: [],
				allowPreviewThumbnails: true
			}
		};

	function ClientValidateEmbedURL(source, arguments) {
		var textBox = document.getElementById("<%=tbEmbedVideoURL.ClientID %>");
		if (source.id.indexOf("Shared") != -1)
			textBox = document.getElementById("<%=tbSharedEmbedVideoURL.ClientID %>");
		else if (source.id.indexOf("Custom") != -1)
			textBox = document.getElementById("<%=tbCustomEmbedVideoURL.ClientID %>");

		var s = textBox.value;
		if ((s.indexOf("youtube.com") != -1 && s.indexOf("v=") != -1) || (s.indexOf("youtu.be/") != -1) || (s.indexOf("vimeo.com") != -1) || (s.indexOf("wistia.com") != -1) || (s.indexOf("wistia.net") != -1))
			arguments.IsValid = true;
		else
			arguments.IsValid = false;
	}

	function ClientValidateStructuredDataTemplate(source, arguments) {
		var jsonTemplate = document.getElementById("<%=tbStructuredDataJSON.ClientID %>").value;
		if (jsonTemplate.indexOf("Placeholder") == -1) {
			arguments.IsValid = true;
		}
		else {
			arguments.IsValid = false;
			$('#<%=pnlSEO.ClientID%>').children('.content').slideDown(0);
			$('#<%=pnlSEO.ClientID%> h1').addClass('close');
			$('#<%=pnlSEO.ClientID%>').find('.edsTabStructuredData').click();
			$('#<%=tbStructuredDataJSON.ClientID %>').focus();
		}

	}

	window.edn_module_root = '<%=_ControlPath%>';
	window.edn_geolocation_request = <%=askForLocation%>;

	function initializeUploadify(inputId, galleryId) {
		(function ($) {
			if ($('#EDNadmin .uploadify_container').length == 0)
				return;

			$('#' + inputId).uploadify({
				'uploader': '<%=_ControlPath%>js/uploadify.swf',
				'script': '<%=_ControlPath%>UploadImages.ashx?tabid=<%=TabId%>',
				'scriptData': { 'moduleId': <%=ModuleId%>, 'galleryId': galleryId, 'revisionid': <%=RevisionHistoryEntryID%>, 'articleId': <%=editArticleId%>},
				'cancelImg': '<%=_ControlPath%>images/cancel.png',
				'multi': true,
				'fileDesc': 'Image Files',
				'fileExt': '*.jpg;*.png;*.gif;*.bmp;*.jpeg',
				'queueSizeLimit': 100,
				'sizeLimit': 40000000,
				'buttonText': 'SELECT IMAGES FOR UPLOAD',
				'onAllComplete': function () {
					document.getElementById('<%=galleryUploadComplete.ClientID%>').click();
				},
				'onError': function (e, queueID, fileObj, errorObj) {
					var msg;
					if (errorObj.status == 404) {
						alert('Could not find upload script. Use a path relative to: ' + '<?= getcwd() ?>');
						msg = 'Could not find upload script.';
					} else if (errorObj.type === "HTTP")
						msg = errorObj.type + ": " + errorObj.status;
					else if (errorObj.type === "File Size")
						msg = fileObj.name + '<br>' + errorObj.type + ' Limit: ' + Math.round(errorObj.sizeLimit / 1024) + 'KB';
					else
						msg = errorObj.type + ": " + errorObj.text;
					$.jGrowl('<p></p>' + msg, {
						theme: 'error',
						header: 'ERROR',
						sticky: true
					});
					$('#' + inputId + queueID).fadeOut(250, function () { $('#' + inputId + queueID).remove() });
					return false;
				},
				'onComplete': function (a, b, c) {
					var size = Math.round(c.size / 1024);
					$.jGrowl(
						'<p></p>' + c.name + ' - ' + size + 'KB',
						{
							theme: 'success',
							header: '<%=UploadComplete%>',
							life: 3000,
							sticky: false
						}
					);
				}
			});
		})($);
	}

	<%=initDocumentUploadRblSelection%>

	function CostByDateRestriction_Init() {
		eds2_2('#eds__CostByDateRestriction').eds2_2_DateRestrictionPayment_Edit_1_0_0({
			hfStateId: '#<%=hfDateCostMatrix.ClientID%>',
			hfStateViewSpecificId: '#<%=hfDateCostMatrixViewSpecific.ClientID%>',
			tbValidateDecimalId: '#<%=tbValidateDecimal.ClientID%>',
			i18n: <%=I18n_dateRestriction%>,
			<%=MatrixDateTimePickerSettings%>
		});

		var costByRestriction = eds2_2('#eds__RecurringCostByDateRestriction');
		if (costByRestriction.length !== 0) {
			eds2_2('#eds__RecurringCostByDateRestriction').eds2_2_DateRestrictionPayment_Edit_1_0_0({
				hfStateId: '#<%=hfRecurringDateCostMatrix.ClientID%>',
				hfStateViewSpecificId: '#<%=hfRecurringDateCostMatrixViewSpecific.ClientID%>',
				tbValidateDecimalId: '#<%=tbRecurringValidateDecimal.ClientID%>',
				i18n: <%=I18n_dateRestriction%>,
			<%=MatrixDateTimePickerSettings%>
			});
		}
	}

	function changeMetaDataTemplate(e, templateType) {
		$(e.target).prop("disabled", true);
		$.ajax({
			type: 'GET',
			url: '<%=_ControlPath%>/ashx/GetFileData.ashx',
			dataType: 'json',
			data: {
				portalId: <%=PortalId%>,
				moduleId: <%=ModuleId%>,
				articleId: <%=editArticleId%>,
				tabid: <%=TabId%>,
				templateName: encodeURIComponent(e.target.value),
				action: 'getMetaDataTemplate'
			},
			success: function (response) {
				if (response != null && response.success != undefined && response.success && response.message != undefined) {
					if (templateType == "openGraph")
						document.getElementById("<%=tbOpenGraphMetaTags.ClientID %>").value = response.message;

					if (templateType == "structuredData")
						document.getElementById("<%=tbStructuredDataJSON.ClientID %>").value = response.message;

					if (templateType == "twitterCards")
						document.getElementById("<%=tbTwitterCardMetaTags.ClientID %>").value = response.message;
				}
			},
			complete: function () {
				$(e.target).prop("disabled", false);
			}
		});
		return false;
	}
	function ApproveClicked(elem, forceCheck) {
		var $clicked = $(elem);

		if ($clicked[0].checked) {
			var $selectedState = $('.eds__selectedWorkFlowState', '.eds__workflowStateList'),
				$rejectInput = $('.eds__rejectArticle');

			$('input', $rejectInput).prop('disabled', true);

			if ($selectedState.length > 0) {
				$nextState = $($selectedState).next('li');
				if ($nextState.length > 0) {
					$($selectedState).removeClass('eds__selectedWorkFlowState');
					$($nextState).addClass('eds__selectedWorkFlowState');
					if ($($nextState).data('publishstate') == 'publish' || $($nextState).data('publishstate') == 'approve') {
						$("#<%=btnUpdateArticle.ClientID%>").hide();
						$("#<%=btnAddNewArticle.ClientID%>").hide();
						var $social_sharing_box = $('#<%=pnlSocialSharing.ClientID%>'),
							$PostToJournal = $('#<%=pnlPostToJournal.ClientID%>');
						if ($($nextState).data('publishstate') == 'publish') {
							$social_sharing_box.stop(true, true).fadeTo(200, 1);
							$PostToJournal.stop(true, true).fadeTo(200, 1);
						}
					}
				}
			}
			else {
				var $social_sharing_box = $('#<%=pnlSocialSharing.ClientID%>'),
					$PostToJournal = $('#<%=pnlPostToJournal.ClientID%>');
				$social_sharing_box.stop(true, true).fadeTo(200, 1);
				$PostToJournal.stop(true, true).fadeTo(200, 1);

			}
		}
		else {
			if (!forceCheck) {
				var $selectedState = $('.eds__selectedWorkFlowState', '.eds__workflowStateList'),
					$rejectInput = $('.eds__rejectArticle');

				$('input', $rejectInput).prop('disabled', false);

				if ($selectedState.length > 0) {
					$prevState = $($selectedState).prev('li');
					if ($prevState.length > 0) {
						$($selectedState).removeClass('eds__selectedWorkFlowState');
						$($prevState).addClass('eds__selectedWorkFlowState');
						//if ($($selectedState).data('publishstate') == 'publish' || $($selectedState).data('publishstate') == 'approve') {
						$("#<%=btnUpdateArticle.ClientID%>").show();
						$("#<%=btnAddNewArticle.ClientID%>").show();
						var $social_sharing_box = $('#<%=pnlSocialSharing.ClientID%>'),
							$PostToJournal = $('#<%=pnlPostToJournal.ClientID%>');
						$social_sharing_box.stop(true, true).fadeTo(0, 0);
						$PostToJournal.stop(true, true).fadeTo(0, 0);
						//}
					}
				}
				else {
					var $social_sharing_box = $('#<%=pnlSocialSharing.ClientID%>'),
						$PostToJournal = $('#<%=pnlPostToJournal.ClientID%>');
					$social_sharing_box.stop(true, true).fadeTo(0, 0);
					$PostToJournal.stop(true, true).fadeTo(0, 0);
				}
			}
			else {
				var $social_sharing_box = $('#<%=pnlSocialSharing.ClientID%>'),
					$PostToJournal = $('#<%=pnlPostToJournal.ClientID%>');
				$social_sharing_box.stop(true, true).fadeTo(0, 0);
				$PostToJournal.stop(true, true).fadeTo(0, 0);
			}
		}
	}

	function RejectClicked(elem, forceCheck) {
		var $clicked = $(elem);

		if ($clicked[0].checked) {
			var $selectedState = $('.eds__selectedWorkFlowState', '.eds__workflowStateList'),
				$approveArticle = $('.eds__approveArticle'),
				$rejectMessage = $('.eds__rejectArticleMessageText');

			$('input', $approveArticle).prop('disabled', true);

			if ($selectedState.length > 0) {
				$prevState = $($selectedState).prev('li');
				if ($prevState.length > 0) {
					$($selectedState).removeClass('eds__selectedWorkFlowState');
					$($prevState).addClass('eds__selectedWorkFlowState');
					$rejectMessage.show();
					if ($($prevState).data('publishstate') == 'approve' || $($prevState).data('publishstate') == 'draft') {
						$("#<%=btnUpdateArticle.ClientID%>").hide();
					}
				}
			}
		}
		else {
			if (!forceCheck) {
				var $selectedState = $('.eds__selectedWorkFlowState', '.eds__workflowStateList'),
					$approveArticle = $('.eds__approveArticle'),
					$rejectMessage = $('.eds__rejectArticleMessageText');

				$('input', $approveArticle).prop('disabled', false);

				if ($selectedState.length > 0) {
					$nextState = $($selectedState).next('li');
					if ($nextState.length > 0) {
						$($selectedState).removeClass('eds__selectedWorkFlowState');
						$($nextState).addClass('eds__selectedWorkFlowState');
						$rejectMessage.hide();
						if ($("#<%=btnUpdateArticle.ClientID%>").length)
							$("#<%=btnUpdateArticle.ClientID%>").show();
					}
				}
			}
		}
	}

	eds2_2(function ($) {
		$(document).ready(function () {

			ApproveClicked($("#<%=cbApproveArticle.ClientID%>"), true);
			if ($("#<%=cbRejectArticle.ClientID%>").length)
				RejectClicked($("#<%=cbRejectArticle.ClientID%>"), true);

			$("#<%=cbApproveArticle.ClientID%>").on('click', function (e) {
				ApproveClicked(this, false)
			})

			$("#<%=cbRejectArticle.ClientID%>").on('click', function (e) {
				RejectClicked(this, false)
			})

			if ('<%=articleLockNeeded%>' == 'True') {
				eds2_2('a', '.edNews_adminNavigationMenu').click(function () {
					cleararticleCacheLock();
					return true;
				});
				setInterval(function () {
					closingCode();
				}, 270000);
			}

			<%--if ('<%=IS_ARTICLE_REVISION%>' == 'True')
				$("#<%=pnlCustomFieldsSelect.ClientID%> :input").attr("disabled", true);--%>
		});
		$("#<%=ddlOpenGraphTemplate.ClientID%>").change(function (event) {
			if (event.target.value != "0")
				changeMetaDataTemplate(event, "openGraph");
		});

		$("#<%=ddlStructuredDataTemplate.ClientID%>").change(function (event) {
			changeMetaDataTemplate(event, "structuredData");
		});

		$("#<%=ddlTwitterCardsTemplate.ClientID%>").change(function (event) {
			changeMetaDataTemplate(event, "twitterCards");
		});

		CostByDateRestriction_Init();

		$('#<%=lbSocialSecurityGroups.ClientID %>').dropdownchecklist({
			forceMultiple: true,
			minWidth: 106,
			width: 106,
			emptyText: '<span class="empty">None</span>'
		});

		$("#eds_add_attendees_discount").click(function () {
			AddRowToEventDiscountTable('<%=tblAttendeesDiscount.ClientID%>');
		});

		$('#<%=tblAttendeesDiscount.ClientID%>').on('click', '.eds_removeRow', function () {
			$(this).parent().parent().remove();
			FillEventAttendeesDiscountHf();
		});

		$('#<%=tblAttendeesDiscount.ClientID%>').on('keyup', '.eds_table_cell_input', function () {
			if ($(this).parent().parent().next('tr').length == 0)
				AddRowToEventDiscountTable('<%=tblAttendeesDiscount.ClientID%>');

			FillEventAttendeesDiscountHf();
		});

		$(function () {
			$('#<%=tblAttendeesDiscount.ClientID%> tbody').sortable({
				cursor: "pointer",
				update: function (event, ui) {
					FillEventAttendeesDiscountHf();
				}
			});
		});

		$("#eds_add_cost_per_attendee").click(function () {
			AddRowToEventCostTable('<%=tblCostPerAttendee.ClientID%>');
		});

		$('#<%=tblCostPerAttendee.ClientID%>').on('click', '.eds_removeRow', function () {
			$(this).parent().parent().remove();
			FillEventAttendeesCostHf();
		});

		$('#<%=tblCostPerAttendee.ClientID%>').on('keyup', '.eds_table_cell_input', function () {
			if ($(this).parent().parent().next('tr').length == 0)
				AddRowToEventCostTable('<%=tblCostPerAttendee.ClientID%>');

			FillEventAttendeesCostHf();
		});

		$(function () {
			$('#<%=tblCostPerAttendee.ClientID%> tbody').sortable({
				cursor: "pointer",
				update: function (event, ui) {
					FillEventAttendeesCostHf();
				}
			});
		});

		var token_editors_initialized = false;

		$('#EDNadmin').bind('token_editor_initialized', function () {
			if (token_editors_initialized)
				return;

			token_editors_initialized = true;

			$('.content_token_generator.gallery_item').html('\
				<div class="dialog_wrapper">\
					<div class="token_area edNews_inputGroup inputBorder">\
						<textarea class="the_token" cols="50" rows="5"></textarea>\
						<p><%=CopyAndPaste%></p>\
					</div>\
					<h1><%=Itemtokensettings%></h1>\
					<p class="option">\
						<label for="gallery_item_token_width">\
							<%=Width%></label>\
						<input id="gallery_item_token_width" type="text" name="width" value="" /></p>\
					<p class="option">\
						<label for="gallery_item_token_height">\
							<%=Height %></label>\
						<input id="gallery_item_token_height" type="text" name="height" value="" /></p>\
					<p class="option">\
						<%=Sizing%><input type="radio" id="gallery_item_token_sizing_proportional" class="gallery_item_token_sizing" name="sizing" value="proportional" />\
						<label for="gallery_item_token_sizing_proportional">\
							<%=Proportional %></label>\
						<input type="radio" id="gallery_item_token_sizing_crop" class="gallery_item_token_sizing" name="sizing" value="crop" /><label for="gallery_item_token_sizing_crop"><%=Croptosize%></label></p>\
					<p class="option">\
						<%=Position%><input type="radio" id="gallery_item_token_position_left_clear" class="gallery_item_token_position" name="position" value="left_clear" />\
						<label for="gallery_item_token_position_left_clear">\
							<%=Leftclear%></label>\
						<input type="radio" id="gallery_item_token_position_left" class="gallery_item_token_position" name="position" value="left" />\
						<label for="gallery_item_token_position_left">\
							<%=Leftwrap%></label>\
						<input type="radio" id="gallery_item_token_position_right" class="gallery_item_token_position" name="position" value="right" />\
						<label for="gallery_item_token_position_right">\
							<%=Rightwrap%></label></p>\
					<p class="option">\
						<%=Onclickaction%>\
						<input type="radio" id="gallery_item_token_onclick_lightbox" class="gallery_item_token_onclick" name="onclick" value="lightbox" />\
						<label for="gallery_item_token_onclick_lightbox">\
							<%=Openiteminlightbox%></label>\
						<input type="radio" id="gallery_item_token_onclick_redirect" class="gallery_item_token_onclick" name="onclick" value="redirect" />\
						<label for="gallery_item_token_onclick_redirect">\
							<%=RedirecttosetURL%></label>\
						<input type="radio" id="gallery_item_token_onclick_nothing" class="gallery_item_token_onclick" name="onclick" value="nothing" />\
						<label for="gallery_item_token_onclick_nothing">\
							<%=None%></label></p>\
					<p class="option">\
						<input type="checkbox" class="normalCheckBox" id="gallery_item_token_title" name="title" value="true" />\
						<label for="gallery_item_token_title">\
							<%=Showtitle%></label></p>\
					<p class="option">\
						<input type="checkbox" class="normalCheckBox" id="gallery_item_token_description" name="description" value="true" />\
						<label for="gallery_item_token_description">\
							<%=Showdescription%></label></p>\
					<p class="option">\
						<input type="checkbox" class="normalCheckBox" id="gallery_item_token_as_text_link" name="as_text_link" value="true" />\
						<label for="gallery_item_token_as_text_link">\
							<%=Showastandardtextlink%></label></p>\
					<div class="indented" style="display: none;">\
						<p class="option no_margin">\
							<label for="gallery_item_token_link_text">\<%=Linktext%></label>\
							<input type="text" id="gallery_item_token_link_text" name="link_text" value="" /></p>\
						<p class="option no_margin small_grey"><%=Note%></p>\
					</div>\
				</div>');

			$('.content_token_generator.google_maps').html('\
						<div class="dialog_wrapper edNews_adminWrapper">\
							<div class="pages_container">\
								<div class="page">\
									<div class="location_search">\
										<%=Searchforlocation%>\
										<input type="text" name="search_input" id="map_location_search" value="" />\
									</div>\
									<div class="map_container">\
									</div>\
									<div class="token_settings">\
										<div class="settings_wrapper">\
											<div class="page general">\
												<p class="option">\
													<button type="button" class="generate_token ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">\
														<%=Generatetoken%></button>\
												</p>\
												<h2>\
													<%=Generalsettings%></h2>\
												<p class="option">\
													<label for="edn_maps_token_map_type">\
														<%=Maptype%></label>\
													<select name="map_type" id="edn_maps_token_map_type">\
														<option value="roadmap">Roadmap</option>\
														<option value="satellite">Satellite</option>\
														<option value="hybrid">Hybrid</option>\
														<option value="terrain">Terrain</option>\
													</select>\
												</p>\
												<p class="option">\
													<label for="edn_maps_token_latitude">\
														<%=Latitude%></label>\
													<input type="text" name="latitude" id="edn_maps_token_latitude" value="" />\
												</p>\
												<p class="option">\
													<label for="edn_maps_token_longitude">\
														<%=Longitude%></label>\
													<input type="text" name="longitude" id="edn_maps_token_longitude" value="" />\
												</p>\
												<p class="option">\
													<label for="edn_maps_token_zoom">\
														<%=Zoom%></label>\
													<input type="text" name="zoom" id="edn_maps_token_zoom" value="" />\
												</p>\
												<p class="option">\
													<label for="edn_maps_token_width">\
														<%=WidthMap%></label>\
													<input type="text" name="width" id="edn_maps_token_width" value="" />\
												</p>\
												<p class="option">\
													<label for="edn_maps_token_height">\
														<%=HeightMap%></label>\
													<input type="text" name="height" id="edn_maps_token_height" value="" />\
												</p>\
												<p class="option styledCheckbox">\
													<input type="checkbox" name="scrollwheel" class="normalCheckBox" id="edn_maps_token_scrollwheel" value="1" />\
													<label for="edn_maps_token_scrollwheel">\
														<%=Enablescrollwheelzoom%></label>\
												</p>\
												<div class="mainActions smallActions noMargin textRight">\
													<button type="button" class="add_marker_trigger add">\
														<%=Addmarker%></button>\
												</div>\
												<div class="map_marker_container">\
													<h2>\
														<%=Mapmarkers %></h2>\
													<a href="#" class="delete_selected">\
														<%=Delete%></a>\
													<div class="marker_list">\
													</div>\
												</div>\
											</div>\
										</div>\
									</div>\
									<div class="token_area">\
										<p class="token_message">\
											<%=CopyAndPasteToken %></p>\
										<div class="edNews_inputGroup inputBorder">\
											<textarea class="the_token" cols="10" rows="3"></textarea></div>\
										<button type="button" class="back_to_editor ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">\
											<%=Backtoediting%></button>\
									</div>\
								</div>\
							</div>\
						</div>');
		});

		if (typeof toogleDocumentPanels == 'function')
			toogleDocumentPanels();

		if (typeof toogleDocumentUploadPanels == 'function')
			toogleDocumentUploadPanels();

		if (typeof toogleRecurringEventDocumentPanels == 'function')
			toogleRecurringEventDocumentPanels();

		$('#<%=tbPublishDate.ClientID%>,#<%=tbExpireDate.ClientID%>,#<%=tbEventStartDate.ClientID%>,#<%=tbEventEndDate.ClientID%>,#<%=tbxRecurringEndByDate.ClientID%>,#<%=tbxRecurringEventStartDate.ClientID%>,#<%=tbxRecurringEventEndDate.ClientID%>').datepick({ dateFormat: "<%=dateFormat%>" });

		$('#<%=tbEventStartTime.ClientID%>,#<%=tbEventEndTime.ClientID%>,#<%=tbxRecurringEventStartTime.ClientID%>,#<%=tbxRecurringEventEndTime.ClientID%>,#<%=tbPublishTime.ClientID%>,#<%=tbExpireTime.ClientID%>').timePicker({
			startTime: "00:00",
			endTime: new Date(0, 0, 0, 23, 59, 0),
			show24Hours: <%=time24h %>,
			separator: ':',
			step: 30
		}
		);

		$("#EDN_admin_included_galleries")
			.sortable()
			.disableSelection();
		$('#add_existing_tags_box > .content')
			.hide(0);
		$('#add_existing_tags_box > h1.collapsible_box_title.close')
			.removeClass('close');

		var toggleCollapsibleBox = function (e) {
			var clicked = $(e.target),
				target_content = clicked.parent().children('.content');

			if (target_content.is(':visible')) {
				target_content.slideUp(300);
				clicked.removeClass('close');
			} else {
				target_content.slideDown(300);
				clicked.addClass('close');
			}
		};

		$('#EDNadmin .main_content').delegate('h1.collapsible_box_title', 'click', toggleCollapsibleBox);
		$('#<%=pnlPreviousVersions.ClientID%>').click(toggleCollapsibleBox);
		$('#<%=tbArticleTitle.ClientID%>').EDNGenerateUrl('#<%=tbArticleURL.ClientID%>', {
		<%=jsReplaceCharacters%>
		});

		$('#EDNadmin .main_content').delegate('#<%=hlOpenImageTitleDescriptionOptions.ClientID%>', 'click', function () {
			var clickedLink = $(this), targetToOpen = $('#<%=pnlImageTitleDescriptionOptions.ClientID%>');
			if (targetToOpen.is(':visible')) {
				targetToOpen.slideUp(300);
				clickedLink.removeClass('close');
			} else {
				targetToOpen.slideDown(300);
				clickedLink.addClass('close');
			}
			return false;
		});

		$('#<%=tbCLArticleTitle.ClientID%>').EDNGenerateUrl('#<%=tbxCLArticleURL.ClientID%>', {
		<%=jsReplaceCharacters%>
		});

		$('#<%=upArticleImages.ClientID%>')
			.delegate('input.token_box', 'focusin', function () {
				var $clicked = $(this);
				$clicked.select()
			})
			.delegate('#<%=lbGallerySettings.ClientID%>', 'click', function () {
				var $toggle_button = $(this),
					$gal_settings_pnl = $('#<%=pnlGallerySettings.ClientID%>');
				if ($gal_settings_pnl.is(":visible")) {
					$gal_settings_pnl.stop(false, true).hide(300);
					$toggle_button
						.html('<%=Viewsettings%>')
						.removeClass('up_arrows')
						.addClass('down_arrows');
				} else {
					$gal_settings_pnl.stop(false, true).show(300);
					$toggle_button
						.html('<%=Closesettings%>')
						.removeClass('down_arrows')
						.addClass('up_arrows');
				}
				return false;
			});

		$('#EDN_btnReGenerateURL').click(function () {
			$('#<%=tbArticleTitle.ClientID%>').trigger('keyup');
			return false;
		});
		$('#EDN_btnCLReGenerateURL').click(function () {
			$('#<%=tbCLArticleTitle.ClientID%>').trigger('keyup');
			return false;
		});

		initializeUploadify(
			'<%=fileInput.ClientID%>',
			$('#<%=hfGalID.ClientID%>').val()
		);

		initializeUploadify(
			'<%=SharedfileInput.ClientID%>',
			$('#<%=hfSharedGalID.ClientID%>').val()
		);

		initializeUploadify(
			'<%=GalfileInput.ClientID%>',
			'1'
		);

		if (document.getElementById('<%=hfResize.ClientID%>') != null)
			eds2_2('.galleryFineUploader').edsFineUploader_1_3(galleryFineUploaderSettings());

		var $documentsFineUploader = eds2_2('#<%=divAddDocumentFineUploader.ClientID %>');
		if ($documentsFineUploader.length > 0)
			$documentsFineUploader.edsFineUploader_1_3(documentsFineUploaderSettings());

		var $recurringDocumentsFineUploader = eds2_2('#<%=divRecurringEventAddDocumentFineUploader.ClientID %>');
		if ($recurringDocumentsFineUploader.length > 0)
			$recurringDocumentsFineUploader.edsFineUploader_1_3(recurringDocumentsFineUploaderSettings());
	});

	<%=languageDropdownCheckbox%>
	<%=languageDropdownCheckboxGridViewJS%>
	<%=includeLanguageListboxFunctions%>
	<%=includeDocumentLanguageJS%>

	function AddRowToEventDiscountTable(TableName) {
		eds2_2('#' + TableName).append('<tr valign="top"><td><input type="text" class="eds_table_cell_input" name="eds_RowName" value="" placeholder="Number of" /> </td><td> <input type="text" class="eds_table_cell_input" name="eds_RowValue" value="" placeholder="Discount" /> </td><td><select name="eds_valueType" class="eds_table_cell_select"><option value="0">Unit</option><option value="1">Percent</option></select></td><td><img src="<%=_ControlPath%>images/move2red.png" height="16" width="16"></td><td> <a href="javascript:void(0);" class="eds_removeRow">Remove</a></td></tr>');
	}
	function AddRowToEventCostTable(TableName) {
		eds2_2('#' + TableName).append('<tr valign="top"><td><input type="text" class="eds_table_cell_input" name="eds_CostRowName" value="" placeholder="Name" /> </td><td><input type="hidden" class="eds_table_cell_input" name="eds_costid" value="" />  <input type="text" class="eds_table_cell_input" name="eds_CostRowValue" value="" placeholder="Cost" /> </td><td><img src="<%=_ControlPath%>images/move2red.png" height="16" width="16"></td><td> <a href="javascript:void(0);" class="eds_removeRow">Remove</a></td></tr>');
	}

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			(function ($) {

				CostByDateRestriction_Init();

				$("#eds_add_attendees_discount").click(function () {
					AddRowToEventDiscountTable('<%=tblAttendeesDiscount.ClientID%>');
				});

				eds2_2('#<%=tblAttendeesDiscount.ClientID%>').on('click', '.eds_removeRow', function () {
					$(this).parent().parent().remove();
					FillEventAttendeesDiscountHf();
				});

				eds2_2('#<%=tblAttendeesDiscount.ClientID%>').on('keyup', '.eds_table_cell_input', function () {
					if ($(this).parent().parent().next('tr').length == 0)
						AddRowToEventDiscountTable('<%=tblAttendeesDiscount.ClientID%>');

					FillEventAttendeesDiscountHf();
				});

				$(function () {
					$('#<%=tblAttendeesDiscount.ClientID%> tbody').sortable({
						cursor: "pointer",
						update: function (event, ui) {
							FillEventAttendeesDiscountHf();
						}
					});
				});

				$("#eds_add_cost_per_attendee").click(function () {
					AddRowToEventCostTable('<%=tblCostPerAttendee.ClientID%>');
				});

				eds2_2('#<%=tblCostPerAttendee.ClientID%>').on('click', '.eds_removeRow', function () {
					$(this).parent().parent().remove();
					FillEventAttendeesCostHf();
				});

				eds2_2('#<%=tblCostPerAttendee.ClientID%>').on('keyup', '.eds_table_cell_input', function () {
					if ($(this).parent().parent().next('tr').length == 0)
						AddRowToEventCostTable('<%=tblCostPerAttendee.ClientID%>');

					FillEventAttendeesCostHf();
				});

				$(function () {
					$('#<%=tblCostPerAttendee.ClientID%> tbody').sortable({
						cursor: "pointer",
						update: function (event, ui) {
							FillEventAttendeesCostHf();
						}
					});
				});

				$('#<%=tbPublishDate.ClientID%>,#<%=tbExpireDate.ClientID%>,#<%=tbEventStartDate.ClientID%>,#<%=tbEventEndDate.ClientID%>,#<%=tbxRecurringEndByDate.ClientID%>,#<%=tbxRecurringEventStartDate.ClientID%>,#<%=tbxRecurringEventEndDate.ClientID%>').datepick({ dateFormat: "<%=dateFormat%>" });

				$('#<%=tbEventStartTime.ClientID%>,#<%=tbEventEndTime.ClientID%>,#<%=tbxRecurringEventStartTime.ClientID%>,#<%=tbxRecurringEventEndTime.ClientID%>,#<%=tbPublishTime.ClientID%>,#<%=tbExpireTime.ClientID%>').timePicker({
					startTime: "00:00",
					endTime: new Date(0, 0, 0, 23, 59, 0),
					show24Hours: <%=time24h %>,
					separator: ':',
					step: 30
				}
				);

				if ($('#<%=upArticleImages.ClientID%> .uploadifyQueue').length == 0) {
					$("#EDN_admin_included_galleries")
						.sortable()
						.disableSelection();

					initializeUploadify(
						'<%=fileInput.ClientID%>',
						$('#<%=hfGalID.ClientID%>').val()
					);

					initializeUploadify(
						'<%=SharedfileInput.ClientID%>',
						$('#<%=hfSharedGalID.ClientID%>').val()
					);

					initializeUploadify(
						'<%=GalfileInput.ClientID%>',
						'1'
					);
				}

				if (document.getElementById('<%=hfResize.ClientID%>') != null)
					eds2_2('.galleryFineUploader').edsFineUploader_1_3(galleryFineUploaderSettings());

				eds2_2('.edNews_tooltip').eds_tooltipster();

			})(eds2_2);
		}
	}
	// ]]>
</script>
