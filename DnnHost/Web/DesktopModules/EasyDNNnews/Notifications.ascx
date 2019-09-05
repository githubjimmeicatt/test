<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.Notifications.EditNotifications, App_Web_notifications.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>

<script type="text/javascript">
	//<![CDATA[

	var edn_all_categories = <%=GetAllCategoriesObject() %>;

	var generate_category_list_items = function (selected_categories, items) {
		var all_categories = jQuery.extend(true, [], items),
			category_list = '',
			i = 0;

		for (; i < all_categories.length; i++) {
			category_list += '<li style="margin-left: ' + (all_categories[i].level * 15) + 'px"><label><input type="checkbox"' + ((selected_categories.indexOf(',' + all_categories[i].id + ',') != -1) ? ' checked="checked"' : '') + ' name="edn_permission_for_category_' + all_categories[i].id + '" value="' + all_categories[i].id + '" /><span>' + all_categories[i].name + '</span></label></li>';
		}

		return category_list;
	}

	function InitAutoCompleateSearch($, tbSearch, hfId, HttpHandler, params) {
		$('#' + tbSearch).autocomplete('/DesktopModules/EasyDNNnews/Ashx/' + HttpHandler, {
			remoteDataType: 'json',
			minChars: 1,
			filter: false,
			sort: false,
			useCache: false,
			matchSubset: false,
			matchCase: false,
			resultsClass: 'edsNewsAdmin_searchAutocomplete',
			extraParams: params,
			showResult: function (value, data) {
				return '<span>' + value + '</span>';
			},
			onItemSelect: function (value) {
				document.getElementById(hfId).value = value.data[0];
				document.getElementById(tbSearch).value = value.data[1];
			}
		})
	};

	jQuery().ready(function ($) {

		var $permissions_show_all_items = $('.permissions_show_all_items > input'),
			$permissions_show_manual_item_selection = $('.permissions_show_manual_item_selection > input'),
			$permissions_show_no_items = $('.permissions_show_no_items > input'),
			$edn_permission_selection_dialog = $('.permission_selection_dialog'),
			$permission_list_items = $edn_permission_selection_dialog.find('> ul'),
			$permissions_show_selection_dialog = $('a.permissions_show_selection_dialog');

		$edn_permission_selection_dialog
			.dialog({
				autoOpen: false,
				buttons: { 'Close': function () { $(this).dialog('close'); } },
				resizable: false,
				width: 'auto'
			});

		$permissions_show_all_items.change(function () {
			var $this = $(this),
				$parent = $this.parent().parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection
				.hide(200)
				.children('input[type="hidden"]').val('')
				.siblings('textarea').html('');

			$edn_permission_selection_dialog.dialog('close');
		});

		$permissions_show_manual_item_selection.change(function () {
			var $this = $(this),
				$parent = $this.parent().parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.show(200);

			$edn_permission_selection_dialog.dialog('close');
		});

		$permissions_show_no_items.change(function () {
			var $this = $(this),
				$parent = $this.parent().parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.find('> input[type="hidden"]').val('');
			$permissions_manual_item_selection.find('> .selected_categories').html('');

			$permissions_manual_item_selection.hide(200);

			$edn_permission_selection_dialog.dialog('close');
		});

		$permissions_show_selection_dialog.click(function () {
			var $clicked = $(this),
				$parent = $clicked.parent(),
				$selected_categories_field = $clicked.siblings('input[type="hidden"]'),
				$selected_categories_text = $parent.find('textarea.selected_categories');

			$permission_list_items
				.html(generate_category_list_items($selected_categories_field.val(), edn_all_categories))
				.find('input[type="checkbox"]')
				.change(function () {
					var $selected_categories = $permission_list_items.find('input[type="checkbox"]:checked'),
						selected_ids = ',',
						selected_categories_names = '';

					if ($selected_categories.length) {
						$selected_categories.each(function () {
							var $this = $(this);

							selected_ids += $this.val() + ',';
							selected_categories_names += $this.siblings('span:first').html() + ', ';
						});
						$selected_categories_field.attr('value', selected_ids);
						$selected_categories_text.html(selected_categories_names.substring(0, selected_categories_names.length - 2));
					} else {
						$selected_categories_field.attr('value', '');
						$selected_categories_text.html('');
					}
				});

			$edn_permission_selection_dialog
				.dialog('open');

			return false;
		});

		InitAutoCompleateSearch(eds2_2, '<%=tbUserNameToAdd.ClientID%>', '<%=hfUserIdToAdd.ClientID%>', 'SearchUsers.ashx', { portalid: '<%=PortalId%>', moduleId: '<%=ModuleId%>', tabId: '<%=TabId%>' });

	});

	//]]>
