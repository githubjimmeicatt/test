<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Activate, App_Web_activate.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<style type="text/css">
	#EDSadmin {
		color: #464646;
		font-family: Arial,Helvetica,sans-serif;
		font-size: 12px;
		margin: 0 auto;
		width: 600px;
	}

		#EDSadmin .module_settings {
			background: none repeat scroll 0 0 #FAFAFA;
			border-radius: 10px;
		}

			#EDSadmin .module_settings .settings_category_container {
				border: 0 none;
				margin: 0;
				padding: 0;
			}

				#EDSadmin .module_settings .settings_category_container .category_toggle {
					-moz-border-bottom-colors: none;
					-moz-border-left-colors: none;
					-moz-border-right-colors: none;
					-moz-border-top-colors: none;
					background-color: #E8E8E8;
					border-color: #E2E1E1;
					border-image: none;
					border-style: solid solid none;
					border-width: 1px 1px 0;
					height: 34px;
					margin: 0;
					overflow: hidden;
					padding: 0;
				}

					#EDSadmin .module_settings .settings_category_container .category_toggle h2 {
						float: left;
						font-family: Verdana,sans-serif;
						font-size: 14px;
						font-weight: bold;
						line-height: normal;
						margin: 6px 0 0 7px;
						padding: 0;
						color: #486580;
					}

		#EDSadmin .main_content {
			-moz-border-bottom-colors: none;
			-moz-border-left-colors: none;
			-moz-border-right-colors: none;
			-moz-border-top-colors: none;
			background: none repeat scroll 0 0 #F4F4F4;
			border-color: #E2E1E1;
			border-image: none;
			border-right: 1px solid #E2E1E1;
			border-style: none solid solid;
			border-width: 0 1px 1px;
			margin: 0;
		}

			#EDSadmin .main_content input {
				font-size: 12px;
				padding: 2px 4px;
				margin: 2px 0 0;
				background: #f4f4f4;
				color: #464646;
				border: 1px solid #858585;
				border-radius: 3px 3px 3px 3px;
				box-shadow: 0 1px 0 0 rgba(255, 255, 255, 0.8), 0 1px 2px 0 rgba(0, 0, 0, 0.1) inset;
				min-width: 150px;
			}

				#EDSadmin .main_content input[type="submit"] {
					background-color: #358eea;
					border-color: #0d569e;
					box-shadow: 0 1px 0 0 rgba(0, 0, 0, 0.6), 0 1px 0 0 rgba(255, 255, 255, 0.4) inset;
					color: #efefef;
					text-shadow: 0 -1px 0 #185b93;
					height: 27px;
				}

					#EDSadmin .main_content input[type="submit"]:hover {
						background: -moz-linear-gradient(center top, #6cb6f3 0%, #4387d2 100%) repeat scroll 0 0 transparent;
						border-color: #0d569e;
						color: white;
					}

		#EDSadmin .leftwidth {
			width: 170px;
			vertical-align: top;
		}

		#EDSadmin .rightwidth {
			vertical-align: top;
		}

	td > .dnnLabel {
		width: 170px;
	}

	#EDSadmin .msgareq {
		color: #f00;
		font-size: 11px;
	}

	#EDSadmin .edn_activationMessage {
		border: solid 1px #109300;
		background-color: #B3F7B2;
		color: #028800;
		margin: 15px 10px;
		padding: 10px;
		text-align: center;
		font-size: 14px;
	}

		#EDSadmin .edn_activationMessage p {
			margin: 0 0 15px;
			padding: 0;
		}

		#EDSadmin .edn_activationMessage a {
			text-decoration: underline;
			color: #000;
		}

			#EDSadmin .edn_activationMessage a:hover {
				text-decoration: none;
			}

		#EDSadmin .edn_activationMessage.edn_info {
			border-color: #007CFF;
			background-color: #C0DCFE;
			color: #0072CF;
		}

		#EDSadmin .edn_activationMessage.edn_warning {
			border-color: #FFA900;
			background-color: #FCF0BF;
			color: #DC7A5D;
		}

		#EDSadmin .edn_activationMessage.edn_error {
			border-color: #FF0000;
			background-color: #FF9999;
			color: #CF000E;
		}

	#EDSadmin .main_content input.btnmoreinfo {
		background-color: #f9d405;
		border-color: #fcbb00;
		box-shadow: 0 1px 0 0 rgba(83, 83, 83, 0.6), 0 1px 0 0 rgba(255, 255, 255, 0.4) inset;
		text-shadow: none;
		color: #3b3b3b;
		height: 27px;
	}

		#EDSadmin .main_content input.btnmoreinfo:hover {
			background: -moz-linear-gradient(center top, #f3c76c 0%, #ffab00 100%) repeat scroll 0 0 transparent;
			border-color: #d17d00;
			color: #3b3b3b;
		}
