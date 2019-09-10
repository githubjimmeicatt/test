var WowChartv2_InitEditApp = function (appName) {
    'use strict';

    angular
        .module(appName, ['WowChartv2.Core', 'ngRoute', 'cgBusy', 'colorpicker.module'])
        .config(configRoute)
        .config(commonAppConfig)
        .factory('chartService', WowChartv2_chartService)
        .controller('mainAppCtrl', WowChartv2_mainAppCtrl)
        .controller('indexCtrl', WowChartv2_indexCtrl)
        .controller('previewCtrl', WowChartv2_previewCtrl);

    configRoute.$inject = ['$routeProvider', '$locationProvider', 'ModuleInfo'];
    function configRoute($routeProvider, $locationProvider, ModuleInfo) {
        $locationProvider.hashPrefix('');

        $routeProvider
            .when('/', {
                templateUrl: ModuleInfo.TemplatesUrl + 'index.html?' + ver,
                controller: 'indexCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: true
                }
            })
            .when('/Preview', {
                templateUrl: ModuleInfo.TemplatesUrl + 'preview.html?' + ver,
                controller: 'previewCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: true
                }
            })
            .when('/Unauthorized', {
                templateUrl: ModuleInfo.BaseTemplatesUrl + 'unauthorized.html?' + ver,
                controller: 'UnauthorizedCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: false
                }
            });
    }
};