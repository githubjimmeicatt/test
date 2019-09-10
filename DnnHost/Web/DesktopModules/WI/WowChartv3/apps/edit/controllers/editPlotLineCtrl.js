WowChartv3_editPlotLineCtrl.$inject = ['$scope', 'dialogService', 'ModuleInfo'];
function WowChartv3_editPlotLineCtrl($scope, dialogService, ModuleInfo) {
    var self = this, dialogId;

    self.init = init;
    self.save = save;
    self.cancel = cancel;

    function save() {
        dialogService.close(dialogId, self.plotLine);
    }
    function cancel() {
        dialogService.cancel(dialogId);
    }

    function init() {
        self.viewMoreImageUrl = ModuleInfo.ViewMoreImageUrl;
        self.plotLine = $scope.model.PlotLine;
        self.DataSources = [{ Id: 1, Text: 'Fixed Value' }, { Id: 3, Text: 'Chart Data' }, { Id: 2, Text: 'SQL Data' }];
        self.StatFunctions = [{ Id: 'max', Text: 'Maximum' }, { Id: 'min', Text: 'Minimum' }, { Id: 'mean', Text: 'Mean' }, { Id: 'median', Text: 'Median' }, { Id: 'mode', Text: 'Mode' }, { Id: 'stdev', Text: 'Standard deviation' }, { Id: 'variance', Text: 'Variance' }, { Id: 'quantiles|0.25', Text: '1st Quantile' }, { Id: 'quantiles|0.5', Text: '2nd Quantile' }, { Id: 'quantiles|0.75', Text: '3rd Quantile' }];
        self.LineStyles = ['Solid', 'ShortDash', 'ShortDot', 'ShortDashDot', 'ShortDashDotDot', 'Dot', 'Dash', 'LongDash', 'DashDot', 'LongDashDot', 'LongDashDotDot'];
        dialogId = $scope.model.DialogId;
    }
}