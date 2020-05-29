var WowChartv3_InitEditApp = function (appName) {
    'use strict';

    angular
        .module(appName, ['WowChartv3.Core', 'ngRoute', 'cgBusy', 'colorpicker.module', 'dialogService'])
        .config(configRoute)
        .config(commonAppConfig)
        .factory('chartService', WowChartv3_chartService)
        .controller('mainAppCtrl', WowChartv3_mainAppCtrl)
        .controller('indexCtrl', WowChartv3_indexCtrl)
        .controller('editPlotLineCtrl', WowChartv3_editPlotLineCtrl);

    configRoute.$inject = ['$routeProvider', '$locationProvider', 'ModuleInfo'];
    function configRoute($routeProvider, $locationProvider, ModuleInfo) {
        $locationProvider.hashPrefix('');

        $routeProvider
            .when('/', {
                templateUrl: ModuleInfo.TemplatesUrl + 'index.html?' + ModuleInfo.Version,
                controller: 'indexCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: true
                }
            })
            .when('/Preview', {
                templateUrl: ModuleInfo.TemplatesUrl + 'preview.html?' + ModuleInfo.Version,
                controller: 'previewCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: true
                }
            })
            .when('/Unauthorized', {
                templateUrl: ModuleInfo.BaseTemplatesUrl + 'unauthorized.html?' + ModuleInfo.Version,
                controller: 'UnauthorizedCtrl',
                controllerAs: 'ctrl',
                access: {
                    authRequired: false
                }
            });
    }
};