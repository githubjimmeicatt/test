<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LogOverview.aspx.cs" Inherits="Sphdhv.Klantportaal.Audit.LogOverview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <style>
        table {
            width: 100%;
        }

        label {
            margin-top: 5px;
        }

        div.pageheader {
            font-family: Tahoma;
            font-size: 14px;
            font-weight: bold;
        }

        div.pagesubheader {
            font-family: Tahoma;
            font-size: 10px;
            margin: 4px 0 12px 0;
            display: block;
        }

        div.cell{
            margin: 0;
            float: left;
            padding: 0 20px 0 0;
        }

        div.row {
            padding: 0;
        }

        .header {
            font-family: Tahoma;
            font-size: 11px;
            font-weight: bold;
            background-color: #D0D0D0;
            border: solid 1px #909090;
        }

        .row {
            font-family: Tahoma;
            font-size: 10px;
            padding: 2px 4px;
        }

        .item {
            border: solid 1px #D0D0D0;
        }

        .itemstrong {
            font-weight: bold;
            border: solid 1px #D0D0D0;
        }

        .btn-search {
            margin-top: 10px;
        }

        .hidden {
            display: none;
        }

        div.pagesubheader input, div.pagesubheader label {
            display: block;
        }

        .validationMessage {
            color: #ff3300;
        }
    </style>
    <form id="form1" runat="server">
        <div>
            <div class="pageheader">Log Sphdhv </div>
            <div class="pagesubheader">

                <div class="row">
                    <div class="cell">
                        <label>Na</label>
                        <asp:TextBox runat="server" ID="txtNa" Width="200px"></asp:TextBox>
                    </div>
                    <div class="cell">
                        <label>Vóór</label>
                        <asp:TextBox runat="server" ID="txtVoor" Width="200px"></asp:TextBox>
                    </div>
                    <div class="cell">
                        Vul altijd een datum-tijd bereik in. Default wordt de laatste 24 uur ingevuld. Queries zonder datum-tijd bereik en mét andere filters worden heel erg traag en 
                    kunnen het wegschrijven van nieuwe statements naar de database belemmeren. Bij leeglaten van Voor/Na velden wordt een default waarde ingevuld.
                    </div>
                </div>
                <br style="clear: both" />

                <label>Bericht tekst</label>
                <asp:TextBox runat="server" ID="txtBericht" Width="200px"></asp:TextBox>

                <label>Sessie</label>
                <asp:TextBox runat="server" ID="txtSession" Width="200px"></asp:TextBox>

                <label>Request</label>
                <asp:TextBox runat="server" ID="txtRequest" Width="200px"></asp:TextBox>


                <label>Area tekst</label>
                <asp:TextBox runat="server" ID="txtArea" Width="200px"></asp:TextBox>


                <label>Details</label>
                <asp:TextBox runat="server" ID="txtDetails" Width="200px"></asp:TextBox>

                
                


                <label>Application</label>
                <%--<asp:TextBox runat="server" ID="txtApplication"></asp:TextBox>--%>
                <asp:DropDownList runat="server" id="ddlAppName">
                    <asp:ListItem Value="" Text="-- Alle applicaties --"/>
                </asp:DropDownList>

                <label>Vanaf niveau</label>
                <asp:DropDownList runat="server" ID="ddlLevel" DataSourceID="LogLevelDatasource" DataTextField="Text" DataValueField="Value">
                </asp:DropDownList>


                <asp:Button runat="server" CssClass="btn-search" ID="btnSearch" OnClick="BtnSearchClick" Text="Zoek" />

            </div>


        <asp:GridView ID="gvwLog" runat="server" AutoGenerateColumns="false"
            GridLines="None" DataSourceID="ObjectDataSource1">
            <HeaderStyle CssClass="header" />
            <RowStyle CssClass="row" />
            <Columns>
                <asp:BoundField DataField="CreatedAtLocal" DataFormatString="{0:dd/MM/yyyy HH:mm:ss.fffffff}" HeaderText="Datum">
                    <HeaderStyle CssClass="header" />
                    <ItemStyle CssClass="item" />
                </asp:BoundField>
                <asp:BoundField DataField="SessionId" HeaderText="Sessie">
                    <HeaderStyle />
                    <ItemStyle CssClass="item" />
                </asp:BoundField>
                <asp:BoundField DataField="RequestId" HeaderText="Request">
                    <HeaderStyle />
                    <ItemStyle CssClass="item" />
                </asp:BoundField>
                <asp:BoundField DataField="LogLevel" HeaderText="Niveau">
                    <HeaderStyle />
                    <ItemStyle CssClass="item" />
                </asp:BoundField>
                <asp:BoundField DataField="MessageId" HeaderText="Bericht ID">
                    <HeaderStyle />
                    <ItemStyle CssClass="item" />
                </asp:BoundField>
                <asp:BoundField DataField="Message" HeaderText="Bericht">
                    <HeaderStyle Width="50%" />
                    <ItemStyle CssClass="itemstrong" />
                </asp:BoundField>
                <asp:BoundField DataField="ApplicationArea" HeaderText="Area">
                    <HeaderStyle CssClass="header" />
                    <ItemStyle CssClass="item" />
                </asp:BoundField>
                <asp:HyperLinkField DataNavigateUrlFields="Id,CreatedAtUtc" DataNavigateUrlFormatString="LogDetails.aspx?id={0}&amp;utc={1:yyyy-MM-dd HHmmss.fffffff}" Text="Details">
                    <HeaderStyle CssClass="header" />
                    <ItemStyle CssClass="item" />
                </asp:HyperLinkField>
            </Columns>
        </asp:GridView>


        <asp:ObjectDataSource ID="LogLevelDatasource" runat="server"
            OldValuesParameterFormatString="original_{0}"
            TypeName="Sphdhv.Klantportaal.Audit.LoggingLevelDataSource"
            SelectMethod="GetItems"
            EnablePaging="False"></asp:ObjectDataSource>

        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server"
            OldValuesParameterFormatString="original_{0}" TypeName="Sphdhv.Klantportaal.Audit.LogEntries"
            SelectMethod="GetLogItemsPaged" EnablePaging="True"
            SelectCountMethod="TotalNumberOfProducts"></asp:ObjectDataSource>

        </div>
    </form>
</body>
</html>
