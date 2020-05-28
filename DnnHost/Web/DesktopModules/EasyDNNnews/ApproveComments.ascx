<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.ApproveComments, App_Web_approvecomments.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>
<script type="text/javascript">
	function ShowValue() {
		var dropdownList;
		eds3_5_jq("#<%=gvComments.ClientID %> select[id*='ddlFotterActionForSelected']").each(function (index) {
			dropdownList = eds3_5_jq(this);
		});

		if (dropdownList.val() == '-1')
			alert('<%=_("selectAction.Text")%>');
		else
			return confirm('<%=_("Areyousure.Text")%>');
	}

	function GridViewActions_Init() {
		var $gvComments = $('#<%= gvComments.ClientID%>');

		$('[id*=ibFooterSelectAll]', $gvComments).on("click", function () {
			$('[id*=cbSelectRow]', $gvComments).each(function () {
				$(this).prop("checked", "checked");
			});
		});

		$('[id*=ibFooterUnSelectAll]', $gvComments).on("click", function () {
			$('[id*=cbSelectRow]', $gvComments).each(function () {
				$(this).removeProp("checked");
			});
		});
	}

	jQuery(document).ready(function ($) {
		GridViewActions_Init();
	});

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {
			GridViewActions_Init();
		}
	}

</script>
<asp:Label ID="lblApproveMessage" runat="server" Text="You are not allowed to approve comments." Visible="False" resourcekey="lblApproveMessageResource1"></asp:Label>
<div class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=ApproveCommentsTitle%></span>
		</div>
		<div class="sectionBox noPadding sectionBox2">
			<asp:Panel ID="hlCommentFilterToggle" runat="server" class="sectionBoxHeader edNews__toggleWrapper">
				<asp:HyperLink ID="hlCommentFilterToggleLink" runat="server" CssClass="sectionBoxHeaderTitle edNews__toggle" href="#" runat="server" Text="Show filter settings" resourcekey="hlCommentFilterToggleResource1" />
			</asp:Panel>
			<asp:Panel ID="pnlCommentFilterSettings" runat="server" CssClass="edNews__toggledContent">
				<div class="sectionBox noPadding">
					<div class="sectionBoxSubtitle textLeft">
						<span><%=Filterby%></span>
					</div>
					<div class="edNews_OptionBoxes">
						<asp:Panel ID="pnlCategoryFilter" runat="server" CssClass="dis_box">
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbFilterByCategory" runat="server" Text="Category" CssClass="normalCheckBox" OnCheckedChanged="cbFilterByCategory_CheckedChanged" AutoPostBack="True" resourcekey="cbFilterByCategoryResource1" />
							</div>
							<label for="<%=cbFilterByCategory.ClientID %>"><%=_("cbFilterByCategoryResource1.Text") %></label>
							<asp:DropDownList ID="ddlCategorySelect" runat="server" Enabled="False">
								<asp:ListItem Value="-1" resourcekey="ListItemResource3">Select category</asp:ListItem>
							</asp:DropDownList>
						</asp:Panel>
					</div>
					<div class="edNews_OptionBoxes">
						<asp:Panel ID="pnlApprovedFilter" runat="server" CssClass="dis_box">
							<div class="switchCheckbox">
								<asp:CheckBox ID="cbApprovedFilter" runat="server" Text="Approved" CssClass="normalCheckBox" OnCheckedChanged="cbApprovedFilter_CheckedChanged" AutoPostBack="True" />
							</div>
							<label for="<%=cbApprovedFilter.ClientID %>"><%=_("cbApprovedFilter.Text") %></label>
							<asp:DropDownList ID="ddlApprovedFilter" runat="server" Enabled="False">
								<asp:ListItem Value="-1" resourcekey="liAll">All</asp:ListItem>
								<asp:ListItem Value="1" resourcekey="liApproved">Approved</asp:ListItem>
								<asp:ListItem Value="2" resourcekey="liUnapproved">Unapproved</asp:ListItem>
							</asp:DropDownList>
						</asp:Panel>
					</div>
				</div>
				<div class="mainActions noMargin">
					<asp:LinkButton ID="btnFilerComments" class="filterAction" runat="server" resourcekey="btnFilterComments" OnClick="btnFilerComments_Click"></asp:LinkButton>
				</div>
				<asp:HiddenField ID="hfFilterSettingsState" runat="server" Value="closed" />
			</asp:Panel>
		</div>
		<div class="sectionBox noPadding">
			<asp:GridView ID="gvComments" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="CommentID" DataSourceID="odsGetComments" EnableModelValidation="True" OnRowCommand="gvComments_RowCommand" OnRowDeleting="gvComments_RowDeleting" CssClass="strippedTable fullWidthTable noBorder tablePadding5 textLeft" ShowFooter="True" OnPreRender="gvComments_PreRender">
				<Columns>
					<asp:TemplateField>
						<FooterTemplate>
							<i class="fa fa-mail-reply fa-rotate-180"></i>
							<div class="mainActions noMargin smallActions displayInline">
								<a id="ibFooterSelectAll" class="secondaryAction"><i class="fa fa-list-alt"></i><%=_("ibFooterSelectAllResource1") %></a>
								<a id="ibFooterUnSelectAll" class="secondaryAction"><i class="fa fa-times-circle-o"></i><%=_("ibFooterUnSelectAllResource1") %></a>
							</div>
							<asp:DropDownList ID="ddlFotterActionForSelected" runat="server">
								<asp:ListItem resourcekey="liSelectAction" Value="-1">Select action</asp:ListItem>
								<asp:ListItem Value="Delete" resourcekey="ListItemResource4">Delete</asp:ListItem>
							</asp:DropDownList>
							<div class="mainActions noMargin smallActions displayInline">
								<asp:Button ID="ibFooterOK" runat="server" CssClass="primaryAction" resourcekey="ok" OnClick="ibFooterOK_Click" OnClientClick="return ShowValue();" />
							</div>
						</FooterTemplate>
						<ItemTemplate>
							<div class="styledCheckbox noLabel">
								<asp:CheckBox ID="cbSelectRow" CssClass="normalCheckBox" Text="Select Row" runat="server" />
							</div>
						</ItemTemplate>
						<ItemStyle Width="30px" CssClass="textCenter" />
					</asp:TemplateField>
					<asp:TemplateField ShowHeader="False">
						<EditItemTemplate>
							<div class="edNews_boxedActions edNews_twoInRow">
								<asp:LinkButton ID="LinkButton1" runat="server" CommandName="Update" CssClass="edNews_aaSave edNews_tooltip" resourcekey="Save" data-tooltip-content='<%#_("SaveChanges")%>' data-tooltip-position="top-left"></asp:LinkButton>
								<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" CssClass="edNews_aaCancel color4 edNews_tooltip" resourcekey="Cancel" data-tooltip-content='<%#_("CancelUpdate")%>' data-tooltip-position="top-left"></asp:LinkButton>
							</div>
						</EditItemTemplate>
						<ItemTemplate>
							<div class="edNews_boxedActions edNews_twoInRow">
								<asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" CssClass="edNews_aaEdit edNews_tooltip" resourcekey="LinkButton1Resource1" data-tooltip-content='<%#_("Editcomment") %>' data-tooltip-position="top-left" Visible='<%#!Convert.ToBoolean(Eval("IsDeleted")) %>'></asp:LinkButton>
								<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" CssClass="edNews_aaDelete color4 edNews_tooltip" resourcekey="LinkButton2Resource1" OnClientClick="return confirm('Do you realy want to delete this comment?');" data-tooltip-content='<%#_("Deletecomment")%>' data-tooltip-position="top-left" Visible='<%#!Convert.ToBoolean(Eval("IsDeleted")) %>'></asp:LinkButton>
							</div>
							<div class="itemActions noBorder smallActions">
								<asp:LinkButton ID="lbApprove" runat="server" CommandArgument='<%# Eval("CommentID") %>' CommandName="Approve" CssClass="unCheckAction edNews_tooltip" resourcekey="lbApproveResource1" data-tooltip-content='<%#_("lbApproveResource1.ToolTip") %>' data-tooltip-position="top-left" Visible='<%#!Convert.ToBoolean(Eval("Approved")) && !Convert.ToBoolean(Eval("IsDeleted")) %>'><%#("lbApproveResource1")%></asp:LinkButton>
								<asp:LinkButton ID="lbDisApprove" runat="server" CommandArgument='<%# Eval("CommentID") %>' CommandName="DisApprove" CssClass="checkAction edNews_tooltip" resourcekey="lbDisApproveResource1" data-tooltip-content='<%#_("lbDisApproveResource1.ToolTip")%>' data-tooltip-position="top-left" Visible='<%# Convert.ToBoolean(Eval("Approved")) && !Convert.ToBoolean(Eval("IsDeleted"))%>'><%#("lbDisApproveResource1")%></asp:LinkButton>
							</div>
						</ItemTemplate>
						<HeaderStyle Width="100px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Author">
						<ItemTemplate>
							<asp:Label ID="lblAuthor" runat="server" Text='<%# String.Format("<a href=\"mailto:{0}\" >{1}</a>",Eval("CommentersEmail"),Eval("CommentersName"))%>'></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="smallText" />
						<HeaderStyle Width="150px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Comment">
						<EditItemTemplate>
							<asp:TextBox ID="TextBox1" runat="server" MaxLength="10000" Text='<%# Bind("Comment") %>' TextMode="MultiLine"></asp:TextBox>
						</EditItemTemplate>
						<ItemTemplate>
							<asp:Label ID="Label1" runat="server" Text='<%#Convert.ToBoolean(Eval("IsDeleted"))?Localization.GetString("ThisCommentIsDeleted.Text", LocalResourceFile): Eval("Comment") %>'></asp:Label>
						</ItemTemplate>
						<ItemStyle CssClass="smallText" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Stats" SortExpression="DateAdded">
						<ItemTemplate>
							<p>
								<strong><%=Created%></strong><%# GetCommentDate(Eval("DateAdded"))%>
							</p>
							<p>
								<strong><%=Upvotes%></strong><%# Eval("GoodVotes") %>
							</p>
							<p>
								<strong><%=Downvotes%></strong><%# Eval("BadVotes") %>
							</p>
						</ItemTemplate>
						<ItemStyle CssClass="smallText" />
						<HeaderStyle Width="230px" />
					</asp:TemplateField>
					<asp:TemplateField HeaderText="Article title">
						<ItemTemplate>
							<asp:HyperLink ID="hlViewArticle" runat="server" NavigateUrl='<%#GetAricleUrl(Eval("Articleid"), Eval("Title"), Eval("TitleLink"), Eval("DetailType"), Eval("DetailTypeData"))%>' Target="_blank"><%# Eval("Title") %></asp:HyperLink>
						</ItemTemplate>
						<ItemStyle CssClass="smallText" />
						<HeaderStyle Width="200px" />
					</asp:TemplateField>
				</Columns>
				<HeaderStyle CssClass="tableHeader2 highlighted" />
				<PagerStyle CssClass="contentPagination" />
				<EditRowStyle CssClass="editItemState" />
			</asp:GridView>
			<div class="edNews_numberOfRows" runat="server" id="divPageSize">
				<div>
					<asp:Label ID="lblFooterSelectNumberOfRows" runat="server" AssociatedControlID="ddlFooterNumberOfRows" resourcekey="lblFooterSelectNumberOfRowsResource1" Text="Number of rows:"></asp:Label>
					<asp:DropDownList ID="ddlFooterNumberOfRows" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlFooterNumberOfRows_SelectedIndexChanged">
						<asp:ListItem Value="10" resourcekey="ListItemResource5">10</asp:ListItem>
						<asp:ListItem Value="20" resourcekey="ListItemResource6">20</asp:ListItem>
						<asp:ListItem Value="30" resourcekey="ListItemResource7">30</asp:ListItem>
						<asp:ListItem Value="50" resourcekey="ListItemResource8">50</asp:ListItem>
						<asp:ListItem Value="100" resourcekey="ListItemResource9">100</asp:ListItem>
					</asp:DropDownList>
				</div>
			</div>
			<asp:Panel ID="pnlNoCommentsMatched" runat="server" class="infoMessages info topMargin" Visible="False">
				<%=Therearentany%>
			</asp:Panel>
		</div>
	</div>
