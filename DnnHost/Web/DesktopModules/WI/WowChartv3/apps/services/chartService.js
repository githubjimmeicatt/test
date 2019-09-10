WowChartv3_chartService.$inject = ['$http', 'ModuleInfo'];
function WowChartv3_chartService($http, ModuleInfo) {
    var obj = {};

    obj.headers = {
        "PortalAliasId": ModuleInfo.PortalAliasId,
        "ModuleId": ModuleInfo.ModuleId,
        "TabId": ModuleInfo.TabId,
        "Content-Type": "application/json; charset=utf-8"
    };

    obj.header2 = {
        "PortalAliasId": ModuleInfo.PortalAliasId,
        "ModuleId": ModuleInfo.ModuleId,
        "TabId": ModuleInfo.TabId,
        "Content-Type": undefined
    };

    obj.getEditModel = function () {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetEditModel",
            headers: obj.headers,
            data: {}
        });
    }

    obj.deleteChart = function (chartId) {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/DeleteChart",
            headers: obj.headers,
            data: {
                chartId: chartId
            }
        });
    }

    obj.getChartSetting = function (chartId, reportId, previewMode) {
        if (angular.isUndefinedOrNull(chartId)) chartId = null;
        if (angular.isUndefinedOrNull(reportId)) reportId = null;
        if (angular.isUndefinedOrNull(previewMode)) previewMode = false;

        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetChartSetting",
            headers: obj.headers,
            data: {
                chartId: chartId,
                reportId: reportId,
                previewMode: previewMode
            }
        });
    }

    obj.getChartData = function (input) {
        if (ModuleInfo.PreviewMode == true) {
            input.parentUrl = document.referrer;
        }

        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetChartData",
            headers: obj.headers,
            data: {
                input: input
            }
        });
    }

    obj.saveChartSetting = function (chart) {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/SaveChartSetting",
            headers: obj.headers,
            data: {
                chartDTO: chart
            }
        });
    }

    obj.getCsvFiles = function (folder) {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetCsvFiles",
            headers: obj.headers,
            data: { folder: folder }
        });
    }

    obj.uploadCSVFile = function (data) {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/UploadCSVFile",
            headers: obj.header2,
            data: data
        });
    }

    return obj;
}