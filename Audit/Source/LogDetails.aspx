<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogDetails.aspx.cs" Inherits="Sphdhv.Klantportaal.Audit.LogDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
	<style>
		div.pageheader	{ font-family: Tahoma; font-size: 14; font-weight:bold; margin:8px 0px; }
		div.pagesubheader	{ font-family: Tahoma; font-size:10px; margin:4px 0px 12px 16px; }
		.header			{ font-family: Tahoma; font-size:11px; font-weight:bold; background-color:#A0A0FF; border:solid 1px #8080EF; }
		.fieldrow			{ margin:0; }
		.fieldtable			{ margin:0; }
		.entrylabel		{ font-family: Tahoma; font-size:11px; padding:2px 4px; }
		.entryvalue		{ font-family: Tahoma; font-size:11px; font-weight:bold; padding:2px 4px; }
		.item			{ border:solid 1px #D0D0D0; }
		.itemstrong		{ font-weight:bold; border:solid 1px #D0D0D0; }
		.hidden			{ display: none;}
		.scrollbox		{ font-family: Tahoma; font-size:12px; overflow: auto; border: solid 1px #D0D0D0; padding: 4px; }
	</style>
    <form id="form1" runat="server">
    <div>
		<div class="pageheader">Details log entry <asp:Literal ID="litCreatedDate" runat="server" /></div>
		<br/>
		<table class="fieldtable">
			<tr class="fieldrow">
				<td class="entrylabel" style="width:100px;">Bericht</td>
				<td class="entryvalue" style="width:600px;"><asp:Literal ID="litMessage" runat="server" /></td>
			</tr>
			<tr>
				<td class="entrylabel" style="width:100px;">Level</td>
				<td class="entryvalue" style="width:600px;"><asp:Literal ID="litLogLevel" runat="server" /></td>
			</tr>
			<tr>
				<td class="entrylabel" style="width:100px;">Area</td>
				<td class="entryvalue" style="width:600px;"><asp:Literal ID="litApplicationArea" runat="server" /></td>
			</tr>
		</table>
		<br/>
		<div class="scrollbox" style="width:800px; height:400px;"><asp:Literal ID="litDetails" runat="server" /></div>
    </div>
    </form>
</body>
</html>
