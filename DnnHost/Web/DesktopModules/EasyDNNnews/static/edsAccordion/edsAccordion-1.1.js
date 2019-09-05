(function ($, window) {
	var activeClass = 'edsAccordion_active',
		sectionClass = 'edsAccordion_section',
		sectionContentWrapper = 'edsAccordion_contentWrapper',

		defaultSettings = {
			toggleActive: true
		};

	function edsAccordion (elem, settings) {
		var self = this,
			$mainWrapper = $(elem);

		$mainWrapper
			.on('click', '.' + sectionClass + ' > .edsAccordion_title', function (e) {
				var $clicked = $(this),
					$section = $clicked.parent(),
					$sectionContentWrapper = $('> .' + sectionContentWrapper, $section),
					$activeSections = $('.' + sectionClass + '.' + activeClass, $mainWrapper),
					currentlyActive = $section.hasClass(activeClass);

				if (currentlyActive && !settings.toggleActive)
					return false;

				$('> .' + sectionContentWrapper, $activeSections)
					.stop(true)
					.animate(
						{
							height: 0
						},
						{
							duration: 200
						}
					);
				$activeSections.removeClass(activeClass);

				if (currentlyActive)
					return false;

				$sectionContentWrapper
					.stop(true)
					.animate(
						{
							height: $('> .edsAccordion_content', $sectionContentWrapper).outerHeight(true)
						},
						{
							duration: 200,
							complete: function () {
								$sectionContentWrapper.css('height', 'auto');
							}
						}
					);
				$section.addClass(activeClass);

				return false;
			});
	}

	edsAccordion.prototype = {};

	$.fn.edsAccordion_1 = function (settings) {
		var instanceKey = 'edsAccordionRun';

		settings = $.extend(true, {}, defaultSettings, settings);

		return this.each(function () {
			var elem = this;

			if (!$.data(elem, instanceKey))
				$.data(elem, instanceKey, new edsAccordion(elem, settings));
		});
	};

})(jQuery, window);