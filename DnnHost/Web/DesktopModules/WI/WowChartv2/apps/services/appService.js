WowAnalytics_appService.$inject = ['$http', 'ModuleInfo'];
function WowAnalytics_appService($http, ModuleInfo) {
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

    obj.getChartData = function () {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/GetChartData",
            headers: obj.headers,
            data: ''
        });
    }

    obj.saveChartSetting = function (settings, dsSettings) {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/SaveChartSetting",
            headers: obj.headers,
            data: {
                settings: settings,
                dsSettings: dsSettings
            }
        });
    }

    obj.importDnnSiteLogs = function () {
        return $http({
            method: 'POST',
            url: ModuleInfo.ServiceUrl + "/ImportDnnSiteLogs",
            headers: obj.headers,
            data: ''
        });
    }

    return obj;
}