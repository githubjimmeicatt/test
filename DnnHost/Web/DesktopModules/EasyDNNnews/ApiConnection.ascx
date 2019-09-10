<%@ control language="C#" autoeventwireup="true" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.ApiConnection, App_Web_apiconnection.ascx.d988a5ac" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<script type="text/ecmascript">
	function ShowWarning() {
		return confirm('<%=Localization.GetString("Warning.Text", this.LocalResourceFile)%>');
	}
</script>
<asp:Panel ID="pnlMain" runat="server" CssClass="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=APIconnections %></span>
		</div>
		<div class="sectionBox sectionBox2 noPadding">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=TwitterAPIConnection%></span>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel strongText textTop">
						<asp:Label ID="lblInstructions" resourcekey="lblInstructions" runat="server" Text="Instructions:"></asp:Label>
					</td>
					<td class="textTop">
						<asp:HyperLink ID="hlVisitDetailInstrictionsTwitter" resourcekey="hlVisitDetailInstrictionsTwitter" runat="server" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/how-to-setup-auto-posting-to-twitter" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink>
						<asp:Label ID="lblDetailInstructions" resourcekey="lblDetailInstructions" runat="server" Text="&lt;ol&gt;&lt;li&gt;Visit the URL below &lt;/li&gt;&lt;li&gt;Create a Twitter app&lt;/li&gt;&lt;li&gt;Click on the 'Settings' tab and under 'Application type' 'Access:' select 'Read and Write'&lt;/li&gt;&lt;li&gt;Go to 'Details' tab and copy 'Consumer key' and 'Consumer secret' values into fields below.&lt;/li&gt;&lt;/ol&gt;"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblGoToURL" resourcekey="lblGoToURL" runat="server" Text="Visit this url:"></asp:Label>
					</td>
					<td>
						<asp:HyperLink ID="hlTwitterDevURL" resourcekey="hlTwitterDevURL" runat="server" NavigateUrl="https://dev.twitter.com/apps/new" Target="_blank" ImageUrl="~/DesktopModules/EasyDNNnews/images/twitter_connect.png">Twitter create new app</asp:HyperLink>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblConsumerKey" resourcekey="lblConsumerKey" runat="server" Text="Consumer key:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbConsumerKey" runat="server" ValidationGroup="addTwitterApp"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvTwitterKey" CssClass="smallInfo error" runat="server" ControlToValidate="tbConsumerKey" ErrorMessage="Please enter consumer key." ValidationGroup="addTwitterApp"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblConsumerSecret" resourcekey="lblConsumerSecret" runat="server" Text="Consumer secret:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbConsumerSecret" runat="server" ValidationGroup="addTwitterApp"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvTwitterSecret" CssClass="smallInfo error" runat="server" ControlToValidate="tbConsumerSecret" ErrorMessage="Please enter consumer secret." ValidationGroup="addTwitterApp"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
			</table>
			<asp:Label ID="lblSaveMessage" runat="server" ForeColor="Red" EnableViewState="False"></asp:Label>
			<div class="mainActions smallActions">
				<asp:Button ID="btnSaveTwitter" resourcekey="btnSaveTwitter" CssClass="downSave" runat="server" Text="Add or update Twitter app keys" OnClick="btnSaveTwitter_Click" ValidationGroup="addTwitterApp" />
				<asp:Button ID="btnDeleteExistingTwiter" resourcekey="btnDeleteExistingTwiter" CssClass="delete" runat="server" Text="Delete Existing Keys" OnClientClick="return ShowWarning();" OnClick="btnDeleteExistingTwiter_Click" />
			</div>
		</div>
		<div class="sectionBox sectionBox2 noPadding">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=FacebookAPIConnection%></span>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel strongText textTop" valign="top">
						<asp:Label ID="lblFacebookInstructions" resourcekey="lblFacebookInstructions" runat="server" Text="Instructions:"></asp:Label>
					</td>
					<td class="textTop">
						<asp:HyperLink ID="hlVisitDetailInstrictionsFacebook" resourcekey="hlVisitDetailInstrictionsFacebook" runat="server" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/easydnnnews-and-facebook-integration" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink>
						<asp:Label ID="lblFaceBookDetailInstructions" resourcekey="lblFaceBookDetailInstructions" runat="server" Text="&lt;ol&gt; &lt;li&gt;Visit the URL below and create Facebook application&lt;/li&gt; &lt;li&gt;If on localhost you must specify Site Domain as &quot;localhost&quot; and Site URL as http://localhost:####/ where #### is port number&lt;/li&gt; &lt;li&gt;To below textboxes, add information from created Facebook application settings tab&lt;/li&gt;&lt;/ol&gt;"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblFacebookVisitLink" resourcekey="lblFacebookVisitLink" runat="server" Text="Visit this url:"></asp:Label>
					</td>
					<td>
						<asp:HyperLink ID="hlFacebookCreateApp" resourcekey="hlFacebookCreateApp" runat="server" NavigateUrl="https://developers.facebook.com/apps" Target="_blank" ImageUrl="~/DesktopModules/EasyDNNnews/images/facebook_connect.png">Facebook create new app</asp:HyperLink>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblAppFacebookidapiKey" resourcekey="lblAppFacebookidapiKey" runat="server" Text="App ID/API Key:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxFacebookApiKey" runat="server" ValidationGroup="addFacebookApp"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvFacebookApiKey" CssClass="smallInfo error" runat="server" ControlToValidate="tbxFacebookApiKey" ErrorMessage="Please enter App ID/API Key." ValidationGroup="addFacebookApp"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblFacebookAppSecret" resourcekey="lblFacebookAppSecret" runat="server" Text="App secret:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxFacebookAppSecret" runat="server" ValidationGroup="addFacebookApp"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvFacebookAppSecret" CssClass="smallInfo error" runat="server" ControlToValidate="tbxFacebookAppSecret" ErrorMessage="Please enter App secret." ValidationGroup="addFacebookApp"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
			</table>
			<asp:Label ID="lblSaveInfo" runat="server" ForeColor="#FF3300" EnableViewState="False"></asp:Label>
			<asp:Label ID="lblFaceBookError" runat="server" EnableViewState="False"></asp:Label>
			<div class="mainActions smallActions">
				<asp:Button ID="btnSaveFacebook" resourcekey="btnSaveFacebook" CssClass="downSave" runat="server" Text="Add or update Facebook app keys" ValidationGroup="addFacebookApp" OnClick="btnSaveFacebook_Click" />
				<asp:Button ID="btnDeleteExistingFacebook" resourcekey="btnDeleteExistingFacebook" CssClass="delete" runat="server" OnClick="btnDeleteExistingFacebook_Click" OnClientClick="return ShowWarning();" Text="Delete Existing Keys" />
			</div>
		</div>
		<div class="sectionBox sectionBox2 noPadding">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=LinkedInAPIConnection%></span>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel strongText textTop">
						<asp:Label ID="lblLinkedInInstructions" resourcekey="lblLinkedInInstructions" runat="server" Text="Instructions:"></asp:Label>
					</td>
					<td class="textTop">
						<asp:HyperLink ID="hlVisitDetailInstrictionsLinkedIn" resourcekey="hlVisitDetailInstrictionsLinkedIn" runat="server" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/how-to-setup-auto-posting-to-linkedin" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink>
						<asp:Label ID="lblLinkedIDetailInstructions" runat="server"></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblLinkedInVisitLink" resourcekey="lblLinkedInVisitLink" runat="server" Text="Visit this url:"></asp:Label>
					</td>
					<td>
						<asp:HyperLink ID="hlLinkedInCreateApp" resourcekey="hlLinkedInCreateApp" runat="server" NavigateUrl="https://www.linkedin.com/developer/apps" Target="_blank" ImageUrl="~/DesktopModules/EasyDNNnews/images/linkedin.png">LinkedIn create new app</asp:HyperLink>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblLinkedInClientID" resourcekey="lblLinkedInClientID" runat="server" Text="LinkedIn ClientID:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxLinkedInClientID" runat="server" ValidationGroup="addLinkedInApp"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvLinkedInApiKey" CssClass="smallInfo error" resourcekey="rfvLinkedInApiKey.ErrorMessage" runat="server" ControlToValidate="tbxLinkedInClientID" ErrorMessage="Please enter ClientID." ValidationGroup="addLinkedInApp"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblLinkedInClientSecret" resourcekey="lblLinkedInAppSecret" runat="server" Text="LinkedIn Client Secret:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxLinkedInClientSecret" runat="server" ValidationGroup="addLinkedInApp"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvLinkedInClientSecret" CssClass="smallInfo error" resourcekey="rfvLinkedInClientSecret.ErrorMessage" runat="server" ControlToValidate="tbxLinkedInClientSecret" ErrorMessage="Please enter LinkedIn Client Secret." ValidationGroup="addLinkedInApp"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
			</table>
			<asp:Label ID="lblLinkedInSaveInfo" runat="server" ForeColor="#FF3300" EnableViewState="False"></asp:Label>
			<div class="mainActions smallActions">
				<asp:Button ID="btnSaveLinkedIn" resourcekey="btnSaveLinkedIn" CssClass="downSave" runat="server" Text="Add or update LinkedIn app keys" ValidationGroup="addLinkedInApp" OnClick="btnSaveLinkedIn_Click" />
				<asp:Button ID="btnDeleteExistingLinkedIn" resourcekey="btnDeleteExistingLinkedIn" CssClass="delete" runat="server" OnClientClick="return ShowWarning();" Text="Delete Existing Keys" OnClick="btnDeleteExistingLinkedIn_Click" />
			</div>
		</div>
		<div class="sectionBox sectionBox2 noPadding">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%=GoogleRecaptcha%></span>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel strongText textTop">
						<asp:Label ID="lblGoogleRecaptchaInstructions" resourcekey="lblGoogleRecaptchaInstructions" runat="server" Text="Instructions:"></asp:Label>
					</td>
					<td class="textTop">
						<asp:HyperLink ID="hlVisitDetailInstrictionsGoogleRecaptcha" runat="server" resourcekey="hlVisitDetailInstrictionsGoogleRecaptcha" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/easydnnnews-and-google-recaptcha-integration" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink>
						<asp:Label ID="lblGoogleRecaptchaDetailInstructions" runat="server" resourcekey="lblGoogleRecaptchaDetailInstructions"><ol><li>Visit the URL below and create Google Recaptcha keys with your site info</li><li>To below textboxes, add Site key and Secret key</li></ol></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblGoogleRecaptchaVisitLink" runat="server" resourcekey="lblGoogleRecaptchaVisitLink" Text="Visit this url:"></asp:Label>
					</td>
					<td>
						<asp:HyperLink ID="hlGoogleRecaptchaCreateApp" runat="server" NavigateUrl="https://www.google.com/recaptcha/admin#list" Target="_blank" ImageUrl="~/DesktopModules/EasyDNNnews/images/googleRecaptcha_icon.png">GoogleRecaptcha create keys</asp:HyperLink>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblGoogleRecaptchaSiteKey" resourcekey="lblGoogleRecaptchaSiteKey" runat="server" Text="GoogleRecaptcha Site key:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxGoogleRecaptchaSiteKey" runat="server" ValidationGroup="vgGoogleRecaptcha"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvGoogleRecaptchaApiKey" CssClass="smallInfo error" runat="server" resourcekey="rfvGoogleRecaptchaApiKey.ErrorMessage" ControlToValidate="tbxGoogleRecaptchaSiteKey" ErrorMessage="Please enter Site key." ValidationGroup="vgGoogleRecaptcha"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblGoogleRecaptchaSecretKey" runat="server" resource="lblGoogleRecaptchaSecretKey" Text="GoogleRecaptcha Secret key:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxGoogleRecaptchaSecretKey" runat="server" ValidationGroup="vgGoogleRecaptcha"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvGoogleRecaptchaClientSecret" CssClass="smallInfo error" runat="server" resourcekey="rfvGoogleRecaptchaClientSecret.ErrorMessage" ControlToValidate="tbxGoogleRecaptchaSecretKey" ErrorMessage="Please enter GoogleRecaptcha Secret key." ValidationGroup="vgGoogleRecaptcha"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
			</table>
			<asp:Label ID="lblGoogleRecaptchaSaveInfo" runat="server" ForeColor="#FF3300" EnableViewState="False"></asp:Label>
			<div class="mainActions smallActions">
				<asp:Button ID="btnSaveGoogleRecaptcha" runat="server" resourcekey="btnSaveGoogleRecaptcha" CssClass="downSave" Text="Add or update GoogleRecaptcha app keys" ValidationGroup="vgGoogleRecaptcha" OnClick="btnSaveGoogleRecaptcha_Click" />
				<asp:Button ID="btnDeleteExistingGoogleRecaptcha" runat="server" resourcekey="btnDeleteExistingGoogleRecaptcha" CssClass="delete" OnClientClick="return ShowWarning();" Text="Delete Existing Keys" OnClick="btnDeleteExistingGoogleRecaptcha_Click" />
			</div>
		</div>
		<div class="sectionBox sectionBox2 noPadding">
			<div class="sectionBoxHeader">
				<span class="sectionBoxHeaderTitle"><%= _("AddThis.Text")%></span>
			</div>
			<table class="optionsList fullWidthTable strippedTable noBorder">
				<tr>
					<td class="tdLabel strongText textTop">
						<asp:Label ID="lblAddThisInstructions" resourcekey="lblAddThisInstructions" runat="server" Text="Instructions:"></asp:Label>
					</td>
					<td class="textTop">
						<asp:HyperLink ID="hlVisitDetailInstrictionsAddThis" resourcekey="hlVisitDetailInstrictionsAddThis" runat="server" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/integration-with-addthis" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink>
						<asp:Label ID="lblAddthisDetailInstructions" resourcekey="lblAddthisDetailInstructions" runat="server"><ol><li>Visit the URL below, create and setup site profile</li><li>Go to site profile 'General settings' and copy profile id to below textbox. Profile is must start with 'ra-'.</li></ol></asp:Label>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblAddthisVisitLink" resourcekey="lblAddthisVisitLink" runat="server" Text="Visit this url:"></asp:Label>
					</td>
					<td>
						<asp:HyperLink ID="hlAddThis" runat="server" NavigateUrl="https://www.addthis.com" Target="_blank" ImageUrl="~/DesktopModules/EasyDNNnews/images/addthis.png">AddThis</asp:HyperLink>
					</td>
				</tr>
				<tr>
					<td class="tdLabel strongText">
						<asp:Label ID="lblAddThisProfileId" resourcekey="lblAddThisProfileId" runat="server" Text="AddThis profile id:"></asp:Label>
					</td>
					<td>
						<div class="edNews_inputGroup inputWidth40">
							<asp:TextBox ID="tbxAddThisProfileId" runat="server" ValidationGroup="vgAddThis"></asp:TextBox>
							<asp:RequiredFieldValidator ID="rfvAddThisProfileId" CssClass="smallInfo error" runat="server" resourcekey="rfvAddThisProfileId.ErrorMessage" ControlToValidate="tbxAddThisProfileId" ErrorMessage="Please enter AddThis profile id." ValidationGroup="vgAddThis"></asp:RequiredFieldValidator>
						</div>
					</td>
				</tr>
			</table>
			<asp:Label ID="lblAddThisRecaptchaSaveInfo" runat="server" ForeColor="#FF3300" EnableViewState="False"></asp:Label>
			<div class="mainActions smallActions">
				<asp:Button ID="btnSaveAddThis" resourcekey="btnSaveAddThis" runat="server" CssClass="downSave" Text="Add or update AddThis profile Id" ValidationGroup="vgAddThis" OnClick="btnSaveAddThis_Click" />
				<asp:Button ID="btnDeleteExistingAddThis" resourcekey="btnDeleteExistingAddThis" runat="server" CssClass="delete" OnClientClick="return ShowWarning();" Text="Delete Existing Keys" OnClick="btnDeleteExistingAddThis_Click" />
			</div>
		</div>
	</div>
</asp:Panel>
