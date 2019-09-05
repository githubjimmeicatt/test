<%@ Control language="vb" autoeventwireup="false" codefile="Settings.ascx.vb" inherits="Icatt.DotNetNuke.Modules.GoogleSearchResults.Settings" %>
<%@ Register tagprefix="dnn" tagname="Label" src="~/controls/LabelControl.ascx" %>
<table cellspacing="0" cellpadding="2" border="0" summary="GoogleSearchResults Settings Design Table">
	<tr>
		<td class="SubHead" width="150">
			<dnn:Label id="lblDefaultCollection" runat="server" controlname="txtDefaultCollection"
				suffix=":"></dnn:Label>
		</td>
		<td valign="bottom">
			<asp:TextBox id="txtDefaultCollection" cssclass="NormalTextBox" textmode="SingleLine"
				maxlength="1000" runat="server" />
			<asp:RequiredFieldValidator id="valDefaultCollectionRequired" runat="server" controltovalidate="txtDefaultCollection"
				 text="Enter a default collection name." display="dynamic" enableclientscript="true" />
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:Label id="lblRoleBasedCollection" runat="server" controlname="txtRoleBasedCollections"
				suffix=":"></dnn:Label>
		</td>
		<td valign="bottom">
			<asp:TextBox id="txtRoleBasedCollections" cssclass="NormalTextBox" textmode="MultiLine" Wrap="true"
				maxlength="1000" runat="server" Width="500" Rows="3"  />
				<asp:CustomValidator ID="valRoleBasedCollections" runat="server" ControlToValidate="txtRoleBasedCollections" display="Dynamic" EnableClientScript="false"  />
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:Label id="lblDefaultFrontEndName" runat="server" controlname="txtDefaultFrontEndName"
				suffix=":"></dnn:Label>
		</td>
		<td valign="bottom">
			<asp:TextBox id="txtDefaultFrontEndName" cssclass="NormalTextBox" textmode="SingleLine"
				maxlength="1000" runat="server" />
			<asp:RequiredFieldValidator id="valDefaultFrontEndNameRequired" runat="server" controltovalidate="txtDefaultFrontEndName"
				 text="Enter a default front-end name." display="dynamic" enableclientscript="true" />
		</td>
	</tr>
	<tr>
		<td class="SubHead" width="150">
			<dnn:Label id="lblDefaultPageSize" runat="server" controlname="txtDefaultPageSize"
				suffix=":"></dnn:Label>
		</td>
		<td valign="bottom">
			<asp:TextBox id="txtDefaultPageSize" cssclass="NormalTextBox" textmode="SingleLine"
				maxlength="3" runat="server" />
			<asp:RangeValidator id="valDefaultPageSizeRange" runat="server" controltovalidate="txtDefaultPageSize" type="Integer" maximumvalue="999" minimumvalue="1" display="Dynamic" setfocusonerror="true"><br />Enter a value between 1 and 999. The default is 25 if left blank.</asp:RangeValidator>
		</td>
	</tr>
	
</table>