</div>
<asp:ObjectDataSource ID="odsGetComments" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" SelectMethod="GetAllComments" DeleteMethod="DeleteComment" UpdateMethod="UpdateComment" EnablePaging="True" SelectCountMethod="SelectTotalNumberOfComments">
	<DeleteParameters>
		<asp:Parameter Name="CommentID" Type="Int32" />
	</DeleteParameters>
	<UpdateParameters>
		<asp:Parameter Name="CommentID" Type="Int32" />
		<asp:Parameter Name="Comment" Type="String" />
	</UpdateParameters>
	<SelectParameters>
		<asp:Parameter Name="portalId" Type="Int32" />
		<asp:Parameter Name="portalIds" Type="String" />
		<asp:Parameter Name="maximumRows" Type="Int32" DefaultValue="1" />
		<asp:Parameter Name="startRowIndex" Type="Int32" DefaultValue="10" />
		<asp:Parameter Name="categoryId" Type="Int32" DefaultValue="-1" />
			<asp:Parameter Name="approved" Type="Int32" DefaultValue="-1" />
	</SelectParameters>
</asp:ObjectDataSource>
<asp:ObjectDataSource ID="odsGetCommentsByArticleID" runat="server" DeleteMethod="DeleteComment" EnablePaging="True" SelectCountMethod="SelectNumberOfCommentsByArticleID" SelectMethod="GetCommentsByArticleID" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" UpdateMethod="UpdateComment">
	<DeleteParameters>
		<asp:Parameter Name="CommentID" Type="Int32" />
	</DeleteParameters>
	<UpdateParameters>
		<asp:Parameter Name="CommentID" Type="Int32" />
		<asp:Parameter Name="Comment" Type="String" />
	</UpdateParameters>
	<SelectParameters>
		<asp:Parameter Name="ArticleID" Type="Int32" />
		<asp:Parameter Name="maximumRows" Type="Int32" DefaultValue="1" />
		<asp:Parameter Name="startRowIndex" Type="Int32" DefaultValue="10" />
	</SelectParameters>
</asp:ObjectDataSource>
