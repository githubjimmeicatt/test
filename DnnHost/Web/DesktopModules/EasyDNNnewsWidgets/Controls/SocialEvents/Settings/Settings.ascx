<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Widgets.Settings.SettingsSocialEvents, App_Web_settings.ascx.ba6e357c" %>
<div class="sectionBox noPadding">
	<div class="sectionBoxHeader">
		<span class="sectionBoxHeaderTitle"><%=SettingsTitle%></span>
	</div>
	<asp:UpdatePanel ID="upModuleTheme4" runat="server" OnUnload="UpdatePanel_Unload">
		<ContentTemplate>
			<table class="optionsList fullWidthTable tablePadding5 strippedTable noBorder">
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlNewsModuleConnection.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNewsModuleConnection.Help", true) %>" data-tooltip-position="top-right"><%=_("lblNewsModuleConnection.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlNewsModuleConnection" runat="server" ValidationGroup="vgCatMenuSettings4" />
						<asp:CompareValidator ID="cvNewsModuleConnection" runat="server" ForeColor="Red" ControlToValidate="ddlNewsModuleConnection" Display="Dynamic" ErrorMessage=" Please select news module." Operator="NotEqual" ValidationGroup="vgCatMenuSettings4"
							ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlTheme4.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTheme.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTheme.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlTheme4" runat="server" OnSelectedIndexChanged="ddlTheme_SelectedIndexChanged" AutoPostBack="True" ValidationGroup="vgCatMenuSettings4" />
						<asp:CompareValidator ID="cvThemeSelect4" runat="server" ForeColor="Red" ControlToValidate="ddlTheme4" Display="Dynamic" ErrorMessage=" Please select theme." Operator="NotEqual" ValidationGroup="vgCatMenuSettings4"
							ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlThemeStyle4.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeStyle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblThemeStyle.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlThemeStyle4" runat="server" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=ddlThemeHTMLTemplate4.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeHTMLTemplate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblThemeHTMLTemplate.Text") %></label>
					</td>
					<td>
						<asp:DropDownList ID="ddlThemeHTMLTemplate4" runat="server" ValidationGroup="vgCatMenuSettings4" />
						<asp:CompareValidator ID="cvThemeHTMLTemplate" runat="server" ForeColor="Red" ControlToValidate="ddlThemeHTMLTemplate4" Display="Dynamic" ErrorMessage=" Please select HTML template" Operator="NotEqual" ValidationGroup="vgCatMenuSettings4" ValueToCompare="" />
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowSignUpActionBar.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowSignUpActionBar.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowSignUpActionBar.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowSignUpActionBar" runat="server" Text=" " />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowGoingUsers.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowGoingUsers.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowGoingUsers.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowGoingUsers" runat="server" Text=" " />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowNotGoingUsers.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowNotGoingUsers.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowNotGoingUsers.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowNotGoingUsers" runat="server" Text=" " />
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel">
						<label for="<%=cbShowMayBeGoingUsers.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowMayBeGoingUsers.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowMayBeGoingUsers.Text") %></label>
					</td>
					<td>
						<div class="switchCheckbox">
							<asp:CheckBox CssClass="normalCheckBox" ID="cbShowMayBeGoingUsers" runat="server" Text=" " />
						</div>
					</td>
				</tr>
			</table>
		</ContentTemplate>
	</asp:UpdatePanel>
</div>
