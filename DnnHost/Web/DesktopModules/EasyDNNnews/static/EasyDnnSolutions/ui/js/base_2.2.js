(function ($, undefined) {

var filledInClass = 'filledIn',
	floatingLabel = function () {
		var $this = $(this),
			$parent = $this.parent();

		if ($this.val().trim() == '')
			$parent.removeClass(filledInClass);
		else
			$parent.addClass(filledInClass);
	};


function FloatingLabel (el) {
	var self = this,
		oldValue;

	self.$el = $(el);
	floatingLabel.call(el);

	self.$el.on('propertychange change click keyup input paste', function () {
		floatingLabel.call(el);
	});

	setInterval(
		function () {
			floatingLabel.call(el);
		},
		250
	);
}

FloatingLabel.prototype = {
	refresh: function () {
		var self = this;

		floatingLabel.call(self.$el[0]);
	}
};


$.fn.eds_floatingLabel = function (action) {
	var instanceKey = 'eds_floatingLabel';

	return this.each(function () {
		var self = this,
			objectInstance = $.data(self, instanceKey);

		if (!objectInstance) {
			objectInstance = new FloatingLabel(self);
			$.data(self, instanceKey, objectInstance);
		}

		if (action && objectInstance[action])
			objectInstance[action]();
	});
};

})(eds2_2);


(function ($, undefined) {

$.fn.eds_tooltipster = function () {
	var tooltipInitKey = 'tooltipInitiated';

	return this.tooltipster({
		contentAsHTML: true,
		theme: 'tooltipster-edsBlue',
		autoClose: true,
		multiple: true,
		functionBefore: function ($el, continueTooltip) {
			var tooltipData;

			if (!$el.data(tooltipInitKey)) {
				tooltipData = $el.data();

				$el
					.data(tooltipInitKey, true)
					.tooltipster('content', tooltipData.tooltipContent);

				if (tooltipData.tooltipPosition)
					$el.tooltipster('option', 'position', tooltipData.tooltipPosition);
			}

			continueTooltip();
		}
	});
};

})(eds2_2);


eds2_2(function ($) {
	var $flashMessages = $('.edNews_topBarWrapper .flashMessage');

	$('.floatingLabel > select, .floatingLabel > input, .floatingLabel > textarea').eds_floatingLabel();

	if ($flashMessages.length > 0) {
		setTimeout(
			function () {
				$flashMessages.fadeOut(400, function () {
					$flashMessages.remove();
				});
			},
			7000
		);
	}

	$('.edNews_tooltip').eds_tooltipster();
});

(function ($, window) {

	var activeClass = 'edsTabulator_active',
		tabTriggerSelector = '.edsTabulator_tabTrigger',
		tabSelector = '.edsTabulator_tab';

	function edsTabulator (elem) {
		var self = this,
			$mainWrapper = $(elem);

		$mainWrapper
			.on('click', tabTriggerSelector, function () {
				var $clicked = $(this),
					itemIndex = $clicked.index(),
					$tabContentWrappers = $('.edsTabulator_tabsWrapper .edsTabulator_tab', $mainWrapper);

				if ($clicked.hasClass(activeClass))
					return;

				$tabContentWrappers.removeClass(activeClass);
				$(tabTriggerSelector, $mainWrapper).removeClass(activeClass);

				$clicked.addClass(activeClass);
				$tabContentWrappers.eq(itemIndex).addClass(activeClass);
			});

		if ($(tabTriggerSelector + '.' + activeClass, $mainWrapper).length == 0) {
			$(tabSelector + '.' + activeClass, $mainWrapper).removeClass(activeClass);

			$(tabTriggerSelector, $mainWrapper).eq(0).addClass(activeClass);
			$(tabSelector, $mainWrapper).eq(0).addClass(activeClass);
		}
	}

	edsTabulator.prototype = {};

	$.fn.edsTabulator_1 = function () {
		var instanceKey = 'edsTabulatorRun';

		return this.each(function () {
			var self = this;

			if (!$.data(self, instanceKey))
				$.data(self, instanceKey, new edsTabulator(self));
		});
	};

})(eds2_2, window);

eds2_2(function ($) {

	$('.eds_Tabs').edsTabulator_1();

});