</script>

<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topActions">
			<li class="edNews_save">
				<asp:LinkButton ID="btnSave" runat="server" Text="Save settings" ValidationGroup="vgSettings" resourcekey="btnSave.Text" />
			</li>
			<li class="edNews_saveAndClose">
				<asp:LinkButton ID="btnSaveAndClose" runat="server" Text="Save &amp; Close" ValidationGroup="vgSettings" resourcekey="btnSaveClose.Text" />
			</li>
			<li class="edNews_close">
				<asp:LinkButton ID="btnClose" runat="server" Text="Close" UseSubmitBehavior="False" resourcekey="btnClose.Text" />
			</li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div id="EDNadmin" class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span><%=TopTitle%></span>
		</div>
		<div class="main_content gridview_content_manager">
			<asp:Literal ID="liAdminNavigation" runat="server"></asp:Literal>

			<div id="pnlAllSettings" class="module_settings sectionBox noPadding" runat="server" visible="false">
				<table class="optionsList fullWidthTable strippedTable noBorder topMargin">
					<tr>
						<td class="tdLabel width50">
							<label for="<%=rblNotificationProvider.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNotificationProvider.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNotificationProvider.Text") %></label>
						</td>
						<td>
							<div class="edNews_inputGroup displayInline">
								<asp:RadioButtonList runat="server" ID="rblNotificationProvider" RepeatDirection="Horizontal" CssClass="inlineList styledRadio smallRadio">
									<asp:ListItem Value="DnnApi" Text="DNN API" resourcekey="liDnnApi" Selected="True" />
									<asp:ListItem Value="Smtp" Text="SMTP" resourcekey="liSmtp" />
									<asp:ListItem Value="Both" Text="BOTH" resourcekey="liBoth" />
								</asp:RadioButtonList>
							</div>
						</td>
					</tr>
				</table>
				<div id="pnlPermissions" runat="server" cssclass="settings_category_container">
					<div class="category_content">
						<div class="permission_selection_dialog" title="Select items">
							<ul>
							</ul>
						</div>
						<div class="settings_category_container">
							<asp:GridView ID="gvRoleNotificationSettings" runat="server" CssClass="optionsList strippedTable fullWidthTable textCenter edNews_permissionsTable" AutoGenerateColumns="False" DataKeyNames="RoleID" CellPadding="0" OnRowDataBound="gvRoleNotificationSettings_RowDataBound">
								<Columns>
									<asp:TemplateField HeaderText="Roles">
										<ItemTemplate>
											<p title="<%#Eval("RoleName")%>">
												<asp:Label ID="lblRoleName" runat="server" Text='<%#Eval("RoleName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
											</p>
										</ItemTemplate>
										<ItemStyle CssClass="subjectTd textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="New article notification">
										<ItemTemplate>
											<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
											<asp:HiddenField ID="hfRoleName" runat="server" Value='<%# Eval("RoleName") %>' />
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbNewArticle" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("NewArticle"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="New event notification">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbNewEvent" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("Newevent"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Edit article notification">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbEditArticle" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("EditArticle"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Request for approve article">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbApproveArticle" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveArticle"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="New comment notification">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbNewComment" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("NewComment"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Request for approve comment">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbApproveComment" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveComment"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Event registration">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbEventRegistration" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("EventRegistration"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Select categories">
										<ItemTemplate>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbAllCategories" runat="server" Checked='<%# Convert.ToBoolean(Eval("SendToAllCategories")) %>' CssClass="permissions_show_all_items" GroupName="roleCategoryPermissions" Text="All categories" />
											</div>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("SendToAllCategories")) %>' CssClass="permissions_show_manual_item_selection" GroupName="roleCategoryPermissions" Text="Select categories" />
											</div>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbRoleNoneShow" runat="server" Checked='<%# !Convert.ToBoolean(Eval("SendToAllCategories")) %>' CssClass="permissions_show_no_items" GroupName="roleCategoryPermissions" Text="None" />
											</div>
											<asp:Panel runat="server" ID="pnlShowCatsManualSelection" CssClass="permissions_manual_item_selection" Style="display: none">
												<asp:HiddenField ID="hfCategoriesToShow" runat="server" />
												<asp:LinkButton ID="lbManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog edNews_buttonLink" Text="Select categories" />
												<asp:TextBox ID="tbRolesCatsToShow" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" onkeypress="javascript:return false;" />
											</asp:Panel>
										</ItemTemplate>
										<HeaderStyle CssClass="inputsTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader" />
							</asp:GridView>
							<asp:GridView ID="gvUserNotificationSettings" runat="server" CssClass="optionsList strippedTable fullWidthTable edNews_permissionsTable topMargin" AutoGenerateColumns="False" DataKeyNames="UserID" CellPadding="0" OnRowCommand="gvUserNotificationSettings_RowCommand" OnRowDataBound="gvUserNotificationSettings_RowDataBound">
								<Columns>
									<asp:TemplateField HeaderText="Users">
										<ItemTemplate>
											<asp:Label ID="lblUserName" runat="server" CssClass="subjectName" Text='<%#Eval("UserName")%>' resourcekey="lblRoleNameResource1"></asp:Label>
											<div class="itemActions">
												<asp:LinkButton ID="lbUserNotificationsRemove" resourcekey="lbUserNotificationsRemove" runat="server" CssClass="deleteAction" CausesValidation="False" CommandArgument='<%#Eval("UserID")%>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user notifications?');" Text="Remove"></asp:LinkButton>
											</div>
										</ItemTemplate>
										<ItemStyle CssClass="subjectTd textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="New article notification">
										<ItemTemplate>
											<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
											<asp:HiddenField ID="hfUsername" runat="server" Value='<%# Eval("Username") %>' />
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbNewArticle" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("NewArticle"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="New event notification">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbNewEvent" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("Newevent"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Edit article notification">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbEditArticle" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("EditArticle"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Request for article approval">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbApproveArticle" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveArticle"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="New comment notification">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbNewComment" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("NewComment"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Request for comment approval">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbApproveComment" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("ApproveComment"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Event registration">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox ID="cbEventRegistration" Text=" " runat="server" Checked='<%#Convert.ToBoolean(Eval("EventRegistration"))%>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Select categories">
										<ItemTemplate>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbUserAllCategories" runat="server" Checked='<%# Convert.ToBoolean(Eval("SendToAllCategories")) %>' CssClass="permissions_show_all_items" GroupName="userCategoryPermissions" Text="All categories" />
											</div>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbUserManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("SendToAllCategories")) %>' CssClass="permissions_show_manual_item_selection" GroupName="userCategoryPermissions" Text="Select categories" />
											</div>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbUserNoneShow" runat="server" Checked='<%# !Convert.ToBoolean(Eval("SendToAllCategories")) %>' CssClass="permissions_show_no_items" GroupName="userCategoryPermissions" Text="None" />
											</div>
											<asp:Panel runat="server" ID="pnlUserShowCatsManualSelection" CssClass="permissions_manual_item_selection" Style="display: none">
												<asp:HiddenField ID="hfUserCategoriesToShow" runat="server" />
												<asp:LinkButton ID="lbUserManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog edNews_buttonLink" Text="Select categories" />
												<asp:TextBox ID="tbUserCatsToShow" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" onkeypress="javascript:return false;" />
											</asp:Panel>
										</ItemTemplate>
										<HeaderStyle CssClass="inputsTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader" />
							</asp:GridView>
						</div>
					</div>
				</div>
				<table class="optionsList fullWidthTable strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbUserNameToAdd.ClientID %>"><%=_("lblUsernameToAdd.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbUserNameToAdd" runat="server" />
							<asp:HiddenField ID="hfUserIdToAdd" runat="server" />
							<div class="mainActions smallActions noMargin displayInline">
								<asp:LinkButton ID="lbUsernameAdd" CssClass="add" resourcekey="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" />
							</div>
							<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="False" ForeColor="Red" />
						</td>
					</tr>
				</table>
				<table class="optionsList fullWidthTable strippedTable noBorder topMargin">
					<tr>
						<td class="tdLabel width50">
							<label for="<%=cbArticleApproveConfirmation.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleApproveConfirmation.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleApproveConfirmation.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbArticleApproveConfirmation" Text="Send notification to author of article when article is approved or denied" runat="server" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel width50">
							<label for="<%=cbCommentApproveConfirmation.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCommentApproveConfirmation.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCommentApproveConfirmation.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbCommentApproveConfirmation" Text="Send notification to author of comment when comment is approved or denied" runat="server" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel width50">
							<label for="<%=cbArticleAuthorCommentApproveConfirm.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblcbArticleAuthorCommentApproveConfirm.Help", true) %>" data-tooltip-position="top-right"><%=_("lblcbArticleAuthorCommentApproveConfirm.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbArticleAuthorCommentApproveConfirm" Text="Send notification to author of article when comment is posted to their article." runat="server" />
							</div>
						</td>
					</tr>
					<tr>
						<td class="tdLabel width50">
							<label for="<%=cbSendEventRegistrationInfoToArticleAuthor.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendEventRegistrationInfoToArticleAuthor.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendEventRegistrationInfoToArticleAuthor.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbSendEventRegistrationInfoToArticleAuthor" Text="Send notification to author of article when someone registers to event." runat="server" />
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2" class="textCenter">
							<asp:Label ID="lblsaveInfo" runat="server" EnableViewState="False" />
						</td>
					</tr>
				</table>
			</div>

			<asp:Panel ID="pnlEmailSettings" Visible="false" class="sectionBox noPadding" runat="server">
				<asp:Panel ID="pnlPostCategories" runat="server" CssClass="edNews_numberedOptions">
					<div class="edNews_numberedOptionsHeader">
						<span class="edNews_numberedOptionsHeaderNumber">1</span>
						<h2><%=_("eventLinks.Text")%></h2>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=ddlDefaultWhereToOpenContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultWhereToOpenContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultWhereToOpenContent.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlDefaultWhereToOpenContent" runat="server"></asp:DropDownList>
								<asp:PlaceHolder ID="pnlDinamicTreeView" runat="server"></asp:PlaceHolder>
							</td>
						</tr>
					</table>
				</asp:Panel>

				<asp:Panel ID="pnlEmailNotificationTemplates" runat="server" CssClass="edNews_numberedOptions">
					<div class="edNews_numberedOptionsHeader">
						<span class="edNews_numberedOptionsHeaderNumber">2</span>
						<h2><%=_("emailNotificationTemplates.Text")%></h2>
					</div>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("newArticleNotification.Text")%></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbNewArticleNotificationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewArticleNotificationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewArticleNotificationMailSubject.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbNewArticleNotificationMailSubject" runat="server" placeholder="e.g. Notification New article created [title]..."></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvtbNewArticleNotificationMailSubject" CssClass="smallInfo error" resource="rfvtbNewArticleNotificationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbNewArticleNotificationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlNewArticleNotificationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewArticleNotificationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewArticleNotificationEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlNewArticleNotificationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="NewArticleNotificationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<asp:DropDownList ID="ddlNewArticleNotificationEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnNewArticleNotificationEmailTemplate" CssClass="upload" resourcekey="btnNewArticleNotificationEmailTemplate" runat="server" Text="Load" OnClick="NewArticleNotification_Click" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=teNewArticleNotificationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewArticleNotificationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewArticleNotificationEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="teNewArticleNotificationEmailTemplateContent" runat="server" Height="450" />
								</div>
							</td>
						</tr>
					</table>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("newEventNotification.Text")%></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbNewEventNotificationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewEventNotificationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewEventNotificationMailSubject.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbNewEventNotificationMailSubject" runat="server"></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvNewEventNotificationMailSubject" CssClass="smallInfo error" resoucekey="rfvNewEventNotificationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbNewEventNotificationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlNewEventNotificationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewEventNotificationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewEventNotificationEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlNewEventNotificationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="NewEventNotificationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<asp:DropDownList ID="ddlNewEventNotificationEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnNewEventNotificationEmailTemplate" CssClass="upload" resourcekey="btnNewEventNotificationEmailTemplate" runat="server" Text="Load" OnClick="NewEventNotificationEmailTemplate_Click" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=teNewEventNotificationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewEventNotificationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewEventNotificationEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="teNewEventNotificationEmailTemplateContent" runat="server" Height="450" />
								</div>
							</td>
						</tr>
					</table>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("editArticleNotification.Text")%></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbEditArticleNotificationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEditArticleNotificationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEditArticleNotificationMailSubject.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbEditArticleNotificationMailSubject" runat="server"></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvEditArticleNotificationMailSubject" CssClass="smallInfo error" resourcekey="rfvEditArticleNotificationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbEditArticleNotificationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlEditArticleNotificationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEditArticleNotificationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEditArticleNotificationEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlEditArticleNotificationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="EditArticleNotificationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<asp:DropDownList ID="ddlEditArticleNotificationEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnEditArticleNotificationEmailTemplate" CssClass="upload" resourcekey="btnEditArticleNotificationEmailTemplate" runat="server" Text="Load" OnClick="EditArticleNotificationEmailTemplate_Click" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=teEditArticleNotificationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEditArticleNotificationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEditArticleNotificationEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="teEditArticleNotificationEmailTemplateContent" runat="server" Height="450" />
								</div>
							</td>
						</tr>
					</table>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("requestForApproveArticle.Text")%></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbRequestForApproveArticleMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequestForApproveArticleMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRequestForApproveArticleMailSubject.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbRequestForApproveArticleMailSubject" runat="server"></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvRequestForApproveArticleMailSubject" CssClass="smallInfo error" resourcekey="rfvRequestForApproveArticleMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbRequestForApproveArticleMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlRequestForApproveArticleEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequestForApproveArticleEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRequestForApproveArticleEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlRequestForApproveArticleEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RequestForApproveArticleEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<asp:DropDownList ID="ddlRequestForApproveArticleEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnRequestForApproveArticleEmailTemplate" CssClass="upload" resourcekey="btnRequestForApproveArticleEmailTemplate" runat="server" Text="Load" OnClick="RequestForApproveArticleEmailTemplate_Click" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=teRequestForApproveArticleEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequestForApproveArticleEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRequestForApproveArticleEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="teRequestForApproveArticleEmailTemplateContent" runat="server" Height="450" />
								</div>
							</td>
						</tr>
					</table>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("newCommentNotification.Text")%></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbNewCommentNotificationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewCommentNotificationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewCommentNotificationMailSubject.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbNewCommentNotificationMailSubject" runat="server"></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvNewCommentNotificationMailSubject" CssClass="smallInfo error" resourcekey="rfvNewCommentNotificationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbNewCommentNotificationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlNewCommentNotificationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewCommentNotificationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewCommentNotificationEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlNewCommentNotificationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="NewCommentNotificationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<asp:DropDownList ID="ddlNewCommentNotificationEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnNewCommentNotificationEmailTemplate" CssClass="upload" resourcekey="btnNewCommentNotificationEmailTemplate" runat="server" Text="Load" OnClick="NewCommentNotificationEmailTemplate_Click" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=teNewCommentNotificationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewCommentNotificationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewCommentNotificationEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="teNewCommentNotificationEmailTemplateContent" runat="server" Height="450" />
								</div>
							</td>
						</tr>
					</table>
					<div class="sectionBoxSubtitle highlighted3">
						<span><%=_("requestForApproveComment.Text")%></span>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbRequestForApproveCommentMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequestForApproveCommentMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRequestForApproveCommentMailSubject.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth100">
									<asp:TextBox ID="tbRequestForApproveCommentMailSubject" runat="server"></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvRequestForApproveCommentMailSubject" CssClass="smallInfo error" resourcekey="rfvRequestForApproveCommentMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbRequestForApproveCommentMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlRequestForApproveCommentEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequestForApproveCommentEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRequestForApproveCommentEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlRequestForApproveCommentEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RequestForApproveCommentEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<asp:DropDownList ID="ddlRequestForApproveCommentEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnRequestForApproveCommentEmailTemplate" CssClass="upload" resourcekey="btnRequestForApproveCommentEmailTemplate" runat="server" Text="Load" OnClick="RequestForApproveCommentEmailTemplate_Click" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=teRequestForApproveCommentEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRequestForApproveCommentEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRequestForApproveCommentEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="teRequestForApproveCommentEmailTemplateContent" runat="server" Height="450" />
								</div>
							</td>
						</tr>
					</table>
				</asp:Panel>

				<asp:Panel ID="pnlSendEmailSettings" runat="server" CssClass="edNews_numberedOptions">
					<div class="edNews_numberedOptionsHeader">
						<span class="edNews_numberedOptionsHeaderNumber">3</span>
						<h2><%=_("emailSettingsHeader.Text")%></h2>
					</div>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxDefaultFromName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultFromName.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultFromName.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxDefaultFromName" runat="server" Width="450px"></asp:TextBox>
								</div>
<%--								<asp:RequiredFieldValidator ID="rfvDefaultFromName" CssClass="smallInfo error" resourcekey="rfvDefaultFromName.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxDefaultFromName" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxDefaultFromMail.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultFromMail.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultFromMail.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxDefaultFromMail" runat="server" Width="450px"></asp:TextBox>
								</div>
<%--								<asp:RequiredFieldValidator ID="rfvDefaultFromMail" CssClass="smallInfo error" resourcekey="rfvDefaultFromMail.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxDefaultFromMail" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxDefaultReplyTo.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultReplyTo.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultReplyTo.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxDefaultReplyTo" runat="server" Width="450px"></asp:TextBox>
								</div>
<%--								<asp:RequiredFieldValidator ID="rfvDefaultReplyTo" CssClass="smallInfo error" runat="server" resourcekey="required.ErrorMessage" ErrorMessage="Required!" ControlToValidate="tbxDefaultReplyTo" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
							</td>
						</tr>
					</table>
				</asp:Panel>

				<asp:Label ID="lblEmailSettingsInfo" runat="server" EnableViewState="false" />

			</asp:Panel>
		</div>
	</div>
</div>
