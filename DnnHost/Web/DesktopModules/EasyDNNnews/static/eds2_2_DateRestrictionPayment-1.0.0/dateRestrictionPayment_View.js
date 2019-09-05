(function ($, window) {
	var defaultSettings = {
		currencyOption: {
			symbol:'',
			decimal:'',
			thousand:'',
			precision:'',
			format:''
		},
		minNumberOfTickets: 1,
		maxNumberOfTickets: 1,
		tax: 0,
		mainDivWrapperId: '',
		hiddenFieldId: '',
		numberOfAttendeesId: '',
		registerButtonId: '',
		infoSpanId: '',
		rblGroupName: '',
		i18n: [],
		costs: []
	};

	function edsMatrixView(elem, settings) {
		var self = this,
			$mainWrapper = $(elem),
			$mainDivWrapper = $(settings.mainDivWrapperId),
			$hiddenFieldId = $(settings.hiddenFieldId, $mainDivWrapper),
			$registerButtonId = $(settings.registerButtonId, $mainDivWrapper),
			$infoSpanId = $(settings.infoSpanId, $mainWrapper);

		if ($mainDivWrapper.length == 0 ||
			$mainWrapper.length == 0 ||
			$hiddenFieldId.length == 0 ||
			$registerButtonId.length == 0
		)
			return;

		var roundDecimals = function(value, decimals) {
			return Number(Math.round(value + 'e' + decimals) + 'e-' + decimals);
		},
		isInteger = function (value) {
			if(value === undefined || value === null || value === '')
				return false;
			
			if(Number.isInteger(Number(value)))
				return true;

			return false;
		},
		formatCurrency = function(number) {	
			return accounting.formatMoney(number, settings.currencyOption);
		},
		i18n = function (key) {
			if (!settings.i18n)
				return key;
			if (!settings.i18n[key])
				return key;
			return settings.i18n[key];
		},
		html = '<div id="cost_summary">' +
			'<div class="eds_labelAndInput eds_paymentInfo eds_subTotal">' + i18n('SubTotal.Text') + ' <span id="eds_SubTotal">0</span></div>' +
			'<div class="eds_labelAndInput eds_paymentInfo eds_salesTax">' + i18n('SalesTax.Text') + ' <span id="eds_SalesTax">0</span></div>' +
			'<div class="eds_labelAndInput eds_paymentInfo eds_estimatedTotal">' + i18n('EstimatedTotal.Text') + ' <span id="eds_EstimatedTotal">0</span></div>' +
			'</div>',
		getCostValue = function (id) {
			if(id === null)
				return 0;

			if(settings.costs.length > 0){
				for (var i = 0; i < settings.costs.length; i++) {
					if(settings.costs[i][0] === id) {
						return settings.costs[i][1];
					}
				}
			}

			return 0;
		}
		refreshCalculation = function(numberOfAttendeesValue, costValue) {
			var numOfAttendes = 1;
			if(isInteger(numberOfAttendeesValue)) {
				numOfAttendes = numberOfAttendeesValue;
			}

			var subTotal = costValue * numOfAttendes;
			var taxValue = 0;
			
			if(settings.tax != 0){				
				if(subTotal > 0)
					taxValue = subTotal * settings.tax;

				taxValue = roundDecimals(taxValue, 2);		
			}
			else
				taxValue = roundDecimals(taxValue, 2);

			$('#eds_SubTotal', $mainDivWrapper).html(formatCurrency(subTotal));
			$('#eds_SalesTax', $mainDivWrapper).html(formatCurrency(taxValue));
			$('#eds_EstimatedTotal', $mainDivWrapper).html(formatCurrency(roundDecimals((subTotal + taxValue), 2)));

		},
		getSelectedRadioButtonId = function() {
			var $checkedRadio = $mainWrapper.find("input[name='" + settings.rblGroupName + "']:checked");

			if($checkedRadio.length === 0)
				return null;
			else
				return $checkedRadio.attr("id");
		}

		$mainDivWrapper
			.on("click", settings.registerButtonId, function (e) {
				if ($("input[name='" + settings.rblGroupName + "']:checked").length) {
					return true;
				} else {
					$infoSpanId.show();
					return false;
				}
			})
			.on("propertychange change keyup paste input", settings.numberOfAttendeesId, function (e) {
				refreshCalculation($(this).val(), getCostValue(getSelectedRadioButtonId()));
			})

		var isValueSelected = false;
		$("input[name='" + settings.rblGroupName + "']", $mainWrapper).change(function (e) {
			if (!isValueSelected) {
				isValueSelected = true;
				$mainWrapper.append(html);
				$infoSpanId.hide();
			}

			var $numberOfAttendees = $(settings.numberOfAttendeesId);

			var numOfAttendes = 1;
			if($numberOfAttendees.length !== 0)
				numOfAttendes = $numberOfAttendees.val();

			refreshCalculation(numOfAttendes, getCostValue($(this).attr("id")));

			$hiddenFieldId.val($(this).attr("id"));
		});
	}

	edsMatrixView.prototype = {};

	$.fn.eds2_2_DateRestrictionPayment_View_1_0_0 = function (settings) {
		var instanceKey = 'eds2_2_DateRestrictionPayment_View_1_0_0';
		settings = $.extend(true, {}, defaultSettings, settings);

		return this.each(function () {
			var elem = this;
			if (!$.data(elem, instanceKey)) {
				$.data(elem, instanceKey, new edsMatrixView(elem, settings));
			}
		});
	};
})(eds2_2, window);