var WowChartv3_InitViewApp = function (appName) {
    'use strict';

    angular
        .module(appName, ['WowChartv3.Core', 'cgBusy'])
        //.config(configRoute)
        .config(commonAppConfig)
        .factory('chartService', WowChartv3_chartService)
        .controller('mainAppCtrl', WowChartv3_mainAppCtrl);
}