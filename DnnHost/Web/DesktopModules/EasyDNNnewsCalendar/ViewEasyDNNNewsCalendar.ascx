<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Calendar.ViewEasyDNNNewsCalendar, App_Web_vieweasydnnnewscalendar.ascx.3e42803b" autoeventwireup="true" enableviewstate="true" %>
<asp:Literal ID="litSettingsInfo" runat="server" Visible="false" />
<div class="<%=MainDivClass%>">
	<asp:PlaceHolder ID="includeJavaScriptToolTip" runat="server" />
	<asp:PlaceHolder ID="includeFullCalendar" runat="server" />

	<asp:UpdatePanel ID="upCalendar" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
		<ContentTemplate>
			<div runat="server" id="divAdvancedIcons" visible="false" class="top_calendar_actions">
				<asp:PlaceHolder ID="phAdvancedIcons" runat="server" />
			</div>
			<asp:Panel ID="pnlCalendarArchive" CssClass="callendar_table_container" runat="server">
				<div class="edn_styledSelect" runat="server" id="divCalendarMonthSelect" visible="false">
					<asp:Label ID="lblContactFormSubject" runat="server" AssociatedControlID="ddlCalendarMonthSelect" Style="border: 0; clip: rect(0 0 0 0); height: 1px; margin: -1px; overflow: hidden; padding: 0; position: absolute; width: 1px;"><span>Select month:</span></asp:Label>
					<span>
						<asp:DropDownList runat="server" ID="ddlCalendarMonthSelect" AutoPostBack="true" OnSelectedIndexChanged="ddlCalendarMonthSelect_SelectedIndexChanged" />
					</span>
				</div>
				<asp:Calendar ID="calDate" runat="server" CssClass="calendar_table" NextMonthText="&raquo;" PrevMonthText="&laquo;" SelectMonthText="&raquo;" SelectWeekText="&rsaquo;" CellPadding="0" CellSpacing="0" ShowGridLines="false" BorderStyle="None" BorderWidth="0"
					FirstDayOfWeek="Monday" OnVisibleMonthChanged="calDate_VisibleMonthChanged" OnUnload="calDate_Unload">
					<SelectedDayStyle CssClass="selected day" />
					<TitleStyle CssClass="month_selection" />
					<NextPrevStyle CssClass="next_prev_months" />
					<DayHeaderStyle CssClass="week_days" />
					<TodayDayStyle CssClass="day today" />
					<OtherMonthDayStyle CssClass="day other_month" />
					<DayStyle CssClass="day" />
				</asp:Calendar>
			</asp:Panel>
		</ContentTemplate>
	</asp:UpdatePanel>
	<asp:Panel ID="pnlMonthlyArchive" class="archive_list" runat="server" Visible="false" EnableViewState="false">
		<asp:Literal ID="htmlArchive" runat="server" EnableViewState="false" />
	</asp:Panel>
	<asp:Panel ID="pnlEventArchive" class="archive_list events" runat="server" Visible="false" EnableViewState="false">
		<h1 id="EventH1" runat="server" class="edn_module_title">
			<span>
				<%=EventHeader%></span>
			<asp:PlaceHolder ID="phUpcomingEventsIcons" runat="server" EnableViewState="false" />
		</h1>
		<asp:PlaceHolder ID="phupcomingEventsArchive" runat="server" EnableViewState="false" />
	</asp:Panel>
	<asp:Label ID="lblCalMessage" runat="server" resourcekey="lblCalMessage" Text="Please edit and save settings." Visible="false" EnableViewState="false" />
</div>
