<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Preview.ascx.cs" Inherits="WI.Modules.WowChartv2.InnerControls.Preview" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.Web.Client.ClientResourceManagement" Assembly="DotNetNuke.Web.Client" %>

<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Content/angular-toastr.min.css" />
<dnn:DnnCssInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Content/angular-busy.min.css" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Scripts/highcharts.js" Priority="1" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Scripts/highcharts-more.js" Priority="2" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Scripts/drilldown.js" Priority="2" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Scripts/jquery-migrate-fixes.js" Priority="3" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Scripts/angular-toastr.tpls.min.js" Priority="3" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/Scripts/angular-busy.min.js" Priority="3" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/services/chartService.js" Priority="4" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/view/controllers/mainAppCtrl.js" Priority="4" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/view/app.js" Priority="5" />

<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/common.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/ngGoalChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/ngHighChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/ngOrgChart.js" Priority="6" />
<dnn:DnnJsInclude runat="server" FilePath="~/DesktopModules/WI/WowChartv2/apps/core.js" Priority="7" />

<div id="module-<%=ModuleId %>" data-ng-controller="mainAppCtrl as ctrl" data-ng-init="ctrl.init()" data-ng-cloak="" data-cg-busy="{promise:ctrl.appPromise}" class="chart-module-container">
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
        fetchPermissions('WowChartv2.ngApp-<%= ModuleId %>', WowChartv2_InitViewApp, {
            PortalAliasId: <%= PortalAlias.PortalAliasID %>, 
            ModuleId: <%= ModuleId %>, 
            TabId: <%= TabId %>,
            BusyMsg: 'Preparing Chart',
            TemplatesUrl: '<%= ResolveUrl("../apps/view/templates/") %>',
            BaseTemplatesUrl: '<%= ResolveUrl("../apps/templates/") %>',
            ServiceUrl: '<%= ResolveUrl("../Services/Main.asmx") %>',
            ExportingJsUrl: '<%= ResolveUrl("../Scripts/exporting.js") %>',
            ExportCSVJsUrl: '<%= ResolveUrl("../Scripts/export-csv.js") %>',
            Highcharts3dJsUrl:'<%= ResolveUrl("../Scripts/highcharts-3d.js") %>',
            PreviewMode:true,
            FrameId:'<%= Request.QueryString.Get("iframe") %>'
        }).then(bootstrapApplication);
    });

    (function ($) {
        $(document.body).ready(function () {
            var maxRetries = 10, retries = 1;
            var x = setInterval(function () {
                var $container = $('.personalBarContainer');
                if ($container.length > 0) {
                    $container.remove();
                    clearInterval(x);
                } else {
                    var $controlPanel = $('#ControlBar_ControlPanel');
                    if ($controlPanel.length > 0) {
                        $controlPanel.remove();

                        var $form = $('body > form');
                        $form.removeClass('showControlBar');
                    }
                    else if (retries >= maxRetries) {
                        clearInterval(x);
                    }
                }
                retries++;
            }, 150);
        });
    })($);

</script>
