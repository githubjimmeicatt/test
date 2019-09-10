var WowChartv2_InitViewApp = function (appName) {
    'use strict';

    angular
        .module(appName, ['WowChartv2.Core', 'cgBusy'])
        //.config(configRoute)
        .config(commonAppConfig)
        .factory('chartService', WowChartv2_chartService)
        //.controller('indexCtrl', WowChartv2_indexCtrl)
        .controller('mainAppCtrl', WowChartv2_mainAppCtrl);

    configRoute.$inject = ['$routeProvider', 'ModuleInfo'];
    function configRoute($routeProvider, ModuleInfo) {
        $routeProvider
            .when('/', {
                templateUrl: ModuleInfo.TemplatesUrl + 'index.html?' + ver,
                controller: 'indexCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: false
                }
            }).when('/Unauthorized', {
                templateUrl: ModuleInfo.BaseTemplatesUrl + 'unauthorized.html?' + ver,
                controller: 'UnauthorizedCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: false
                }
            });
    }
}