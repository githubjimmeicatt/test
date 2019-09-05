<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.ArticleEditor, App_Web_articleeditor.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Import Namespace="EasyDNNSolutions.Modules.EasyDNNNews" %>
<asp:Panel ID="pnlMainWrapper" runat="server" CssClass="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div id="EDNadmin" class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=ArticleManager%></span>
		</div>
		<asp:UpdatePanel ID="upMainAjax" runat="server" OnUnload="UpdatePanel_Unload">
			<ContentTemplate>
				<div class="edNews_adminProgressOverlayWrapper">
					<asp:UpdateProgress ID="uppMainAjax" runat="server" AssociatedUpdatePanelID="upMainAjax" DisplayAfter="100" DynamicLayout="true">
						<ProgressTemplate>
							<div class="edNews_adminProgressOverlay"></div>
						</ProgressTemplate>
					</asp:UpdateProgress>
					<asp:Panel ID="pnlArticleListWrapper" runat="server">
						<div class="sectionBox noPadding sectionBox2">
							<asp:Panel ID="hlArticleFilterToggle" runat="server" CssClass="sectionBoxHeader edNews__toggleWrapper">
								<asp:HyperLink ID="hlArticleFilterToggleLink" runat="server" CssClass="sectionBoxHeaderTitle edNews__toggle" href="#" Text="Show filter settings" resourcekey="hlArticleFilterToggleResource1" />
							</asp:Panel>
							<asp:Panel ID="pnlArticleFilterSettings" runat="server" class="edNews__toggledContent">
								<div class="edNews_twoColumns noBorder">
									<div>
										<div class="sectionBox noPadding">
											<div class="sectionBoxSubtitle textLeft">
												<span><%=Filterby%></span>
											</div>
											<div class="edNews_OptionBoxes">
												<asp:Panel ID="pnlCategoryFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByCategory" runat="server" Text="Category" CssClass="normalCheckBox" resourcekey="cbFilterByCategoryResource1" />
													</div>
													<label for="<%=cbFilterByCategory.ClientID %>"><%=_("cbFilterByCategoryResource1.Text") %></label>
													<asp:Panel runat="server" ID="divCategoryFilterList" class="edNews__styledSelect"></asp:Panel>
													<asp:HiddenField runat="server" ID="hfSelectedFilterCategories" />
												</asp:Panel>
												<asp:Panel ID="pnlGroupOrAuthorFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByGroupOrAuthor" runat="server" Text="Group or Author" CssClass="normalCheckBox" OnCheckedChanged="cbFilterByGroupOrAuthor_CheckedChanged" AutoPostBack="True" resourcekey="cbFilterByGroupOrAuthor" />
													</div>
													<label for="<%=cbFilterByGroupOrAuthor.ClientID %>"><%=_("cbFilterByGroupOrAuthor.Text") %></label>
													<asp:DropDownList ID="ddlFilterByGroupOrAuthor" runat="server" Enabled="False">
														<asp:ListItem Value="-1" Text="Select group or author" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlPublishFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByPublish" runat="server" CssClass="normalCheckBox" Text="Published" resourcekey="cbFilterByPublishResource1" />
													</div>
													<label for="<%=cbFilterByPublish.ClientID %>"><%=_("cbFilterByPublishResource1.Text") %></label>
													<asp:DropDownList ID="ddlFilterByPublish" runat="server">
														<asp:ListItem Value="True" resourcekey="ListItemResource5" Text="Published" />
														<asp:ListItem Value="False" resourcekey="ListItemResource6" Text="Unpublished" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlApprovedFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByApproved" runat="server" CssClass="normalCheckBox" Text="Approved" resourcekey="cbFilterByApprovedResource1" />
													</div>
													<label for="<%=cbFilterByApproved.ClientID %>"><%=_("cbFilterByApprovedResource1.Text") %></label>
													<asp:DropDownList ID="ddlFilterByApproved" runat="server">
														<asp:ListItem Value="True" resourcekey="ListItemResource7" Text="Approved " />
														<asp:ListItem Value="False" resourcekey="ListItemResource8" Text="Unapproved" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlFeaturedFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByFeatured" runat="server" CssClass="normalCheckBox" Text="Featured" resourcekey="cbFilterByFeaturedResource1" />
													</div>
													<label for="<%=cbFilterByFeatured.ClientID %>"><%=_("cbFilterByFeaturedResource1.Text") %></label>
													<asp:DropDownList ID="ddlFilterByFeatured" runat="server">
														<asp:ListItem Value="True" resourcekey="ListItemResource9" Text="Featured" />
														<asp:ListItem Value="False" resourcekey="ListItemResource10" Text="Unfeatured" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlArticleTypeFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByArticleType" runat="server" CssClass="normalCheckBox" Text="Article type" resourcekey="cbFilterByArticleType" />
													</div>
													<label for="<%=cbFilterByArticleType.ClientID %>"><%=_("cbFilterByArticleType.Text") %></label>
													<asp:DropDownList ID="ddlFilterByArticleType" runat="server">
														<asp:ListItem resourcekey="liNews" Value="News" Text="News" />
														<asp:ListItem resourcekey="liEvents" Value="Events" Text="Events" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlPermissionsByArticleFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbFilterByPermissionsByArticle" runat="server" CssClass="normalCheckBox" Text="Permissions per article" resourcekey="cbFilterByPermissionsByArticle" />
													</div>
													<label for="<%=cbFilterByPermissionsByArticle.ClientID %>"><%=_("cbFilterByPermissionsByArticle.Text") %></label>
													<asp:DropDownList ID="ddlFilterByPermissionsByArticle" runat="server">
														<asp:ListItem Value="True" resourcekey="liEnabled" Text="Enabled" />
														<asp:ListItem Value="False" resourcekey="liDisabled" Text="Disabled" />
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlCustomFieldsTemplateFilter" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbCustomFieldsTemplateFilter" runat="server" CssClass="normalCheckBox" Text="Custom fields template" resourcekey="cbCustomFieldsTemplateFilter" />
													</div>
													<label for="<%=cbCustomFieldsTemplateFilter.ClientID %>"><%=_("cbCustomFieldsTemplateFilter.Text") %></label>
													<asp:DropDownList ID="ddlCustomFieldsTemplateFilter" runat="server">
													</asp:DropDownList>
												</asp:Panel>
												<asp:Panel ID="pnlSearchTerm" runat="server" CssClass="dis_box">
													<div class="switchCheckbox">
														<asp:CheckBox ID="cbSearchTerm" runat="server" CssClass="normalCheckBox" Text="Search" resourcekey="cbSearchTerm" />
													</div>
													<label for="<%=cbSearchTerm.ClientID %>"><%=_("cbSearchTerm.Text") %></label>
													<asp:TextBox ID="tbSearchTerm" runat="server" Text="" />
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
														<asp:ListItem Value="-1" resourcekey="ListItemResource11">Order by</asp:ListItem>
														<asp:ListItem Value="PublishDate" resourcekey="ListItemResource12">Publish date</asp:ListItem>
														<asp:ListItem Value="NumberofViews" resourcekey="ListItemResource13">Number of Views</asp:ListItem>
														<asp:ListItem Value="RatingValue" resourcekey="ListItemResource14">Rating</asp:ListItem>
														<asp:ListItem Value="DateAdded" resourcekey="ListItemResource15">Date added</asp:ListItem>
														<asp:ListItem Value="ExpireDate" resourcekey="ListItemResource16">Expire date</asp:ListItem>
														<asp:ListItem Value="LastModified" resourcekey="ListItemResource17">Last modified</asp:ListItem>
														<asp:ListItem Value="NumberOfComments" resourcekey="ListItemResource18">Number of comments</asp:ListItem>
														<asp:ListItem Value="Title" resourcekey="ListItemResource19">Title</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlOrderType" runat="server">
														<asp:ListItem Value="ASC" resourcekey="ListItemResource20">Ascending</asp:ListItem>
														<asp:ListItem Value="DESC" resourcekey="ListItemResource21">Descending</asp:ListItem>
													</asp:DropDownList>
												</div>
												<div>
													<asp:DropDownList ID="ddlOrderBySecond" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlOrderBySecond_SelectedIndexChanged">
														<asp:ListItem Value="-1" resourcekey="ListItemResource22">Order by</asp:ListItem>
														<asp:ListItem Value="PublishDate" resourcekey="ListItemResource23">Publish date</asp:ListItem>
														<asp:ListItem Value="NumberofViews" resourcekey="ListItemResource24">Number of Views</asp:ListItem>
														<asp:ListItem Value="RatingValue" resourcekey="ListItemResource25">Rating</asp:ListItem>
														<asp:ListItem Value="DateAdded" resourcekey="ListItemResource26">Date added</asp:ListItem>
														<asp:ListItem Value="ExpireDate" resourcekey="ListItemResource27">Expire date</asp:ListItem>
														<asp:ListItem Value="LastModified" resourcekey="ListItemResource28">Last modified</asp:ListItem>
														<asp:ListItem Value="NumberOfComments" resourcekey="ListItemResource29">Number of comments</asp:ListItem>
														<asp:ListItem Value="Title" resourcekey="ListItemResource30">Title</asp:ListItem>
													</asp:DropDownList>
													<asp:DropDownList ID="ddlOrderTypeSecond" runat="server">
														<asp:ListItem Value="ASC" resourcekey="ListItemResource31">Ascending</asp:ListItem>
														<asp:ListItem Value="DESC" resourcekey="ListItemResource32">Descending</asp:ListItem>
													</asp:DropDownList>
												</div>
												<div>
													<div class="edNews_inputGroup noWidthLabel">
														<asp:Label ID="lblFilterStartDate" runat="server" Text="Event start date:" AssociatedControlID="tbxFilterStartDate" resourcekey="lblFilterStartDate" />
														<div class="input-group input-append date" id="datePickerSearchFromDate" runat="server">
															<asp:TextBox ID="tbxFilterStartDate" runat="server" CssClass="form-control" ValidationGroup="vgEditArticle" />
															<span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="mainActions noMargin">
									<asp:LinkButton ID="btnFilerArticles" class="filterAction" runat="server" OnClick="btnFilerArticles_Click" resourcekey="btnFilerArticlesResource1"></asp:LinkButton>
								</div>
								<asp:HiddenField ID="hfFilterSettingsState" runat="server" Value="closed" />
							</asp:Panel>
						</div>
						<div class="sectionBox noPadding">
							<asp:GridView ID="gvArticleList" runat="server" AllowPaging="True" AllowSorting="False" AutoGenerateColumns="False" DataKeyNames="ArticleID,IsRecurring" DataSourceID="odsGetPagedArticlesByUser" EnableModelValidation="True"
								OnRowCommand="gvArticleList_RowCommand" ShowFooter="True" OnPreRender="gvArticleList_PreRender" CssClass="strippedTable fullWidthTable noBorder tablePadding5">
								<Columns>
									<asp:TemplateField>
										<FooterTemplate>
											<span class="floatRight smallText" style="margin-top: 17px;"><%#TotalCount%></span>
											<i class="fa fa-mail-reply fa-rotate-180"></i>
											<div class="mainActions noMargin smallActions displayInline">
												<a id="ibFooterSelectAll" class="secondaryAction"><i class="fa fa-list-alt"></i><%=_("ibFooterSelectAllResource1") %></a>
												<a id="ibFooterUnSelectAll" class="secondaryAction"><i class="fa fa-times-circle-o"></i><%=_("ibFooterUnSelectAllResource1") %></a>
											</div>
											<div class="edNews_inputGroup displayInline">
												<asp:DropDownList ID="ddlFotterActionForSelected" runat="server" Visible="<%#!ApproveMode%>" AutoPostBack="true" OnSelectedIndexChanged="ddlFotterActionForSelected_SelectedIndexChanged">
													<asp:ListItem resourcekey="liSelectAction" Value="-1" Text="Select action" />
													<asp:ListItem resourcekey="ListItemResource33" Value="Publish" Text="Publish" />
													<asp:ListItem resourcekey="ListItemResource34" Value="Unpublish" Text="Unpublish" />
													<asp:ListItem resourcekey="ListItemResource35" Value="Delete" Text="Delete" />
													<asp:ListItem resourcekey="ListItemResource36" Value="Approve" Text="Approve" />
													<asp:ListItem resourcekey="ListItemResource37" Value="Unapprove" Text="Unapprove" />
													<asp:ListItem resourcekey="ListItemResource38" Value="Feature" Text="Feature" />
													<asp:ListItem resourcekey="ListItemResource39" Value="Unfeature" Text="Unfeature" />
													<asp:ListItem resourcekey="liChangePublishDate" Value="ChangePublishDate" Text="Change publish date" />
													<asp:ListItem resourcekey="liChangeExpireDate" Value="ChangeExpireDate" Text="Change expire date" />
													<asp:ListItem resourcekey="liMoveToCategories" Value="MoveToCategories" Text="Move to categories" />
													<asp:ListItem resourcekey="liCopyToCategories" Value="CopyToCategories" Text="Copy to categories" />
												</asp:DropDownList>
												<asp:DropDownList ID="ddlFotterActionForSelectedApprove" runat="server" Visible="<%#ApproveMode%>">
													<asp:ListItem resourcekey="liSelectAction" Value="-1" Text="Select action" />
													<asp:ListItem resourcekey="ListItemResource36" Value="Approve" Text="Approve" />
													<asp:ListItem resourcekey="ListItemResource37" Value="Unapprove" Text="Unapprove" />
												</asp:DropDownList>

												<asp:Panel runat="server" ID="divFotterCategoryFilterList" class="edNews__styledSelect" Style="display: none"></asp:Panel>
												<asp:HiddenField runat="server" ID="hfFotterSelectedFilterCategories" />
											</div>
											<asp:Panel ID="pnlPublishExpireDate" class="edNews_inputGroup displayInline" runat="server" Visible="false">
												<div class="input-group input-append date" id="datePickerSearchFromDate" runat="server">
													<asp:TextBox ID="tbPublishExpireDate" runat="server" CssClass="form-control" ValidationGroup="vgGVArticleListFutter" />
													<span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
												</div>
												<asp:RequiredFieldValidator ID="rfvPublishExpireDate" runat="server" ControlToValidate="tbPublishExpireDate" CssClass="smallInfo error" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgGVArticleListFutter" />
												<asp:Label ID="lblPubDateError" ResourceKey="lblPubDateError" runat="server" ForeColor="Red" Text="Invalid date." Visible="false" />
											</asp:Panel>
											<div class="mainActions noMargin smallActions displayInline">
												<asp:Button ID="ibFooterOK" runat="server" CssClass="primaryAction" ValidationGroup="vgGVArticleListFutter" CausesValidation="true" OnClick="ibFooterOK_Click" OnClientClick="return ShowValue();" resourcekey="ok" />
											</div>
										</FooterTemplate>
										<ItemTemplate>
											<asp:HiddenField ID="hfMainArticleID" runat="server" Value='<%# Bind("ArticleID") %>' />
											<div class="styledCheckbox noLabel">
												<asp:CheckBox ID="cbSelectRow" runat="server" Text="Select Row" />
											</div>
										</ItemTemplate>
										<ItemStyle Width="30px" CssClass="textCenter" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Action">
										<ItemTemplate>
											<div class="edNews_boxedActions edNews_threeInRow">
												<asp:HyperLink ID="hlEditThisArticle" runat="server" CssClass="edNews_aaEdit edNews_tooltip" NavigateUrl='<%# GetArticleEditUrl(Convert.ToInt32(Eval("ArticleID")), Eval("IsRecurring")) %>' resourcekey="lbEditThisArticleResource1" Visible="<%#!ApproveMode%>" data-tooltip-content="<%#EditToolTip%>" data-tooltip-position="top-left"></asp:HyperLink>
												<asp:LinkButton ID="lbDeleteArticle" runat="server" CssClass="edNews_aaDelete edNews_tooltip" CausesValidation="False" CommandArgument='<%# Eval("ArticleID") %>' CommandName="DeleteArticle" Visible="<%#!ApproveMode%>" data-tooltip-content="<%#DeleteTooltip%>" data-tooltip-position="top-left" />
												<asp:HyperLink ID="hlPreviewArticle" runat="server" CssClass="edNews_aaView edNews_tooltip" NavigateUrl='<%# GetArticleUrl(Convert.ToInt32(Eval("ArticleID")), Eval("IsRecurring")) %>' Target="_blank" data-tooltip-content="<%#ViewTooltip%>" data-tooltip-position="top-left"></asp:HyperLink>
												<asp:HyperLink ID="hlEditComments" runat="server" CssClass="edNews_aaComments edNews_tooltip" resourcekey="hlEditCommentsResource1" NavigateUrl='<%# GetEditCommentsUrl(Convert.ToInt32(Eval("ArticleID"))) %>' Target="_self" Visible="<%#!ApproveMode%>" data-tooltip-content="<%#ViewCommentsTooltip%>" data-tooltip-position="bottom-left" />
												<asp:HyperLink ID="hlCreateNewArticle" runat="server" CssClass="edNews_aaCreateAsNew edNews_tooltip" resourcekey="hlCreateNewArticleResource1" NavigateUrl='<%# GetArticleCopyUrl(Convert.ToInt32(Eval("ArticleID"))) %>' Target="_blank" Visible="<%#!ApproveMode%>" data-tooltip-content="<%#CopyArticleTooltip%>" data-tooltip-position="bottom-left" />
												<asp:HyperLink ID="hlLocalizeArticle" runat="server" CssClass="edNews_aaLocalization edNews_tooltip" NavigateUrl='<%# GetArticleLocalizeUrl(Convert.ToInt32(Eval("ArticleID")), Eval("IsRecurring")) %>' resourcekey="hlLocalizeArticleResource1" Visible="<%#!ApproveMode%>" data-tooltip-content="<%#LocalizeArticleToolTip%>" data-tooltip-position="bottom-left"></asp:HyperLink>
												<asp:HiddenField ID="hfRegistrationEnabled" runat="server" Value='<%#Convert.ToBoolean(Eval("RegistrationEnabled"))%>' />
												<asp:HiddenField ID="hfEventArticle" runat="server" Value='<%#Convert.ToBoolean(Eval("EventArticle"))%>' />
											</div>
										</ItemTemplate>
										<ItemStyle Width="100px" CssClass="textCenter" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Title">
										<ItemTemplate>
											<asp:Panel ID="pnlArticleImage" runat="server" CssClass="edNews_thumb width60 floatLeft" Visible='<%# GetArticleImageURLVisible(Convert.ToInt32(Eval("ArticleID")),Convert.ToString(Eval("ArticleImage"))) %>'>
												<asp:Image ID="imgArticleImage" runat="server" ImageUrl='<%# GetArticleImageURL(Convert.ToInt32(Eval("ArticleID")),Convert.ToString(Eval("ArticleImage"))) %>' />
											</asp:Panel>
											<span><%# Eval("Title") %></span>
											<span class="edNews_articleTableSubTitle"><%# Eval("SubTitle") %></span>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Article dates">
										<ItemTemplate>
											<p>
												<span class="edNews_articleDates edNews_PubDate edNews_tooltip" data-tooltip-content="<%#PublishDateTooltip%>" data-tooltip-position="top-left"><%# GetFormatedDate(Convert.ToDateTime(Eval("PublishDate")))%></span>
											</p>
											<p>
												<span class="edNews_articleDates edNews_ExpireDate edNews_tooltip" data-tooltip-content="<%#ExpireDateToolTip%>" data-tooltip-position="top-left"><%# GetFormatedDate(Convert.ToDateTime(Eval("ExpireDate")))%></span>
											</p>
											<p>
												<span class="edNews_articleDates edNews_LastModified edNews_tooltip" data-tooltip-content="<%#LastModifiedTooltip%>" data-tooltip-position="top-left"><%# GetFormatedDate(Convert.ToDateTime(Eval("LastModified")))%></span>
											</p>
											<%# GetStartFormatedDate(Eval("EventStartDate"), Eval("IsRecurring"))%>
										</ItemTemplate>
										<HeaderStyle Width="180px" CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Info">
										<ItemTemplate>
											<span class="edNews_infoColUser"><%# Eval("DisplayName")%></span>
											<asp:Label ID="lblIsEvent" resourcekey="lblIsEvent" runat="server" CssClass="edNews_eventArticle" Visible='<%#Convert.ToBoolean(Eval("EventArticle"))%>' Text="Event" />
											<asp:Label ID="lblHasRegistration" resourcekey="lblHasRegistration" runat="server" CssClass="edNews_registrationEnabled" Visible='<%#Convert.ToBoolean(Eval("RegistrationEnabled"))%>' Text="Registration" />
											<asp:Label ID="lblHasPayment" resourcekey="lblHasPayment" runat="server" CssClass="edNews_paymentEnabled" Visible='<%# Convert.ToBoolean(Eval("PaymentEnabled"))%>' Text="Payment" />
											<asp:Label ID="lblPermissionsPerArticle" resourcekey="lblPermissionsPerArticle" CssClass="edNews_permissionsPerArticle" runat="server" Visible='<%#Convert.ToBoolean(Eval("HasPermissions"))%>' Text="Permissions per article" />
										</ItemTemplate>
										<ItemStyle CssClass="edNews_infoCol" />
										<HeaderStyle Width="150px" CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Stats">
										<ItemTemplate>
											<asp:Label ID="lblArticleListViewCount" runat="server" CssClass="edNews_statColViews edNews_tooltip" Text='<%# Bind("NumberOfViews") %>' data-tooltip-content="<%#NumberOfViewTooltip%>" data-tooltip-position="top-left"></asp:Label>
											<asp:Label ID="lblArticleListCurrentRating" runat="server" CssClass="edNews_statColCurrentRating edNews_tooltip" Text='<%# String.Format("{0:.00}",Eval("RatingValue")) %>' data-tooltip-content="<%#RatigTooltip%>" data-tooltip-position="top-left"></asp:Label>
											<asp:Label ID="lblArticleListCommentCount" runat="server" CssClass="edNews_statColCommentCount edNews_tooltip" Text='<%# Bind("NumberOfCOmments") %>' data-tooltip-content="<%#NumberOfCommentsTooltip%>" data-tooltip-position="top-left"></asp:Label>
										</ItemTemplate>
										<ItemStyle CssClass="edNews_statsCol" />
										<HeaderStyle Width="100px" CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Action">
										<ItemTemplate>
											<div class="itemActions displayBlock">
												<asp:LinkButton ID="lbArticleListPublished" runat="server" CommandArgument='<%# Eval("ArticleID") %>' CommandName="Publish" CssClass='<%# GetIconClas(Convert.ToBoolean(Eval("Active"))) %>' resourcekey="lbArticleListPublishedResource1" Visible="<%#!ApproveMode%>">
													<asp:Label runat="server" Text="Published" ID="lblArticleListPublished" resourcekey="lblArticleListPublishedResource1" />
												</asp:LinkButton>
												<asp:LinkButton ID="lbArticleListApproved" runat="server" CommandArgument='<%# Eval("ArticleID") %>' CommandName="Approve" CssClass='<%# GetIconClas(Convert.ToBoolean(Eval("Approved"))) %>' Enabled="<%# EnableApprove() %>" resourcekey="lbArticleListApprovedResource1">
													<asp:Label runat="server" Text="Approved" ID="lblArticleListApproved" resourcekey="lblArticleListApprovedResource1"></asp:Label>
												</asp:LinkButton>
												<asp:LinkButton ID="lbArticleListFeatured" runat="server" CommandArgument='<%# Eval("ArticleID") %>' CommandName="Feature" CssClass='<%# GetIconClas(Convert.ToBoolean(Eval("Featured"))) %>' resourcekey="lbArticleListFeaturedResource1" Enabled="<%# EnabledFeatured() %>" Visible="<%#!ApproveMode%>">
													<asp:Label runat="server" Text="Featured" ID="lblArticleListFeatured" resourcekey="lblArticleListFeaturedResource1" />
												</asp:LinkButton>
												<asp:LinkButton ID="lbArticleListReject" resourcekey="lbArticleListReject" Visible='<%# GetRejectVisible(Convert.ToBoolean(Eval("Approved")),Convert.ToBoolean(Eval("Active"))) %>' runat="server" CommandArgument='<%# Eval("ArticleID") %>' CommandName="Reject" CssClass="rejectAction" Enabled="<%# EnableApprove() %>">
													<asp:Label runat="server" Text="Reject" ID="lblArticleListReject" />
												</asp:LinkButton>
											</div>
											<asp:Panel runat="server" ID="pnlRejectMessage" Visible="false" CssClass="edNews_popUp edNews_bottomLeft">
												<div class="edNews_inputGroup">
													<div class="floatingLabel">
														<asp:TextBox ID="tbRejectMessage" runat="server" TextMode="MultiLine"></asp:TextBox>
														<asp:Label ID="lblRejectMessage" runat="server" AssociatedControlID="tbRejectMessage" Text="Explain why the article was rejected:"></asp:Label>
													</div>
												</div>
												<div class="mainActions smallActions displayInline noMargin">
													<asp:LinkButton ID="lbRejectWMwssage" CssClass="primaryAction" CommandArgument='<%# Eval("ArticleID") %>' CommandName="RejectWithMessage" runat="server" resourcekey="Reject">Reject</asp:LinkButton>
													<asp:LinkButton ID="lbCancelRejectWMwssage" CssClass="cancel" CommandName="Cancel" runat="server" resourcekey="Cancel">Cancel</asp:LinkButton>
												</div>
											</asp:Panel>
										</ItemTemplate>
										<ItemStyle CssClass="tdActions edNews_popUpContainer" />
									</asp:TemplateField>
								</Columns>
								<PagerStyle CssClass="contentPagination" />
								<HeaderStyle CssClass="tableHeader2 highlighted" />
							</asp:GridView>
							<div class="edNews_numberOfRows" runat="server" id="divGvPagingSelection">
								<div>
									<asp:Label ID="lblFooterSelectNumberOfRows" AssociatedControlID="ddlFooterNumberOfRows" runat="server" Text="Number of rows:" resourcekey="lblFooterSelectNumberOfRowsResource1" />
									<asp:DropDownList ID="ddlFooterNumberOfRows" runat="server" OnSelectedIndexChanged="ddlFooterNumberOfRows_SelectedIndexChanged" AutoPostBack="True">
										<asp:ListItem resourcekey="ListItemResource40" Text="10" Value="10" />
										<asp:ListItem resourcekey="ListItemResource41" Text="20" Value="20" />
										<asp:ListItem resourcekey="ListItemResource42" Text="30" Value="30" />
										<asp:ListItem resourcekey="ListItemResource43" Text="50" Value="50" />
										<asp:ListItem resourcekey="ListItemResource44" Text="100" Value="100" />
									</asp:DropDownList>
								</div>
							</div>
							<asp:Panel ID="pnlNoArticlesMatched" runat="server" class="infoMessages info topMargin" Visible="False">
								<asp:Literal ID="liInfoArticleCount" runat="server" />
							</asp:Panel>
						</div>
					</asp:Panel>
					<asp:Panel ID="pnlNoArticles" CssClass="sectionBox" runat="server" Visible="False">
						<div class="sectionBoxSubtitle highlighted3">
							<span>
								<asp:Literal ID="liInfoArticleCount2" runat="server" /></span>
						</div>
						<div class="mainActions">
							<asp:HyperLink ID="hlAddNewArticle" runat="server" CssClass="add" resourcekey="hlAddNewArticleResource1">Add an article</asp:HyperLink>
						</div>
					</asp:Panel>
				</div>
			</ContentTemplate>
		</asp:UpdatePanel>
	</div>
