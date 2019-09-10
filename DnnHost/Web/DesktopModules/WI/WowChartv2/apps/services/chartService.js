WowChartv2_chartService.$inject = ['$http', 'ModuleInfo'];
function WowChartv2_chartService($http, ModuleInfo) {
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

    obj.getChartSetting = function () {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetChartSetting",
            headers: obj.headers,
            data: ''
        });
    }

    obj.getChartData = function (filters) {
        var parentUrl = null;
        if (ModuleInfo.PreviewMode == true) {
            parentUrl = document.referrer;
        } else {
            parentUrl = null;
        }

        if (angular.isUndefinedOrNull(filters)) filters = null;

        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetChartData",
            headers: obj.headers,
            data: {
                parentUrl: parentUrl,
                filters: filters
            }
        });
    }

    obj.saveChartSetting = function (dataSource, settings, dsSettings) {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/SaveChartSetting",
            headers: obj.headers,
            data: {
                dataSource: dataSource,
                settings: settings,
                dsSettings: dsSettings
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