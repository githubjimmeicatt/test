WowChartv2_indexCtrl.$inject = ['$scope', '$rootScope', '$filter', 'pageService', 'chartService', 'toastrService', 'ModuleInfo', 'utils'];
function WowChartv2_indexCtrl($scope, $rootScope, $filter, pageService, chartService, toastrService, ModuleInfo, utils) {
    var self = this;
    var tabId = "t1";

    self.init = init;
    self.newLabel = newLabel;
    self.removeLabel = removeLabel;
    self.newSeries = newSeries;
    self.removeSeries = removeSeries;
    self.saveData = saveData;
    self.onChartTypeChange = onChartTypeChange;
    self.onLegendEnabledChanged = onLegendEnabledChanged;
    self.newDrillDownItem = newDrillDownItem;
    self.removeLabelDrillDownItem = removeLabelDrillDownItem;
    self.onFileFolderChange = onFileFolderChange;
    self.onDataSourceChange = onDataSourceChange;
    self.uploadCSVFile = uploadCSVFile;
    self.cancelUploadCSVFile = cancelUploadCSVFile;
    self.onFileDataSourceInfoChanged = onFileDataSourceInfoChanged;

    self.newSeriesColor = newSeriesColor;
    self.removeSeriesColor = removeSeriesColor;
    self.saveSeriesColor = saveSeriesColor;
    self.validSeriesColor = validSeriesColor;
    self.cancelSeriesColor = cancelSeriesColor;

    self.newYAxisPlotBand = newYAxisPlotBand;
    self.removeYAxisPlotBand = removeYAxisPlotBand;
    self.saveYAxisPlotBand = saveYAxisPlotBand;
    self.validYAxisPlotBand = validYAxisPlotBand;
    self.cancelYAxisPlotBand = cancelYAxisPlotBand;

    self.newXAxisPlotBand = newXAxisPlotBand;
    self.removeXAxisPlotBand = removeXAxisPlotBand;
    self.saveXAxisPlotBand = saveXAxisPlotBand;
    self.validXAxisPlotBand = validXAxisPlotBand;
    self.cancelXAxisPlotBand = cancelXAxisPlotBand;

    self.newPointColor = newPointColor;
    self.removePointColor = removePointColor;
    self.savePointColor = savePointColor;
    self.validPointColor = validPointColor;
    self.cancelPointColor = cancelPointColor;

    self.toggleDataTableSelection = toggleDataTableSelection;
    self.onTabSelected = onTabSelected;

    function onTabContentClick() {
        if ($('#' + tabId + 'Content .ng-invalid').length == 0) {
            $('#' + tabId).removeClass('ng-invalid');
        } else {
            $('#' + tabId).addClass('ng-invalid');
        }
    }
    function onTabSelected(tId, firstLoad) {
        onTabContentClick();

        tabId = tId;
        onTabContentClick();

        var $tabContent = $('#' + tabId + 'Content');
        $('#tabs ul.dnnVerticalTabs').height(Math.max(300, $tabContent.height() + 45));
        $tabContent.click(onTabContentClick);

        self.TabName = $('#' + tabId).text();

        if (firstLoad != true) {
            var tabListItem = document.getElementById(tabId);
            $scope.$root['tabs-settings'] = {
                tabIdx: $('#tabs ul.dnnVerticalTabs li').index(tabListItem)
            }
        }
    }

    function toggleDataTableSelection(id) {
        var tables = self.ChartSettings.Options.dataTableIntegration.tables;
        var idx = tables.indexOf(id);
        if (idx > -1) {
            tables.splice(idx, 1);
        }
        else {
            tables.push(id);
        }
    }

    function newPointColor() {
        self.selectedPointColor = {};
    }
    function removePointColor() {
        if (self.selectedPointColor.id) {
            var colors = self.ChartSettings.Options.series[0].pointsColors;
            if (confirm('Are You Sure You Want To Remove This Color?') == true) {
                for (var i = 0; i < colors.length; i++) {
                    if (colors[i].id == self.selectedPointColor.id) {
                        colors.splice(i, 1);
                        cancelPointColor();
                        break;
                    }
                }
            }
        }
    }
    function savePointColor() {
        var col = angular.copy(self.selectedPointColor);
        if (angular.isUndefinedOrNull(col.id)) {
            var colors = self.ChartSettings.Options.series[0].pointsColors;
            col.id = colors.length + 1;
            colors.push(col);
            self.selectedPointColor = colors[colors.length - 1];
        }

        cancelPointColor();
    }
    function validPointColor() {
        if (self.selectedPointColor) {
            if (angular.isUndefinedOrNull(self.selectedPointColor.name)) return false;
            if (angular.isUndefinedOrNull(self.selectedPointColor.color)) return false;

            return true;
        } else {
            return false;
        }
    }
    function cancelPointColor() {
        delete self.selectedPointColor;
    }

    function newXAxisPlotBand() {
        self.selectedXAxisPlotBand = {};
    }
    function removeXAxisPlotBand() {
        if (self.selectedXAxisPlotBand.id) {
            var plotBands = self.ChartSettings.Options.xAxis._plotBands;
            if (confirm('Are You Sure You Want To Remove This Range Color?') == true) {
                for (var i = 0; i < plotBands.length; i++) {
                    if (plotBands[i].id == self.selectedXAxisPlotBand.id) {
                        plotBands.splice(i, 1);
                        cancelXAxisPlotBand();
                        break;
                    }
                }
            }
        }
    }
    function saveXAxisPlotBand() {
        var col = angular.copy(self.selectedXAxisPlotBand);
        if (angular.isUndefinedOrNull(col.id)) {
            var plotBands = self.ChartSettings.Options.xAxis._plotBands;
            col.id = plotBands.length + 1;
            plotBands.push(col);
            self.selectedXAxisPlotBand = plotBands[plotBands.length - 1];
        }

        cancelXAxisPlotBand();
    }
    function validXAxisPlotBand() {
        if (self.selectedXAxisPlotBand) {
            if (angular.isUndefinedOrNull(self.selectedXAxisPlotBand.color)) return false;
            return true;
        } else {
            return false;
        }
    }
    function cancelXAxisPlotBand() {
        delete self.selectedXAxisPlotBand;
    }

    function newYAxisPlotBand() {
        self.selectedYAxisPlotBand = {};
    }
    function removeYAxisPlotBand() {
        if (self.selectedYAxisPlotBand.id) {
            var plotBands = self.ChartSettings.Options.yAxis._plotBands;
            if (confirm('Are You Sure You Want To Remove This Range Color?') == true) {
                for (var i = 0; i < plotBands.length; i++) {
                    if (plotBands[i].id == self.selectedYAxisPlotBand.id) {
                        plotBands.splice(i, 1);
                        cancelYAxisPlotBand();
                        break;
                    }
                }
            }
        }
    }
    function saveYAxisPlotBand() {
        var col = angular.copy(self.selectedYAxisPlotBand);
        if (angular.isUndefinedOrNull(col.id)) {
            var plotBands = self.ChartSettings.Options.yAxis._plotBands;
            col.id = plotBands.length + 1;
            plotBands.push(col);
        }

        cancelYAxisPlotBand();
    }
    function validYAxisPlotBand() {
        if (self.selectedYAxisPlotBand) {
            if (angular.isUndefinedOrNull(self.selectedYAxisPlotBand.color)) return false;

            return true;
        } else {
            return false;
        }
    }
    function cancelYAxisPlotBand() {
        delete self.selectedYAxisPlotBand;
    }

    function newSeriesColor() {
        self.selectedSeriesColor = {};
    }
    function removeSeriesColor() {
        if (self.selectedSeriesColor.id) {
            var colors = self.ChartSettings.Options.series[0].colors;
            if (confirm('Are You Sure You Want To Remove This Color?') == true) {
                for (var i = 0; i < colors.length; i++) {
                    if (colors[i].id == self.selectedSeriesColor.id) {
                        colors.splice(i, 1);
                        cancelSeriesColor();
                        break;
                    }
                }
            }
        }
    }
    function saveSeriesColor() {
        var col = angular.copy(self.selectedSeriesColor);
        if (angular.isUndefinedOrNull(col.id)) {
            var colors = self.ChartSettings.Options.series[0].colors;
            col.id = colors.length + 1;
            colors.push(col);
            self.selectedSeriesColor = colors[colors.length - 1];
        }

        cancelSeriesColor();
    }
    function validSeriesColor() {
        if (self.selectedSeriesColor) {
            if (angular.isUndefinedOrNull(self.selectedSeriesColor.name)) return false;
            if (angular.isUndefinedOrNull(self.selectedSeriesColor.color)) return false;

            return true;
        } else {
            return false;
        }
    }
    function cancelSeriesColor() {
        delete self.selectedSeriesColor;
    }

    function onFileDataSourceInfoChanged() {
        self.ChartSettings.FileDataSourceInfo.xAxesColumn = null;
        self.ChartSettings.FileDataSourceInfo.yAxesColumn = null;
        self.ChartSettings.FileDataSourceInfo.yAxesDataFunc = null;
        self.ChartSettings.FileDataSourceInfo.SeriesColumn = null;
        self.ChartSettings.FileDataSourceInfo.DrillDownColumn = null;
    }

    function onDataSourceChange() {
        self.showCsvUploadField = false;
        self.UploadCSVFileModel = {};
    }

    function uploadCSVFile() {
        var formData = new FormData();

        if (angular.isUndefinedOrNull(self.ChartSettings.FileDataSourceInfo.Folder) == false)
            formData.append('TargetFolder', self.ChartSettings.FileDataSourceInfo.Folder);

        if (angular.isUndefinedOrNull(self.UploadCSVFileModel.Override) == false)
            formData.append('Override', self.UploadCSVFileModel.Override);

        formData.append('file', self.UploadCSVFileModel.File);

        self.appPromise = chartService.uploadCSVFile(formData);
        utils.ajaxSuccess(self.appPromise, function () {
            self.onFileFolderChange();
            self.ChartSettings.FileDataSourceInfo.File = self.UploadCSVFileModel.File.name;

            self.showCsvUploadField = false;
            self.UploadCSVFileModel = {};

            toastrService.success('Wow Chart v2', 'CSV File uploaded successfully');
        });
    }

    function cancelUploadCSVFile() {
        self.showCsvUploadField = false;
        self.UploadCSVFileModel = {};
    }

    function onFileFolderChange() {
        var folder;
        if (angular.isUndefinedOrNull(self.ChartSettings.FileDataSourceInfo.Folder) == false) {
            folder = self.ChartSettings.FileDataSourceInfo.Folder;
        } else {
            folder = "";
        }

        self.appPromise = chartService.getCsvFiles(folder);
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            self.Files = result.d.Files;
        });
    }

    function removeLabel(index) {
        self.ChartSettings.Labels.splice(index, 1);
        angular.forEach(self.ChartSettings.Data, function (row) {
            row.splice(index, 1);
        });
    }

    function removeLabelDrillDownItem(index) {
        if (self.SelectedLabel) {
            self.SelectedLabel.drillDownData.splice(index, 1);
        }
    }

    function newDrillDownItem() {
        if (self.SelectedLabel) {
            self.SelectedLabel.drillDownData.push({
                series: null,
                data: [null, null]
            });
        }
    }

    function onLegendEnabledChanged() {
        self.ChartSettings.Options.plotOptions.series.showInLegend = self.ChartSettings.Options.legend.enabled;
    }

    function setSelectedChartType(settings, chartTypes) {
        if (settings && chartTypes) {
            var typeId = settings.Options.chart.typeId;
            if (typeId != null) {
                var item = $filter("filter")(chartTypes, { Id: typeId });
                self.SelectedChartType = item[0];
            } else {
                self.SelectedChartType = null;
            }
        } else {
            self.SelectedChartType = null;
        }
    }

    function onChartTypeChange() {
        var settings = self.ChartSettings;
        var isGoalChart = false, isPieChart = false;

        if (self.SelectedChartType) {
            settings.Options.chart.typeId = self.SelectedChartType.Id;
            settings.Options.chart.type = self.SelectedChartType.Type;

            isPieChart = self.SelectedChartType.Id == 5;
            isGoalChart = self.SelectedChartType.Id == 255;

            settings.Options.chart.options3d.depth = 100;

            if (settings.Options.plotOptions[settings.Options.chart.type])
                settings.Options.plotOptions[settings.Options.chart.type].depth = 100;

            if (self.SelectedChartType.Id != 1 || self.SelectedChartType.Id != 2 || self.SelectedChartType.Id != 6)
                settings.Options.chart.polar = false;
        } else {

            settings.Options.chart.polar = false;
        }

        if (isGoalChart && settings.DataSourceInfos == undefined) {
            settings.DataSourceInfos = [];
            settings.DataSourceInfos.push({});
            settings.DataSourceInfos.push({});
        } else if (!isGoalChart && settings.Data.length > 0 && settings.Data[0].push == undefined) {
            settings.Data = [];
        }

        if (!isPieChart) {
            settings.Options.mics.showSeriesSelector = false;
        }

        settings.Options.legend.labelFormat = '{name}';
        settings.Options.series[0].colorByPoint = false;
    }

    function setChartSettings(event, settings) {
        if (angular.isUndefinedOrNull(settings.FileDataSourceInfo)) {
            settings.FileDataSourceInfo = {};
        }

        self.ChartSettings = settings;
        setSelectedChartType(self.ChartSettings, self.ChartTypes);
        self.onFileFolderChange();
    }

    function onChartTypesChanged(event, types) {
        self.ChartTypes = types;
        setSelectedChartType(self.ChartSettings, self.ChartTypes);
    }

    function newLabel() {
        self.ChartSettings.Labels.push({
            name: null,
            drillDownData: []
        });

        angular.forEach(self.ChartSettings.Data, function (row) {
            row.push(null);
        });
    }
    function removeLabel(index) {
        self.ChartSettings.Labels.splice(index, 1);
        angular.forEach(self.ChartSettings.Data, function (row) {
            row.splice(index, 1);
        });
    }
    function newSeries() {
        self.ChartSettings.Series.push(null);
        self.ChartSettings.Data.push([]);
    }
    function removeSeries(index) {
        self.ChartSettings.Series.splice(index, 1);
        self.ChartSettings.Data.splice(index, 1);
    }
    function saveData() {

        if (self.ChartSettings.DataSource > 1) {
            self.ChartSettings.Labels = [];
            self.ChartSettings.Series = [];
            self.ChartSettings.Data = [];
            self.ChartSettings.AdditionalData = [];
            self.ChartSettings.AdditionalDataProps = [];
        }

        var settings = angular.copy(self.ChartSettings);
        var dataSourceSettings = {
            ChartTypeId: settings.Options.chart.typeId,
            DataSource: settings.DataSource,
            DataSourceInfo: angular.copy(settings.DataSourceInfo),
            DataSourceInfos: angular.copy(settings.DataSourceInfos),
            FileDataSourceInfo: angular.copy(settings.FileDataSourceInfo)
        };

        delete settings.DataSourceInfo;
        delete settings.DataSourceInfos;
        delete settings.FileDataSourceInfo;
        delete settings.Folders;
        delete settings.PreviewHtml;
        delete settings.DataTables;

        if (self.ChartSettings.DataTables == null)
            settings.Options.dataTableIntegration.enableDriveTables = false;

        if (settings.Options.dataTableIntegration.enableDriveTables == false)
            settings.Options.dataTableIntegration.tables = [];

        var jsonChartSettings = angular.toJson(settings);
        var jsonDSChartSettings = angular.toJson(dataSourceSettings);

        self.appPromise = chartService.saveChartSetting(settings.DataSource, jsonChartSettings, jsonDSChartSettings);
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            if (result.d.PreviewHtml) {
                self.ChartSettings.PreviewHtml = result.d.PreviewHtml
            }

            toastrService.success('Wow Chart v2', 'Chart Settings Saved Successfully');
        });
    }

    function init() {
        pageService.setTitle('Chart Setup');

        self.QueryTypes = [{
            Id: 1,
            Name: 'Table/View/Function'
        }, {
            Id: 2,
            Name: 'Select Statement'
        }];

        self.DataSources = [{
            Id: 1,
            Text: 'Predefined Data'
        }, {
            Id: 2,
            Text: 'SQL Table Data'
        }, {
            Id: 3,
            Text: 'CSV File'
        }];

        self.DrillDownXLocations = [{
            Id: 1,
            Text: 'Title'
        }, {
            Id: 2,
            Text: 'Subtitle'
        }];

        $scope.$on('onChartSettingsChanged', setChartSettings);
        if ($rootScope.ChartSettings)
            setChartSettings(null, $rootScope.ChartSettings);

        $scope.$on('OnChartTypesChanged', onChartTypesChanged);
        if ($rootScope.ChartTypes)
            onChartTypesChanged(null, $rootScope.ChartTypes);

        self.Files = [];
        self.showCsvUploadField = false;
        self.UploadCSVFileModel = {};
        self.viewMoreImageUrl = ModuleInfo.ViewMoreImageUrl;

        if (ModuleInfo.UserInfoMessage.length > 0)
            self.userInfoMessage = ModuleInfo.UserInfoMessage;

        onTabSelected(tabId, true);
    }
}