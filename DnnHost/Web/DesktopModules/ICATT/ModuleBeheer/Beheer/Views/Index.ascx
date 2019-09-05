<%@ Control Language="C#" AutoEventWireup="true" Inherits="Icatt.Dnn.Mvc.ViewUserControl" %>
<%@ Import Namespace="System.Activities.Statements" %>
<%@ Import Namespace="Icatt.Dnn.Extensions.ModuleBeheer.Models.Beheer" %>
<%@ Import Namespace="Icatt.Dnn.Mvc.Presenting" %>
<%
    var data = Model as Icatt.Dnn.Extensions.ModuleBeheer.Models.Beheer.IndexModel ?? new IndexModel();

    if (Messages.Count > 0)
    {
        var message = Messages.First();
%>
<div class="messageHeader"><span class="<%= message.Type > ViewMessageType.Informational ? "dnnFormError" : "" %>"><%= message.Text %></span></div>
<%        
    }
%>

<div>
<a href="<%= Html.ActionLink("DeploySystemResources") %>">(Re)deploy system resources</a>    
</div>
<table id="<%= UniquePrefix %>">
    <tr>
        <th></th>
        <th>Active</th>
        <th>Suite</th>
        <th style="text-align: center">Installed Version</th>
        <th style="text-align: center">Assembly Version</th>
        <th></th>
        <th></th>
    </tr>
    <%
        foreach (var suiteInfo in data.ModuleSuites)
        {
    %>
    <tr>
        <td class="bttn-plusmin">+</td>
        <td><%: suiteInfo.Installed.HasValue ? suiteInfo.Installed.Value ? "ja" : "nee" : "gedeeltelijk" %></td>
        <td title="<%: suiteInfo.Namespace %>"><%: "..."+suiteInfo.Namespace.Split(new []{'.'}).Last() %></td>
        <td style="text-align: center"><%: suiteInfo.Modules.Min(m => m.InstalledVersion)   %></td>
        <td style="text-align: center"><%: suiteInfo.AssemblyVersion %></td>
        <td>
            <%
            if (suiteInfo.Installed.HasValue && !suiteInfo.Installed.Value)
            {
            %>
            <a href="<%= Html.ActionLink("ActivateSuite", new NameValueCollection() {{"name", suiteInfo.Namespace}}) %>">Activeer suite</a>
            <%
            }
            else if (suiteInfo.Installed.HasValue && suiteInfo.Installed.Value)
            {
            %>
            <a href="<%= Html.ActionLink("DeactivateSuite", new NameValueCollection() {{"name", suiteInfo.Namespace}}) %>">Deactiveer suite</a>
            <%
            }
            %>
        </td>
        <td><a href="<%= Html.ActionLink("DeploySuiteResources", new NameValueCollection() {{"name", suiteInfo.Namespace}}) %>">Resources plaatsen</a></td>
    </tr>
    <tr style="display: none;" data-suite="<%: suiteInfo.Namespace %>">
        <td colspan="2">&nbsp;</td>
        <td colspan="4">
            <table>
                <tr>
                    <th>Active</th>
                    <th>Friendly Name</th>
                    <th style="text-align: center">Installed Version</th>
                    <th>Assembly Version</th>
                    <th></th>
                    <th></th>
                </tr>
                <% foreach (var moduleInfo in suiteInfo.Modules.Select(m => m.Info))
                   {
                %>
                <tr>
                    <td><%= moduleInfo.IsActivated ? "ja" : "nee" %></td>
                    <td title="<%: moduleInfo.DesktopModuleName %>"><%: moduleInfo.DefaultController.Names.FriendlyName %></td>
                    <td style="text-align: center"><%= moduleInfo.DnnProperties.Version %></td>
                    <td style="text-align: center"><%= moduleInfo.DefaultController.AssemblyVersion %></td>
                    <td><% if (!moduleInfo.IsActivated && moduleInfo.DefaultController.HasDefaultAction)
                           {
                    %><a href="<%= Html.ActionLink("ActivateModule", new NameValueCollection() {{"name", moduleInfo.DesktopModuleName}}) %>">Activeer</a>
                        <%
                           }
                           else if (!moduleInfo.DefaultController.HasDefaultAction)
                           {
                        %>No default action<%
                           }
                           else if (moduleInfo.IsActivated)
                           {
                        %>
                      <a href="<%= Html.ActionLink("DeactivateModule", new NameValueCollection() {{"name", moduleInfo.DesktopModuleName}}) %>">Deactiveer</a>
                        <%
                           }
                        %></td>
                    <td><a href="<%= Html.ActionLink("DeployModuleResources", new NameValueCollection() {{"name", moduleInfo.DesktopModuleName}}) %>">Resources plaatsen</a></td>
                </tr>
                <%
                   } %>
            </table>
        </td>
    </tr>
    <%
        }
    %>
</table>
<script type="text/javascript">
    (function ($) {

        $(function () {
            $('#<%=UniquePrefix%> > tbody > tr > td.bttn-plusmin')
                .click(function () {
                    var $btn = $(this);

                    if ($btn.text() == '-' || $btn.data('open') == true) {
                        $btn.parent().next().hide();
                        $btn.text('+');
                        $btn.data('open', false);
                    } else {
                        $btn.parent().next().show();
                        $btn.text('-');
                        $btn.data('open', true);
                    }
                });

        });

    })(jQuery);
</script>



