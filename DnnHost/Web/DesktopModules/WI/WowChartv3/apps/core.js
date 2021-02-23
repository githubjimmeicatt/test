(function () {
    'use strict';

    var ngApp = angular
        .module("WowChartv3.Core", ['toastr']);

    ngApp
        .service("utils", utils)
        .service("authentication", authentication)
        .service("toastrService", toastrService)
        .factory("authHttpResponseInterceptor", authHttpResponseInterceptor)
        .provider('httpRequestInterceptorCacheBuster', httpRequestInterceptorCacheBuster)
        .controller("UnauthorizedCtrl", UnauthorizedCtrl)
        .directive("ngPermissions", ngPermissions)
        .directive("ngConfirmClick", ngConfirmClick)
        .directive("ngGoalChart", WowChartv3_ngGoalChart)
        .directive("ngHighChart", WowChartv3_ngHighChart)
        .directive("ngOrgChart", WowChartv3_ngOrgChart);

    try {
        ngApp.directive("fileModel", WowChartv3_fileModel);
    } catch (ex) { }

    try {
        ngApp.directive("ngTooltip", WowChartv3_ngTooltip);
    } catch (ex) { }

    try {
        ngApp.directive("ngTabs", WowChartv3_ngTabs);
    } catch (ex) { }

    function utils() {
        var obj = {};
        obj.http_error_data = function (rejection) {
            var data = rejection.data;

            if (data && data.d)
                return [data.d];

            if (angular.isArray(data)) {
                return data;
            }
            else if (angular.isString(data) && data > "") {
                return [data];
            }
            else if (data.hasOwnProperty('Message')) {
                return [data.Message];
            } else if (angular.isUndefinedOrNull(rejection.statusText) == false) {
                return [rejection.statusText];
            }
        };

        obj.getInitialChartSettings = function () {
            var chartData = {
                Labels: [],
                Series: [],
                Data: [],
                Options: obj.getInitialChartOptions(),
                GoalChart: obj.getInitialGoalChartOptions(),
            };

            return chartData;
        }
        obj.getInitialChartOptions = function () {
            return {
                style: {
                    width: null,
                    height: null,
                },
                mics: {
                    showSeriesSelector: false,
                    drillDownXLocation: null,
                    drillDownXPrefix: null,
                    drillDownHideTitle: false,
                    drillDownHideSubtitle: false,
                    previewAsImage: false
                },
                chart: {
                    typeId: null,
                    backgroundColor: '#FFFFFF',
                    options3d: {
                        enabled: false,
                        alpha: 0,
                        beta: 0,
                        depth: 100,
                        viewDistance: 100
                    },
                    inverted: false,
                    shadow: false,
                    plotBackgroundImage: null,
                    zoomType: null,
                    spacing: [10, 10, 15, 10],
                    margin: [0, 0, 0, 0],
                    plotBorderWidth: 0,
                    events: {
                        drilldown: function (args) {
                            var chart = this;
                            var options = chart.options;
                            if (angular.isUndefinedOrNull(options.mics.drillDownXLocation)) return;

                            var chartWinObj = window[chart.container.id];

                            if (angular.isUndefinedOrNull(chartWinObj._title) == false) return;
                            if (angular.isUndefinedOrNull(chartWinObj._subtitle) == false) return;

                            var title = options.title;
                            var subtitle = options.subtitle;
                            var xaxis = args.point.name;
                            var prefix = options.mics.drillDownXPrefix || '';
                            if (prefix) {
                                prefix += ' ';
                            }

                            if (options.mics.drillDownXLocation == 1) {
                                if (angular.isUndefinedOrNull(title.text)) {
                                    chartWinObj._title = '';
                                    title.text = prefix + xaxis;
                                } else {
                                    chartWinObj._title = title.text;
                                    if (options.mics.drillDownHideTitle) {
                                        title.text = prefix + xaxis;
                                    } else {
                                        title.text += " - " + prefix + xaxis;
                                    }
                                }

                                if (options.mics.drillDownHideSubtitle == true) {
                                    if (angular.isUndefinedOrNull(subtitle.text) == false) {
                                        chartWinObj._subtitle = subtitle.text;
                                        subtitle.text = '';
                                    }
                                }
                            } else if (options.mics.drillDownXLocation == 2) {
                                if (angular.isUndefinedOrNull(subtitle.text)) {
                                    chartWinObj._subtitle = '';
                                    subtitle.text = prefix + xaxis;
                                }
                                else {
                                    chartWinObj._subtitle = subtitle.text;
                                    if (options.mics.drillDownHideSubtitle) {
                                        subtitle.text = prefix + xaxis;
                                    } else {
                                        subtitle.text += " - " + prefix + xaxis;
                                    }
                                }

                                if (options.mics.drillDownHideTitle == true) {
                                    if (angular.isUndefinedOrNull(title.text) == false) {
                                        chartWinObj._title = title.text;
                                        title.text = '';
                                    }
                                }
                            }

                            chart.setTitle(title, subtitle);
                        },
                        drillupall: function () {

                            var chart = this;
                            var options = chart.options;
                            var title = options.title;
                            var subtitle = options.subtitle;

                            var chartWinObj = window[chart.container.id];

                            if (angular.isUndefinedOrNull(chartWinObj._title) == false) {
                                title.text = chartWinObj._title;
                                delete chartWinObj._title;
                            }

                            if (angular.isUndefinedOrNull(chartWinObj._subtitle) == false) {
                                subtitle.text = chartWinObj._subtitle;
                                delete chartWinObj._subtitle;
                            }

                            chart.setTitle(title, subtitle);
                        }
                    }
                },
                xAxis: {
                    tickmarkPlacement: null,
                    lineWidth: 1,
                    lineColor: '#ccd6eb',
                    title: {
                        text: null,
                        align: 'middle',
                        style: {
                            color: "#666666"
                        }
                    },
                    min: null,
                    labels: {
                        enabled: true,
                        format: '{value}',
                        rotation: 0,
                        padding: 5,
                        style: {
                            'color': '#666666',
                            'font-size': '11px',
                            'font-weight': 'normal'
                        },
                        step: null
                    },
                    gridLineWidth: 0,
                    gridLineColor: '#e6e6e6',
                    crosshair: true,
                    _plotBands: [],
                    _plotLines: []
                },
                yAxis: {
                    title: {
                        text: null,
                        align: 'middle',
                        style: {
                            color: "#666666"
                        }
                    },
                    max: null,
                    min: null,
                    labels: {
                        enabled: true,
                        format: '{value}',
                        padding: 5,
                        style: {
                            'color': '#666666',
                            'font-size': '11px',
                            'font-weight': 'normal'
                        }
                    },
                    gridLineInterpolation: null,
                    gridLineWidth: 1,
                    gridLineColor: '#e6e6e6',
                    lineWidth: 1,
                    lineColor: '#ccd6eb',
                    crosshair: true,
                    additionalBand: {},
                    _plotBands: [],
                    _plotLines: []
                },
                tooltip: {
                    enabled: true,
                    headerFormat: '<span style="font-size: 10px">{point.key}</span><br/>',
                    pointFormat: '<span style="color:{point.color}">\u25CF</span> {series.name}: <b>{point.y}</b><br/>',
                    split: false,
                    shared: false
                },
                series: [{
                    pointsColors: [],
                    colors: [],
                    types: [],
                    colorByPoint: false,
                    fillOpacity: 1.0
                }],
                title: {
                    text: null,
                    align: 'center',
                    margin: 15,
                    verticalAlign: null,
                    style: {
                        fontSize: 18,
                        color: '#333333',
                        'background-color': null,
                        padding: '0px'
                    },
                    useHTML: false,
                    floating: false,
                    x: 0,
                    y: 0
                },
                subtitle: {
                    text: null,
                    align: 'center',
                    verticalAlign: null,
                    style: {
                        color: '#666666'
                    },
                    floating: false,
                    x: 0,
                    y: 0
                },
                legend: {
                    enabled: true,
                    align: 'center',
                    layout: 'horizontal',
                    verticalAlign: 'bottom',
                    title: {
                        text: null
                    },
                    backgroundColor: undefined,
                    borderColor: '#999999',
                    borderRadius: 0,
                    borderWidth: 0,
                    floating: false,
                    x: 0,
                    y: 0,
                    labelFormat: '{name}',
                    disableClick: false
                },
                pane: {
                    size: '85%',
                    startAngle: 0,
                    endAngle: 360
                },
                plotOptions: {
                    series: {
                        turboThreshold: 0,
                        pointPadding: 0.1,
                        groupPadding: 0.2,
                        borderWidth: 1,
                        dataLabels: {
                            enabled: false,
                            format: '{y}',
                            rotation: 0,
                            y: -6,
                            x: 0,
                            color: null,
                            borderWidth: 0,
                            borderColor: undefined,
                            borderRadius: 0,
                            distance: 30
                        },
                        showInLegend: true,
                        animation: true,
                        stacking: null,
                        point: {
                            events: {}
                        },
                        allowPointSelect: false,
                        events: {},
                        marker: {}
                    },
                    pie: {
                        depth: 0,
                        startAngle: 0,
                        endAngle: null,
                        innerSize: 0,
                        size: 75
                    },
                    column: {
                        depth: 25
                    },
                    bar: {
                        depth: 25
                    },
                    bubble: {
                        maxSize: "20%",
                        minSize: 8
                    }
                },
                lang: {
                    downloadJPEG: 'Download JPEG image',
                    downloadPDF: 'Download PDF document',
                    downloadPNG: 'Download PNG image',
                    downloadSVG: 'Download SVG image',
                    drillUpText: 'Back to {series.name}',
                    printChart: 'Print Chart',
                    noData: 'No Data to display',
                    downloadCSV: 'Download CSV',
                    downloadXLS: 'Download XLS',
                    viewData: 'View data table',
                    decimalPoint: '.',
                    thousandsSep: ' '
                },
                drilldown: {
                    series: []
                },
                credits: {
                    enabled: false
                },
                exporting: {
                    enabled: true,
                    externalServer: true,
                    downloadCSV: false,
                    downloadXLS: false,
                    viewData: false
                },
                orgChart: {
                    startVerticalLevel: null,
                    loadOnDemand: true,
                    loadOnDemandItems: 0,
                    spaceBetweenNodes: 35,
                    node: {
                        margin: 4,
                        padding: 12.5,
                        radius: 3.5,
                        stroke: "#ffffff",
                        strokeWidth: 1,
                        fill: "#7cb5ec",
                        color: "#434348",
                        shadow: true,
                        fontSize: 12
                    },
                    path: {
                        stroke: "#f7a35c",
                        strokeWidth: 1
                    }
                },
                dataTableIntegration: {
                    enableDriveTables: false,
                    tables: []
                },
                driveCharts: {
                    enabled: false,
                    charts: []
                },
                colors: Highcharts.defaultOptions.colors,
                pareto: obj.getInitialParetoOptions(),
                userActions: [],
                autoRefresh: {
                    enabled: false,
                    rate: 1
                }
            };
        }
        obj.getInitialParetoOptions = function () {
            return {
                series: {
                    type: 'pareto',
                    name: 'Pareto',
                    yAxis: 1,
                    zIndex: 10,
                    baseSeries: 1,
                    showInLegend: true,
                    tooltip: {
                        valueDecimals: 2,
                        valueSuffix: '%'
                    }
                },
                yAxis: {
                    title: {
                        text: ''
                    },
                    minPadding: 0,
                    maxPadding: 0,
                    max: 100,
                    min: 0,
                    opposite: true,
                    labels: {
                        format: "{value}%"
                    }
                }
            };
        };
        obj.getInitialGoalChartOptions = function () {
            return {
                padding: {
                    x: 10,
                    y: 10
                },
                box: {
                    radius: 10,
                    color: "#00ff00"
                },
                progressLine: {
                    height: 5,
                    color: "#ffffff",
                    backColor: "#000000",
                    enabled: true
                },
                fonts: [{
                    size: '1.8em',
                    color: "#ffffff",
                    family: "\"Lucida Grande\", \"Lucida Sans Unicode\", Arial, Helvetica, sans-serif"
                }, {
                    size: '1.4em',
                    color: "#ffffff",
                    family: "\"Lucida Grande\", \"Lucida Sans Unicode\", Arial, Helvetica, sans-serif"
                }]
            };
        }

        obj.isEmptyData = function (settings) {
            if (angular.isUndefinedOrNull(settings.Labels) == false
                && settings.Labels.length > 0
                && angular.isUndefinedOrNull(settings.Labels[0].opacity) == false) {
                var isEmpty = true;
                for (var idx = 0; idx < settings.Labels.length; idx++) {
                    var label = settings.Labels[idx];
                    if (label.opacity != 0 && label.opacity != '0') {
                        isEmpty = false;
                        break;
                    }
                }

                if (isEmpty) {
                    return true;
                }
            }

            if (settings.Data && settings.Data.length > 0) {
                if (angular.isArray(settings.Data[0]))
                    return settings.Data[0].length == 0;
                else
                    return false;
            }
            else if (settings.Series && settings.Series.length > 0)
                return false;
            else
                return true;
        }
        obj.ajaxSuccess = function (promise, callBack) {
            if (promise.then) return promise.then(callBack);
            else if (promise.success) return promise.success(callBack);
            else return null;
        }

        return obj;
    }

    authentication.$inject = ['currentUser', 'permissions'];
    function authentication(currentUser, permissions) {
        var obj = {
        };
        obj.authenticate = function (access) {
            if (angular.isUndefined(access)) return true;
            if (angular.isUndefined(access.authRequired)) return true;

            if (access.authRequired && angular.isUndefinedOrNull(currentUser)) {
                return false;
            }

            return true;
        };

        obj.authorize = function (access) {
            if (angular.isUndefined(access)) return true;
            if (angular.isUndefined(access.permissions)) return true;
            if (currentUser.IsHostOrAdmin) return true;

            for (var i = 0; i < access.permissions.length; i++) {
                if (permissions.indexOf(access.permissions[i]) == -1) return false;
            }

            return true;
        };

        obj.canDo = function (permKey) {
            return currentUser.IsHostOrAdmin || permissions.indexOf(permKey) != -1;
        };

        return obj;
    }

    toastrService.$inject = ['toastr'];
    function toastrService(toastr) {
        var obj = {
        };
        obj.success = function (title, message) {
            toastr.success(message, title);
            console.log(message);
        };
        obj.error = function (message) {
            toastr.error(message, 'Error Occurred');
            console.error(message);
        };
        obj.warning = function (message) {
            toastr.warning(message, 'Warning');
            console.warn(message);
        };

        return obj;
    }

    authHttpResponseInterceptor.$inject = ['$rootScope', '$q', '$location', '$injector', 'utils'];
    function authHttpResponseInterceptor($rootScope, $q, $location, $injector, utils) {
        return {
            response: function (response) {
                if (response.status === 401) {
                    $location.path('/Unauthorized');
                } else if (response.status === 200) {
                    $rootScope.errors = [];
                }
                return response || $q.when(response);
            },
            responseError: function (rejection) {
                if (rejection.status === 401) {
                    $location.path('/Unauthorized');
                }

                var errorsMsg = '<ul>';
                var errors = utils.http_error_data(rejection);
                angular.forEach(errors, function (error) {
                    errorsMsg += '<li>' + error + '</li>';
                });
                errorsMsg += '</ul>';

                var toastrService = $injector.get('toastrService');
                toastrService.error(errorsMsg);

                return $q.reject(rejection);
            }
        };
    }

    UnauthorizedCtrl.$inject = ['$rootScope'];
    function UnauthorizedCtrl($rootScope) {
        var self = this;
        self.init = init;

        function init() {
            $rootScope.title = 'Unauthorized';
        }
    }

    ngPermissions.$inject = ['currentUser', 'permissions'];
    function ngPermissions(currentUser, permissions) {
        return {
            restrict: 'A',
            prioriry: 100000,
            scope: false,
            compile: function (element, attr, linker) {
                if (currentUser.IsHostOrAdmin == false && permissions.indexOf(attr.ngPermissions) == -1) {
                    element.remove();
                }
            }
        };
    }

    function ngConfirmClick() {
        return {
            priority: -1,
            restrict: 'A',
            link: function (scope, element, attrs) {
                element.bind('click', function (e) {
                    var message = attrs.ngConfirmClick || 'Are You Sure Delete Record';
                    if (message && !confirm(message)) {
                        e.stopImmediatePropagation();
                        e.preventDefault();
                    }
                });
            }
        };
    }

    function httpRequestInterceptorCacheBuster() {
        this.matchlist = [/.*Templates.*/];

        this.$get = ['$q', function ($q) {
            var matchlist = this.matchlist;

            var d = new Date();
            var cacheBuster = d.getTime();

            return {
                'request': function (config) {
                    var busted = false;

                    for (var i = 0; i < matchlist.length; i++) {
                        if (config.url.match(matchlist[i])) {
                            busted = true; break;
                        }
                    }

                    //Bust if the URL was on blacklist or not on whitelist
                    if (busted) {
                        config.url = config.url.replace(/[?|&]cb=\d+/, '');
                        //Some url's allready have '?' attached
                        config.url += config.url.indexOf('?') === -1 ? '?' : '&'
                        config.url += 'cb=' + cacheBuster;
                    }

                    return config || $q.when(config);
                }
            }
        }];
    }
})();