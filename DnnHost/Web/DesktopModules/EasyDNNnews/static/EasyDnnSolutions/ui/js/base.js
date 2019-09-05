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

})(eds1_11);


(function ($, undefined) {

$.fn.eds_tooltipster = function () {
	var tooltipInitKey = 'tooltipInitiated';

	return this.tooltipster({
		contentAsHTML: true,
		theme: 'tooltipster-edsBlue',
		autoClose: true,
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

})(eds1_11);


eds1_11(function ($) {
	var $flashMessages = $('.topBarWrapper > .wrapper > .flashMessage');

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

	$('.tooltip').eds_tooltipster();
});