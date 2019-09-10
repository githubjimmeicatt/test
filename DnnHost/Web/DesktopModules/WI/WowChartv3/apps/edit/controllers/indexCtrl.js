WowChartv3_indexCtrl.$inject = ['$scope', '$rootScope', '$filter', 'chartService', 'toastrService', 'ModuleInfo', 'utils', 'dialogService'];
function WowChartv3_indexCtrl($scope, $rootScope, $filter, chartService, toastrService, ModuleInfo, utils, dialogService) {
    var self = this, tabId = "t1", previewHtml, selectFDSFolder = null, xLine = null;

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

    self.toggleDriveTableSelection = toggleDriveTableSelection;
    self.toggleDriveChartSelection = toggleDriveChartSelection;
    self.onTabSelected = onTabSelected;

    self.onDefinedChartChange = onDefinedChartChange;
    self.previewChart = previewChart;
    self.newChart = newChart;
    self.exit = exit;
    self.onSeriesChange = onSeriesChange;
    self.exitPreview = exitPreview;
    self.deleteChart = deleteChart;

    self.editXAxisLine = editXAxisLine;
    self.removeXAxisLine = removeXAxisLine;
    self.newXAxisLine = newXAxisLine;

    self.editYAxisLine = editYAxisLine;
    self.removeYAxisLine = removeYAxisLine;
    self.newYAxisLine = newYAxisLine;
    self.showTab = showTab;

    function showTab(tId) {
        if (angular.isUndefinedOrNull(self.ChartSettings)) return false;

        if (tId == 3 || tId == 6
            || tId == 14 || tId == 15
            || tId == 30) {
            return self.ChartSettings.Options.chart.typeId < 200;
        } else if (tId == 4 || tId == 5
            || tId == 19 || tId == 20) {
            return self.ChartSettings.Options.chart.typeId != 255;
        } else if (tId == 27) {
            return self.ChartSettings.Options.chart.typeId < 200 && self.DriveCharts != null;
        } else if (tId == 21) {
            return self.ChartSettings.Options.chart.typeId < 200 && self.DriveTables != null;
        } else if (tId == 23 || tId == 24) {
            return self.ChartSettings.Options.chart.typeId == 255;
        } else if (tId == 25 || tId == 26) {
            return self.ChartSettings.Options.chart.typeId == 200;
        } else if (tId == 7 || tId == 8 || tId == 9 || tId == 10
            || tId == 11 || tId == 12 || tId == 13 || tId == 16 || tId == 17 || tId == 18
            || tId == 28 || tId == 29) {
            return self.ChartSettings.Options.chart.typeId != 10 && self.ChartSettings.Options.chart.typeId < 200;
        }
    }

    function editYAxisLine() {
        var plotLine = angular.copy(self.selectedYAxisLine);
        plotLine.DataSource = angular.copy(self.ChartSettings.PlotLinesDataSource.yAxis[plotLine.id]);

        xLine = false;
        openEditPlotLineDlg('Edit Y-Axis Line', plotLine);
    }
    function removeYAxisLine() {
        if (self.selectedYAxisLine.id) {
            if (confirm('Are You Sure You Want To Remove This Line?') == true) {
                for (var i = 0; i < self.ChartSettings.Options.yAxis._plotLines.length; i++) {
                    if (self.ChartSettings.Options.yAxis._plotLines[i].id == self.selectedYAxisLine.id) {
                        self.ChartSettings.Options.yAxis._plotLines.splice(i, 1);
                        delete self.ChartSettings.PlotLinesDataSource.yAxis[self.selectedYAxisLine.id];
                        delete self.selectedYAxisLine;
                        break;
                    }
                }
            }
        }
    }
    function newYAxisLine() {
        var plotLine = {
            DataSource: {},
            Options: {
                label: {}
            }
        };
        xLine = false;
        openEditPlotLineDlg('New Y-Axis Line', plotLine);
    }

    function editXAxisLine() {
        var plotLine = angular.copy(self.selectedXAxisLine);
        plotLine.DataSource = angular.copy(self.ChartSettings.PlotLinesDataSource.xAxis[plotLine.id]);

        xLine = true;
        openEditPlotLineDlg('Edit X-Axis Line', plotLine);
    }
    function removeXAxisLine() {
        if (self.selectedXAxisLine.id) {
            if (confirm('Are You Sure You Want To Remove This Line?') == true) {
                for (var i = 0; i < self.ChartSettings.Options.xAxis._plotLines.length; i++) {
                    if (self.ChartSettings.Options.xAxis._plotLines[i].id == self.selectedXAxisLine.id) {
                        self.ChartSettings.Options.xAxis._plotLines.splice(i, 1);
                        delete self.ChartSettings.PlotLinesDataSource.xAxis[self.selectedXAxisLine.id];
                        delete self.selectedXAxisLine;
                        break;
                    }
                }
            }
        }
    }
    function newXAxisLine() {
        var plotLine = {
            DataSource: {},
            Options: {
                label: {}
            }
        };
        xLine = true;
        openEditPlotLineDlg('New X-Axis Line', plotLine);
    }

    function openEditPlotLineDlg(title, plotLine) {
        var model = {
            DialogId: "editPlotLineDlg",
            PlotLine: plotLine,
        };

        // jQuery UI dialog options
        var options = {
            modal: true,
            resizable: false,
            title: title,
            dialogClass: "dnnFormPopup",
            width: Math.min(800, window.innerWidth * 0.75),
            height: Math.min(600, window.innerHeight * 0.75),
            open: function (event, ui) {
                $(".ui-dialog-titlebar-close", ui.dialog | ui).remove();
            }
        };

        // Open the dialog using template from script
        dialogService.open(model.DialogId, ModuleInfo.TemplatesUrl + 'editPlotLine.html?' + ver, model, options).then(
            function (plotLine) {
                if (xLine == true) {
                    if (angular.isUndefinedOrNull(plotLine.id)) {
                        plotLine.id = self.ChartSettings.Options.xAxis._plotLines.length + Math.floor(Math.random() * 101);
                        self.ChartSettings.PlotLinesDataSource.xAxis[plotLine.id] = plotLine.DataSource;
                        delete plotLine.DataSource;
                        self.ChartSettings.Options.xAxis._plotLines.push(plotLine);
                    } else {
                        self.ChartSettings.PlotLinesDataSource.xAxis[plotLine.id] = plotLine.DataSource;
                        delete plotLine.DataSource;

                        for (var i = 0; i < self.ChartSettings.Options.xAxis._plotLines.length; i++) {
                            if (self.ChartSettings.Options.xAxis._plotLines[i].id == plotLine.id) {
                                self.ChartSettings.Options.xAxis._plotLines[i] = plotLine;
                                self.selectedXAxisLine = self.ChartSettings.Options.xAxis._plotLines[i];
                                break;
                            }
                        }
                    }
                } else if (xLine == false) {
                    if (angular.isUndefinedOrNull(plotLine.id)) {
                        plotLine.id = self.ChartSettings.Options.yAxis._plotLines.length + Math.floor(Math.random() * 101);
                        self.ChartSettings.PlotLinesDataSource.yAxis[plotLine.id] = plotLine.DataSource;
                        delete plotLine.DataSource;
                        self.ChartSettings.Options.yAxis._plotLines.push(plotLine);
                    } else {
                        self.ChartSettings.PlotLinesDataSource.yAxis[plotLine.id] = plotLine.DataSource;
                        delete plotLine.DataSource;

                        for (var i = 0; i < self.ChartSettings.Options.yAxis._plotLines.length; i++) {
                            if (self.ChartSettings.Options.yAxis._plotLines[i].id == plotLine.id) {
                                self.ChartSettings.Options.yAxis._plotLines[i] = plotLine;
                                self.selectedYAxisLine = self.ChartSettings.Options.yAxis._plotLines[i];
                                break;
                            }
                        }
                    }
                }
            },
            function (error) { }
        );
    }

    function fillChartObjectFromUI() {
        var settings = angular.copy(self.ChartSettings);

        if (settings.DataSource > 1) {
            settings.Labels = [];
            settings.Series = [];
            settings.Data = [];
            settings.AdditionalData = [];
            settings.AdditionalDataProps = [];
        }

        var dsSettings = {
            ChartTypeId: settings.Options.chart.typeId,
            DataSource: settings.DataSource,
            DataSourceInfo: angular.copy(settings.DataSourceInfo),
            DataSourceInfos: angular.copy(settings.DataSourceInfos),
            FileDataSourceInfo: angular.copy(settings.FileDataSourceInfo),
            PlotLinesDataSource: angular.copy(settings.PlotLinesDataSource)
        };

        delete settings.DataSourceInfo;
        delete settings.DataSourceInfos;
        delete settings.FileDataSourceInfo;
        delete settings.PlotLinesDataSource;
        delete settings.Options.xAxis.plotLines;
        delete settings.Options.yAxis.plotLines;
        delete settings.Options.xAxis.plotLines;
        delete settings.Options.yAxis.plotLines;
        delete settings.Folders;
        delete settings.PreviewHtml;

        if (self.DriveTables == null)
            settings.Options.dataTableIntegration.enableDriveTables = false;

        if (settings.Options.dataTableIntegration.enableDriveTables == false)
            settings.Options.dataTableIntegration.tables = [];

        if (self.DriveCharts == null)
            settings.Options.driveCharts.enabled = false;

        if (settings.Options.driveCharts.enabled == false)
            settings.Options.driveCharts.charts = [];

        for (var idx = 0; idx < settings.Options.xAxis._plotLines.length; idx++) {
            var line = settings.Options.xAxis._plotLines[idx];
            var lineDS = dsSettings.PlotLinesDataSource.xAxis[line.id];
            line.TypeId = lineDS.TypeId;
            line.StatFunction = lineDS.StatFunction;
            line.Value = lineDS.Value;
        }

        for (var idx = 0; idx < settings.Options.yAxis._plotLines.length; idx++) {
            var line = settings.Options.yAxis._plotLines[idx];
            var lineDS = dsSettings.PlotLinesDataSource.yAxis[line.id];
            line.TypeId = lineDS.TypeId;
            line.StatFunction = lineDS.StatFunction;
            line.Value = lineDS.Value;
        }

        var jsonChartSettings = angular.toJson(settings);
        var jsonDSChartSettings = angular.toJson(dsSettings);

        var chartObj = angular.copy(self.selectedChart);
        chartObj.ChartSettings = jsonChartSettings;
        chartObj.DataSourceSettings = jsonDSChartSettings;

        return chartObj;
    }

    function deleteChart() {
        if (confirm('Are You Sure You Want To Remove This Chart?') == true) {
            self.appPromise = chartService.deleteChart(self.selectedChart.Id);
            utils.ajaxSuccess(self.appPromise, function (response) {
                var result = response.data;
                if (!angular.isUndefinedOrNull(result.d)
                    && !angular.isUndefinedOrNull(result.d.Error)) {
                    toastrService.error(result.d.Error);
                    return;
                }

                for (var idx = 0; idx < self.Charts.length; idx++) {
                    if (self.Charts[idx].Id == self.selectedChart.Id) {
                        self.Charts.splice(idx, 1);
                        delete self.selectedChart;
                        toastrService.success('Wow Chart v3', 'Chart Deleted Successfully');
                        break;
                    }
                }
            });
        }
    }
    function exitPreview() {
        self.previewMode = false;
        delete self.PreviewChartSettings;
        delete self.data;
        delete self.currentSeries;
    }
    function onSeriesChange() {
        self.data = data[self.currentSeries];

        var settings = self.PreviewChartSettings;
        settings.CurrentSeries = settings.Series[self.currentSeries];
        settings.CurrentSeriesIndex = self.currentSeries;
        $scope.$broadcast('onDataChanged', self.data);
    }
    function exit() {
        window.location.href = ModuleInfo.BackUrl;
    }
    function newChart() {
        if (self.previewMode == true)
            exitPreview();

        self.selectedChart = {
            IsDefault: self.Charts.length == 0
        };

        var settings = utils.getInitialChartSettings();
        settings.Options = utils.getInitialChartOptions();
        settings.DataSourceInfo = {};
        settings.FileDataSourceInfo = {};
        settings.PlotLinesDataSource = { xAxis: {}, yAxis: {} };
        self.ChartSettings = settings;
        delete self.selectedXAxisLine;
        delete self.selectedYAxisLine;

        setSelectedChartType(settings, self.ChartTypes);
        onFileFolderChange();

        onTabSelected('t1', true);
        onChartTypeChange();
    }
    function previewChart() {
        delete self.PreviewChartSettings;
        delete self.data;
        delete self.currentSeries;

        self.previewMode = true;

        var chartObj = fillChartObjectFromUI();
        var settings = settings = angular.fromJson(chartObj.ChartSettings);
        if (settings.Options.chart.typeId == null) {
            self.emptyData = true;
            settings.Options = utils.getInitialChartOptions();
            self.PreviewChartSettings = settings;
            return;
        }

        if (settings.DataSource == undefined || settings.DataSource == null || settings.DataSource == 1) {
            self.emptyData = utils.isEmptyData(settings);

            var _settings = angular.deepExtend({}, settings);
            if (_settings.Options.mics.showSeriesSelector && _settings.Series.length > 0) {
                self.currentSeries = 0;
                data = angular.copy(_settings.Data);

                _settings.Data = data[0];
                _settings.CurrentSeries = _settings.Series[0];
                _settings.CurrentSeriesIndex = 0;
            }
            self.PreviewChartSettings = _settings;
            self.PreviewChartSettings._name = chartObj.Name;
        } else {
            var requestInput = { chart: chartObj };
            self.appPromise = chartService.getChartData(requestInput);
            utils.ajaxSuccess(self.appPromise, function (response) {
                var result = response.data;
                if (!angular.isUndefinedOrNull(result.d)
                    && !angular.isUndefinedOrNull(result.d.Error)) {
                    toastrService.error(result.d.Error);
                    self.emptyData = true;
                    return;
                }

                var chartData = result.d.ChartData;
                if (!angular.isUndefinedOrNull(chartData)
                    && !angular.isUndefinedOrNull(chartData.Error)) {
                    toastrService.error(chartData.Error);
                    self.emptyData = true;
                    return;
                }

                settings.Labels = chartData.Labels;
                settings.Series = chartData.Series;
                settings.PlotLinesData = result.d.PlotLinesData;

                self.emptyData = utils.isEmptyData(chartData);

                if (settings.Options.mics.showSeriesSelector && settings.Series.length > 0) {
                    self.currentSeries = 0;
                    data = chartData.Data;

                    settings.Data = data[0];
                    settings.CurrentSeries = settings.Series[0];
                    settings.CurrentSeriesIndex = 0;
                } else {
                    settings.Data = chartData.Data;
                }

                settings.AdditionalDataProps = chartData.AdditionalDataProps;
                settings.AdditionalData = chartData.AdditionalData;

                self.PreviewChartSettings = settings;
                self.PreviewChartSettings._name = chartObj.Name;
            });
        }
    }
    function getPreviewHtml(chartId, settings) {
        var frameId = Math.floor(Math.random() * 10000);
        var width = "100%", heigth = "100%";

        if (!angular.isUndefinedOrNull(settings.Options.style.width)
            && settings.Options.style.width != "")
            width = settings.Options.style.width;

        if (!angular.isUndefinedOrNull(settings.Options.style.heigth)
            && settings.Options.style.heigth != "")
            heigth = settings.Options.style.heigth;

        return String.format(previewHtml, frameId, width, heigth, chartId);
    }
    function onDefinedChartChange() {
        if (self.selectedChart) {
            var settings;
            if (self.selectedChart.ChartSettings) {
                settings = angular.fromJson(self.selectedChart.ChartSettings);

                var dsSettings = angular.fromJson(self.selectedChart.DataSourceSettings);
                settings.DataSource = dsSettings.DataSource;
                settings.DataSourceInfo = dsSettings.DataSourceInfo;
                settings.DataSourceInfos = dsSettings.DataSourceInfos;
                settings.FileDataSourceInfo = dsSettings.FileDataSourceInfo;
                settings.PlotLinesDataSource = dsSettings.PlotLinesDataSource;
                delete dsSettings;
            } else {
                settings = utils.getInitialChartSettings();
            }

            settings.Options = angular.deepExtend(utils.getInitialChartOptions(), settings.Options);
            if (settings.Options.series[0].colors == undefined) settings.Options.series[0].colors = [];
            if (settings.Options.series[0].pointsColors == undefined) settings.Options.series[0].pointsColors = [];

            if (angular.isUndefinedOrNull(settings.FileDataSourceInfo)) {
                settings.FileDataSourceInfo = {};
            }

            if (angular.isUndefinedOrNull(settings.PlotLinesDataSource)) {
                settings.PlotLinesDataSource = { xAxis: {}, yAxis: {} };
            }

            settings.PreviewHtml = getPreviewHtml(self.selectedChart.Id, settings);

            self.ChartSettings = settings;
            setSelectedChartType(self.ChartSettings, self.ChartTypes);
            onFileFolderChange();

            onTabSelected('t1', true);
            onChartTypeChange();
        } else {
            delete self.ChartSettings;
        }

        if (self.previewMode) {
            previewChart();
        }
    }

    function onTabContentClick() {
        if ($('#' + tabId + 'Content .ng-invalid').length == 0) {
            $('#' + tabId).removeClass('ng-invalid');
        } else {
            $('#' + tabId).addClass('ng-invalid');
        }
    }
    function onTabSelected(tId, firstLoad) {
        if (tabId != tId)
            onTabContentClick();

        tabId = tId;
        window.setTimeout(onTabContentClick, 100);

        var $tabContent = $('#' + tabId + 'Content');
        $('#tabs ul.dnnVerticalTabs').height(Math.max(300, $tabContent.height() + 45));
        $tabContent.click(onTabContentClick);

        self.TabName = $('#' + tabId).text();

        if (firstLoad == true) {
            self.activeTabIndex = 0;
        } else {
            var tabListItem = document.getElementById(tabId);
            self.activeTabIndex = $('#tabs ul.dnnVerticalTabs li').index(tabListItem);
        }
    }
    function toggleDriveTableSelection(id) {
        var tables = self.ChartSettings.Options.dataTableIntegration.tables;
        var idx = tables.indexOf(id);
        if (idx > -1) {
            tables.splice(idx, 1);
        }
        else {
            tables.push(id);
        }
    }
    function toggleDriveChartSelection(id) {
        var charts = self.ChartSettings.Options.driveCharts.charts;
        var idx = charts.indexOf(id);
        if (idx > -1) {
            charts.splice(idx, 1);
        }
        else {
            charts.push(id);
        }
    }

    function newPointColor() {
        self.selectedPointColor = {
        };
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
        self.selectedXAxisPlotBand = {
        };
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
        self.selectedYAxisPlotBand = {
        };
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
        self.selectedSeriesColor = {
        };
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
        self.UploadCSVFileModel = {
        };
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
            selectFDSFolder = null;
            self.onFileFolderChange();
            self.ChartSettings.FileDataSourceInfo.File = self.UploadCSVFileModel.File.name;

            self.showCsvUploadField = false;
            self.UploadCSVFileModel = {};

            toastrService.success('Wow Chart v3', 'CSV File uploaded successfully');
        });
    }
    function cancelUploadCSVFile() {
        self.showCsvUploadField = false;
        self.UploadCSVFileModel = {
        };
    }
    function onFileFolderChange() {
        var folder;
        if (angular.isUndefinedOrNull(self.ChartSettings.FileDataSourceInfo.Folder) == false) {
            folder = self.ChartSettings.FileDataSourceInfo.Folder;
        } else {
            folder = "";
        }

        if (selectFDSFolder == null || folder != selectFDSFolder) {
            selectFDSFolder = folder;

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
        var isGoalChart = false, isPieChart = false, isBubbleChart = false, isWordcloudChart = false;

        if (self.SelectedChartType) {
            settings.Options.chart.typeId = self.SelectedChartType.Id;
            settings.Options.chart.type = self.SelectedChartType.Type;

            isPieChart = self.SelectedChartType.Id == 5;
            isBubbleChart = self.SelectedChartType.Id == 9;
            isWordcloudChart = self.SelectedChartType.Id == 10;
            isGoalChart = self.SelectedChartType.Id == 255;

            settings.Options.chart.options3d.depth = 100;

            if (settings.Options.plotOptions[settings.Options.chart.type])
                settings.Options.plotOptions[settings.Options.chart.type].depth = 100;

            if (self.SelectedChartType.Id != 1 || self.SelectedChartType.Id != 2 || self.SelectedChartType.Id != 6) {
                settings.Options.chart.polar = false;
            }
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

        if (!isBubbleChart) {
            delete settings.DataSourceInfo.VolumeColumn;
            delete settings.FileDataSourceInfo.VolumeColumn;
        }

        if (isWordcloudChart) {
            settings.Options.chart.inverted = false;
            settings.Options.xAxis.crosshair = false;
            settings.Options.yAxis.crosshair = false;
            settings.Options.legend.enabled = false;
            settings.Options.plotOptions.series.dataLabels.enabled = false;
            settings.Options.series[0].colorByPoint = true;
            self.xAxesColumnText = "Word";
            self.yAxesColumnText = "Weight";
        } else {
            settings.Options.series[0].colorByPoint = false;
            self.xAxesColumnText = "X-Axes";
            self.yAxesColumnText = "Y-Axes";
        }

        settings.Options.legend.labelFormat = '{name}';
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
        var chartObj = fillChartObjectFromUI();
        self.appPromise = chartService.saveChartSetting(chartObj);
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            result = result.d;
            self.Charts = result.Charts;
            for (var idx = 0; idx < self.Charts.length; idx++) {
                if (self.Charts[idx].Id == result.ChartId) {
                    self.selectedChart = self.Charts[idx];
                    break;
                }
            }
            self.ChartSettings.PreviewHtml = getPreviewHtml(self.selectedChart.Id, self.ChartSettings);
            toastrService.success('Wow Chart v3', 'Chart Settings Saved Successfully');
        });
    }

    function onEditModelInitialized(event, editModel) {
        self.Charts = editModel.charts;
        self.ChartTypes = editModel.chartTypes;
        self.Folders = editModel.folders;
        self.DriveTables = editModel.driveTables;
        self.DriveCharts = editModel.driveCharts;

        previewHtml = editModel.previewHtml;
        onDefinedChartChange();
    }

    function init() {
        self.previewMode = false;
        self.QueryTypes = [{ Id: 1, Name: 'Table/View/Function' }, { Id: 2, Name: 'Select Statement' }];
        self.DataSources = [{ Id: 1, Text: 'Predefined Data' }, { Id: 2, Text: 'SQL Data' }, { Id: 3, Text: 'CSV File' }];
        self.DrillDownXLocations = [{ Id: 1, Text: 'Title' }, { Id: 2, Text: 'Subtitle' }];

        self.Files = [];
        self.showCsvUploadField = false;
        self.UploadCSVFileModel = {
        };
        self.viewMoreImageUrl = ModuleInfo.ViewMoreImageUrl;

        if (ModuleInfo.UserInfoMessage.length > 0)
            self.userInfoMessage = ModuleInfo.UserInfoMessage;

        $scope.$on('onEditModelInitialized', onEditModelInitialized);
        if ($rootScope.editModel)
            onEditModelInitialized(null, $rootScope.editModel);
    }
}