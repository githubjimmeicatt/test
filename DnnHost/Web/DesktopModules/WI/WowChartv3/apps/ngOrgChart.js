WowChartv3_ngOrgChart.$inject = ['$filter', 'ModuleInfo'];
function WowChartv3_ngOrgChart($filter, ModuleInfo) {
    return {
        restrict: "A",
        transclude: true,
        scope: {
            settings: '=chartSettings'
        },
        link: function (scope, element, attrs) {
            var chart, renderer, ocOptions, tooltip, width, height, startY, numOfLevels = 0;
            var orgData, rootNode = null, titleIdx = -1, colorIdx = -1, tooltipIdx = -1;
            var $element = $(element), settings, unregSettings, minX = 0, maxX = 0, maxY = 0, partialLoadedNodes = [], loadingMore = false;

            function resizeChart(isPrinting) {
                var reSize = false, newWidth, newHeight, overflow = "hidden";

                newHeight = maxY;
                if (newHeight > chart.chartHeight) {
                    reSize = true;
                } else {
                    newHeight = chart.chartHeight;
                }

                var newWidth = maxX + Math.abs(minX) + 100;
                if (newWidth > chart.chartWidth) {
                    reSize = true;
                    overflow = "auto";
                } else {
                    newWidth = chart.chartWidth;
                }

                if (reSize) {
                    chart.setSize(newWidth, newHeight, false);

                    if (isPrinting == false) {
                        var $svgContainer = $($element[0].firstChild);
                        $svgContainer.css("max-width", "100%");
                        $svgContainer.css("overflow", overflow);
                    }
                }
            }
            function xSetter(parent, node, x) {
                if (node.level < ocOptions.startVerticalLevel) {
                    node.elem.xSetter(x);
                } else {
                    node.elem.xSetter(parent.elem.x);
                }
            }
            function onSettingsChanged(newValue, oldValue) {
                settings = newValue;
                unregSettings();

                buildChart();
            }

            function correctPositions(node) {
                if (node.children.length > 1) {
                    var _x = node.elem.x
                        + (node.elem.width / 2)
                        - (node.box.width / 2)
                        - ((ocOptions.spaceBetweenNodes / 2) * (node.children.length - 1));

                    for (var idx = 0; idx < node.children.length; idx++) {

                        var child = node.children[idx];
                        if (child.elem == undefined) break;

                        _x += ocOptions.spaceBetweenNodes;
                        xSetter(node, child, _x + (child.box.width / 2) - (child.elem.width / 2));
                        _x += child.box.width;

                        if ((chart.isPrinting == true || renderer.forExport == true) == false)
                            child.elem.fadeIn();

                        drawPath(node, child);
                        correctPositions(child);
                    }
                } else if (node.children.length == 1) {
                    var child = node.children[0];
                    var _x = node.elem.x
                        + (node.elem.width / 2)
                        - (child.elem.width / 2);

                    xSetter(node, child, _x);

                    if ((chart.isPrinting == true || renderer.forExport == true) == false)
                        child.elem.fadeIn();

                    drawPath(node, child);
                    correctPositions(child);
                }

                if ((chart.isPrinting == true || renderer.forExport == true) == false)
                    node.elem.fadeIn();
            }
            function drawHorizantalPath(node, child) {
                var startPoint = {
                    x: node.elem.x + (node.elem.width / 2),
                    y: node.elem.y + (node.elem.height) + ocOptions.node.margin
                };
                var endPoint = {
                    x: child.elem.x + (child.elem.width / 2),
                    y: child.elem.y - ocOptions.node.margin
                };
                var midPoint = {
                    x: child.elem.x + (child.elem.width / 2),
                    y: ((endPoint.y + startPoint.y) / 2)
                };

                if (minX > endPoint.x) minX = endPoint.x - (child.elem.width / 2);
                if (maxX < endPoint.x) maxX = endPoint.x + (child.elem.width / 2);
                maxY = Math.max(maxY, child.elem.y + child.elem.height);

                var pathArrow = [
                    'M', startPoint.x, startPoint.y,
                    'L', startPoint.x, midPoint.y,
                    'L', midPoint.x, midPoint.y,
                    'L', midPoint.x, endPoint.y,
                    'M', midPoint.x - 5, endPoint.y - 5,
                    'L', midPoint.x, endPoint.y + 2,
                    'M', midPoint.x + 5, endPoint.y - 5,
                    'L', midPoint.x, endPoint.y + 2];

                renderer.path(pathArrow)
                    .attr({
                        'stroke-width': ocOptions.path.strokeWidth,
                        stroke: ocOptions.path.stroke,
                        class: 'org-path'
                    })
                    .add();
            }
            function drawVerticalPath(node, child) {

                var p1 = {
                    x: node.elem.x,
                    y: node.elem.y + (node.elem.height / 2)
                };
                var p2 = {
                    x: node.elem.x - (ocOptions.spaceBetweenNodes / 2),
                    y: node.elem.y + (node.elem.height / 2)
                };

                var p3 = {
                    x: child.elem.x - (ocOptions.spaceBetweenNodes / 2),
                    y: child.elem.y + (node.elem.height / 2)
                };

                var p4 = {
                    x: child.elem.x,
                    y: child.elem.y + (node.elem.height / 2)
                };

                maxY = Math.max(maxY, child.elem.y + child.elem.height);

                var pathArrow = [
                    'M', p1.x, p1.y,
                    'L', p2.x, p2.y,
                    'L', p3.x, p3.y,
                    'L', p4.x, p4.y,
                    'L', p4.x - 5, p4.y + 5,
                    'M', p4.x, p4.y,
                    'L', p4.x - 5, p4.y - 5, ];

                renderer.path(pathArrow)
                    .attr({
                        'stroke-width': ocOptions.path.strokeWidth,
                        stroke: ocOptions.path.stroke,
                        class: 'org-path'
                    })
                    .add();
            }
            function drawPath(node, child) {
                if (child.level < ocOptions.startVerticalLevel)
                    drawHorizantalPath(node, child);
                else
                    drawVerticalPath(node, child);
            }

            function createNode(idx, level) {
                var result = {
                    id: orgData.data[idx][0],
                    parentId: orgData.data[idx][1],
                    name: orgData.series[idx],
                    level: level,
                    box: {}
                };

                if (colorIdx > -1) {
                    var fillColor = orgData.data[idx][colorIdx];
                    if (angular.isUndefinedOrNull(fillColor) == false && fillColor.length > 0) {
                        result.fillColor = fillColor;
                    } else {
                        result.fillColor = ocOptions.node.fill;
                    }
                } else {
                    result.fillColor = ocOptions.node.fill;
                }

                if (tooltipIdx > -1) {
                    var str = orgData.data[idx][tooltipIdx];
                    if (angular.isUndefinedOrNull(str) == false && str.length > 0) {
                        result.tooltip = str;
                    }
                }

                if (titleIdx > -1) {
                    result.title = orgData.data[idx][titleIdx];
                }

                orgData.series.splice(idx, 1);
                orgData.data.splice(idx, 1);

                numOfLevels = Math.max(numOfLevels, result.level);

                return result;
            }
            function fillChildren(node) {
                node.children = [];

                for (var i = 0; i < orgData.series.length;) {
                    var parentId = orgData.data[i][1];
                    if (node.id == parentId) {
                        var child = createNode(i, node.level + 1);
                        child.index = node.children.length;

                        fillChildren(child);
                        node.children.push(child);
                    } else {
                        i++;
                    }
                }
            }
            function drawNodeLabel(node, x, y) {
                if (angular.isUndefinedOrNull(node)) {
                    node = {};
                }

                var labelText = '<center>';
                if (angular.isUndefinedOrNull(node.title) || node.title == '')
                    labelText += node.name;
                else
                    labelText += node.name + '<br/><i>' + node.title + '</i>';

                labelText += '</center>';

                var svgNode = renderer.label(labelText, x, y, null, null, null, true)
                    .attr({
                        fill: node.fillColor,
                        stroke: ocOptions.node.stroke,
                        'stroke-width': ocOptions.node.strokeWidth,
                        padding: ocOptions.node.padding,
                        opacity: ocOptions.node.opacity,
                        r: ocOptions.node.radius
                    })
                    .css({
                        color: ocOptions.node.color,
                        fontSize: ocOptions.node.fontSize + 'px'
                    })
                    .add()
                    .shadow(ocOptions.node.shadow);

                if (node.tooltip) {
                    svgNode.element.setAttribute('tooltip', node.tooltip);

                    svgNode
                        .on('mousemove', function (e) {
                            if (e.target.width) {
                                var width = e.target.width.baseVal.value;
                                var height = e.target.height.baseVal.value;

                                var transform = e.target.parentElement.transform.baseVal[0].matrix;
                                var translateE = e.target.parentElement.transform.baseVal[0].matrix["e"];
                                var translateF = e.target.parentElement.transform.baseVal[0].matrix["f"];

                                tooltip.move(translateE + width / 2, translateF + height / 2);
                            }
                        })
                        .on('mouseout', function (e) {
                            tooltip.hide();
                        })
                        .on('mouseover', function (e) {
                            var el = e.target;
                            var str = null;
                            while (el && str == null) {
                                str = el.getAttribute("tooltip");
                                el = el.parentElement;
                            }

                            clearTimeout(tooltip.hideTimer);
                            tooltip.isHidden = false;
                            if (tooltip.label) {
                                tooltip.label.attr({
                                    text: str
                                });
                                tooltip.label.attr('opacity', 1).show();
                            }
                        });
                }

                node.elem = svgNode;

                return node;
            }

            function drawNode(node, x, y) {
                node = drawNodeLabel(node, x, y);

                if (node.children.length > 0) {
                    node.box.width = 0;
                    var y = node.elem.y + node.elem.height + ocOptions.spaceBetweenNodes;

                    var itemsToDraw;
                    if ((chart.isPrinting == true || renderer.forExport == true) == false) {
                        if (ocOptions.loadOnDemand == true && node.level == (numOfLevels - 1)) {
                            itemsToDraw = Math.min(ocOptions.loadOnDemandItems, node.children.length);
                        } else {
                            itemsToDraw = node.children.length;
                        }
                    } else {
                        itemsToDraw = node.children.length;
                    }

                    for (var idx = 0; idx < itemsToDraw; idx++) {
                        var child = node.children[idx];

                        if (child.level >= ocOptions.startVerticalLevel) {
                            child = drawNode(child, node.elem.x - (node.elem.width / 2), y);
                            y += child.elem.height + ocOptions.spaceBetweenNodes;
                        } else {
                            child = drawNode(child, node.elem.x + (node.elem.width / 2), y);
                        }

                        node.children[idx] = child;

                        if (node.level >= (ocOptions.startVerticalLevel - 1)) {
                            node.box.width = Math.max(node.box.width, child.box.width);
                        } else {
                            node.box.width += child.box.width;
                        }
                    }

                    if (ocOptions.loadOnDemand == true && itemsToDraw < node.children.length) {
                        node.loadedChildren = itemsToDraw;
                        partialLoadedNodes.push(node);
                    }

                    if (node.level < (ocOptions.startVerticalLevel - 1)) {
                        if (node.children.length > 2)
                            node.box.width += (ocOptions.spaceBetweenNodes * (node.children.length - 1));
                        else
                            node.box.width += (ocOptions.spaceBetweenNodes * node.children.length);
                    } else {
                        node.box.width += ocOptions.spaceBetweenNodes;
                    }

                } else {
                    node.box.width = node.elem.width;
                }

                return node;
            }
            function preRender(elem) {
                var erase = Highcharts.erase;
                var labels = elem.getElementsByClassName('highcharts-label');
                var i = labels.length;
                while (i--) {
                    erase(labels, labels[i].parentElement.removeChild(labels[i]));
                }

                var paths = elem.getElementsByClassName('org-path');
                var i = paths.length;
                while (i--) {
                    erase(paths, paths[i].parentElement.removeChild(paths[i]));
                }
            }
            function onRender() {

                chart = this;
                renderer = this.renderer;
                tooltip = chart.tooltip;
                width = $element.width();
                height = this.plotHeight;
                startY = this.plotTop;
                orgData = this.userOptions.orgData;
                ocOptions = chart.userOptions.orgChart;

                if (loadingMore) return;

                preRender(this.container);
                partialLoadedNodes = [];
                minX = 0, maxX = 0, maxY = 0;

                if (rootNode == null) {

                    for (var idx = 0; idx < orgData.labels.length; idx++) {
                        var label = orgData.labels[idx];
                        if (label.name == "Color") {
                            colorIdx = idx;
                        } else if (label.name == "Tooltip") {
                            tooltipIdx = idx;
                        } else if (label.name == "Title") {
                            titleIdx = idx;
                        }
                    }

                    for (var idx = 0; idx < orgData.series.length; idx++) {
                        var parentId = orgData.data[idx][1];
                        if (angular.isUndefinedOrNull(parentId)
                            || parentId == '0'
                            || parentId == '') {
                            rootNode = createNode(idx, 1);
                            break;
                        }
                    }

                    if (rootNode)
                        fillChildren(rootNode);
                }

                rootNode = drawNode(rootNode, (width / 2), startY);
                xSetter(null, rootNode, (width / 2) - (rootNode.elem.width / 2));
                correctPositions(rootNode);

                if (chart.isPrinting == true || renderer.forExport == true) {
                    resizeChart(true);
                }
            }

            function cachedScript(url, callback) {
                return $.ajax({
                    type: "GET",
                    url: url,
                    success: callback,
                    dataType: "script",
                    cache: true
                });
            };
            function highCharts(hcOptions) {
                if (hcOptions.exporting.enabled && angular.isUndefinedOrNull(window.ExportingJsUrl)) {
                    cachedScript(ModuleInfo.ExportingJsUrl, function () {
                        window.ExportingJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.exporting.enabled && angular.isUndefinedOrNull(window.OfflineExportingJsUrl)) {
                    cachedScript(ModuleInfo.OfflineExportingJsUrl, function () {
                        window.OfflineExportingJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.exporting.enabled &&
                    (hcOptions.exporting.downloadCSV == true ||
                        hcOptions.exporting.downloadXLS == true ||
                        hcOptions.exporting.viewData == true) &&
                    angular.isUndefinedOrNull(window.ExportCSVJsUrl)) {
                    cachedScript(ModuleInfo.ExportCSVJsUrl, function () {
                        window.ExportCSVJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else if (hcOptions.chart.options3d.enabled && angular.isUndefinedOrNull(window.Highcharts3dJsUrl)) {
                    cachedScript(ModuleInfo.Highcharts3dJsUrl, function () {
                        window.Highcharts3dJsUrl = 0;
                        highCharts(hcOptions);
                    });
                } else {
                    if (hcOptions.exporting.enabled) {
                        var buttons = Highcharts.getOptions().exporting.buttons;

                        if (hcOptions.exporting.downloadCSV == true) {
                            var result = $filter('filter')(buttons.contextButton.menuItems, { 'textKey': 'downloadCSV' });
                            if (result.length == 0) {
                                buttons.contextButton.menuItems.push({
                                    textKey: 'downloadCSV',
                                    onclick: function () { this.downloadCSV(); }
                                });
                            }
                        }

                        if (hcOptions.exporting.downloadXLS == true) {
                            var result = $filter('filter')(buttons.contextButton.menuItems, { 'textKey': 'downloadXLS' });
                            if (result.length == 0) {
                                buttons.contextButton.menuItems.push({
                                    textKey: 'downloadXLS',
                                    onclick: function () { this.downloadXLS(); }
                                });
                            }
                        }

                        if (hcOptions.exporting.viewData == true) {
                            var result = $filter('filter')(buttons.contextButton.menuItems, { 'textKey': 'viewData' });
                            if (result.length == 0) {
                                buttons.contextButton.menuItems.push({
                                    textKey: 'viewData',
                                    onclick: function () { this.viewData(); }
                                });
                            }
                        }

                        hcOptions.exporting.buttons = buttons;
                    }

                    hcOptions.chart.events.render = onRender;

                    $element.highcharts(hcOptions);

                    var id = $element[0].firstChild.id;
                    window[id] = {};

                    resizeChart(false);

                    if (ocOptions.loadOnDemand == true) {
                        $(window).scroll(function () {
                            if ($(window).scrollTop() + $(window).height() >= $element.offset().top + $element.height()) {
                                if (loadingMore == false) {
                                    loadingMore = true;
                                    for (var i = 0; i < partialLoadedNodes.length; i++) {
                                        var node = partialLoadedNodes[i];
                                        if (node.loadedChildren < node.children.length) {
                                            var y = node.children[node.loadedChildren - 1].elem.y
                                                + node.children[node.loadedChildren - 1].elem.height
                                                + ocOptions.spaceBetweenNodes;

                                            var itemsToDraw = node.loadedChildren + 1;
                                            for (var idx = node.loadedChildren; idx < itemsToDraw; idx++) {
                                                var child = node.children[idx];

                                                child = drawNodeLabel(child, node.elem.x, y);
                                                y += child.elem.height + ocOptions.spaceBetweenNodes;

                                                node.children[idx] = child;

                                                drawPath(node, child);
                                            }

                                            node.loadedChildren = itemsToDraw;
                                        }
                                    }

                                    resizeChart(false);
                                    loadingMore = false;
                                }
                            }
                        });
                    }
                }
            }

            function buildChart() {

                var hcOptions = angular.copy(settings.Options);

                hcOptions.orgData = {
                    series: settings.Series,
                    data: settings.Data,
                    labels: settings.Labels
                };

                hcOptions.defaultSeries = angular.copy(hcOptions.series[0]);
                hcOptions.series = [];

                hcOptions.title.style.fontSize += 'px';
                hcOptions.plotOptions.pie.innerSize += '%';
                hcOptions.exporting.url = 'WowChartsv3Export.axd';

                delete hcOptions.chart.typeId;
                delete hcOptions.chart.type;
                delete hcOptions.style;
                delete hcOptions.xAxis.categories;

                if (hcOptions.chart.margin[0] == 0
                    && hcOptions.chart.margin[1] == 0
                    && hcOptions.chart.margin[2] == 0
                    && hcOptions.chart.margin[3] == 0)
                    hcOptions.chart.margin = [null];

                if (hcOptions.exporting.enabled) {
                    if (angular.isUndefinedOrNull(hcOptions.title.text) == false)
                        hcOptions.exporting.filename = hcOptions.title.text;

                    hcOptions.exporting.chartOptions = {
                        plotOptions: hcOptions.plotOptions
                    };
                }

                hcOptions.tooltip = {
                    enabled: true,
                    followPointer: true
                };

                if (angular.isUndefinedOrNull(hcOptions.orgChart.startVerticalLevel)) {
                    hcOptions.orgChart.startVerticalLevel = 99999;
                    hcOptions.orgChart.loadOnDemand = false;
                }

                if (angular.isUndefinedOrNull(hcOptions.orgChart.loadOnDemand)) {
                    hcOptions.orgChart.loadOnDemand = false;
                }

                highCharts(hcOptions);
            }

            unregSettings = scope.$watch(function () { return scope.settings; }, onSettingsChanged, true);

            scope.$on('onDataChanged', function (e) {
                data = e.targetScope.ctrl.data;
                buildChart();
            });
        }
    };
}