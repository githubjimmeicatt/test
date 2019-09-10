WowChartv2_ngTabs.$inject = [];
function WowChartv2_ngTabs() {
    return {
        restrict: "A",
        link: function (scope, element, attrs) {
            var $element = $(element[0]);
            var elemId = $element.attr('id');

            var tabIdx = 0;
            if (scope.$root[elemId + '-settings'])
                tabIdx = scope.$root[elemId + '-settings'].tabIdx;
            
            $element.dnnTabs({
                active: tabIdx,
                selected: tabIdx,
            }).addClass("ui-tabs-vertical ui-helper-clearfix");
            $element.find("li").removeClass("ui-corner-top").addClass("ui-corner-left");
        }
    };
}