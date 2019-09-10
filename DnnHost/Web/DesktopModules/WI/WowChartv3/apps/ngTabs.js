WowChartv3_ngTabs.$inject = [];
function WowChartv3_ngTabs() {
    return {
        restrict: "A",
        scope: {
            activeTabIndex: '='
        },
        link: function (scope, element, attrs) {
            var $element = $(element[0]);

            var init = function (idx) {
                $element.dnnTabs({
                    active: idx,
                    selected: idx
                }).addClass("ui-tabs-vertical ui-helper-clearfix");
                $element.find("li").removeClass("ui-corner-top").addClass("ui-corner-left");
            };

            scope.$watch('activeTabIndex', function (newValue, oldValue) {
                if (newValue != oldValue)
                    init(newValue);
            }, true);

            init(scope.activeTabIndex);
        }
    };
}