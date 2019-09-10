<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.EventManager, App_Web_eventmanager.ascx.b9f6810f" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>

<asp:Panel ID="pnlMainWrapper" runat="server" CssClass="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liTopAdminNavigation" runat="server" />
			<span><%=topControlTitle%></span>
		</div>
		<div class="main_content gridview_content_manager">

			<asp:Literal ID="liAdminNavigation" runat="server"></asp:Literal>

			<asp:Literal ID="liEventTitle" runat="server"></asp:Literal>
			<asp:Literal ID="liControlTitle" runat="server"></asp:Literal>
			<asp:Literal ID="liBreadCrumbs" runat="server"></asp:Literal>

			<asp:Panel ID="pnlListOfEventsWithEnabledRegistration" runat="server">
				<div class="edNews_adminProgressOverlayWrapper">
					<asp:Panel ID="pnlArticleListWrapper" runat="server">
						<div class="sectionBox noPadding sectionBox2">
							<asp:Panel ID="hlArticleFilterToggle" runat="server" CssClass="sectionBoxHeader edNews__toggleWrapper">
								<asp:HyperLink ID="hlArticleFilterToggleLink" CssClass="sectionBoxHeaderTitle edNews__toggle" href="#" runat="server" Text="Show filter settings" resourcekey="hlArticleFilterToggle" />
							</asp:Panel>
							<asp:Panel ID="pnlArticleFilterSettings" runat="server" CssClass="edNews__toggledContent">
								<div class="edNews_twoColumns noBorder">
									<div>
										<div class="sectionBox noPadding">
											<div class="sectionBoxSubtitle textLeft">
												<span><%=filterBy%></span>
											</div>
											<div class="edNews_OptionBoxes">
												<asp:Panel ID="pnlCategoryFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByCategory" runat="server" Text="Category" CssClass="normalCheckBox" OnCheckedChanged="cbFilterByCategory_CheckedChanged" AutoPostBack="True" resourcekey="cbFilterByCategory" />
													</div>
													<label for="<%=cbFilterByCategory.ClientID %>"><%=_("cbFilterByCategory.Text") %></label>
													<asp:DropDownList ID="ddlFilterCategorySelect" runat="server" DataTextField="CategoryName" DataValueField="CategoryID" AppendDataBoundItems="True" Enabled="False">
														<asp:ListItem Value="-1" resourcekey="liSelectCategory" Text="Select category" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlGroupOrAuthorFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByGroupOrAuthor" runat="server" Text="Group or Author" CssClass="normalCheckBox" OnCheckedChanged="cbFilterByGroupOrAuthor_CheckedChanged" AutoPostBack="True" resourcekey="cbFilterByGroupOrAuthor" />
													</div>
													<label for="<%=cbFilterByGroupOrAuthor.ClientID %>"><%=_("cbFilterByGroupOrAuthor.Text") %></label>
													<asp:DropDownList ID="ddlFilterByGroupOrAuthor" runat="server" Enabled="False">
														<asp:ListItem Value="-1" resourcekey="liSelectgrouporauthor" Text="Select group or author" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlPublishFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByPublish" runat="server" AutoPostBack="True" CssClass="normalCheckBox" Text="Published" OnCheckedChanged="cbFilterByPublish_CheckedChanged" resourcekey="cbFilterByPublish" />
													</div>
													<label for="<%=cbFilterByPublish.ClientID %>"><%=_("cbFilterByPublish.Text") %></label>
													<asp:DropDownList ID="ddlFilterByPublish" runat="server" AutoPostBack="True" Enabled="False">
														<asp:ListItem Value="True" resourcekey="liPublished" Text="Published" />
														<asp:ListItem Value="False" resourcekey="liUnpublished" Text="Unpublished" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlFeaturedFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByFeatured" runat="server" CssClass="normalCheckBox" Text="Featured" AutoPostBack="True" OnCheckedChanged="cbFilterByFeatured_CheckedChanged" resourcekey="cbFilterByFeatured" />
													</div>
													<label for="<%=cbFilterByFeatured.ClientID %>"><%=_("cbFilterByFeatured.Text") %></label>
													<asp:DropDownList ID="ddlFilterByFeatured" runat="server" Enabled="False">
														<asp:ListItem Value="True" resourcekey="liFeatured" Text="Featured" />
														<asp:ListItem Value="False" resourcekey="liUnfeatured" Text="Unfeatured" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlPayedFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByPayed" runat="server" CssClass="normalCheckBox" Text="Payed" AutoPostBack="True" OnCheckedChanged="cbFilterByPayed_CheckedChanged" resourcekey="lblFilterByPayed" />
													</div>
													<label for="<%=cbFilterByPayed.ClientID %>"><%=_("lblFilterByPayed.Text") %></label>
													<asp:DropDownList ID="ddlFilterByPayed" runat="server" Enabled="False">
														<asp:ListItem Value="True" resourcekey="liPayed" Text="Payed" />
														<asp:ListItem Value="False" resourcekey="liFree" Text="Free" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlPermissionsByArticleFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByPermissionsByArticle" runat="server" CssClass="normalCheckBox" Text="Permissions per article" AutoPostBack="True" OnCheckedChanged="cbFilterByPermissionsByArticle_CheckedChanged" resourcekey="cbFilterByPermissionsByArticle" />
													</div>
													<label for="<%=cbFilterByPermissionsByArticle.ClientID %>"><%=_("cbFilterByPermissionsByArticle.Text") %></label>
													<asp:DropDownList ID="ddlFilterByPermissionsByArticle" runat="server" Enabled="False">
														<asp:ListItem Value="True" resourcekey="liEnabled" Text="Enabled" />
														<asp:ListItem Value="False" resourcekey="liDisabled" Text="Disabled" />
													</asp:DropDownList>
												</asp:Panel>
											</div>
										</div>
									</div>
									<div>
										<div class="sectionBox noPadding">
											<div class="sectionBoxSubtitle textLeft">
												<span><%=_("OrderOrderType.Text") %></span>
											</div>
											<div class="edNews_OptionBoxes">
												<div>
													<asp:DropDownList ID="ddlOrderBy" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlOrderBy_SelectedIndexChanged">
														<asp:ListItem Value="-1" resourcekey="liOrderby">Order by</asp:ListItem>
														<asp:ListItem Value="StartDate" resourcekey="liStartdate">Start date</asp:ListItem>
														<asp:ListItem Value="PublishDate" resourcekey="liPublishdate">Publish date</asp:ListItem>
														<asp:ListItem Value="NumberofViews" resourcekey="liNumberofViews">Number of Views</asp:ListItem>
														<asp:ListItem Value="RatingValue" resourcekey="liRating">Rating</asp:ListItem>
														<asp:ListItem Value="DateAdded" resourcekey="liDateAdded">Date added</asp:ListItem>
														<asp:ListItem Value="ExpireDate" resourcekey="liExpireDate">Expire date</asp:ListItem>
														<asp:ListItem Value="LastModified" resourcekey="liLastmodified">Last modified</asp:ListItem>
														<asp:ListItem Value="NumberOfComments" resourcekey="liNumberOfCmments">Number of comments</asp:ListItem>
														<asp:ListItem Value="Title" resourcekey="liTitle">Title</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlOrderType" runat="server">
														<asp:ListItem Value="ASC" resourcekey="liAscending">Ascending</asp:ListItem>
														<asp:ListItem Value="DESC" resourcekey="liDescending">Descending</asp:ListItem>
													</asp:DropDownList>
												</div>
												<div>
													<asp:DropDownList ID="ddlOrderBySecond" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlOrderBySecond_SelectedIndexChanged">
														<asp:ListItem Value="-1" resourcekey="liOrderby">Order by</asp:ListItem>
														<asp:ListItem Value="StartDate" resourcekey="liStartdate">Start date</asp:ListItem>
														<asp:ListItem Value="PublishDate" resourcekey="liPublishdate">Publish date</asp:ListItem>
														<asp:ListItem Value="NumberofViews" resourcekey="liNumberofViews">Number of Views</asp:ListItem>
														<asp:ListItem Value="RatingValue" resourcekey="liRating">Rating</asp:ListItem>
														<asp:ListItem Value="DateAdded" resourcekey="liDateAdded">Date added</asp:ListItem>
														<asp:ListItem Value="ExpireDate" resourcekey="liExpireDate">Expire date</asp:ListItem>
														<asp:ListItem Value="LastModified" resourcekey="liLastmodified">Last modified</asp:ListItem>
														<asp:ListItem Value="NumberOfComments" resourcekey="liNumberOfCmments">Number of comments</asp:ListItem>
														<asp:ListItem Value="Title" resourcekey="liTitle">Title</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlOrderTypeSecond" runat="server">
														<asp:ListItem Value="ASC" resourcekey="liAscending">Ascending</asp:ListItem>
														<asp:ListItem Value="DESC" resourcekey="liDescending">Descending</asp:ListItem>
													</asp:DropDownList>
												</div>
												<div>
													<asp:Label ID="lblFilterStartDate" runat="server" Text="Start date:" AssociatedControlID="tbxFilterStartDate" resourcekey="lblFilterStartDate" />
													<div class="input-group input-append date" id="datePickerSearchFromDate" runat="server">
														<asp:TextBox ID="tbxFilterStartDate" runat="server" CssClass="form-control" ValidationGroup="vgEditArticle" />
														<span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
													</div>
													<asp:RequiredFieldValidator ID="rfvEventStartDate" runat="server" ControlToValidate="tbxFilterStartDate" CssClass="smallInfo error" Display="Dynamic" Enabled="false" ErrorMessage="Date required." ValidationGroup="vgEditArticle" resourcekey="rfvEventStartDateResource1" />
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="mainActions noMargin">
									<asp:LinkButton ID="btnFilerArticles" class="filterAction" runat="server" OnClick="btnFilerArticles_Click" resourcekey="btnFilerArticles"></asp:LinkButton>
								</div>
								<asp:HiddenField ID="hfFilterSettingsState" runat="server" Value="closed" />
							</asp:Panel>
						</div>
						<div class="sectionBox noPadding">
							<asp:GridView ID="gvArticleList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ArticleID" DataSourceID="odsGetPagedArticlesByUser" EnableModelValidation="True" OnRowCommand="gvArticleList_RowCommand" ShowFooter="True" OnPreRender="gvArticleList_PreRender" CssClass="strippedTable fullWidthTable noBorder tablePadding5">
								<Columns>
									<asp:TemplateField>
										<FooterTemplate>
											<span class="floatRight smallText" style="margin-top: 17px;"><%#TotalCount%></span>
											<i class="fa fa-mail-reply fa-rotate-180"></i>
											<div class="mainActions noMargin smallActions displayInline">
												<a id="ibFooterSelectAll" class="secondaryAction"><i class="fa fa-list-alt"></i><%=_("ibFooterSelectAll") %></a>
												<a id="ibFooterUnSelectAll" class="secondaryAction"><i class="fa fa-times-circle-o"></i><%=_("ibFooterUnSelectAll") %></a>
											</div>
											<asp:DropDownList ID="ddlFotterActionForSelected" runat="server">
												<asp:ListItem resourcekey="liSelectAction" Value="-1" Text="Select action" />
												<asp:ListItem resourcekey="liDelete" Value="Delete" Text="Delete" />
											</asp:DropDownList>
											<div class="mainActions noMargin smallActions displayInline">
												<asp:Button ID="ibFooterOK" runat="server" CssClass="primaryAction" OnClick="ibFooterOK_Click" OnClientClick="return ShowValue();" resourcekey="ok" />
											</div>
										</FooterTemplate>
										<ItemTemplate>
											<asp:HiddenField ID="hfMainArticleID" runat="server" Value='<%# Bind("ArticleID") %>' />
											<asp:HiddenField ID="hfMainRecurringID" runat="server" Value='<%# Bind("RecurringID") %>' />
											<div class="styledCheckbox noLabel">
												<asp:CheckBox ID="cbSelectRow" runat="server" CssClass="normalCheckBox" Text="Select Row" />
											</div>
										</ItemTemplate>
										<ItemStyle Width="30px" CssClass="textCenter" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Action">
										<ItemTemplate>
											<div class="edNews_boxedActions edNews_threeInRow">
												<asp:LinkButton ID="lbEditThisArticle" runat="server" CssClass="edNews_aaEdit edNews_tooltip" Text="Edit event" CausesValidation="False" CommandArgument='<%# Eval("ArticleID") + ";" + Eval("RecurringID") %>' CommandName="EditArticle" data-tooltip-content='<%#_("Editevent.Text")%>' data-tooltip-position="top-left" resourcekey="lbEditThisArticle" />
												<asp:HyperLink runat="server" ID="hlEditAttendees" CssClass="edNews_aaEditUser edNews_tooltip" data-tooltip-content='<%#_("hlEditAttendees.Text")%>' data-tooltip-position="top-left" resourcekey="hlEditAttendees" NavigateUrl='<%# CreateLinkForListAttendees(Eval("ArticleID"),Eval("RecurringID")) %>' Text="Edit attendees" Enabled='<%# HasAttendees(Eval("HasAttendees")) %>'></asp:HyperLink>
												<asp:HyperLink runat="server" ID="hlAddAttendee" CssClass="edNews_aaAddUser edNews_tooltip" data-tooltip-content='<%#_("hlAddAttendee.Text")%>' data-tooltip-position="top-left" resourcekey="hlAddAttendee" NavigateUrl='<%# CreateLinkForAddAttendee(Eval("ArticleID"),Eval("RecurringID")) %>' Text="Add attendees" Visible='<%# CanAddAttendee %>'></asp:HyperLink><%=CanAddAttendee ? "" : "" %>
												<asp:HyperLink runat="server" ID="hlEditInvitations" CssClass="edNews_aaEdit2 edNews_tooltip" data-tooltip-content='<%#_("hlEditInvitations.Text")%>' data-tooltip-position="bottom-left" resourcekey="hlEditInvitations" NavigateUrl='<%# CreateLinkForSendInvitations(Eval("ArticleID"),Eval("RecurringID")) %>' Text="Edit invitations"></asp:HyperLink>
												<asp:HyperLink runat="server" ID="hlEditReminders" CssClass="edNews_aaEdit2 color8 edNews_tooltip" data-tooltip-content='<%#_("hlEditReminders.Text")%>' data-tooltip-position="bottom-left" resourcekey="hlEditReminders" NavigateUrl='<%# CreateLinkForSendReminders(Eval("ArticleID"),Eval("RecurringID")) %>' Text="Edit reminders"></asp:HyperLink>
											</div>
										</ItemTemplate>
										<HeaderStyle Width="150px" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Event Title">
										<ItemTemplate>
											<asp:Panel ID="pnlArticleImage" runat="server" CssClass="edNews_thumb" Visible='<%# GetArticleImageURLVisible(Eval("ArticleID"),Eval("ArticleImage")) %>'>
												<asp:Image ID="imgArticleImage" runat="server" ImageUrl='<%# GetArticleImageURL(Eval("ArticleID"),Eval("ArticleImage")) %>' />
											</asp:Panel>
											<asp:Label ID="lblEventTitle" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Event Dates">
										<ItemTemplate>
											<p>
												<asp:Label ID="lblEventStartDate" runat="server" CssClass="edNews_articleDates edNews_EventStartDate edNews_tooltip" Text='<%# GetFormatedDate(Convert.ToDateTime(Eval("StartDate")))%>' data-tooltip-content='<%#_("Startdate.Text")%>' data-tooltip-position="top-left" />
											</p>
											<p>
												<asp:Label ID="lblEventEndDate" runat="server" CssClass="edNews_articleDates edNews_ExpireDate edNews_tooltip" Text='<%# GetFormatedDate(Convert.ToDateTime(Eval("EndDate")))%>' data-tooltip-content='<%#_("Enddate.Text")%>' data-tooltip-position="top-left" />
											</p>
										</ItemTemplate>
										<HeaderStyle Width="200px" CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Seats">
										<ItemTemplate>
											<asp:Label ID="lblReserved" runat="server" ToolTip='<%#_("Isreccuringevent.Text")%>' Text='<%# GetReserved(Eval("RegistratedCount"))%>' />
											<br />
											<asp:Label ID="lblTotalPlaces" resourcekey="lblTotalPlaces" runat="server" Text='<%# GetMaxNumberOfTickets(Eval("MaxNumberOfTickets")) %>' ToolTip='<%#_("Totalseats.Text")%>' /><br />
											<asp:Label ID="lblRemaining" runat="server" ToolTip='<%#_("Remaining.Text")%>' Text='<%# GetRemainingTickets(Eval("MaxNumberOfTickets"), Eval("RegistratedCount")) %>' /><br />
											<asp:Literal ID="lblTotalIncome" runat="server" Text='<%# GetTotalIncome(Eval("EventCosts")) %>' />
										</ItemTemplate>
										<HeaderStyle Width="200px" CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Info" HeaderStyle-Width="100px">
										<ItemTemplate>
											<asp:Label ID="lblModerated" runat="server" Text='<%# GetModerated(Eval("RegistrationApproval")) %>' ToolTip='<%#_("Moderated.Text")%>'></asp:Label><br />
											<asp:Label ID="lblActiveRegistration" runat="server" Text='<%# GetActiveRegistration(Eval("DisableFurtherRegistration")) %>' ToolTip='<%#_("Activeregistration.Text")%>'></asp:Label><br />
											<asp:Label ID="lblIsRecurring" runat="server" ToolTip='<%#_("Isrecurringevent.Text")%>' Text='<%# GetRecurringText(Eval("Recurring")) %>' /><br />
											<asp:Label ID="lblRecurringID" runat="server" Text='<%# GetRecurringID(Eval("RecurringID")) %>' ToolTip='<%#_("RecurringID.Text")%>' /><br />
											<asp:Label ID="lblOwner" runat="server" Text='<%# GetOwner(Eval("DisplayName")) %>' ToolTip='<%#_("Owner.Text")%>' /><br />
											<asp:Label ID="lblApproveAttendeeCount" CssClass="color1" runat="server" Text='<%# GetApproveAttendeeCount(Eval("ApproveAttendeeCount")) %>' ToolTip='<%#_("Waitingforapproval.Text")%>'></asp:Label><br />
											<asp:Label ID="lblPaymentEnabled" runat="server" Text='<%# GetPaymentEnabled(Eval("PaymentEnabled")) %>' ToolTip='<%#_("PaymentEnabled.Text")%>' /><br />
											<asp:Literal ID="liCostInfo" runat="server" Text='<%# GetCostInfo(Eval("PaymentEnabled"),Eval("PaymentByType"),Eval("FixedPrice"),Eval("CostPerAttendee"), Eval("AttendeesDiscount"), Eval("DateRestrictionPayment")) %>'></asp:Literal>
										</ItemTemplate>
										<HeaderStyle Width="250px" CssClass="textLeft" />
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader2 highlighted" />
								<PagerStyle CssClass="contentPagination" />
							</asp:GridView>
							<div class="edNews_numberOfRows">
								<div>
									<asp:Label ID="lblFooterSelectNumberOfRows" AssociatedControlID="ddlEventListNumberOfRows" runat="server" Text="Number of rows:" resourcekey="lblFooterSelectNumberOfRowsResource1" />
									<asp:DropDownList ID="ddlEventListNumberOfRows" runat="server" OnSelectedIndexChanged="ddlEventListNumberOfRows_SelectedIndexChanged" AutoPostBack="True">
										<asp:ListItem Value="10" Text="10" />
										<asp:ListItem Value="20" Text="20" />
										<asp:ListItem Value="30" Text="30" />
										<asp:ListItem Value="50" Text="50" />
										<asp:ListItem Value="100" Text="100" />
									</asp:DropDownList>
								</div>
							</div>
						</div>
						<asp:Panel ID="pnlNoArticlesMatched" runat="server" class="infoMessages info topMargin" Visible="False">
							<asp:Literal ID="liNoMatchingArticles" runat="server" />
						</asp:Panel>
					</asp:Panel>
					<asp:Panel ID="pnlNoArticles" CssClass="sectionBox" runat="server" Visible="False">
						<div class="sectionBoxSubtitle highlighted3">
							<span>
								<asp:Literal ID="liInfoNoArticles" runat="server" /></span>
						</div>
						<div class="mainActions noMargin">
							<asp:HyperLink ID="hlAddNewArticle" runat="server" CssClass="add" resourcekey="hlAddNewArticle">Add an article</asp:HyperLink>
						</div>
					</asp:Panel>
				</div>
			</asp:Panel>

			<asp:Panel ID="pnlListOfAttendess" runat="server" Visible="false">
				<div class="edNews_adminProgressOverlayWrapper">
					<asp:Panel ID="pnlAttendeesListWrapper" CssClass="sectionBox noPadding" runat="server">
						<div class="mainActions textLeft smallActions">
							<asp:HyperLink ID="hlExportUsersToExcel" CssClass="export" runat="server" resourcekey="hlExportUsersToExcel" Text="Export users to Excel" />
						</div>
						<asp:GridView ID="gvEventAttendess"
							runat="server"
							AllowPaging="True"
							AllowSorting="True"
							AutoGenerateColumns="False"
							DataKeyNames="Id,ArticleID,RecurringID,EventUserID"
							DataSourceID="odsGetListOfAttendess"
							OnRowDataBound="gvEventAttendess_RowDataBound"
							EnableModelValidation="True"
							OnRowCommand="gvEventAttendess_RowCommand"
							ShowFooter="True"
							OnPreRender="gvEventAttendess_PreRender"
							CssClass="strippedTable fullWidthTable noBorder tablePadding5" PageSize="10">
							<Columns>
								<asp:TemplateField>
									<FooterTemplate>
										<span class="floatRight smallText" style="margin-top: 17px;"><%#TotalCountListOfAttendess%></span>
										<i class="fa fa-mail-reply fa-rotate-180"></i>
										<div class="mainActions noMargin smallActions displayInline">
											<a id="ibFooterSelectAll" class="secondaryAction"><i class="fa fa-list-alt"></i><%=_("ibFooterSelectAll") %></a>
											<a id="ibFooterUnSelectAll" class="secondaryAction"><i class="fa fa-times-circle-o"></i><%=_("ibFooterUnSelectAll") %></a>
										</div>
										<asp:DropDownList ID="ddlFotterActionForSelected" runat="server">
											<asp:ListItem resourcekey="liSelectAction" Value="-1" Text="Select action" />
											<asp:ListItem resourcekey="liDelete" Value="Delete" Text="Delete" />
											<asp:ListItem resourcekey="liApprove" Value="Approve" Text="Approve" />
											<asp:ListItem resourcekey="liUnapprove" Value="Unapprove" Text="Unapprove" />
											<asp:ListItem resourcekey="liUnregister" Value="Unregister" Text="Unregister" />
										</asp:DropDownList>
										<div class="mainActions noMargin smallActions displayInline">
											<asp:Button ID="ibFooterOK" runat="server" CssClass="primaryAction" OnClick="gvEventAttendessibFooterOK_Click" OnClientClick="return ShowValueEventAttendess();" resourcekey="ok" />
										</div>
									</FooterTemplate>
									<ItemTemplate>
										<asp:HiddenField ID="hfMainArticleID" runat="server" Value='<%# Bind("ArticleID") %>' />
										<asp:HiddenField ID="hfMainRecurringID" runat="server" Value='<%# Bind("RecurringID") %>' />
										<asp:HiddenField ID="hfEventUserID" runat="server" Value='<%# Bind("EventUserID") %>' />
										<div class="styledCheckbox noLabel">
											<asp:CheckBox ID="cbSelectRow" CssClass="normalCheckBox" runat="server" Text=" " />
										</div>
									</ItemTemplate>
									<ItemStyle Width="30px" CssClass="textCenter" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Action">
									<ItemTemplate>
										<div class="itemActions displayBlock noBorder smallActions">
											<asp:HyperLink runat="server" ID="hlEditUser" CssClass="editAction" resourcekey="hlEditUser" NavigateUrl='<%# CreateLinkForEditUser(Eval("ArticleID"),Eval("RecurringID"),Eval("EventUserID"),Eval("Id")) %>' Text="Edit user"></asp:HyperLink>
											<asp:LinkButton ID="lblDelateRegistration" CssClass="deleteAction" resourcekey="lblDelateRegistration" runat="server" Text="Delete registration" CausesValidation="False" CommandArgument='<%# Container.DataItemIndex  %>' CommandName="DelateRegistration" ToolTip='<%#_("Delateregistration.Text")%>' OnClientClick="return confirm('Are you sure you want to remove this attendee?');" />
										</div>
									</ItemTemplate>
									<HeaderStyle Width="150px" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="User">
									<ItemTemplate>
										<asp:Label ID="lblEventUserFullName" runat="server" Text='<%# GetUserFullName(Eval("FirstName"), Eval("LastName")) %>' ToolTip='<%#_("Userfullname.Text")%>' /><br />
										<asp:Label ID="lblEventUserEmail" runat="server" Text='<%# Eval("Email") %>' ToolTip='<%#_("Usersemail.Text")%>' /><br />
									</ItemTemplate>
									<HeaderStyle CssClass="textLeft" />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Qnt">
									<ItemTemplate>
										<asp:Label ID="lblQnt" resourcekey="lblQnt" runat="server" ToolTip='<%#_("Qnt.Text")%>' Text='<%# Eval("NumberOfTickets")%>' />
									</ItemTemplate>
									<ItemStyle CssClass="textCenter" />
									<HeaderStyle />
								</asp:TemplateField>
								<asp:TemplateField HeaderText="Info">
									<ItemTemplate>
										<asp:Label ID="lblRegistrationDate" runat="server" Text='<%# GetRegistrationDate(Convert.ToDateTime(Eval("CreatedOnDate"))) %>' ToolTip='<%#_("Registrationdate.Text")%>' /><br />
										<asp:Literal ID="lblCancellationDate" runat="server" />
										<asp:Label ID="lblIsRecurring" runat="server" Text='<%# GetRecurringText(Eval("Recurring")) %>' ToolTip='<%#_("Isrecurringevent.Text")%>' /><br />
										<asp:Label ID="lblRecurringID" runat="server" Text='<%# GetRecurringID(Eval("RecurringID")) %>' ToolTip='<%#_("RecurringID.Text")%>' /><br />
										<asp:Label ID="lblRegistrationID" runat="server" CssClass="color1" Text='<%# GetRegistrationID(Eval("RegistrationID"))%>' ToolTip='<%#_("RegistrationID.Text")%>' /><br />
										<asp:Label ID="lblUserStatus" runat="server" Text='<%# GetUserStatus(Eval("UserStatus"),Eval("EventType")) %>' ToolTip='<%#_("RecurringID.Text")%>' />
									</ItemTemplate>
									<HeaderStyle Width="250px" CssClass="textLeft" />
								</asp:TemplateField>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:Literal ID="liPaymentInfo" runat="server" Text='<%# GetPaymentInfo(Eval("EventUserItemID"),Eval("SubTotal"),Eval("Discount"),Eval("TaxValue"),Eval("EstimatedTotal"),Eval("PaymentStatus"),Eval("PaymentXML")) %>'></asp:Literal>
									</ItemTemplate>
								</asp:TemplateField>
								<asp:TemplateField>
									<ItemTemplate>
										<asp:Panel runat="server" ID="pnlApproveAttende" Visible="true">
											<div class="itemActions displayBlock">
												<asp:LinkButton ID="lbUnregisterAttendee" CssClass="unregisterAction color4" runat="server" CommandArgument='<%# Container.DataItemIndex %>' CommandName="UnregisterAttendee">
													<asp:Label runat="server" Text="Unregister" ID="lblUnregisterAttendee" resourcekey="lblUnregisterAttendee" />
												</asp:LinkButton><asp:Panel runat="server" ID="pnlApproveCancellationRequest" CssClass="additionalActions" Visible="false">
													<asp:Label runat="server" Text="Cancellation request:" resourcekey="CancellationRequest" />
													<asp:LinkButton ID="lbApproveUnregisterAttendee" runat="server" CssClass="approve" CommandArgument='<%# Container.DataItemIndex %>' CommandName="ApproveUnregisterAttendee">
														<asp:Label runat="server" Text="approve" resourcekey="ApproveUnregisterAttendee" />
													</asp:LinkButton><asp:LinkButton ID="lbRejectCancellation" CssClass="reject" resourcekey="lbRejectCancellation" runat="server" CommandArgument='<%# Container.DataItemIndex %>' CommandName="RejectCancellationPopUp" Text="reject"></asp:LinkButton>
												</asp:Panel>
												<asp:Label runat="server" CssClass="smallInfo deleted centered" ID="lblIsDeletedStatus" />
												<asp:LinkButton ID="lbApproveAttendee" runat="server" CssClass='<%# GetIconClas(Eval("ApproveStatus")) %>' CommandArgument='<%# Container.DataItemIndex %>' CommandName="ApproveAttendee">
													<asp:Label runat="server" Text="Unapprove registration" ID="lblArticleListApproved" Visible='<%# IsApproved(Eval("ApproveStatus")) %>' resourcekey="lblArticleListApproved"></asp:Label>
													<asp:Label runat="server" Text="Approve registration" ID="lblApproveRegistration" Visible='<%# !IsApproved(Eval("ApproveStatus")) %>' resourcekey="lblArticleListNotApproved.Text"></asp:Label>
												</asp:LinkButton><asp:LinkButton ID="lbRejectAttendee" resourcekey="lbRejectAttendee" runat="server" Visible='<%# !IsApproved(Eval("ApproveStatus")) %>' CommandArgument='<%# Container.DataItemIndex %>' CommandName="Reject" CssClass="rejectAction" Text="Reject"></asp:LinkButton>
											</div>
											<asp:CheckBox runat="server" ID="cbApproved" CssClass="normalCheckBox" Visible="false" Checked='<%# IsApproved(Eval("ApproveStatus")) %>'></asp:CheckBox>
											<asp:Literal ID="liMailVerified" runat="server" Text='<%# IsVerifyed(Eval("Verified")) %>'></asp:Literal><asp:Label ID="liAlreadyApprovedRegistration" CssClass="smallInfo warning centered" Visible='<%# IsAlreadyRejacted(Eval("ApproveStatus")) %>' runat="server" Text="<%#alreadyRejected %>" />
										</asp:Panel>
										<asp:Panel runat="server" ID="pnlRejectMessage" Visible="false" CssClass="edNews_popUp edNews_topLeft">
											<div class="edNews_inputGroup">
												<div class="floatingLabel">
													<asp:TextBox ID="tbRejectMessage" runat="server" TextMode="MultiLine"></asp:TextBox><asp:Label ID="lblRejectMessage" resourcekey="lblRejectMessage" AssociatedControlID="tbRejectMessage" runat="server" Text="Explain why the attende was rejected:"></asp:Label>
												</div>
											</div>
											<div class="mainActions smallActions displayInline noMargin">
												<asp:LinkButton ID="lbRejectWMessage" resourcekey="lbRejectWMessage" CssClass="primaryAction" CommandArgument='<%# Container.DataItemIndex %>' CommandName="RejectAttendee" runat="server" Text="Reject"> </asp:LinkButton><asp:LinkButton ID="lbCancelRejectWMessage" resourcekey="lbCancelRejectWMessage" CssClass="cancel" CommandName="Cancel" Font-Bold="True" runat="server" Text="Cancel"></asp:LinkButton>
											</div>
										</asp:Panel>
										<asp:Panel runat="server" ID="pnlRejectCancellationMessage" Visible="false" CssClass="edNews_popUp edNews_topLeft">
											<div class="edNews_inputGroup">
												<div class="floatingLabel">
													<asp:TextBox ID="tbRejectCancellationMessage" runat="server" TextMode="MultiLine"></asp:TextBox><asp:Label ID="lblRejectCancellationMessage" resourcekey="lblRejectCancellationMessage" AssociatedControlID="tbRejectCancellationMessage" runat="server" Text="Explain why the cancellation was rejected:"></asp:Label>
												</div>
											</div>
											<div class="mainActions smallActions displayInline noMargin">
												<asp:LinkButton ID="lbRejectCancellationMessage" resourcekey="lbRejectCancellationMessage" CssClass="primaryAction" CommandArgument='<%# Container.DataItemIndex %>' CommandName="RejectCancellation" runat="server" Text="Reject"> </asp:LinkButton><asp:LinkButton ID="lbCancelRejectCancellationMessage" resourcekey="lbCancelRejectCancellationMessage" CssClass="cancel" CommandName="Cancel" Font-Bold="True" runat="server" Text="Cancel"></asp:LinkButton>
											</div>
										</asp:Panel>
									</ItemTemplate>
									<ItemStyle CssClass="tdActions edNews_popUpContainer" />
								</asp:TemplateField>
							</Columns>
							<HeaderStyle CssClass="tableHeader2 highlighted" />
							<PagerStyle CssClass="contentPagination" />
						</asp:GridView>
						<div class="edNews_numberOfRows">
							<div>
								<asp:Label ID="lblFooterNumberOfRows" AssociatedControlID="gvEventAttendessNumberOfRows" runat="server" Text="Number of rows:" resourcekey="lblFooterNumberOfRows" />
								<asp:DropDownList ID="gvEventAttendessNumberOfRows" runat="server" OnSelectedIndexChanged="gvEventAttendessNumberOfRows_SelectedIndexChanged" AutoPostBack="True">
									<asp:ListItem resourcekey="ListItemResource40" Text="10" />
									<asp:ListItem resourcekey="ListItemResource41" Text="20" />
									<asp:ListItem resourcekey="ListItemResource42" Text="30" />
									<asp:ListItem resourcekey="ListItemResource43" Text="50" />
									<asp:ListItem resourcekey="ListItemResource44" Text="100" />
								</asp:DropDownList>
							</div>
						</div>
						<asp:Panel ID="Panel10" runat="server" class="sectionBox" Visible="False">
							<div class="infoMessages topMargin">
								<asp:Literal ID="Literal1" runat="server" />
							</div>
						</asp:Panel>
					</asp:Panel>
				</div>
			</asp:Panel>

			<asp:Panel ID="pnlUserData" runat="server" Visible="false" class="sectionBox noPadding">
				<div class="sectionBoxSubtitle highlighted3 textLeft">
					<span><%=eventRegistrationUserdata%></span>
				</div>
				<table class="optionsList strippedTable noBorder fullWidthTable tablePadding5">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxFirstName.ClientID %>"><%=_("lblFirstName.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxFirstName" runat="server" ValidationGroup="vgUserData" MaxLength="50" CausesValidation="true"></asp:TextBox><asp:RequiredFieldValidator ID="rfvFirstName" CssClass="smallInfo error" resourcekey="rfvFirstName.ErrorMessage" runat="server" ControlToValidate="tbxFirstName" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxLastName.ClientID %>"><%=_("lblLastName.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxLastName" runat="server" ValidationGroup="vgUserData" MaxLength="50" placeholder="Last name"></asp:TextBox><asp:RequiredFieldValidator ID="rfvLastName" CssClass="smallInfo error" resourcekey="rfvLastName.ErrorMessage" runat="server" ControlToValidate="tbxLastName" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True" />
						</td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxEmail.ClientID %>"><%=_("lblEmail.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxEmail" runat="server" ValidationGroup="vgUserData" MaxLength="256" placeholder="E-mail"></asp:TextBox><asp:RequiredFieldValidator ID="rfvEmail" CssClass="smallInfo error" resourcekey="rfvEmail.ErrorMessage" runat="server" ControlToValidate="tbxEmail" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True" />
							<asp:RegularExpressionValidator ID="revEmail" resourcekey="revEmail.ErrorMessage" runat="server" ControlToValidate="tbxEmail" Display="Dynamic" ErrorMessage="Please enter a valid email address." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="vgUserData" SetFocusOnError="True" />
						</td>
					</tr>
					<tr runat="server" id="rowNumberOfTickets">
						<td class="tdLabel">
							<label for="<%=tbxNumberOfTickets.ClientID %>"><%=_("lblNumberOfTickets.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxNumberOfTickets" runat="server" MaxLength="4" placeholder="Number of tickets" Text="1"></asp:TextBox><asp:RequiredFieldValidator ID="rfvNumberOfTickets" CssClass="smallInfo error" resourcekey="rfvNumberOfTickets.ErrorMessage" runat="server" ControlToValidate="tbxNumberOfTickets" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True" />
							<asp:RangeValidator ID="rvNumberOfTickets" resourcekey="rvNumberOfTickets.ErrorMessage" runat="server" ControlToValidate="tbxNumberOfTickets" ErrorMessage="Value between" Type="Integer" SetFocusOnError="True" MaximumValue="5" MinimumValue="1" Display="Dynamic"></asp:RangeValidator></td>
					</tr>
				</table>
				<table runat="server" id="tblExtendedUserData" cellspacing="0" cellpadding="0" class="optionsList strippedTable noBorder fullWidthTable tablePadding5" align="center" visible="false">
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxStreet.ClientID %>"><%=_("lblStreet.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxStreet" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxCity.ClientID %>"><%=_("lblCity.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxCity" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxRegion.ClientID %>"><%=_("lblRegion.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxRegion" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxCountry.ClientID %>"><%=_("lblCountry.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxCountry" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxPostalCode.ClientID %>"><%=_("lblPostalCode.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxPostalCode" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox></td>
					</tr>
					<tr>
						<td class="tdLabel">
							<label for="<%=tbxTelephone.ClientID %>"><%=_("lblTelephone.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxTelephone" runat="server" CausesValidation="false" Enabled="false"></asp:TextBox></td>
					</tr>
				</table>
				<table class="optionsList strippedTable noBorder fullWidthTable tablePadding5">
					<tr runat="server" id="rowuserStatus">
						<td class="tdLabel">
							<label for="<%=ddlIsUserGoing.ClientID %>"><%=_("lblUserStatus.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlIsUserGoing" runat="server">
								<asp:ListItem Value="1" resourcekey="liYes" Text="Yes" />
								<asp:ListItem Value="0" resourcekey="liNo" Text="No" />
								<asp:ListItem Value="2" resourcekey="liMaybe" Text="Maybe" />
							</asp:DropDownList>
						</td>
					</tr>
					<tr runat="server" id="rowUserPaymentStatus" visible="false">
						<td class="tdLabel">
							<label for="<%=ddlUserPaymentStatus.ClientID %>"><%=_("lblUserPaymentStatus.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlUserPaymentStatus" runat="server">
								<asp:ListItem Value="6" Text="Pending" />
								<asp:ListItem Value="1" Text="Paid" />
								<asp:ListItem Value="11" Text="Canceled" />
							</asp:DropDownList>
						</td>
					</tr>
				</table>
				<div>
					<asp:PlaceHolder ID="phCustomFields" runat="server" Visible="false">
						<asp:HiddenField runat="server" ID="hfParenSelectedValue" />
						<asp:HiddenField runat="server" ID="hfLastSelectedIndexChanged" />
						<asp:HiddenField runat="server" ID="hfCFLastTriggerdByList" />
						<asp:HiddenField runat="server" ID="hfPreviousCFTemplateID" />
						<asp:HiddenField runat="server" ID="hfUploadFieldState" />
					</asp:PlaceHolder>
				</div>
				<table class="optionsList strippedTable noBorder fullWidthTable tablePadding5">
					<tr>
						<td class="tdLabel textTop">
							<label for="<%=tbxMessage.ClientID %>"><%=_("lblMessage.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxMessage" runat="server" MaxLength="256" TextMode="MultiLine"></asp:TextBox></td>
					</tr>
				</table>
				<asp:Literal ID="litPaymentDataInfo" runat="server"></asp:Literal>
				<table runat="server" id="tblEditPaymentData" cellspacing="0" cellpadding="0" class="optionsList strippedTable noBorder fullWidthTable tablePadding5" align="center" visible="false">
					<tr>
						<td class="tdLabel">
							<label for="<%=btnEditPaymentDetails.ClientID %>">Edit payment details:</label>
						</td>
						<td>
							<div class="mainActions textLeft smallActions">
								<asp:Button ID="btnEditPaymentDetails" CssClass="downSave" runat="server" Text="Edit payment details" OnClick="btnEditPaymentDetails_Click" />
							</div>
						</td>
					</tr>
					<tr runat="server" id="trEditSubtotal" visible="false">
						<td class="tdLabel">
							<label for="<%=tbEditSubtotal.ClientID %>">Sub Total:</label>
						</td>
						<td>
							<asp:TextBox ID="tbEditSubtotal" runat="server" CausesValidation="false"></asp:TextBox><asp:RequiredFieldValidator ID="rfvEditSubtotal" CssClass="smallInfo error" resourcekey="rfvEventPostName.ErrorMessage" runat="server" ControlToValidate="tbEditSubtotal" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CompareValidator ID="cvEditSubtotal" ControlToValidate="tbEditSubtotal" runat="server" ErrorMessage="Please add valid decimal." Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="true" ValidationGroup="vgUserData"></asp:CompareValidator></td>
					</tr>
					<tr runat="server" id="trDiscount" visible="false">
						<td class="tdLabel">
							<label for="<%=tbDiscount.ClientID %>">Discount:</label>
						</td>
						<td>
							<asp:TextBox ID="tbDiscount" runat="server" CausesValidation="false">
							</asp:TextBox><asp:RequiredFieldValidator ID="rfvDiscount" CssClass="smallInfo error" resourcekey="rfvEventPostName.ErrorMessage" runat="server" ControlToValidate="tbDiscount" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True">
							</asp:RequiredFieldValidator><asp:CompareValidator ID="cvDiscount" ControlToValidate="tbDiscount" runat="server" ErrorMessage="Please add valid decimal." Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="true" ValidationGroup="vgUserData"></asp:CompareValidator></td>
					</tr>
					<tr runat="server" id="trTaxValue" visible="false">
						<td class="tdLabel">
							<label for="<%=tbTaxValue.ClientID %>">Tax Value:</label>
						</td>
						<td>
							<asp:TextBox ID="tbTaxValue" runat="server" CausesValidation="false"></asp:TextBox><asp:RequiredFieldValidator ID="rfvTaxValue" CssClass="smallInfo error" resourcekey="rfvEventPostName.ErrorMessage" runat="server" ControlToValidate="tbTaxValue" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CompareValidator ID="cvTaxValue" ControlToValidate="tbTaxValue" runat="server" ErrorMessage="Please add valid decimal." Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="true" ValidationGroup="vgUserData"></asp:CompareValidator></td>
					</tr>
					<tr runat="server" id="trEstimatedTotal" visible="false">
						<td class="tdLabel">
							<label for="<%=tbEstimatedTotal.ClientID %>">Estimated Total:</label>
						</td>
						<td>
							<asp:TextBox ID="tbEstimatedTotal" runat="server" CausesValidation="false"></asp:TextBox><asp:RequiredFieldValidator ID="rfvEstimatedTotal" CssClass="smallInfo error" resourcekey="rfvEventPostName.ErrorMessage" runat="server" ControlToValidate="tbEstimatedTotal" ErrorMessage="Required!" ValidationGroup="vgUserData" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:CompareValidator ID="cvEstimatedTotal" ControlToValidate="tbEstimatedTotal" runat="server" ErrorMessage="Please add valid decimal." Display="Dynamic" Type="Double" Operator="DataTypeCheck" SetFocusOnError="true" ValidationGroup="vgUserData"></asp:CompareValidator></td>
					</tr>
				</table>
				<asp:Label ID="lblregistrationUserDataUpdateInfo" runat="server" EnableViewState="false" />

				<div class="mainActions">
					<asp:Button ID="btnUpdateUserData" CssClass="downSave" resourcekey="btnUpdateUserData" runat="server" Text="Update" OnClick="btnUpdateUserData_Click" ValidationGroup="vgUserData" />
					<asp:Button ID="btnCloseUserData" CssClass="cancel" resourcekey="btnCloseUserData" runat="server" Text="Close" CausesValidation="false" OnClick="btnCloseUserData_Click" />
				</div>
			</asp:Panel>

			<asp:Panel ID="pnlAddUserToEvent" runat="server" Visible="false" CssClass="sectionBox noPadding">
				<asp:Literal ID="liRegistrationInfo" runat="server"></asp:Literal><table class="optionsList strippedTable noBorder fullWidthTable tablePadding5">
					<tr runat="server" id="trAddRolesToEvent">
						<td class="tdLabel textTop">
							<label for="<%=ddlAddUsersFromRole.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddUsersFromRole.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAddUsersFromRole.Text") %></label>
						</td>
						<td>
							<asp:DropDownList ID="ddlAddUsersFromRole" runat="server"></asp:DropDownList>
							<div class="mainActions smallActions displayInline noMargin">
								<asp:LinkButton ID="lbAddUsersFromRole" CssClass="add" resourcekey="lbAddUsersFromRole" runat="server" OnClick="lbAddUsersFromRole_Click" Text="Add" />
							</div>
							<asp:GridView ID="gvAddusersFromRoles" runat="server" AutoGenerateColumns="false" CssClass="strippedTable tablePadding5 textCenter" EnableModelValidation="True" GridLines="None" OnRowCommand="gvAddusersFromRoles_RowCommand" Width="350px">
								<Columns>
									<asp:TemplateField HeaderText="Addusersfromroles">
										<ItemTemplate>
											<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
											<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' />
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField>
										<ItemTemplate>
											<div class="itemActions">
												<asp:LinkButton ID="lbRoleRemove" runat="server" CssClass="deleteAction" CausesValidation="false" CommandArgument='<%# Eval("RoleID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this role?');" Text="Remove" resourcekey="lbRoleRemove"></asp:LinkButton>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader" />
							</asp:GridView>
						</td>
					</tr>
					<tr>
						<td class="tdLabel textTop">
							<label for="<%=tbxAddUserNameToEvent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectUserToAddToEvent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectUserToAddToEvent.Text") %></label>
						</td>
						<td>
							<asp:TextBox ID="tbxAddUserNameToEvent" runat="server"></asp:TextBox><div class="mainActions smallActions displayInline noMargin">
								<asp:LinkButton ID="lbAddUserNameToEvent" CssClass="add" resourcekey="lbAddUserNameToEvent" runat="server" OnClick="lbAddUserNameToEvent_Click" Text="Add" />
							</div>
							<asp:GridView ID="gvAddedUsersToEvent" runat="server" AutoGenerateColumns="false" CssClass="strippedTable tablePadding5 textCenter" EnableModelValidation="True" GridLines="None" OnRowCommand="gvAddedUsersToEvent_RowCommand" Width="350">
								<Columns>
									<asp:TemplateField HeaderText="Userstoadd">
										<ItemTemplate>
											<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
											<asp:HiddenField ID="hfEmail" runat="server" Value='<%# Eval("Email") %>' />
											<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("Name") %>' />
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField>
										<ItemTemplate>
											<div class="itemActions">
												<asp:LinkButton ID="lbUserPremissionRemove" runat="server" CssClass="deleteAction" CausesValidation="false" CommandArgument='<%# Eval("UserID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user?');" Text="Remove" resourcekey="lbUserPremissionRemove"></asp:LinkButton>
											</div>
										</ItemTemplate>
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader" />
							</asp:GridView>
						</td>
					</tr>
				</table>
				<asp:Label ID="lblAddUsersToEventInfo" runat="server" EnableViewState="false" />
				<div class="mainActions">
					<asp:Button ID="btnAddUsersToEvent" CssClass="add" resourcekey="btnAddUsersToEvent" runat="server" Text="Add" OnClick="btnAddUsersToEvent_Click" ValidationGroup="vgAddUsersToEvent" />
					<asp:Button ID="btnCloseAddUsersToEvent" CssClass="cancel" resourcekey="btnCloseAddUsersToEvent" runat="server" Text="Close" OnClick="btnCloseAddUsersToEvent_Click" />
				</div>
			</asp:Panel>

			<asp:Panel ID="pnlPostSettings" runat="server" Visible="false">
				<asp:Panel ID="pnlAddPostSettings" runat="server" Visible="false" CssClass="sectionBox noPadding">
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxEventPostName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventPostName.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventPostName.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxEventPostName" runat="server"></asp:TextBox><asp:RequiredFieldValidator ID="rfvEventPostName" CssClass="smallInfo error" resourcekey="rfvEventPostName.ErrorMessage" runat="server" ControlToValidate="tbxEventPostName" ErrorMessage="Required!" ValidationGroup="vgPostSettings" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=ddlSendToDNNRole.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendToDNNRole.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendToDNNRole.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlSendToDNNRole" runat="server"></asp:DropDownList>
								<div class="mainActions displayInline smallActions noMargin">
									<asp:LinkButton ID="lbSendToDNNRole" CssClass="add" resourcekey="lbSendToDNNRole" runat="server" OnClick="lbRoleAdd_Click" Text="Add" />
								</div>
								<asp:GridView ID="gvSendToRoles" runat="server" AutoGenerateColumns="false" CssClass="strippedTable tablePadding5" EnableModelValidation="True" GridLines="None" OnRowCommand="gvSendToRoles_RowCommand">
									<Columns>
										<asp:TemplateField HeaderText="Sendtorole">
											<ItemTemplate>
												<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
												<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' />
											</ItemTemplate>
											<ItemStyle CssClass="textCenter" />
										</asp:TemplateField>
										<asp:TemplateField>
											<ItemTemplate>
												<div class="itemActions">
													<asp:LinkButton ID="lbRoleRemove" resourcekey="lbRoleRemove" CssClass="deleteAction" runat="server" CausesValidation="false" CommandArgument='<%# Eval("RoleID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this role?');" Text="Remove"></asp:LinkButton>
												</div>
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
									<HeaderStyle CssClass="tableHeader" />
								</asp:GridView>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=tbxSendToUserName.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendToUserName.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendToUserName.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxSendToUserName" runat="server"></asp:TextBox><div class="mainActions displayInline smallActions noMargin">
									<asp:LinkButton ID="lbUsernameAdd" CssClass="add" resourcekey="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" />
								</div>
								<asp:GridView ID="gvSendToUsers" runat="server" AutoGenerateColumns="false" CssClass="strippedTable tablePadding5" EnableModelValidation="True" GridLines="None" OnRowCommand="gvSendToUsers_RowCommand">
									<Columns>
										<asp:TemplateField HeaderText="Sendtousers" HeaderStyle-HorizontalAlign="Center">
											<ItemTemplate>
												<asp:Label ID="lblUserName" runat="server" Text='<%# Eval("Name") %>' />
												<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
												<asp:HiddenField ID="hfEmail" runat="server" Value='<%# Eval("Email") %>' />
											</ItemTemplate>
											<ItemStyle CssClass="textCenter" />
										</asp:TemplateField>
										<asp:TemplateField>
											<ItemTemplate>
												<div class="itemActions">
													<asp:LinkButton ID="lbUserPremissionRemove" CssClass="deleteAction" resourcekey="lbUserPremissionRemove" runat="server" CausesValidation="false" CommandArgument='<%# Eval("UserID") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this user?');" Text="Remove"></asp:LinkButton>
												</div>
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
									<HeaderStyle CssClass="tableHeader" />
								</asp:GridView>
							</td>
						</tr>
						<tr runat="server" id="trSendToEventAttendees">
							<td class="tdLabel">
								<label for="<%=cbSendToEventAtendees.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendToEventAttendees.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendToEventAttendees.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cbSendToEventAtendees" runat="server" CssClass="normalCheckBox" Checked="True" Text="Send to event attendees" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=ddlEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEmailTemplateTheme.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
								<%-- <dnn:Label ID="lblEmailTemplate" runat="server" Text="Template:" HelpText="Here you can choose a template for invitation/reminder email formatting." ResourceKey="nema" ControlName="ddlEmailTemplate" />--%>
								<asp:DropDownList ID="ddlEmailTemplate" runat="server"></asp:DropDownList>
								<div class="mainActions smallActions displayInline noMargin">
									<asp:Button ID="btnEmailTemplate" CssClass="upload" resourcekey="btnEmailTemplate" runat="server" Text="Load" OnClick="btnEmailTemplate_Click" />
								</div>
								<div runat="server" id="divCreateEmailTemplate" class="topMargin sectionBox" visible="false">
									<a id="toggleCreateEmail"><%#createEmailTemplate%></a>
									<%#fileName%>:<asp:TextBox ID="tbxTemplateName" runat="server"></asp:TextBox><div class="mainActions smallActions noMargin">
										<asp:Button ID="btnSaveEmailTemplate" CssClass="downSawe" resourcekey="btnSaveEmailTemplate" runat="server" Text="Save template to file" OnClick="btnSaveEmailTemplate_Click" ValidationGroup="vgSaveEmailTemplate" />
										<asp:Button ID="btnDeleteEmailTemplate" CssClass="delete" resourcekey="btnDeleteEmailTemplate" runat="server" Text="Delete selected template" OnClick="btnDeleteEmailTemplate_Click" ValidationGroup="vgSaveEmailTemplate" />
									</div>
									<asp:Label ID="lblSaveEmailTemplateInfo" runat="server" EnableViewState="false"></asp:Label>
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblMailSubject.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxMailSubject" runat="server" Width="450px"></asp:TextBox><asp:RequiredFieldValidator ID="rfvMailSubject" CssClass="smallInfo error" resourcekey="rfvMailSubject.ErrorMessage" runat="server" ControlToValidate="tbxMailSubject" ErrorMessage="Required!" ValidationGroup="vgPostSettings" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=tbxEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEmailTemplateContent.Text") %></label>
							</td>
							<td>
								<div style="min-height: 450px">
									<dnn:TextEditor ID="tbxEmailTemplateContent" runat="server" Height="450" />
								</div>
								<%--<asp:TextBox ID="tbxEmailTemplateContent" runat="server" TextMode="MultiLine" Width="600px" Height="400px"></asp:TextBox>--%>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=rblSendingTime.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendingTime.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendingTime.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup displayInline">
									<asp:RadioButtonList ID="rblSendingTime" runat="server" OnSelectedIndexChanged="rblSendingTime_SelectedIndexChanged" AutoPostBack="true" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
										<asp:ListItem Value="0" class="normalRadioButton" resourcekey="liInstant" Text="Instant" Selected="True" />
										<asp:ListItem Value="1" class="normalRadioButton" resourcekey="liTime" Text="Time" />
									</asp:RadioButtonList>
								</div>
								<div runat="server" id="divSendingTime" class="displayInline" visible="false">
									<%#days%>
									<asp:TextBox ID="tbxSendingTimeDays" runat="server" Text="5" CssClass="smallCentered" />
									<%#hours%>
									<asp:TextBox ID="tbxSendingTimeHours" runat="server" Text="0" CssClass="smallCentered" />
									<%#minutes %>
									<asp:TextBox ID="tbxSendingTimeMinutes" runat="server" Text="0" CssClass="smallCentered" />
								</div>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=cblblPostSettingsActive.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPostSettingsActive.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPostSettingsActive.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cblblPostSettingsActive" CssClass="normalCheckBox" runat="server" Checked="True" Text="Active" />
								</div>
							</td>
						</tr>
						<tr style="display: none">
							<td class="tdLabel">
								<label for="<%=tbxSendToEmail.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSendToEmail.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSendToEmail.Text") %></label>
								<dnn:Label ID="lblSendToEmail" runat="server" Text="Add e-mail:" HelpText="Add e-mail." ControlName="tbxSendToEmail" />
							</td>
							<td>
								<asp:TextBox ID="tbxSendToEmail" runat="server"></asp:TextBox><div class="mainActions smallActions displayInline noMargin">
									<asp:LinkButton ID="lbEmailAdd" CssClass="add" resourcekey="lbEmailAdd" runat="server" OnClick="lbEmailAdd_Click" Text="Add" />
								</div>
							</td>
						</tr>
						<tr style="display: none">
							<td colspan="2">
								<asp:GridView ID="gvSendToEmail" runat="server" AutoGenerateColumns="false" CellPadding="0" CssClass="permissions_table" EnableModelValidation="True" GridLines="None" OnRowCommand="gvSendToEmail_RowCommand">
									<AlternatingRowStyle CssClass="second" />
									<Columns>
										<asp:TemplateField HeaderText="Send to email/s:">
											<ItemTemplate>
												<asp:Label ID="lblEmail" runat="server" Text='<%# Eval("Email") %>' />
											</ItemTemplate>
											<HeaderStyle CssClass="subject" />
											<ItemStyle CssClass="subject" />
										</asp:TemplateField>
										<asp:TemplateField>
											<ItemTemplate>
												<asp:LinkButton ID="lbUserPremissionRemove" resourcekey="lbUserPremissionRemove" runat="server" CausesValidation="false" CommandArgument='<%# Eval("Email") %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this email?');" Text="Remove"></asp:LinkButton>
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
								</asp:GridView>
							</td>
						</tr>
					</table>
					<asp:Label ID="lblSendInvitationsInfo" runat="server" EnableViewState="false" />
					<div class="mainActions">
						<asp:Button ID="btnAddPostSettings" CssClass="add" resourcekey="btnAddPostSettings" runat="server" Text="Save" OnClick="btnAddPostSettings_Click" ValidationGroup="vgPostSettings" />
						<asp:HyperLink ID="btnCloseAddPostSettings" CssClass="cancel" resourcekey="btnCloseAddPostSettings" runat="server" Text="Close" />
					</div>
				</asp:Panel>

				<asp:Panel ID="pnlPostSettingsList" CssClass="sectionBox noPadding" runat="server" Visible="false">
					<asp:GridView ID="gvPostSettingsList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="Id" DataSourceID="odsGetPostSettings" EnableModelValidation="True" OnPreRender="gvPostSettingsList_PreRender" CssClass="strippedTable fullWidthTable textCenter tablePadding5">
						<Columns>
							<asp:TemplateField HeaderText="Action">
								<ItemTemplate>
									<div class="itemActions">
										<asp:HyperLink runat="server" ID="hlEdit" CssClass="editAction" resourcekey="hlEdit" NavigateUrl='<%# CreateLinkForEdit(Eval("Id"), Eval("PostType")) %>' Text="Edit"></asp:HyperLink><asp:LinkButton ID="lbDelete" resourcekey="lbDelete" CssClass="deleteAction" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
									</div>
								</ItemTemplate>
								<HeaderStyle Width="200px" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Name">
								<ItemTemplate>
									<asp:Label ID="lblName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Sendtype">
								<ItemTemplate>
									<label><%# GetSendType(Eval("SendType"), Eval("SendIntervalValue"))%></label>
								</ItemTemplate>
								<HeaderStyle CssClass="dates" />
								<ItemStyle CssClass="dates" />
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Status">
								<ItemTemplate>
									<label><%# GetPostStatus(Eval("Finished"))%></label>
								</ItemTemplate>
							</asp:TemplateField>
							<asp:TemplateField HeaderText="Active">
								<ItemTemplate>
									<asp:Label ID="lblActive" runat="server" Text='<%# Eval("Active")%>' />
								</ItemTemplate>
							</asp:TemplateField>
						</Columns>
						<HeaderStyle CssClass="tableHeader" />
						<PagerStyle CssClass="contentPagination" />
					</asp:GridView>
					<div class="mainActions">
						<asp:HyperLink ID="hlAddNewPostSettings" runat="server" CssClass="add"></asp:HyperLink>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlEmailSettings" Visible="false" class="sectionBox noPadding" runat="server">
					<asp:Panel ID="pnlPostCategories" runat="server" CssClass="edNews_numberedOptions">
						<div class="edNews_numberedOptionsHeader">
							<span class="edNews_numberedOptionsHeaderNumber">1</span>
							<h2><%=emailEventLinks%></h2>
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
							<h2><%=emailNotificationTemplates%></h2>
						</div>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=approvalNeeded%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxapprovalNeededMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblapprovalNeededMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblapprovalNeededMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxapprovalNeededMailSubject" runat="server" placeholder="e.g. Awaiting registration approval for [event title]..."></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvapprovalNeededMailSubject" CssClass="smallInfo error" resource="rfvapprovalNeededMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxapprovalNeededMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlapprovalNeededEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblapprovalNeededEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblapprovalNeededEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlapprovalNeededEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ApprovalNeededEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlapprovalNeededEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnapprovalNeededEmailTemplate" CssClass="upload" resourcekey="btnapprovalNeededEmailTemplate" runat="server" Text="Load" OnClick="ApprovalNeededEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxapprovalNeededEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblapprovalNeededEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblapprovalNeededEmailTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxapprovalNeededEmailTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=newEventRegistration%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxnewEventRegistrationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblnewEventRegistrationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblnewEventRegistrationMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxnewEventRegistrationMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvnewEventRegistrationMailSubject" CssClass="smallInfo error" resoucekey="rfvnewEventRegistrationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxnewEventRegistrationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlnewEventRegistrationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblnewEventRegistrationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblnewEventRegistrationEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlnewEventRegistrationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="NewEventRegistrationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlnewEventRegistrationEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnnewEventRegistrationEmailTemplate" CssClass="upload" resourcekey="btnnewEventRegistrationEmailTemplate" runat="server" Text="Load" OnClick="NewEventRegistrationEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxnewEventRegistrationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblnewEventRegistrationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblnewEventRegistrationEmailTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxnewEventRegistrationEmailTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=verifyingRegistrationForUnregisteredUsers%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxverifyingRegistrationForUnregisteredUsersMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblverifyingRegistrationForUnregisteredUsersMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblverifyingRegistrationForUnregisteredUsersMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxverifyingRegistrationForUnregisteredUsersMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvverifyingRegistrationForUnregisteredUsersMailSubject" CssClass="smallInfo error" resourcekey="rfvverifyingRegistrationForUnregisteredUsersMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxverifyingRegistrationForUnregisteredUsersMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlverifyingRegistrationForUnregisteredUsersEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblverifyingRegistrationForUnregisteredUsersEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblverifyingRegistrationForUnregisteredUsersEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlverifyingRegistrationForUnregisteredUsersEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="VerifyingRegistrationForUnregisteredUsersEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlverifyingRegistrationForUnregisteredUsersEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnverifyingRegistrationForUnregisteredUsersEmailTemplate" CssClass="upload" resourcekey="btnverifyingRegistrationForUnregisteredUsersEmailTemplate" runat="server" Text="Load" OnClick="VerifyingRegistrationForUnregisteredUsersEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxverifyingRegistrationForUnregisteredUsersEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblverifyingRegistrationForUnregisteredUsersEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblverifyingRegistrationForUnregisteredUsersEmailTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxverifyingRegistrationForUnregisteredUsersEmailTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=awaitingRegistrationApproval%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxAwaitingRegistrationApprovalMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAwaitingRegistrationApprovalMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAwaitingRegistrationApprovalMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxAwaitingRegistrationApprovalMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvAwaitingRegistrationApprovalMailSubject" CssClass="smallInfo error" resourcekey="rfvAwaitingRegistrationApprovalMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxAwaitingRegistrationApprovalMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlAwaitingRegistrationApprovalEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAwaitingRegistrationApprovalEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAwaitingRegistrationApprovalEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlAwaitingRegistrationApprovalEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="AwaitingRegistrationApprovalEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlAwaitingRegistrationApprovalEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnAwaitingRegistrationApprovalEmailTemplate" CssClass="upload" resourcekey="btnAwaitingRegistrationApprovalEmailTemplate" runat="server" Text="Load" OnClick="AwaitingRegistrationApprovalEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxAwaitingRegistrationApprovalEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAwaitingRegistrationApprovalEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAwaitingRegistrationApprovalEmailTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxAwaitingRegistrationApprovalEmailTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=rejectRegistration%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxrejectRegistrationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblrejectRegistrationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblrejectRegistrationMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxrejectRegistrationMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvrejectRegistrationMailSubject" CssClass="smallInfo error" resourcekey="rfvrejectRegistrationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxrejectRegistrationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlrejectRegistrationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblrejectRegistrationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblrejectRegistrationEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlrejectRegistrationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RejectRegistrationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlrejectRegistrationEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnrejectRegistrationEmailTemplate" CssClass="upload" resourcekey="btnrejectRegistrationEmailTemplate" runat="server" Text="Load" OnClick="RejectRegistrationEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxrejectRegistrationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblrejectRegistrationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblrejectRegistrationEmailTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxrejectRegistrationEmailTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=confirmRegistration%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxconfirmRegistrationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblconfirmRegistrationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblconfirmRegistrationMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxconfirmRegistrationMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvconfirmRegistrationMailSubject" CssClass="smallInfo error" resourcekey="rfvconfirmRegistrationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxconfirmRegistrationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlconfirmRegistrationEmailTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblconfirmRegistrationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblconfirmRegistrationEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlconfirmRegistrationEmailTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ConfirmRegistrationEmailTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlconfirmRegistrationEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnconfirmRegistrationEmailTemplate" CssClass="upload" resourcekey="btnconfirmRegistrationEmailTemplate" runat="server" Text="Load" OnClick="ConfirmRegistrationEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxconfirmRegistrationEmailTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblconfirmRegistrationEmailTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblconfirmRegistrationEmailTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxconfirmRegistrationEmailTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=paymentRequest%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxpaymentRequestMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblpaymentRequestMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblpaymentRequestMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxpaymentRequestMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvpaymentRequestMailSubject" CssClass="smallInfo error" resourcekey="rfvpaymentRequestMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxpaymentRequestMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlpaymentRequestTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblpaymentRequestEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblpaymentRequestEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlpaymentRequestTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="PaymentRequestTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlpaymentRequestEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnpaymentRequestEmailTemplate" CssClass="upload" resourcekey="btnpaymentRequestEmailTemplate" runat="server" Text="Load" OnClick="PaymentRequestEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxpaymentRequestTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblpaymentRequestTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("lblpaymentRequestTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxpaymentRequestTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=unregisterNotification%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxUnregisterNotificationMailSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("UnregisterNotificationMailSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("UnregisterNotificationMailSubject.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth100">
										<asp:TextBox ID="tbxUnregisterNotificationMailSubject" runat="server"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvUnregisterNotificationMailSubject" CssClass="smallInfo error" resourcekey="rfvUnregisterNotificationMailSubject.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxUnregisterNotificationMailSubject" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlUnregisterNotificationTemplateTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("UnregisterNotificationEmailTemplateTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("UnregisterNotificationEmailTemplateTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlUnregisterNotificationTemplateTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="UnregisterNotificationTemplateTheme_SelectedIndexChanged"></asp:DropDownList>
									<asp:DropDownList ID="ddlUnregisterNotificationEmailTemplate" runat="server"></asp:DropDownList>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnUnregisterNotificationEmailTemplate" CssClass="upload" resourcekey="btnUnregisterNotificationEmailTemplate" runat="server" Text="Load" OnClick="UnregisterNotificationEmailTemplate_Click" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbxUnregisterNotificationTemplateContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("UnregisterNotificationTemplateContent.Help", true) %>" data-tooltip-position="top-right"><%=_("UnregisterNotificationTemplateContent.Text") %></label>
								</td>
								<td>
									<div style="min-height: 450px">
										<dnn:TextEditor ID="tbxUnregisterNotificationTemplateContent" runat="server" Height="450" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>

					<asp:Panel ID="pnlSendEmailSettings" runat="server" CssClass="edNews_numberedOptions">
						<div class="edNews_numberedOptionsHeader">
							<span class="edNews_numberedOptionsHeaderNumber">3</span>
							<h2><%=emailSettings%></h2>
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
									<asp:RequiredFieldValidator ID="rfvDefaultFromName" CssClass="smallInfo error" resourcekey="rfvDefaultFromName.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxDefaultFromName" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxDefaultFromMail.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultFromMail.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultFromMail.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth40">
										<asp:TextBox ID="tbxDefaultFromMail" runat="server" Width="450px"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvDefaultFromMail" CssClass="smallInfo error" resourcekey="rfvDefaultFromMail.ErrorMessage" runat="server" ErrorMessage="Required!" ControlToValidate="tbxDefaultFromMail" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbxDefaultReplyTo.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultReplyTo.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultReplyTo.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup inputWidth40">
										<asp:TextBox ID="tbxDefaultReplyTo" runat="server" Width="450px"></asp:TextBox>
									</div>
									<asp:RequiredFieldValidator ID="rfvDefaultReplyTo" CssClass="smallInfo error" runat="server" resourcekey="required.ErrorMessage" ErrorMessage="Required!" ControlToValidate="tbxDefaultReplyTo" Display="Dynamic" ValidationGroup="vgEmailSettings" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
							</tr>
						</table>
					</asp:Panel>
					<asp:Panel ID="pnlEmailLog" runat="server" CssClass="edNews_numberedOptions" Visible="false">
						<div class="edNews_numberedOptionsHeader">
							<span class="edNews_numberedOptionsHeaderNumber">4</span>
							<h2><%=emailLog%></h2>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableLogFile.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableLogFile.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableLogFile.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbEnableLogFile" CssClass="normalCheckBox" Text="Enable log file" runat="server" Checked="false"></asp:CheckBox>
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>

					<asp:Panel ID="pnlEventRegistrationSettings" runat="server" CssClass="edNews_numberedOptions">
						<div class="edNews_numberedOptionsHeader">
							<span class="edNews_numberedOptionsHeaderNumber">4</span>
							<h2><%=_("EventRegistrationSettings.Text")%></h2>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEventRegistrationEnableCaptcha.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventRegistrationEnableCaptcha.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventRegistrationEnableCaptcha.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbEventRegistrationEnableCaptcha" CssClass="normalCheckBox" Text="Enable captcha" runat="server" Checked="false"></asp:CheckBox>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEventRegistrationTermsAndConditionsAgreement.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventRegistrationTermsAndConditionsAgreement.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventRegistrationTermsAndConditionsAgreement.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbEventRegistrationTermsAndConditionsAgreement" CssClass="normalCheckBox" Text=" " runat="server" Checked="false"></asp:CheckBox>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEventRegistrationEmailUseAgreement.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventRegistrationEmailUseAgreement.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEventRegistrationEmailUseAgreement.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbEventRegistrationEmailUseAgreement" CssClass="normalCheckBox" Text=" " runat="server" Checked="false"></asp:CheckBox>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbDoubleOptInUserVerification.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDoubleOptInUserVerification.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDoubleOptInUserVerification.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbDoubleOptInUserVerification" CssClass="normalCheckBox" Text="Double Opt-In User Verification" runat="server" Checked="true"></asp:CheckBox>
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>

					<div class="mainActions">
						<asp:Button ID="btnSaveEmailSettings" CssClass="downSave" resourcekey="btnSaveEmailSettings" runat="server" Text="Save settings" OnClick="btnSaveEmailSettings_Click" ValidationGroup="vgEmailSettings" CausesValidation="true" />
					</div>

					<asp:Label ID="lblEmailSettingsInfo" runat="server" EnableViewState="false" />

				</asp:Panel>

			</asp:Panel>

			<asp:Panel ID="pnlPaymentSettings" runat="server" class="sectionBox noPadding" Visible="false">
				<table class="optionsList fullWidthTable strippedTable noBorder">
					<tr>
						<td class="tdLabel">
							<label for="<%=cbEnableEventPayment.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableEventPayment.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableEventPayment.Text") %></label>
						</td>
						<td>
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbEnableEventPayment" runat="server" CssClass="normalCheckBox" OnCheckedChanged="cbEnableEventPayment_CheckedChanged" AutoPostBack="True" Text="Enable event payment" />
							</div>
						</td>
					</tr>
				</table>
				<asp:Panel ID="pnlBasicPaymentOption" runat="server" Visible="false">
					<table runat="server" id="PaymentOption" class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=rblTypeOfPayment.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTypeOfPayment.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTypeOfPayment.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup">
									<asp:RadioButtonList ID="rblTypeOfPayment" runat="server" OnSelectedIndexChanged="rblTypeOfPayment_SelectedIndexChanged" AutoPostBack="true" RepeatLayout="UnorderedList" CssClass="styledRadio inlineList smallRadio">
										<asp:ListItem Value="0" class="normalRadioButton" Text="Offline" Selected="True" />
										<asp:ListItem Value="1" class="normalRadioButton" Text="PayPal" />
									</asp:RadioButtonList>
								</div>
							</td>
						</tr>
					</table>
					<table runat="server" id="tblPayPalSettings" class="optionsList fullWidthTable strippedTable noBorder" visible="false">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxPayPalApyKey.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPayPalApyKey.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPayPalApyKey.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup inputWidth40">
									<asp:TextBox ID="tbxPayPalApyKey" runat="server"></asp:TextBox>
								</div>
								<asp:RequiredFieldValidator ID="rfvPayPalApyKey" CssClass="smallInfo error" runat="server" ControlToValidate="tbxPayPalApyKey" ErrorMessage="Required!" Display="Dynamic" ValidationGroup="vgSavePaymentSettings"></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=cbPayPalSandBoxMode.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPaypalSandBox.Help", true) %>" data-tooltip-position="top-right"><%=_("lblPaypalSandBox.Text") %></label>
							</td>
							<td>
								<div class="switchCheckbox">
									<asp:CheckBox ID="cbPayPalSandBoxMode" CssClass="normalCheckBox" Text="SandBox mode:" runat="server" Checked="true"></asp:CheckBox>
								</div>
							</td>
						</tr>
					</table>
					<table class="optionsList fullWidthTable strippedTable noBorder">
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlStoreCountry.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStoreCountry.Help", true) %>" data-tooltip-position="top-right"><%=_("lblStoreCountry.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlStoreCountry" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlStoreCountry_SelectedIndexChanged"></asp:DropDownList>
								<asp:RequiredFieldValidator ID="rfvStoreCountry" CssClass="smallInfo error" runat="server" ErrorMessage="Please select country" Display="Dynamic" ControlToValidate="ddlStoreCountry" ValidationGroup="vgSavePaymentSettings" InitialValue=""></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlStoreRegion.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStoreRegion.Help", true) %>" data-tooltip-position="top-right"><%=_("lblStoreRegion.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlStoreRegion" runat="server"></asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlDefaultCurrency.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDefaultCurrency.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDefaultCurrency.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlDefaultCurrency" runat="server"></asp:DropDownList>
							</td>
						</tr>
						<tr>
							<td class="tdLabel textTop">
								<label for="<%=rblSalesTaxVatSettings.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSalesTaxVatSettings.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSalesTaxVatSettings.Text") %></label>
							</td>
							<td>
								<div class="edNews_inputGroup">
									<asp:RadioButtonList ID="rblSalesTaxVatSettings" runat="server" OnSelectedIndexChanged="rblSalesTaxVatSettings_SelectedIndexChanged" AutoPostBack="true" RepeatLayout="UnorderedList" CssClass="styledRadio verticalList smallRadio">
										<asp:ListItem Value="0" class="normalRadioButton" Text="No" Selected="True" />
										<asp:ListItem Value="1" class="normalRadioButton" Text="Standard" />
										<asp:ListItem Value="2" class="normalRadioButton" Text="Home state only" />
										<asp:ListItem Value="3" class="normalRadioButton" Text="Tax by country" />
									</asp:RadioButtonList>
								</div>
							</td>
						</tr>
					</table>
					<table runat="server" id="tblHomeStateOnly" class="optionsList fullWidthTable strippedTable noBorder" visible="false">
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlHomeCountry.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHomeCountry.Help", true) %>" data-tooltip-position="top-right"><%=_("lblHomeCountry.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlHomeCountry" runat="server" OnSelectedIndexChanged="ddlHomeCountry_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
								<asp:RequiredFieldValidator ID="rfvHomeCountry" CssClass="smallInfo error" runat="server" ErrorMessage="Please select country" Display="Dynamic" ControlToValidate="ddlHomeCountry" ValidationGroup="vgSavePaymentSettings" InitialValue=""></asp:RequiredFieldValidator></td>
						</tr>
						<tr>
							<td class="tdLabel">
								<label for="<%=ddlHomeState.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHomeState.Help", true) %>" data-tooltip-position="top-right"><%=_("lblHomeState.Text") %></label>
							</td>
							<td>
								<asp:DropDownList ID="ddlHomeState" runat="server"></asp:DropDownList>
							</td>
						</tr>
					</table>
					<table runat="server" id="tblTaxRate" class="optionsList fullWidthTable strippedTable noBorder" visible="false">
						<tr>
							<td class="tdLabel">
								<label for="<%=tbxTaxRate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTaxRate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTaxRate.Text") %></label>
							</td>
							<td>
								<asp:TextBox ID="tbxTaxRate" runat="server"></asp:TextBox>%
								<asp:RequiredFieldValidator ID="rfvTaxRate" CssClass="smallInfo error" runat="server" ControlToValidate="tbxTaxRate" Display="Dynamic" ErrorMessage="This field is required." resourcekey="rfvTaxRate" SetFocusOnError="True" ValidationGroup="vgSavePaymentSettings" />
							</td>
						</tr>
					</table>
					<table runat="server" id="tblTaxTablesAddValue" class="optionsList fullWidthTable strippedTable noBorder" visible="false">
						<tr>
							<td class="tdLabel textTop">
								<label class="edNews_tooltip" data-tooltip-content="<%=_("lblAddTaxRate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAddTaxRate.Text") %></label>
							</td>
							<td>
								<div class="mainActions smallActions noMargin displayInline">
									<asp:Button ID="btnAddTaxRate" runat="server" CssClass="add" Text="Add tax" OnClick="btnAddTaxRate_Click" ValidationGroup="vgAddTaxRate" CausesValidation="true" />
								</div>
								<asp:GridView ID="gvEventsTaxes" runat="server" DataKeyNames="Country,Region" AutoGenerateColumns="false" CssClass="strippedTable textCenter" EnableModelValidation="True" GridLines="None" OnRowCommand="gvEventsTaxes_RowCommand">
									<Columns>
										<asp:TemplateField HeaderText="Country">
											<ItemTemplate>
												<asp:Label ID="lblCountry" runat="server" Text='<%# Eval("Country") %>' />
											</ItemTemplate>
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Region">
											<ItemTemplate>
												<asp:Label ID="lblRegion" runat="server" Text='<%# Eval("Region") %>' />
											</ItemTemplate>
										</asp:TemplateField>
										<asp:TemplateField HeaderText="Tax">
											<ItemTemplate>
												<asp:Label ID="lblTax" runat="server" Text='<%# Eval("TaxValue") %>' />&nbsp;%
											</ItemTemplate>
										</asp:TemplateField>
										<asp:TemplateField>
											<ItemTemplate>
												<div class="itemActions">
													<asp:LinkButton ID="lbRemoveTax" runat="server" CssClass="deleteAction" CausesValidation="false" CommandArgument='<%# Container.DataItemIndex %>' CommandName="Remove" OnClientClick="return confirm('Are you sure you want to remove this tax?');" Text="Remove" resourcekey="lbRemoveTax"></asp:LinkButton>
												</div>
											</ItemTemplate>
										</asp:TemplateField>
									</Columns>
									<HeaderStyle CssClass="tableHeader" />
								</asp:GridView>
							</td>
						</tr>
					</table>
				</asp:Panel>
				<div class="mainActions">
					<asp:Button ID="btnSavePaymentSettings" resourcekey="btnSavePaymentSettings" CssClass="downSave" runat="server" Text="Save settings" OnClick="btnSavePaymentSettings_Click" ValidationGroup="vgSavePaymentSettings" CausesValidation="true" />
				</div>
				<asp:Label ID="lblSavePaymentSettingsInfo" runat="server" EnableViewState="false" />
			</asp:Panel>
		</div>
	</div>
</asp:Panel>
<asp:Literal ID="generatedHtm" runat="server" Visible="False" />
<script type="text/javascript">
	// <![CDATA[
	<%=includeRegistrationDatePickerJS%>;

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
				if (options[i].checked) {
					checkedValues += options[i].value + ',';
				}
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

	function ShowValue() {
		var dropdownList;

		eds2_2("#<%=gvArticleList.ClientID %> select[id*='ddlFotterActionForSelected']").each(function (index) {
			dropdownList = eds2_2(this);
		});

		if (dropdownList.val() == '-1') {
			alert('<%=selectAction%>');
		}
		else {
			return confirm('<%=confirmation%>');
		}
	}

	function ShowValueEventAttendess() {
		var dropdownList;

		eds2_2("#<%=gvEventAttendess.ClientID %> select[id*='ddlFotterActionForSelected']").each(function (index) {
			dropdownList = eds2_2(this);
		});

		if (dropdownList.val() == '-1') {
			alert('<%=selectAction%>');
		}
		else {
			return confirm('<%=confirmation%>');
		}
	}

	function GridViewActions_Init() {
		var $gvArticleList = $('#<%= gvArticleList.ClientID%>');

		$('[id*=ibFooterSelectAll]', $gvArticleList).on("click", function () {
			$('[id*=cbSelectRow]', $gvArticleList).each(function () {
				$(this).prop("checked", "checked");
			});
		});

		$('[id*=ibFooterUnSelectAll]', $gvArticleList).on("click", function () {
			$('[id*=cbSelectRow]', $gvArticleList).each(function () {
				$(this).removeProp("checked");
			});
		});

		var $gvEventAttendess = $('#<%= gvEventAttendess.ClientID%>');

		$('[id*=ibFooterSelectAll]', $gvEventAttendess).on("click", function () {
			$('[id*=cbSelectRow]', $gvEventAttendess).each(function () {
				$(this).prop("checked", "checked");
			});
		});

		$('[id*=ibFooterUnSelectAll]', $gvEventAttendess).on("click", function () {
			$('[id*=cbSelectRow]', $gvEventAttendess).each(function () {
				$(this).removeProp("checked");
			});
		});

		eds2_2('[id*=datePickerSearchFromDate]', eds2_2('#<%= pnlListOfEventsWithEnabledRegistration.ClientID%>')).each(function () {
			eds2_2(this).datetimepicker({
				sideBySide: false,
				showTodayButton: false,
				showClear: false,
				allowInputToggle: true,
				<%=(string.IsNullOrEmpty(selectedLang) ? "" : ("locale: '" + selectedLang + "', "))%>
			});
		});
	}

	eds2_2(document).ready(function ($) {

		GridViewActions_Init();

		$('#<%=pnlArticleListWrapper.ClientID%>').delegate('#<%=hlArticleFilterToggle.ClientID %>', 'click', function () {
			var toggle = $(this),
				filter_settings = $('#<%=pnlArticleFilterSettings.ClientID %>'),
				filter_settings_state = $('#<%=hfFilterSettingsState.ClientID %>');

			if (toggle.hasClass('edNews__open')) {
				toggle.removeClass('edNews__open');
				filter_settings.slideUp(200);
				filter_settings_state.val('closed');
			} else {
				toggle.addClass('edNews__open');
				filter_settings.slideDown(200);
				filter_settings_state.val('open');
			}
			return false;
		});
	});

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			GridViewActions_Init();
			eds2_2('.edNews_tooltip').eds_tooltipster();
		}
	}
	// ]]>
