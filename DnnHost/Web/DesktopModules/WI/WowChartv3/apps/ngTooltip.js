WowChartv3_ngTooltip.$inject = [];
function WowChartv3_ngTooltip() {
    return {
        restrict: "A",
        transclude: true,
        link: function (scope, element, attrs) {
            var $element = $(element);
            if ($.fn.tooltip.noConflict) {
                var bsTooltip = $.fn.tooltip.noConflict();
            }
            $element.tooltip({
                hide: { effect: "fadeOut", duration: 1500 },
                content: function () {
                    return $(this).prop('title');
                },
                close: function (event, ui) {
                    ui.tooltip.remove();
                }
            });
        }
    };
}