</asp:Panel>
<asp:Literal ID="generatedHtm" runat="server" Visible="False" />
<script type="text/javascript">
	eds2_2(document).on('click', function (e) {
		eds2_2('.edNews__styledSelect')
			.not(eds2_2('.edNews__styledSelect').has(eds2_2(e.target)))
			.removeClass('edNews_selectOpen');
	});

	var CategoryDll_Init = function (placeHolderId, hiddenFieldId) {
		var $divCategoryFilterList = eds2_2('#' + placeHolderId),
			$hfSelectedFilterCategories = eds2_2('#' + hiddenFieldId),
			edn_all_categories = <%=GetAllCategoriesObject() %>,
			toInteger = function (number) {
				return Math.round(Number(number));
			},
			resizeDropDown = function () {
				var $dropDown = eds2_2('.edNews__dropdown', $divCategoryFilterList);
				if ($dropDown.length > 0) {
					var $windowheight = eds2_2(window).height();
					var maxHeight = $windowheight - $dropDown.offset().top - eds2_2(window).scrollTop() - (0.03 * $windowheight);
					if (maxHeight < 100)
						maxHeight = 100;
					$dropDown.attr('style', 'max-height:' + (toInteger(maxHeight)) + 'px');
				}
			},
			generate_category_list_items = function (selected_categories, items) {
				var all_categories = jQuery.extend(true, [], items),
					category_list = '',
					i = 0,
					selected;

				category_list += "<span class='edNews_defaultOption'><%=_("ListItemResource2.Text", true) %></span>";
				category_list += "<div><div class='edNews__dropdown'>";
				category_list += '<ul>';

				for (; i < all_categories.length; i++) {
					selected = selected_categories.indexOf(',' + all_categories[i].id + ',') != -1;
					category_list += '<li style="padding-left: ' + (all_categories[i].level * 15) + 'px"><label><input type="checkbox"' + (selected ? ' checked="checked"' : '') + ' name="category_' + all_categories[i].id + '" value="' + all_categories[i].id + '" /><span>' + all_categories[i].name + '</span></label></li>';
				}

				category_list += '</ul>';
				category_list += "</div></div>";

				return category_list;
			}

		if (!$hfSelectedFilterCategories.length)
			return;

		if ($divCategoryFilterList != null) {
			$divCategoryFilterList
				.html(generate_category_list_items($hfSelectedFilterCategories.val(), edn_all_categories))
				.find('input[type="checkbox"]')
				.change(function () {
					var $selected_categories = $divCategoryFilterList.find('input[type="checkbox"]:checked'),
						selected_ids = ',';

					if ($selected_categories.length) {
						$selected_categories.each(function () {
							var $this = $(this);

							selected_ids += $this.val() + ',';
						});

						$hfSelectedFilterCategories.val(selected_ids);
					} else {
						$hfSelectedFilterCategories.val('');
					}
				});

			$divCategoryFilterList.find('span').first().on('click', function () {
				if (!$divCategoryFilterList.hasClass('edNews_disabled')) {
					resizeDropDown();
					$divCategoryFilterList.toggleClass('edNews_selectOpen');
				}
			});

			var isResizeEventAttached = false;
			if (eds2_2._data(window).events && eds2_2._data(window).events.resize) {
				eds2_2._data(window).events.resize.map(function (resizeEvent) {
					if (resizeEvent.handler.name == 'eds__DropdownResize')
						isResizeEventAttached = true;
				})
			}
			if (!isResizeEventAttached) {
				eds2_2(window).on('resize', function eds__DropdownResize() {
					resizeDropDown();
				});
			}
		}
	}

	function ShowValue() {
		var dropdownList;
		if ('<%=!ApproveMode%>' == 'True') {
			eds2_2("#<%=gvArticleList.ClientID %> select[id*='ddlFotterActionForSelected']").each(function (index) {
				dropdownList = eds2_2(this);
			});
		}
		else {
			eds2_2("#<%=gvArticleList.ClientID %> select[id*='ddlFotterActionForSelectedApprove']").each(function (index) {
				dropdownList = eds2_2(this);
			});
		}
		if (dropdownList.val() == '-1') {
			alert('<%=selectAction%>');
		}
		else {
			return confirm('<%=Confirmation%>');
		}
	}

	function FilterOptionsToggle($cbEnableFilter, $outerDiv, $ddlOptions) {
		if ($cbEnableFilter[0].checked) {
			$outerDiv.removeClass("dis_box").addClass("enbl_box");
			$ddlOptions.prop('disabled', false);
		}
		else {
			$outerDiv.removeClass("enbl_box").addClass("dis_box");
			$ddlOptions.prop('disabled', true);
		}
	};

	function FilterOptionsToggleDiv($cbEnableFilter, $outerDiv, $divOptions) {
		if ($cbEnableFilter[0].checked) {
			$outerDiv.removeClass("dis_box").addClass("enbl_box");
			$divOptions.removeClass("edNews_disabled");
		}
		else {
			$outerDiv.removeClass("enbl_box").addClass("dis_box");
			$divOptions.addClass("edNews_disabled");
		}
	};

	function FilterSearchTerm($cbEnableFilter, $outerDiv, $tbSearchTerm) {
		if ($cbEnableFilter[0].checked) {
			$outerDiv.removeClass("dis_box").addClass("enbl_box");
			$tbSearchTerm.prop('disabled', false);
		}
		else {
			$outerDiv.removeClass("enbl_box").addClass("dis_box");
			$tbSearchTerm.val('');
			$tbSearchTerm.prop('disabled', true);
		}
	};

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

		eds2_2('[id*=datePickerSearchFromDate]', eds2_2('#<%= gvArticleList.ClientID%>')).each(function () {
			eds2_2(this).datetimepicker({
				sideBySide: false,
				showTodayButton: false,
				showClear: false,
				allowInputToggle: true,
				locale: '<%=System.Threading.Thread.CurrentThread.CurrentCulture.Name%>'
			});
		});

		eds2_2('[id*=datePickerSearchFromDate]', eds2_2('#<%= pnlArticleFilterSettings.ClientID%>')).each(function () {
			eds2_2(this).datetimepicker({
				sideBySide: false,
				showTodayButton: false,
				showClear: false,
				allowInputToggle: true,
				<%=(string.IsNullOrEmpty(selectedLang) ? "" : ("locale: '" + selectedLang + "', "))%>
			});
		});
	}

	function Filter_Init() {
		FilterOptionsToggle($("#<%=cbFilterByPermissionsByArticle.ClientID %>"), $("#<%=pnlPermissionsByArticleFilter.ClientID %>"), $("#<%=ddlFilterByPermissionsByArticle.ClientID %>"));
		$('#<%=cbFilterByPermissionsByArticle.ClientID %>').on('change', function () {
			FilterOptionsToggle($(this), $("#<%=pnlPermissionsByArticleFilter.ClientID %>"), $("#<%=ddlFilterByPermissionsByArticle.ClientID %>"));
		});

		FilterOptionsToggle($("#<%=cbFilterByArticleType.ClientID %>"), $("#<%=pnlArticleTypeFilter.ClientID %>"), $("#<%=ddlFilterByArticleType.ClientID %>"));
		$('#<%=cbFilterByArticleType.ClientID %>').on('change', function () {
			FilterOptionsToggle($(this), $("#<%=pnlArticleTypeFilter.ClientID %>"), $("#<%=ddlFilterByArticleType.ClientID %>"));
		});

		FilterOptionsToggle($("#<%=cbFilterByFeatured.ClientID %>"), $("#<%=pnlFeaturedFilter.ClientID %>"), $("#<%=ddlFilterByFeatured.ClientID %>"));
		$('#<%=cbFilterByFeatured.ClientID %>').on('change', function () {
			FilterOptionsToggle($(this), $("#<%=pnlFeaturedFilter.ClientID %>"), $("#<%=ddlFilterByFeatured.ClientID %>"));
		});

		FilterOptionsToggle($("#<%=cbFilterByApproved.ClientID %>"), $("#<%=pnlApprovedFilter.ClientID %>"), $("#<%=ddlFilterByApproved.ClientID %>"));
		$('#<%=cbFilterByApproved.ClientID %>').on('change', function () {
			FilterOptionsToggle($(this), $("#<%=pnlApprovedFilter.ClientID %>"), $("#<%=ddlFilterByApproved.ClientID %>"));
		});

		FilterOptionsToggleDiv($("#<%=cbFilterByCategory.ClientID %>"), $("#<%=pnlCategoryFilter.ClientID %>"), $("#<%=divCategoryFilterList.ClientID %>"));
		$('#<%=cbFilterByCategory.ClientID %>').on('change', function () {
			FilterOptionsToggleDiv($(this), $("#<%=pnlCategoryFilter.ClientID %>"), $("#<%=divCategoryFilterList.ClientID %>"));
		});

		FilterOptionsToggle($("#<%=cbFilterByPublish.ClientID %>"), $("#<%=pnlPublishFilter.ClientID %>"), $("#<%=ddlFilterByPublish.ClientID %>"));
		$('#<%=cbFilterByPublish.ClientID %>').on('change', function () {
			FilterOptionsToggle($(this), $("#<%=pnlPublishFilter.ClientID %>"), $("#<%=ddlFilterByPublish.ClientID %>"));
		});

		var $cbCustomFieldsTemplateFilter = $("#<%=cbCustomFieldsTemplateFilter.ClientID %>");

		if ($cbCustomFieldsTemplateFilter.length > 0) {
			FilterOptionsToggle($cbCustomFieldsTemplateFilter, $("#<%=pnlCustomFieldsTemplateFilter.ClientID %>"), $("#<%=ddlCustomFieldsTemplateFilter.ClientID %>"));
			$cbCustomFieldsTemplateFilter.on('change', function () {
				FilterOptionsToggle($(this), $("#<%=pnlCustomFieldsTemplateFilter.ClientID %>"), $("#<%=ddlCustomFieldsTemplateFilter.ClientID %>"));
			});
		}

		FilterSearchTerm($("#<%=cbSearchTerm.ClientID %>"), $("#<%=pnlSearchTerm.ClientID %>"), $("#<%=tbSearchTerm.ClientID %>"));
		$('#<%=cbSearchTerm.ClientID %>').on('change', function () {
			FilterSearchTerm($(this), $("#<%=pnlSearchTerm.ClientID %>"), $("#<%=tbSearchTerm.ClientID %>"));
		});
	}

	eds2_2(document).ready(function ($) {
		GridViewActions_Init();

		Filter_Init();

		CategoryDll_Init('<%=divCategoryFilterList.ClientID%>', '<%=hfSelectedFilterCategories.ClientID%>');
		CategoryDll_Init('<%=GetDivFotterCategoryFilterList%>', '<%=GetHfFotterSelectedFilterCategories%>');

		$('#<%=upMainAjax.ClientID%>').delegate('#<%=hlArticleFilterToggle.ClientID %>', 'click', function () {
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

			Filter_Init();

			CategoryDll_Init('<%=divCategoryFilterList.ClientID%>', '<%=hfSelectedFilterCategories.ClientID%>');
			CategoryDll_Init('<%=GetDivFotterCategoryFilterList%>', '<%=GetHfFotterSelectedFilterCategories%>');

			eds2_2('.edNews_tooltip').eds_tooltipster();
		}
	}

</script>
<asp:ObjectDataSource ID="odsGetPagedArticlesByUser" runat="server" SelectMethod="GetItemsForArticleEditor" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.NewsDataDB" EnablePaging="True" MaximumRowsParameterName="numberOfPostsperPage" SelectCountMethod="CountItemsForArticleEditor"
	StartRowIndexParameterName="startingArticle" OnSelecting="odsGetPagedArticlesByUser_Selecting" OnSelected="odsGetPagedArticlesByUser_Selected">
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
		<asp:Parameter Name="ModuleID" Type="Int32" />
		<asp:Parameter Name="UserID" Type="Int32" />
		<asp:Parameter Name="inCategories" Type="String" />
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
		<asp:Parameter Name="Published" Type="Int32" />
		<asp:Parameter Name="Approved" Type="Int32" />
		<asp:Parameter Name="ArticleType" Type="Int32" />
		<asp:Parameter Name="PermissionsByArticle" Type="Int32" />
		<asp:Parameter Name="startingArticle" Type="Int32" />
		<asp:Parameter Name="numberOfPostsperPage" Type="Int32" />
		<asp:Parameter Name="simpleSearchFindCondition" Type="String" />
		<asp:Parameter Name="startDate" Type="DateTime" />
		<asp:Parameter Name="filterByCustomFieldTemplate" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
