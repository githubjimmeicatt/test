<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.CategoryEditor, App_Web_categoryeditor.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register Src="~/controls/URLControl.ascx" TagName="URL" TagPrefix="Portal" %>
<script type="text/javascript">
	function ShowValue() {
		return confirm('<%=Localization.GetString("Areyousure.Text", this.LocalResourceFile)%>');
	}
</script>
<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topActions">
			<li class="edNews_close">
				<asp:LinkButton ID="hlPowerOff" runat="server" OnClick="lbClose_Click" resourcekey="lbCloseResource1"></asp:LinkButton>
			</li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=CategoryManager%></span>
		</div>
		<asp:Panel ID="pnlCatManagment" CssClass="sectionBox noPadding" runat="server">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=Categories%></span>
			</div>
			<div class="sectionBox noPadding sectionBox">
				<div class="edNews_twoColumns edNews_twoColumns_7030 noBorder edNews_highLightedRight">
					<div>
						<asp:ListBox ID="lbCategoryList" runat="server" CssClass="edNews_listBox" />
					</div>
					<div>
						<div class="sectionBox sectionBox3 noPadding noMargin noBorder">
							<div class="sectionBoxHeader">
								<span class="sectionBoxHeaderTitle">Position</span>
							</div>
							<div class="edNews_MoveActions">
								<div>
									<asp:LinkButton ID="ibUP" runat="server" CssClass="edNews_moveUp" OnCommand="CategoryPositioning" CommandName="Up" resourcekey="ibUP" />
								</div>
								<asp:LinkButton ID="ibLeft" runat="server" CssClass="edNews_moveLeft" OnCommand="CategoryPositioning" CommandName="Left" resourcekey="ibLeft" />
								<asp:LinkButton ID="ibDown" runat="server" CssClass="edNews_moveDown" OnCommand="CategoryPositioning" CommandName="Down" resourcekey="ibDown" />
								<asp:LinkButton ID="inRight" runat="server" CssClass="edNews_moveRight" OnCommand="CategoryPositioning" CommandName="Right" resourcekey="inRight" />
							</div>
						</div>
						<div class="sectionBox sectionBox3 noPadding noMargin noBorder">
							<div class="sectionBoxHeader">
								<span class="sectionBoxHeaderTitle">Edit/Remove</span>
							</div>
							<div class="edNews_editRemoveActions">
								<asp:LinkButton ID="inEditItem" runat="server" CssClass="edNews_edit" OnClick="inEditItem_Click" resourcekey="inEditItem" />
								<asp:LinkButton ID="ibDelete" runat="server" CssClass="edNews_delete" OnClientClick="return ShowValue();" OnClick="ibDelete_Click" resourcekey="ibDelete" />
								<asp:Label ID="lblDeleteMessage" CssClass="infoMessages success" runat="server" EnableViewState="false" Visible="false" />
							</div>
						</div>
					</div>
				</div>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlAddCategories" CssClass="sectionBox" runat="server">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=AddCategory%></span>
			</div>
			<div class="edNews_inputGroup inputWidth40">
				<label class="textLeft" for="<%=tbCategoryName.ClientID %>"><%=Categoryname %></label>
				<asp:TextBox ID="tbCategoryName" runat="server" MaxLength="100" ValidationGroup="vgCreateCat" />
				<asp:RequiredFieldValidator ID="rfvCatName" CssClass="smallInfo error" runat="server" ControlToValidate="tbCategoryName" ErrorMessage="Please enter a name." ValidationGroup="vgCreateCat" resourcekey="rfvCatNameResource1" SetFocusOnError="True" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlParentCategoryList.ClientID%>"><%=Categoryparent%></label>
				<asp:DropDownList ID="ddlParentCategoryList" runat="server" AppendDataBoundItems="True" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlCategoryColor.ClientID%>"><%=CategoryColor%></label>
				<asp:DropDownList ID="ddlCategoryColor" runat="server" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=txtCatText.ClientID %>"><%=Categorydescription%></label>
				<dnn:TextEditor ID="txtCatText" runat="server" Height="300" />
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categoryimage %></span>
				</div>
				<div class="edNews_inputGroup">
					<asp:FileUpload ID="fuCatImage" CssClass="image_selector" runat="server" />
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categorylink%></span>
				</div>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblSelectUrlAdd" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSelectUrlAdd_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Selected="True" Value="None" Text="None" resourcekey="ListItemResource2" />
						<asp:ListItem Value="URL" Text="Link" resourcekey="ListItemResource3" />
						<asp:ListItem Value="Page" Text="Page in the site" resourcekey="ListItemResource4" />
					</asp:RadioButtonList>
				</div>
				<div class="edNews_inputGroup inputWidth100">
					<asp:TextBox ID="tbCatURLAdd" runat="server" Visible="false" resourcekey="tbCatURLAddResource1"></asp:TextBox>
					<Portal:URL ID="ctlURLAdd" runat="server" ShowNewWindow="false" ShowUsers="false" ShowFiles="false" ShowLog="false" ShowSecure="false" ShowTabs="true" ShowTrack="false" ShowUpLoad="false" ShowUrls="false" ShowDatabase="false" UrlType="U" Visible="false" />
				</div>
			</div>
			<asp:Label ID="lblCreateCatMessage" runat="server" EnableViewState="false" />
			<div class="mainActions">
				<asp:LinkButton ID="lbAddNewCategory" runat="server" CssClass="add" OnClick="lbAddNewCategory_Click" ValidationGroup="vgCreateCat" resourcekey="lbAddNewCategoryResource1">Add new category</asp:LinkButton>
				<asp:LinkButton ID="lbClose" runat="server" CssClass="cancel" OnClick="lbClose_Click" resourcekey="lbCloseResource1">Close</asp:LinkButton>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlEditCatItem" CssClass="sectionBox" runat="server" Visible="False">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=EditCategory%></span>
				<div class="mainActions floatRight noMargin smallActions">
					<asp:LinkButton ID="lbLocalizeContent" runat="server" OnClick="lbLocalizeContent_Click" CssClass="primaryAction" resourcekey="lbLocalizeContentResource1" Visible="false">Category localization</asp:LinkButton>
				</div>
			</div>
			<div class="edNews_inputGroup inputWidth40">
				<label class="textLeft" for="<%=tbCategoryName.ClientID %>"><%=Categoryname%></label>
				<asp:TextBox ID="tbCategoryTitleUpdate" runat="server" MaxLength="100" ValidationGroup="vgCatTitleUpdate" CausesValidation="true" />
				<asp:RequiredFieldValidator ID="rfvCategoryName" CssClass="smallInfo error" runat="server" ControlToValidate="tbCategoryTitleUpdate" ErrorMessage="This field is required." ValidationGroup="vgCatTitleUpdate" resourcekey="rfvCategoryNameResource1" SetFocusOnError="True" />
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlParentCategoryEditList.ClientID%>"><%=Categoryparent%></label>
				<asp:DropDownList ID="ddlParentCategoryEditList" runat="server" AppendDataBoundItems="True" resourcekey="ddlParentCategoryEditListResource1">
					<asp:ListItem Value="-1" resourcekey="ListItemResource5">Select parent category</asp:ListItem>
					<asp:ListItem Value="0" resourcekey="ListItemResource6">No parent category</asp:ListItem>
				</asp:DropDownList>
				<asp:RadioButtonList ID="rblCategoriesMove" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblCategoriesMove_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
					<asp:ListItem resourcekey="liMoveAllCategories" Selected="True" Value="all">Move category with subcategories</asp:ListItem>
					<asp:ListItem resourcekey="liMoveOneCategory" Value="one">Move only one category</asp:ListItem>
				</asp:RadioButtonList>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlCategoryColorEdit.ClientID%>"><%=CategoryColor%></label>
				<asp:DropDownList ID="ddlCategoryColorEdit" runat="server" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=txtCatText.ClientID %>"><%=Categorydescription%></label>
				<dnn:TextEditor ID="txtCatDescriptionEdit" runat="server" Height="300" />
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categoryimage%></span>
				</div>
				<div class="edNews_imagePanel clearFix">
					<asp:Image ID="imgCatImageUpdate" CssClass="edNews_thumb" runat="server" />
					<div class="edNews_inputGroup displayInline edNews_fileUpload">
						<asp:FileUpload ID="fuCatReplaceImage" runat="server" />
					</div>
					<asp:Panel ID="pnlDeleteImage" CssClass="edNews_inputGroup edNews_removeImage clearFix" runat="server">
						<div class="mainActions noMargin smallActions floatRight">
							<asp:LinkButton ID="lbRemoveImage" CssClass="delete" runat="server" OnClick="lbRemoveImage_Click" resourcekey="lbRemoveImageResource1">Delete</asp:LinkButton>
						</div>
						<p><strong>This image</strong> is selected as the category's image</p>
					</asp:Panel>
				</div>
			</div>
			<div class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categorylink%></span>
				</div>
				<div class="edNews_inputGroup">
					<asp:RadioButtonList ID="rblSelectUrl" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSelectUrl_SelectedIndexChanged" resourcekey="rblSelectUrlResource1" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
						<asp:ListItem Value="None" Selected="True" resourcekey="ListItemResource7">None</asp:ListItem>
						<asp:ListItem Value="URL" resourcekey="ListItemResource8">Link</asp:ListItem>
						<asp:ListItem Value="Page" resourcekey="ListItemResource9">Page in the site</asp:ListItem>
					</asp:RadioButtonList>
				</div>
				<div class="edNews_inputGroup inputWidth100">
					<asp:TextBox ID="tbCatURL" runat="server"></asp:TextBox>
					<Portal:URL ID="ctlURL" runat="server" ShowNewWindow="False" ShowUsers="False" ShowFiles="False" ShowLog="False" ShowSecure="False" ShowTabs="True" ShowTrack="False" ShowUpLoad="False" ShowUrls="False" ShowDatabase="False" UrlType="U" />
				</div>
			</div>
			<asp:Label ID="lblUpdateCategoryMessage" runat="server" EnableViewState="false" Visible="False" />
			<div class="mainActions">
				<asp:LinkButton ID="lbUpdateCategory" runat="server" CssClass="downSave" OnClick="lbUpdateCategory_Click" ValidationGroup="vgCatTitleUpdate" CausesValidation="true" resourcekey="lbUpdateCategoryResource1">Update category</asp:LinkButton>
				<asp:LinkButton ID="lbCancel" runat="server" OnClick="lbCancel_Click" CssClass="cancel" resourcekey="lbCancelResource1">Cancel</asp:LinkButton>
			</div>
		</asp:Panel>
		<asp:Panel ID="pnlCategoryLocalization" CssClass="sectionBox" runat="server" Visible="False">
			<div class="sectionBoxHeader textLeft">
				<span class="sectionBoxHeaderTitle"><%=CategoryLocalization%></span>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft"><%=_("lblCLTitleResource1", true) %></label>
				<asp:Label ID="lblCatTitle" runat="server" resourcekey="lblCatTitleResource1"></asp:Label>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft"><%=Defaultportallanguage%></label>
				<asp:Label ID="lblDefaultPortalLangugage" runat="server" resourcekey="lblDefaultPortalLangugageResource1"></asp:Label>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft"><%=_("lblLocLangArticleResource1.Text") %></label>
				<asp:Label ID="lblLocalizedLanguages" runat="server" Text="None"></asp:Label>
			</div>
			<div class="edNews_inputGroup">
				<label class="textLeft" for="<%=ddlCLLanguageSelect.ClientID %>"><%=_("lblCLSelectLanguageResource1.Text") %></label>
				<asp:DropDownList ID="ddlCLLanguageSelect" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCLLanguageSelect_SelectedIndexChanged" resourcekey="ddlCLLanguageSelectResource1"></asp:DropDownList>
			</div>
			<div class="mainActions smallActions">
				<asp:LinkButton ID="lbCLCopyDefaults" resourcekey="lbCLCopyDefaults" CssClass="copy" runat="server" OnClick="lbCLCopyDefaults_Click"><span>Copy default values</span></asp:LinkButton>
				<asp:LinkButton ID="btnDeleteLocalization" resourcekey="btnDeleteLocalization" CssClass="delete" runat="server" OnClick="btnDeleteLocalization_Click"><span>Delete selected locale</span></asp:LinkButton>
			</div>
			<div class="edNews_inputGroup inputWidth40">
				<label class="textLeft" for="<%=tbCategoryName.ClientID %>"><%=Categoryname%></label>
				<asp:TextBox ID="tbCLCategoryTitle" CssClass="text" runat="server" MaxLength="200" ValidationGroup="vgCatTitleUpdate" CausesValidation="true" />
				<asp:RequiredFieldValidator CssClass="smallInfo error" ID="rfvCLCategoryTitle" runat="server" ControlToValidate="tbCLCategoryTitle" ErrorMessage="This field is required." ValidationGroup="vgCatTitleUpdate" resourcekey="rfvCategoryNameResource1" />
			</div>
			<div class="edNews_inputGroup labelBlock">
				<label for="<%=txtCatText.ClientID %>"><%=Categorydescription%></label>
				<dnn:TextEditor ID="txtCatLocDescription" runat="server" Height="300" />
			</div>
			<div runat="server" id="pnlCategoryLink" class="sectionBox sectionBox3 noMargin">
				<div class="sectionBoxHeader">
					<span class="sectionBoxHeaderTitle"><%=Categorylink%></span>
				</div>
				<div class="edNews_inputGroup inputWidth100">
					<asp:TextBox ID="tbLocCatURL" runat="server"></asp:TextBox>
					<Portal:URL ID="ctlLocURL" runat="server" ShowNewWindow="False" ShowUsers="False" ShowFiles="False" ShowLog="False" ShowSecure="False" ShowTabs="True" ShowTrack="False" ShowUpLoad="False" ShowUrls="False" ShowDatabase="False" UrlType="U" />
				</div>
			</div>
			<asp:Label ID="lblErrorInfoMsg" runat="server" EnableViewState="false" Visible="false" />
			<div class="mainActions">
				<asp:LinkButton ID="btnAddCoategoryLocalization" CssClass="downSave" runat="server" OnClick="btnAddCoategoryLocalization_Click" CausesValidation="true" ValidationGroup="vgLocCategory" resourcekey="btnAddCoategoryLocalizationResource1">Save category localization</asp:LinkButton>
				<asp:LinkButton ID="btnCloseLocalization" CssClass="cancel" runat="server" OnClick="btnCloseLocalization_Click" Text="Close" resourcekey="btnCloseLocalizationResource1" />
			</div>
		</asp:Panel>
	</div>
</div>