</style>
<script type="text/javascript">
	function openMoreInfo() {
		var a = document.getElementById('<%=hlMoreInfo.ClientID%>');
		if (a.href)
			a.click();
	}
</script>
<div id="EDSadmin">
	<div class="module_settings">
		<div class="settings_category_container">
			<div class="category_toggle">
				<h2>EasyDNNnews Activation</h2>
			</div>
			<table border="0" class="main_content grid_view_table" width="100%">
				<tr>
					<td>&nbsp;
					</td>
				</tr>
				<tr>
					<td class="style3">&nbsp;
					</td>
					<td class="style4">
						<asp:Label ID="lblUpgradeMessage" runat="server" Text="You have upgraded the module with new version. Please activate it again." Visible="False"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="leftwidth" style="height: 41px">
						<dnn:Label ID="lblInvoiceID" runat="server" Text="Please enter invoice id:" HelpText="Enter you invoice id from purchasing the module."></dnn:Label>
					</td>
					<td class="rightwidth" style="height: 41px">
						<div>
							<asp:TextBox ID="tbInvoiceID" runat="server" Width="300px" MaxLength="100"></asp:TextBox>
						</div>
						<div>
							<asp:Label ID="lblInvoiceRequiredMessage" runat="server" ForeColor="Red" Text="This field is required." Visible="False"></asp:Label>
						</div>
					</td>
				</tr>
				<tr>
					<td class="leftwidth">
						<dnn:Label ID="lblOriginalInvoiceID" runat="server" Text="Original invoice id:" HelpText="Enter original invoice id from purchasing the module." Visible="False"></dnn:Label>
					</td>
					<td>
						<div>
							<asp:TextBox ID="tbOriginalInvoiceID" runat="server" Width="300px" MaxLength="100" Visible="False"></asp:TextBox>
						</div>
						<div>
							<asp:Label ID="lblUpgradeInvoiceRequiredMessage" runat="server" ForeColor="Red" Text="This field is required." Visible="False"></asp:Label>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<asp:Button ID="btnActivate" runat="server" OnClick="btnActivate_Click" Text="Activate" />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<asp:Label ID="lblMessage" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="text-align: center;">
						<asp:Button ID="btnCloseActivation" runat="server" OnClientClick="openMoreInfo();" Text="OK" OnClick="btnCloseActivation_Click" Visible="False" />
						<asp:Button ID="btnErrorMoreInfo" CssClass="btnmoreinfo" runat="server" OnClientClick="openMoreInfo(); return false;" Text="More info" Visible="False" />
					</td>
				</tr>
				<tr>
					<td>&nbsp;
					</td>
					<td>
						<asp:HiddenField ID="hfIsUpgrade" runat="server" Value="False" />
					</td>
				</tr>
			</table>
		</div>
	</div>
	<asp:HyperLink runat="server" ID="hlMoreInfo" Style="visibility: hidden" Target="_blank" NavigateUrl="">Open</asp:HyperLink>
</div>