</script>
<asp:ObjectDataSource ID="odsGetPagedArticlesByUser" runat="server" SelectMethod="GetEventsWithRegistration" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.Events.EventsDataDB" EnablePaging="True" MaximumRowsParameterName="numberOfPostsperPage" SelectCountMethod="GetEventsWithRegistrationCount"
	StartRowIndexParameterName="startingArticle" OnSelecting="odsGetPagedArticlesByUser_Selecting" OnSelected="odsGetPagedArticlesByUser_Selected">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="UserID" Type="Int32" />
		<asp:Parameter Name="OnlyOneCategory" Type="Int32" />
		<asp:Parameter Name="FilterByAuthor" Type="Int32" />
		<asp:Parameter Name="FilterByGroupID" Type="Int32" />
		<asp:Parameter Name="EditOnlyAsOwner" Type="Boolean" />
		<asp:Parameter Name="UserCanApprove" Type="Boolean" />
		<asp:Parameter Name="Perm_ViewAllCategores" Type="Boolean" />
		<asp:Parameter Name="Perm_EditAllCategores" Type="Boolean" />
		<asp:Parameter Name="AdminOrSuperUser" Type="Boolean" />
		<asp:Parameter Name="PermissionSettingsSource" Type="Boolean" />
		<asp:Parameter Name="OrderBy" Type="String" />
		<asp:Parameter Name="OrderBy2" Type="String" />
		<asp:Parameter Name="Featured" Type="Int32" />
		<asp:Parameter Name="Payed" Type="Int32" />
		<asp:Parameter Name="Published" Type="Int32" />
		<asp:Parameter Name="Approved" Type="Int32" />
		<asp:Parameter Name="ArticleType" Type="Int32" />
		<asp:Parameter Name="PermissionsByArticle" Type="Int32" />
		<asp:Parameter Name="StartDate" Type="DateTime" />
		<asp:Parameter Name="startingArticle" Type="Int32" />
		<asp:Parameter Name="numberOfPostsperPage" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetPostSettings" runat="server" SelectMethod="GetPostSettings" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.Events.EventsDataDB" EnablePaging="True" MaximumRowsParameterName="numberOfPostsperPage" SelectCountMethod="GetPostSettingsCount"
	StartRowIndexParameterName="startingArticle" OnSelecting="odsGetPostSettings_Selecting" OnSelected="odsGetPostSettings_Selected" DeleteMethod="DeleteEventPostSetting">
	<DeleteParameters>
		<asp:Parameter Name="Id" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ArticleID" Type="Int32" />
		<asp:Parameter Name="RecurringID" Type="Int32" />
		<asp:Parameter Name="PostType" Type="Byte" />
		<asp:Parameter Name="startingArticle" Type="Int32" />
		<asp:Parameter Name="numberOfPostsperPage" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetListOfAttendess" runat="server" SelectMethod="GetEventAttendess" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.Events.EventsDataDB" EnablePaging="True" MaximumRowsParameterName="numberOfPostsperPage" SelectCountMethod="GetEventAttendessCount"
	StartRowIndexParameterName="startingArticle" OnSelecting="odsGetListOfAttendess_Selecting" OnSelected="odsGetListOfAttendess_Selected">
	<SelectParameters>
		<asp:Parameter Name="ArticleID" Type="Int32" />
		<asp:Parameter Name="RecurringID" Type="Int32" />
		<asp:Parameter Name="startingArticle" Type="Int32" />
		<asp:Parameter Name="numberOfPostsperPage" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
