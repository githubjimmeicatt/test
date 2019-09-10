<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.AuthorProfiles, App_Web_authorprofiles.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
	function ConfirmDelete() {
		return confirm('<%=Localization.GetString("Areyousure.Text", this.LocalResourceFile)%>');
	}
</script>
<asp:Panel ID="pnlMainWrap" runat="server" CssClass="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<asp:HiddenField ID="hfUserEdit" runat="server" Value="False" />
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=strAuthorProfiles%></span>
		</div>
		<div class="eds_Tabs topMargin">
			<div class="eds_tabsNav">
				<asp:LinkButton ID="lbAuthorProfiles" runat="server" CssClass="edsTabulator_active" OnClick="lbAuthorProfiles_Click" resourcekey="lbAuthorProfilesResource1">Author profiles</asp:LinkButton>
				<asp:LinkButton ID="lbProfileGropus" runat="server" OnClick="lbProfileGropus_Click" resourcekey="lbProfileGropusResource1">Profile groups</asp:LinkButton>
			</div>
			<asp:Panel ID="pnlAuthorProfiles" runat="server">
				<asp:Panel ID="pnlProfileEditorHeader" runat="server" CssClass="sectionBox noPadding">
					<asp:GridView ID="gvAuthors" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" DataSourceID="odsAuthors" OnPreRender="gvAuthors_PreRender" CssClass="strippedTable fullWidthTable noBorder tablePadding5" ShowFooter="True" DataKeyNames="UserID" AllowPaging="True" AllowSorting="True" OnRowCommand="gvAuthors_RowCommand" OnRowDeleted="gvAuthors_RowDeleted" OnPageIndexChanging="gvAuthors_PageIndexChanging">
						<Columns>
							<asp:TemplateField ShowHeader="False">
								<FooterTemplate>
									<div class="edNews_numberOfRows">
										<div>
											<asp:Label ID="lblFooterSelectNumberOfRows" runat="server" AssociatedControlID="ddlFooterNumberOfRows" resourcekey="lblFooterSelectNumberOfRowsResource1" Text="Number of rows:" />
											<asp:DropDownList ID="ddlFooterNumberOfRows" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFooterNumberOfRows_SelectedIndexChanged">
												<asp:ListItem resourcekey="ListItemResource1">10</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource2">20</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource3">30</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource4">50</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource5">100</asp:ListItem>
											</asp:DropDownList>
										</div>
									</div>
								</FooterTemplate>
								<ItemTemplate>
									<div class="edNews_boxedActions">
										<asp:LinkButton ID="lbEditProfile" runat="server" CausesValidation="False" CommandArgument='<%# Eval("UserID") %>' CommandName="EditProfile" CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("lbEditProfileResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbEditProfileResource1"></asp:LinkButton>
										<asp:LinkButton ID="lbDeleteProfile" runat="server" CausesValidation="False" CommandName="Delete" CssClass="edNews_aaDelete edNews_tooltip color4" data-tooltip-content='<%#_("lbDeleteProfileResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbDeleteProfileResource1" OnClientClick="return ConfirmDelete();"></asp:LinkButton>
									</div>
								</ItemTemplate>
								<HeaderStyle Width="100px" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="UserID">
								<EditItemTemplate>
									<asp:TextBox ID="tbUserId" runat="server" Text='<%# Bind("UserID") %>'></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<p>
										<%=strUserID%><strong><%#Eval("UserID") %></strong>
									</p>
									<p>
										<%=strUserName%><strong><%#Eval("Username")%></strong>
									</p>
									<p>
										<%=strFirstName%><strong><%#Eval("FirstName")%></strong>
									</p>
									<p>
										<%=strLastName%><strong><%#Eval("LastName") %></strong>
									</p>
									<p>
										<%=strDisplayName%><strong><%#Eval("DisplayName")%></strong>
									</p>
									<p>
										<%=strArticleCount%><strong><%#Eval("ArticleCount") %></strong>
									</p>
								</ItemTemplate>
								<HeaderStyle Width="250px" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Short Info">
								<ItemTemplate>
									<asp:Label ID="lblShortInfoDate" runat="server" CssClass="smallText" Text='<%# HttpUtility.HtmlDecode(Eval("ShortInfo").ToString()) %>' />
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Date added">
								<ItemTemplate>
									<%#GetDateAdded(Eval("DateAdded"))%>
								</ItemTemplate>
								<HeaderStyle Width="100px" />
								<ItemStyle CssClass="textCenter" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Image">
								<ItemTemplate>
									<asp:Image ID="imggvProfileImage" CssClass="edNews_thumb" runat="server" ImageUrl='<%# GetAuthorImageURL(Eval("ProfileImage"),Eval("UserID")) %>' Visible='<%# IsImageVisible(Eval("ProfileImage")) %>' />
								</ItemTemplate>
								<HeaderStyle Width="120px" />
								<ItemStyle CssClass="textCenter" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Group name">
								<ItemTemplate>
									<asp:Label ID="lblAuthorGroups" runat="server" Text='<%# Eval("GroupName") %>' />
								</ItemTemplate>
								<HeaderStyle Width="150px" />
								<ItemStyle CssClass="textCenter" />
							</asp:TemplateField>
						</Columns>
						<EditRowStyle CssClass="editItemState" />
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
				</asp:Panel>
				<div class="sectionBox noPadding">
					<div class="sectionBoxHeader">
						<asp:Label ID="lblAddEditProfile" CssClass="sectionBoxHeaderTitle" runat="server" Text="Add new author profile" />
						<asp:HiddenField ID="hfAuthorProfileID" runat="server" />
					</div>
					<table class="fullWidthTable optionsList strippedTable noBorder">
						<tr runat="server" id="rowSelectUser" visible="true">
							<td class="tdLabel">
								<asp:Label ID="lblSelectUSer" runat="server" resourcekey="lblSelectUSer" Text="Select user:" />
							</td>
							<td>
								<asp:DropDownList ID="ddlRoles" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged">
									<asp:ListItem Value="-1" resourcekey="ListItemResource6">Select role</asp:ListItem>
								</asp:DropDownList>
								<asp:DropDownList ID="ddlAuthors" runat="server" AppendDataBoundItems="True" AutoPostBack="True" CssClass="ddlgeneral" OnSelectedIndexChanged="ddlAuthors_SelectedIndexChanged">
									<asp:ListItem Value="0" resourcekey="ListItemResource7">Select author</asp:ListItem>
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblFirstNameInfo" runat="server" Text="First name:" resourcekey="lblFirstNameInfoResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbFirstName" runat="server" Enabled="False" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblLastNameInfo" runat="server" Text="Last name:" resourcekey="lblLastNameInfoResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbLastName" runat="server" Enabled="False" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblDisplayName" runat="server" Text="Display name:" resourcekey="lblDisplayNameResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbDisplayName" runat="server" Enabled="False" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<asp:Label ID="lblShortInfo" runat="server" Text="Short info:" resourcekey="lblShortInfoResource1" />
							</td>
							<td>
								<div runat="server" id="divShortInfoHtmlEditor" class="summaryhtmleditor text_input_set">
									<dnn:TextEditor ID="txtShortInfo" runat="server" Height="300px" />
								</div>
								<div runat="server" id="divShortInfoBasicEditor" class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbShortInfo" runat="server" MaxLength="4000" TextMode="MultiLine" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<asp:Label ID="lblFullBio" runat="server" Text="Full info:" resourcekey="lblFullBioResource1" />
							</td>
							<td>
								<div runat="server" id="divFullInfotHtmlEditor" class="summaryhtmleditor text_input_set">
									<dnn:TextEditor ID="txtFullInfo" runat="server" Height="600px" />
								</div>
								<div runat="server" id="divFullInfoBasicEditor" class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbFullInfo" runat="server" MaxLength="4000" TextMode="MultiLine" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblFacebookURL" runat="server" Text="Facebook URL:" resourcekey="lblFacebookURLResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbFacebookURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblTwitterURL" runat="server" Text="Twitter URL:" resourcekey="lblTwitterURLResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbTwitterURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGooglePlus" runat="server" Text="Google + URL:" resourcekey="lblGooglePlusResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGooglePlusURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblLinkedInURL" runat="server" Text="LinkedIn URL:" resourcekey="lblLinkedInURLResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbLinkedInURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblYouTubeURL" runat="server" Text="YouTube URL:" resourcekey="lblYouTubeURL" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbYouTubeURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblInstagramURL" runat="server" Text="Instagram URL:" resourcekey="lblInstagramURL" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbInstagramURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblWebsiteURL" runat="server" Text="Website URL:" resourcekey="lblWebsiteURL" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbWebsiteURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblProfileGroup" runat="server" Text="Profile group:" resourcekey="lblProfileGroupResource1" />
							</td>
							<td>
								<asp:DropDownList ID="ddlProfileGroups" runat="server" AppendDataBoundItems="True" DataTextField="GroupName" DataValueField="GroupID">
									<asp:ListItem Value="0" resourcekey="ListItemResource8" Text="Select group" />
								</asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<asp:Label ID="lblProfileImage" runat="server" Text="Image:" resourcekey="lblProfileImageResource1" />
							</td>
							<td>
								<asp:Image ID="imgProfileImage" CssClass="edNews_thumb floatLeft" runat="server" Visible="False" />
								<div class="edNews_inputGroup">
									<asp:FileUpload ID="fuProfileImage" runat="server" />
								</div>
							</td>
						</tr>
						<tr id="rowAuthorURL" runat="server">
							<td class="tdLabel textTop">
								<asp:Label ID="lblAuthorURL" runat="server" Text="Author URL:" />
							</td>
							<td>
								<div class="edNews_inputGroup">
									<asp:RadioButtonList ID="rblAuthorUrlAdd" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblAuthorUrlAdd_SelectedIndexChanged" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList">
										<asp:ListItem resourcekey="liNone" class="normalRadioButton" Selected="True" Value="0" Text="None" />
										<asp:ListItem resourcekey="liLink" class="normalRadioButton" Value="1" Text="Link" />
									</asp:RadioButtonList>
								</div>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxAuthorURLAdd" runat="server" Visible="false" />
								</div>
							</td>
						</tr>
					</table>
					<asp:Label ID="lblProfileAdded" runat="server" EnableViewState="false" />
					<div class="mainActions">
						<asp:Button ID="btnAddNewProfile" runat="server" CssClass="add" OnClick="btnAddNewProfile_Click" Text="Add new profile" resourcekey="btnAddNewProfileResource1" />
						<asp:Button ID="btnUpdateProfile" runat="server" CssClass="downSave" OnClick="btnUpdateProfile_Click" Text="Update profile" Visible="False" resourcekey="btnUpdateProfileResource1" />
						<asp:Button ID="btnCancel" runat="server" CssClass="cancel" OnClick="btnCancel_Click" Text="Cancel" resourcekey="btnCancelResource1" />
					</div>
				</div>
			</asp:Panel>
			<asp:Panel ID="pnlProfileGroups" runat="server" Visible="False">
				<div class="sectionBox noPadding">
					<asp:GridView ID="gvProfileGropus" runat="server" EnableModelValidation="True" AutoGenerateColumns="False" DataSourceID="odsGetGroups" CssClass="strippedTable fullWidthTable noBorder tablePadding5" ShowFooter="True" DataKeyNames="GroupID" AllowPaging="True" AllowSorting="True" OnRowCommand="gvProfileGropus_RowCommand" OnRowDeleted="gvProfileGropus_RowDeleted" OnDataBound="gvProfileGropus_DataBound" OnPreRender="gvProfileGropus_PreRender">
						<Columns>
							<asp:TemplateField ShowHeader="False">
								<FooterTemplate>
									<div class="edNews_numberOfRows">
										<div>
											<asp:Label ID="lblFooterSelectNumberOfRows" runat="server" AssociatedControlID="ddlFooterNumberOfRows" resourcekey="lblFooterSelectNumberOfRowsResource2" Text="Number of rows:" />
											<asp:DropDownList ID="ddlFooterNumberOfRows" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFooterNumberOfRows_SelectedIndexChangedGroups">
												<asp:ListItem resourcekey="ListItemResource9">10</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource10">20</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource11">30</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource12">50</asp:ListItem>
												<asp:ListItem resourcekey="ListItemResource13">100</asp:ListItem>
											</asp:DropDownList>
										</div>
									</div>
								</FooterTemplate>
								<ItemTemplate>
									<div class="edNews_boxedActions">
										<asp:LinkButton ID="lbEditGroup" runat="server" CausesValidation="False" CommandArgument='<%# Eval("GroupID") %>' CommandName="EditGroup" CssClass="edNews_aaEdit edNews_tooltip" data-tooltip-content='<%#_("lbEditGroupResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbEditGroupResource1"></asp:LinkButton>
										<asp:LinkButton ID="lbDeleteGroup" runat="server" CausesValidation="False" CommandName="Delete" CssClass="edNews_aaDelete color4 edNews_tooltip" data-tooltip-content='<%#_("lbDeleteGroupResource1.ToolTip")%>' data-tooltip-position="top-left" resourcekey="lbDeleteGroupResource1" OnClientClick="return ConfirmDelete();"></asp:LinkButton>
									</div>
								</ItemTemplate>
								<HeaderStyle Width="100px" />
							</asp:TemplateField>
							<asp:BoundField DataField="GroupID" HeaderText="GroupID">
								<ItemStyle CssClass="textCenter" />
								<HeaderStyle Width="100px" />
							</asp:BoundField>
							<asp:TemplateField HeaderText="Group name">
								<ItemTemplate>
									<asp:Label ID="lblGroupName" runat="server" Text='<%# Eval("GroupName") %>' />
								</ItemTemplate>
								<HeaderStyle Width="200px" />
								<ItemStyle CssClass="textCenter" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Image">
								<ItemTemplate>
									<asp:Image ID="imggvGroupImage" runat="server" CssClass="edNews_thumb" ImageUrl='<%# GetGroupImageURL(Eval("GroupImage"),Eval("GroupID")) %>' Visible='<%# IsImageVisible(Eval("GroupImage")) %>' />
								</ItemTemplate>
								<HeaderStyle Width="120px" />
								<ItemStyle CssClass="textCenter" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Info">
								<ItemTemplate>
									<asp:Label ID="lblInfo" runat="server" CssClass="smallText" Text='<%# HttpUtility.HtmlDecode(Eval("GroupInfo").ToString()) %>' />
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Position">
								<EditItemTemplate>
									<asp:TextBox ID="tbPosition" runat="server" Text='<%# Bind("Position") %>'></asp:TextBox>
								</EditItemTemplate>
								<ItemTemplate>
									<asp:Label ID="lblPosition" runat="server" Text='<%# Bind("Position") %>' Visible="False" />
									<div class="edNews_boxedActions">
										<asp:LinkButton ID="imgCategoryUp" runat="server" CausesValidation="False" CssClass="edNews_aaUp" CommandArgument='<%# Eval("GroupID")%>' CommandName="Up" resourcekey="imgGroupUp" Text="Up" />
										<asp:LinkButton ID="imgCategoryDown" runat="server" CausesValidation="False" CssClass="edNews_aaDown" CommandArgument='<%# Eval("GroupID")%>' CommandName="Down" resourcekey="imgGroupDown" Text="Down" />
									</div>
								</ItemTemplate>
								<HeaderStyle Width="100px" />
								<ItemStyle CssClass="textCenter" />
							</asp:TemplateField>
						</Columns>
						<EditRowStyle CssClass="editItemState" />
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
				</div>
				<asp:Panel ID="pnlAddGroup" CssClass="sectionBox noPadding" runat="server">
					<asp:HiddenField ID="hfGroupID" runat="server" />
					<div class="sectionBoxHeader">
						<asp:Label ID="lblGroup" CssClass="sectionBoxHeaderTitle" runat="server" Text="Add new group" />
					</div>
					<table class="fullWidthTable optionsList strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGrouopName" runat="server" Text="Group name:" resourcekey="lblGrouopNameResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupName" runat="server" ValidationGroup="vgProfileGroups" />
								</div>
								<asp:RequiredFieldValidator ID="rfvGroupName" CssClass="smallInfo error" runat="server" ControlToValidate="tbGroupName" ErrorMessage="Please enter group name" ValidationGroup="vgProfileGroups" resourcekey="rfvGroupNameResource1" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<asp:Label ID="lblGroupInfo" runat="server" Text="Short info:" resourcekey="lblGroupInfoResource1" />
							</td>
							<td>
								<div runat="server" id="divGroupInfoHtmlEditor" class="summaryhtmleditor text_input_set">
									<dnn:TextEditor ID="txtGroupInfo" runat="server" Height="300px" />
								</div>
								<div runat="server" id="divGroupInfoBasicEditor" class="edNews_inputGroup inputWidth40 inputHeight150">
									<asp:TextBox ID="tbGroupInfo" runat="server" MaxLength="300" TextMode="MultiLine" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupFacebookURL" runat="server" Text="Facebook URL:" resourcekey="lblGroupFacebookURLResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupFacebookURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupTwitterURL" runat="server" Text="Twitter URL:" resourcekey="lblGroupTwitterURLResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupTwitterURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupGoogleURL" runat="server" Text="Google + URL:" resourcekey="lblGroupGoogleURLResource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupGoogleURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupLinkedIn" runat="server" Text="LinkedIn URL:" resourcekey="Label10Resource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupLinkedIn" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupYouTubeURL" runat="server" Text="YouTube URL:" resourcekey="lblGroupYouTubeURL" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupYouTubeURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupInstagramURL" runat="server" Text="Instagram URL:" resourcekey="lblGroupInstagramURL" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupInstagramURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupWebsiteURL" runat="server" Text="Website URL:" resourcekey="lblGroupWebsiteURL" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupWebsiteURL" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupContactEmail" runat="server" Text="Group contact email:" resourcekey="Label11Resource1" />
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbGroupContactEmail" runat="server" ValidationGroup="vgProfileGroups" />
								</div>
								<asp:RegularExpressionValidator ID="rfvGroupContactEmail" runat="server" ControlToValidate="tbGroupContactEmail" ErrorMessage="Please enter valid email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vgProfileGroups" resourcekey="rfvGroupContactEmailResource1" />
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<asp:Label ID="lblGroupImage" runat="server" Text="Group image:" resourcekey="lblGroupImageResource1" />
							</td>
							<td>
								<asp:Image ID="imgGroupImage" CssClass="edNews_thumb floatLeft" runat="server" Visible="False" />
								<div class="edNews_inputGroup">
									<asp:FileUpload ID="fuGroupImage" runat="server" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<asp:Label ID="lblGroupURL" runat="server" Text="Group URL:" />
							</td>
							<td>
								<div class="edNews_inputGroup">
									<asp:RadioButtonList ID="rblSelectUrlAdd" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblSelectUrlAdd_SelectedIndexChanged" RepeatLayout="UnorderedList" CssClass="styledRadio smallRadio inlineList">
										<asp:ListItem resourcekey="liNone" class="normalRadioButton" Selected="True" Value="0" Text="None" />
										<asp:ListItem resourcekey="liLink" class="normalRadioButton" Value="1" Text="Link" />
									</asp:RadioButtonList>
								</div>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbCatURLAdd" runat="server" Visible="False" />
								</div>
							</td>
						</tr>
					</table>
					<asp:Label ID="lblGroupAddMessage" runat="server" EnableViewState="false" />
					<div class="mainActions">
						<asp:Button ID="btnAddNewGroup" runat="server" CssClass="add" OnClick="btnAddNewGroup_Click" Text="Add new group" ValidationGroup="vgProfileGroups" resourcekey="btnAddNewGroupResource1" />
						<asp:Button ID="btnUpdateGroup" runat="server" CssClass="downSave" OnClick="btnUpdateGroup_Click" Text="Update group" Visible="False" ValidationGroup="vgProfileGroups" resourcekey="btnUpdateGroupResource1" />
						<asp:Button ID="btnGroupCancel" runat="server" CssClass="cancel" OnClick="btnGroupCancel_Click" Text="Cancel" resourcekey="btnGroupCancelResource1" />
					</div>
				</asp:Panel>
			</asp:Panel>
		</div>
	</div>
	<asp:ObjectDataSource ID="odsAuthors" runat="server" SelectMethod="GetAllAuthorProfilesInPortalODS" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.Authors.AuthorProfileController" DeleteMethod="DeleteAuthorProfile" EnablePaging="True" SelectCountMethod="SelectTotalNumberAuthorsINportalODs">
		<DeleteParameters>
			<asp:Parameter Name="UserID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
			<asp:Parameter Name="maximumRows" Type="Int32" />
			<asp:Parameter Name="startRowIndex" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
	<asp:ObjectDataSource ID="odsGetGroups" runat="server" SelectMethod="GetAllAuthorProfileGroupsInPortal" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.Authors.AuthorProfileController" DeleteMethod="DeleteProfileGroup">
		<DeleteParameters>
			<asp:Parameter Name="GroupID" Type="Int32" />
		</DeleteParameters>
		<SelectParameters>
			<asp:Parameter Name="PortalID" Type="Int32" />
		</SelectParameters>
	</asp:ObjectDataSource>
</asp:Panel>
