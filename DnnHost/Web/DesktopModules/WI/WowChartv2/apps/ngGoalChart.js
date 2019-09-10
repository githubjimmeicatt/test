WowChartv2_ngGoalChart.$inject = [];
function WowChartv2_ngGoalChart() {
    return {
        restrict: "A",
        transclude: true,
        scope: {
            settings: '=chartSettings'
        },
        link: function (scope, element, attrs) {
            window.addEventListener('resize', draw, false);

            var canvas = element[0], settings;

            function numberWithCommas(x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }

            function onChartSettingsChanged(newValue, oldValue) {
                settings = newValue;
                draw();
            }

            function draw() {
                if (angular.isUndefinedOrNull(settings)) return;

                var ctx = canvas.getContext('2d');
                var defaultFontSize = $(canvas.parentElement).css("font-size");
                defaultFontSize = parseFloat(defaultFontSize.substring(0, defaultFontSize.length - 2));

                canvas.width = canvas.parentElement.clientWidth;
                canvas.height = canvas.parentElement.clientHeight;

                var width = canvas.width, height = canvas.height;

                var datasets = settings.Data;

                var actualDS = datasets[0];
                var actual = actualDS[0];
                var actualText = actualDS[1];
                var _actualValue = parseFloat(actual);

                var chartConfig = settings.GoalChart;
                var paddingX = chartConfig.padding.x, paddingY = chartConfig.padding.y;

                var recBorderRadius = chartConfig.box.radius;
                var rectFillColor = chartConfig.box.color;

                var progHeight = chartConfig.progressLine.height;
                var progBackColor = chartConfig.progressLine.backColor;
                var progColor = chartConfig.progressLine.color;
                var progEnabled = chartConfig.progressLine.enabled;

                var actuallyFontFamily = chartConfig.fonts[0].family ? chartConfig.fonts[0].family : "Arial";
                var actualFontSize = chartConfig.fonts[0].size + '';
                if (actualFontSize.indexOf('px') > -1) {
                    actualFontSize = parseFloat(actualFontSize.substring(0, actualFontSize.length - 2));
                }
                else if (actualFontSize.indexOf('em') > -1) {
                    actualFontSize = defaultFontSize * parseFloat(actualFontSize.substring(0, actualFontSize.length - 2));
                } else {
                    actualFontSize += 'px';
                    actualFontSize = parseFloat(actualFontSize.substring(0, actualFontSize.length - 2));
                }

                var actualTextFontSize = actualFontSize - 3;
                var actualColor = chartConfig.fonts[0].color;

                var y = 0;
                var x = 0;

                ctx.roundRect(0, 0, width, height, recBorderRadius, rectFillColor);

                y += actualTextFontSize + paddingY;
                ctx.font = actualTextFontSize + "px " + actuallyFontFamily;
                ctx.fillStyle = actualColor;
                ctx.fillText(actualText, x + paddingX, y);

                var actualValueToDraw = numberWithCommas(_actualValue);
                var actualValueToDrawText = ctx.measureText(actualValueToDraw).width;

                var actualValueX;
                if (datasets.length > 1 && datasets[1][0] != null && progEnabled) {
                    var targetDS = datasets[1];
                    var target = targetDS[0];
                    var _targetValue = parseFloat(target);
                    var progWidth = (_actualValue / _targetValue) * width;
                    if (progWidth > actualValueToDrawText) {
                        if (progWidth + actualValueToDrawText > width)
                            actualValueX = width - actualValueToDrawText - 10;
                        else
                            actualValueX = progWidth - (actualValueToDrawText / 2);
                    } else {
                        actualValueX = x + paddingX;
                    }

                    y = ((height + progHeight) / 2) - 5;
                } else {
                    actualValueX = x + paddingX;
                    y += 10 + actualFontSize;
                }

                ctx.font = actualFontSize + "px " + actuallyFontFamily;
                ctx.fillStyle = actualColor;
                ctx.fillText(numberWithCommas(_actualValue), actualValueX, y);

                if (datasets.length > 1 && datasets[1][0] != null) {
                    var targetFontFamily = chartConfig.fonts[1].family ? chartConfig.fonts[1].family : "Arial";
                    var targetFontSize = chartConfig.fonts[1].size + '';
                    var targetColor = chartConfig.fonts[1].color;

                    if (targetFontSize.indexOf('px') > -1) {
                        targetFontSize = parseFloat(targetFontSize.substring(0, targetFontSize.length - 2));
                    }
                    else {
                        targetFontSize = defaultFontSize * parseFloat(targetFontSize.substring(0, targetFontSize.length - 2));
                    }

                    y = (height + progHeight) / 2;

                    if (progEnabled) {
                        ctx.fillStyle = progBackColor;
                        ctx.fillRect(0, y, width, progHeight);
                        ctx.stroke();
                    }

                    var targetDS = datasets[1];
                    var target = targetDS[0];
                    var targetText = targetDS[1];

                    var _targetValue = parseFloat(target);

                    if (progEnabled) {
                        var progWidth = (_actualValue / _targetValue) * width;

                        ctx.fillStyle = progColor;
                        ctx.fillRect(0, y, progWidth, progHeight);
                        ctx.stroke();
                    }

                    y = height - targetFontSize;
                    ctx.font = targetFontSize + "px " + targetFontFamily;
                    ctx.fillStyle = targetColor;
                    if (targetText != "" && targetText != null)
                        ctx.fillText(targetText + ': ' + numberWithCommas(_targetValue), x + paddingX, y);
                    else
                        ctx.fillText(numberWithCommas(_targetValue), x + paddingX, y);
                }
            }

            scope.$watch(function () { return scope.settings; }, onChartSettingsChanged, true);
        }
    };
}