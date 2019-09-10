<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="WI.Modules.WowChartv3.InnerControls.View" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Content/angular-toastr.min.css" />
<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Content/angular-busy.min.css" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/jquery-migrate-fixes.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/jstat.min.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/highcharts.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/highcharts-more.js" Priority="2" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/drilldown.js" Priority="2" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/angular-toastr.tpls.min.js" Priority="3" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/angular-busy.min.js" Priority="3" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/services/chartService.js" Priority="4" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/view/controllers/mainAppCtrl.js" Priority="4" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/view/app.js" Priority="5" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/common.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngGoalChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngHighChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngOrgChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/core.js" Priority="7" />

<asp:HyperLink ID="lnkSetupCharts" runat="server" Text="Setup Charts" CssClass="dnnSecondaryAction" Visible="false" />

<div id="module-<%=ModuleId %>" data-ng-controller="mainAppCtrl as ctrl" data-ng-init="ctrl.init()" data-ng-cloak="" data-cg-busy="{promise:ctrl.appPromise}" class="chart-module-container">
    <select data-ng-model="ctrl.selectedChart" data-ng-options="chart as 'Id: ' + chart.Id + ' ' + chart.Name for chart in ctrl.charts" data-ng-change="ctrl.onChartChange()" data-ng-if="ctrl.charts.length>1" style="display:initial;min-width:250px;padding:5px;margin-bottom:5px;">
    </select>
    <div class="dnnFormMessage dnnFormInfo" data-ng-if="ctrl.emptyData">
        <strong>{{ctrl.settings.Options.lang.noData}}</strong>
    </div>
    <div data-ng-if="ctrl.emptyData==false && ctrl.settings.Options.mics.showSeriesSelector==true">
        <select data-ng-model="ctrl.currentSeries" data-ng-options="ctrl.settings.Series.indexOf(ser) as ser for ser in ctrl.settings.Series" data-ng-change="ctrl.onSeriesChange()"></select>
    </div>
    <div data-ng-if="ctrl.emptyData==false && ctrl.settings.Options.chart.typeId<200" data-ng-style="ctrl.settings.Options.style" data-chart-settings="ctrl.settings" data-ng-high-chart=""></div>
    <div data-ng-if="ctrl.emptyData==false && ctrl.settings.Options.chart.typeId==200" data-ng-style="ctrl.settings.Options.style" data-chart-settings="ctrl.settings" data-ng-org-chart=""></div>
    <canvas data-ng-if="ctrl.emptyData==false && ctrl.settings.Options.chart.typeId==255" data-ng-style="ctrl.settings.Options.style" data-chart-settings="ctrl.settings" data-ng-goal-chart=""></canvas>
</div>
<script type="text/javascript">
    var ver = '<%= this.Version %>';
    angular.element(document).ready(function () {
        fetchPermissions('WowChartv3.ngApp-<%= ModuleId %>', WowChartv3_InitViewApp, {
            PortalAliasId: <%= PortalAlias.PortalAliasID %>, 
            ModuleId: <%= ModuleId %>, 
            TabId: <%= TabId %>,
            BusyMsg: 'Preparing Chart',
            TemplatesUrl: '<%= ResolveUrl("../apps/view/templates/") %>',
            BaseTemplatesUrl: '<%= ResolveUrl("../apps/templates/") %>',
            ServiceUrl: '<%= ResolveUrl("../Services/Main.asmx") %>',
            ExportingJsUrl: '<%= ResolveUrl("../Scripts/exporting.js") %>',
            OfflineExportingJsUrl: '<%= ResolveUrl("../Scripts/offline-exporting.js") %>',
            ExportCSVJsUrl: '<%= ResolveUrl("../Scripts/export-csv.js") %>',
            Highcharts3dJsUrl: '<%= ResolveUrl("../Scripts/highcharts-3d.js") %>',
            HighchartsWordcloudModuleUrl:'<%= ResolveUrl("../Scripts/hc-modules/wordcloud.js") %>'
        }).then(bootstrapApplication);
    });
</script>
