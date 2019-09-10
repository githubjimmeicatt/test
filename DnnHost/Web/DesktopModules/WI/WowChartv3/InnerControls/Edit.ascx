<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Edit.ascx.cs" Inherits="WI.Modules.WowChartv3.InnerControls.Edit" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Content/angular-toastr.min.css" />
<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Content/angular-busy.min.css" />
<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Content/colorpicker.min.css" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/jquery-migrate-fixes.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/jstat.min.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/highcharts.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/highcharts-more.js" Priority="2" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/drilldown.js" Priority="2" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/angular-toastr.tpls.min.js" Priority="3" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/angular-busy.min.js" Priority="3" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/bootstrap-colorpicker-module.min.js" Priority="3" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/Scripts/dialog-service.min.js" Priority="3" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/services/chartService.js" Priority="4" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/edit/controllers/mainAppCtrl.js" Priority="4" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/edit/controllers/indexCtrl.js" Priority="4" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/edit/controllers/editPlotLineCtrl.js" Priority="4" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/edit/app.js" Priority="5" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/common.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngGoalChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngHighChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngOrgChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/fileModel.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngTooltip.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/ngTabs.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv3/apps/core.js" Priority="7" />

<div id="module-<%=ModuleId %>" data-ng-controller="mainAppCtrl as ctrl" data-ng-init="ctrl.init()" data-ng-cloak="" data-cg-busy="{promise:ctrl.appPromise}" class="chart-module-container">
    <div data-ng-view=""></div>
</div>
<script type="text/javascript">
    var ver = '<%= this.Version %>';
    angular.element(document).ready(function () {
        delete $.fn.dnnCheckbox;
        fetchPermissions('WowChartv3.ngApp-<%= ModuleId %>', WowChartv3_InitEditApp, {
            PortalAliasId: <%= PortalAlias.PortalAliasID %>, 
            ModuleId: <%= ModuleId %>, 
            TabId: <%= TabId %>,
            BusyMsg: 'Processing Request',
            TemplatesUrl: '<%= ResolveUrl("../apps/edit/templates/") %>',
            BaseTemplatesUrl: '<%= ResolveUrl("../apps/templates/") %>',
            ServiceUrl: '<%= ResolveUrl("../Services/Main.asmx") %>',
            ExportingJsUrl: '<%= ResolveUrl("../Scripts/exporting.js") %>',
            OfflineExportingJsUrl: '<%= ResolveUrl("../Scripts/offline-exporting.js") %>',
            ExportCSVJsUrl: '<%= ResolveUrl("../Scripts/export-csv.js") %>',
            Highcharts3dJsUrl: '<%= ResolveUrl("../Scripts/highcharts-3d.js") %>',
            HighchartsWordcloudModuleUrl:'<%= ResolveUrl("../Scripts/hc-modules/wordcloud.js") %>',
            ViewMoreImageUrl: '<%= ResolveUrl("../content/view-more.png") %>',
            EditMode:true,
            UserInfoMessage: '<%= !ManageExpiryDate.HasValue ? "" : "Management License will expire on " + ManageExpiryDate.Value.ToLongDateString() %>',
            BackUrl: '<%= GetBackUrl() %>'
        }).then(bootstrapApplication);
    });
</script>