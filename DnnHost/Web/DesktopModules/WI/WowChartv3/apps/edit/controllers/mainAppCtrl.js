WowChartv3_mainAppCtrl.$inject = ['$scope', '$rootScope', 'chartService', 'toastrService', 'utils'];
function WowChartv3_mainAppCtrl($scope, $rootScope, chartService, toastrService, utils) {
    var self = this;
    self.init = init;

    function init() {
        self.appPromise = chartService.getEditModel();
        utils.ajaxSuccess(self.appPromise, function (response) {
            var result = response.data;

            if (!angular.isUndefinedOrNull(result.d)
                && !angular.isUndefinedOrNull(result.d.Error)) {
                toastrService.error(result.d.Error);
                return;
            }

            var editModel = {
                charts: result.d.Charts,
                chartTypes: result.d.ChartTypes,
                seriesChartTypes: result.d.SeriesChartTypes,
                folders: result.d.Folders,
                previewHtml: result.d.PreviewHtml,
                driveTables: result.d.DriveTables,
                driveCharts: result.d.DriveCharts,
                userActionTypes: result.d.UserActionTypes,
                userActionActs: result.d.UserActionActs,
                userActionTargets: result.d.UserActionTargets
            };

            $rootScope.editModel = editModel;
            $scope.$broadcast('onEditModelInitialized', editModel);
        });
    }
}