(function ($, window) {
	var defaultSettings = {
		validate: [],
		/*validate: function (id) {
		},*/
		dateTimePicker: {
			sideBySide: false,
			showTodayButton: false,
			showClear: false,
			allowInputToggle: true,
		}
	};

	function edsMatrix(elem, settings) {
		var self = this,
			members = {
				structure: {
					x: [],
					y: []
				},
				matrix: []
			},
			$mainWrapper = $(elem),
			$hfState = $(settings.hfStateId),
			$hfStateViewSpecificId = $(settings.hfStateViewSpecificId),
			$tbValidateDecimal = $(settings.tbValidateDecimalId),
			i18n = function (key) {
				if (!settings.i18n)
					return key;
				if (!settings.i18n[key])
					return key;
				return settings.i18n[key];
			},
			leftDataCellOffset = 1,
			tableHtml = '<table class="eds__tblCostByDateRestriction">' +
					'<thead>' +
						'<tr>' +
							'<th class="edNews_theadSeparator" colspan="2">' +
								'<span title="' + i18n('AddRow.Text') + '" id="eds__AddDateRestrictionName" class="edNews_addAction edNews_addRow">' + i18n('AddName.Text') + '</span>' +
								'<span title="' + i18n('AddColumn.Text') + '" id="eds__AddDateRestrictionDate" class="edNews_addAction edNews_addColumn">' + i18n('AddDate.Text') + '</span>' +
							'</th>' +
						'</tr>' +
					'</thead>' +
					'<tbody>' +
					'</tbody>' +
				'</table>' +
				'<span style="display:none;" class="eds__validationInfo infoMessages warning"></span>',
            cellTemplate = '<td><input type="text" class="eds__table_cell_input_value" name="eds_CostRowValue" value="" placeholder="' + i18n('CostPlaceholder.Text') + '" /></td>',
			rowTemplate = '<tr>' +
                            '<td colspan="2">' +
                                '<span title="' + i18n('RemoveTitle.Text') + '" class="eds__RemoveRow edNews_removeItem">' + i18n('RemoveTitle.Text') + '</span>' +
						        '<input type="text" class="eds__table_cell_input_name" name="eds_CostRowName" value="" placeholder="' + i18n('NamePlaceholder.Text') + '" />' +
					        '</td>' +
				        '</tr>',
			dateTimePicker = function (index) {
				return '<div class="input-group date" id="eds_dtp_' + index + '_">' +
						'<input type="text" readonly="readonly" class="form-control" /> ' +
						'<span class="input-group-addon">' +
							'<span class="glyphicon glyphicon-calendar"></span>' +
						'</span>' +
					'</div>';
			},
			previewButton = function () {
				return '<span title="Preview of current setup" style="cursor: pointer" class="glyphicon glyphicon-eye-open" id="eds_dateRestrictionPayment_preview"></span>'
			};

		if ($hfState.length == 0)
			return;

		//$mainWrapper.append(previewButton);
		$mainWrapper.append(tableHtml);

		var $validationInfoSpan = $('.eds__validationInfo', $mainWrapper);

		var $dateRestrictionTable = $('.eds__tblCostByDateRestriction', $mainWrapper),
			thCount = function () {
				return $('thead > tr > th', $dateRestrictionTable).length;
			},
			trCount = function () {
				return $('tbody > tr', $dateRestrictionTable).length;
			},
			tryParseDecimal = function (n) {
				'use strict';
				n = n.replace(/\./g, '').replace(',', '.');
				return !isNaN(parseFloat(n)) && isFinite(n);
			},
			isEmpty = function (value) {
				if (value === undefined || value === null || value === '')
					return true;
				else
					return false;
			},
			validateDecimal = function (value) {
				if (isEmpty(value))
					return false;

				if ($tbValidateDecimal.length !== 0 && typeof (Page_ClientValidate) == 'function') {
					$tbValidateDecimal.val(value);

					if (Page_ClientValidate('vgValidateDecimal') == true)
						return true;
					else
						return false;
				}
				else {
					if (tryParseDecimal(value))
						return true;
					else
						return false;
				}
			},
			validationInfo = function (returnValidationMeta) {
				if (isEmpty(returnValidationMeta.message)) {
					$validationInfoSpan.html('').hide();
				}
				else {
					$validationInfoSpan.html(returnValidationMeta.message).show();
				}
			},
			validateAll = function (id) {
				if(id !== $mainWrapper.attr("id"))
					return false;

				var returnValidationMeta = {
					success: false,
					message: ''
				}

				if (members.structure.x.length == 0 || members.structure.y.length == 0) {
					returnValidationMeta.message = i18n('DefineAtLeastOneValue.Text');
					validationInfo(returnValidationMeta);
				}

				if (members.matrix.length != members.structure.x.length) {
					returnValidationMeta.message = i18n('CostKeyValuePairNotValid.Text');
					validationInfo(returnValidationMeta);
				}

				for (var i = 0; i < members.structure.x.length; i++) {
					if (members.matrix[i].length != members.structure.y.length) {
						returnValidationMeta.message = i18n('CostKeyValuePairNotValid.Text');
						validationInfo(returnValidationMeta);
						break;
					}
				}

				for (var i = 0; i < members.structure.y.length; i++) {
					if (isEmpty(members.structure.y[i].name)) {
						returnValidationMeta.message = i18n('OneOfTheNameValuesIsNotSet.Text');
						validationInfo(returnValidationMeta);
						break;
					}
				}

				for (var i = 0; i < members.structure.x.length; i++) {
					if (isEmpty(members.structure.x[i].value)) {
						returnValidationMeta.message = i18n('OneOfTheDateValuesIsNotSet.Text');
						validationInfo(returnValidationMeta);
						break;
					}
				}

				for (var i = 0; i < members.structure.x.length; i++) {
					for (var j = 0; j < members.structure.y.length; j++) {
						if (!validateDecimal(members.matrix[i][j])) {
							returnValidationMeta.message = i18n('OneOfTheCostValuesIsNotSet.Text');
							validationInfo(returnValidationMeta);
							break;
						}
					}
				}

				if (isEmpty(returnValidationMeta.message))
					returnValidationMeta.success = true;

				return returnValidationMeta;
			},
			removeX = function (rowIndex) {
				members.structure.x.splice(rowIndex, 1)
				members.matrix.splice(rowIndex, 1);
			},
			removeY = function (colIndex) {
				members.structure.y.splice(colIndex, 1)
				for (var i = 0; i < members.matrix.length; i++) {
					var row = members.matrix[i];
					row.splice(colIndex, 1);
				}
			},
			addX = function (type, value) {
				var newX = {
					id: members.structure.x.length + 1,
					type: type,
					value: value
				}
				members.structure.x.push(newX);
				var newXValue = new Array(members.structure.y.length);
				members.matrix.push(newXValue);
			},
			updateXValue = function (index, value) {
				members.structure.x[index].value = value;
			},
			addY = function (type, name) {
				var newY = {
					id: members.structure.y.length + 1,
					type: type,
					name: name
				}

				members.structure.y.push(newY);

				for (var i = 0; i < members.matrix.length; i++) {
					var row = members.matrix[i];
					row.push("");
				}
			},
			updateYValue = function (index, name) {
				members.structure.y[index].name = name;
			},
			setMatrixValue = function (x, y, value) {
				members.matrix[x][y] = value;
			},
			createNameRow = function (name) {
				var rowCount = trCount();
				if (rowCount > 0) {
					var new_row = $dateRestrictionTable.find('tbody > tr:first').clone();
					$('input', new_row).val('');
					if (name)
						$('input:first', new_row).val(name);
					else
                        $('input:first', new_row).val('');

                    $('input', new_row).css("background-color", "")

					$(new_row).appendTo($('tbody', $dateRestrictionTable));
				}
				else {
					var tbodyThCount = thCount(),
						$rowTemplate_Temp = $(rowTemplate)

					if (name)
						$('input:first', $rowTemplate_Temp).val(name);
					else
						$('input:first', $rowTemplate_Temp).val('');

					if (tbodyThCount > leftDataCellOffset) {
						var allCells;
						for (var i = leftDataCellOffset; i < tbodyThCount; i++) {
							allCells += cellTemplate;
						}

						$($($rowTemplate_Temp).append(allCells)).appendTo($('tbody', $dateRestrictionTable));
					}
					else {
						$($rowTemplate_Temp).appendTo($('tbody', $dateRestrictionTable));
					}
				}
				addY('String', name);
			},
			createDateColumn = function (value) {
				var tbodyThCount = thCount() + 1;
				$('tr:first ', $dateRestrictionTable).append("<th><span title='Remove' style='cursor: pointer' class='eds__RemoveCell edNews_removeItem'>Remove</span>" + dateTimePicker(tbodyThCount) + "</th>");

				// zadavanje vrijednosti direktno u text box!
				if (!isEmpty(value)) {
					$('tr:first > th:last', $dateRestrictionTable).find("input").val(value);
				}

				$("#eds_dtp_" + tbodyThCount + "_").datetimepicker(settings.dateTimePicker)
					.on('dp.change', function (e) {
						var indexTh = $(this).closest("th").index() - leftDataCellOffset;
                        updateXValue(indexTh, $(this).find("input").val());
                        updateHiddenField();
					});

				$('tr:not(:first)', $dateRestrictionTable).each(function () {
					$(this).append(cellTemplate);
				});

				addX('DateTime', value);
			},
			createViewPreview = function (matrixData) {
				var data = $hfStateViewSpecificId.val();
				if (data) {
					matrixData = JSON.parse(data);
				}
				var previewHtml = "<div id='eds_matrix_preview'><span title='Close preview' style='cursor: pointer' class='glyphicon glyphicon-remove-circle' id='eds_dateRestrictionPayment_preview_close'></span><table><tbody>";

				for (var i = 0; i < matrixData.structure.y.length; i++) {
					previewHtml += "<tr><td></td>";
					for (var j = 0; j < matrixData.structure.x.length; j++) {
						previewHtml += "<td><span class='eds_preview_cell_title" + (matrixData.structure.x[j].disabled ? "_disabled'" : "'") + ">Price " + matrixData.matrix[j][i] + " <br />Until " + matrixData.structure.x[j].value + "</span></td>";
					}
					previewHtml += "</tr>";

					previewHtml += "<tr><td>" + matrixData.structure.y[i].name + "</td>";

					for (var j = 0; j < matrixData.structure.x.length; j++) {
						//create table columns
						previewHtml += "<td><input type='radio' name='eds_preview_radio_cost' class='eds_preview_radio_cost" + (matrixData.structure.x[j].disabled ? "_disabled'" : "'") + " id='radioButton" + (i + j) + "'></td>";
					}

					previewHtml += "</tr>";
				}

				previewHtml += "</tbody></table></div>";

				$mainWrapper.append(previewHtml);
				$(".eds_preview_radio_cost_disabled", $mainWrapper).attr('disabled', true);
				$(".eds_preview_cell_title_disabled", $mainWrapper).css({ opacity: 0.5 });
            },
            updateHiddenField = function () {
                $hfState.val(JSON.stringify(members));
            },
			action = function ($this, action) {
				switch (action) {
					case "addRow": {
						createNameRow('');
						break;
					}
					case "addColumn": {
						createDateColumn('');
						break;
					}
					case "removeRow": {
						var indexRow = $this.closest("tr").index();
						$this.closest("tr").remove();
						removeY(indexRow);
						break;
					}
					case "removeColumn": {
						var indexCell = $this.closest('th').index();
						$('tbody > tr', $dateRestrictionTable).each(function () { $(this).find("td:eq(" + indexCell + ")").remove(); });
						$this.closest('th').remove();
						removeX(indexCell - leftDataCellOffset);
						break;
					}
					case "updateName": {
						var indexRow = $this.closest("tr").index();
						updateYValue(indexRow, $this.val());
						break;
					}
					case "updateValue": {
						var indexRow = $this.closest("tr").index();
						var indexCell = $this.closest("td").index() - leftDataCellOffset;

						if (validateDecimal($this.val())) {
							$this.css("background-color", "")
							setMatrixValue(indexCell, indexRow, $this.val());
						}
						else {
							// not valid decimal
							$this.css("background-color", "#FEB4BE");
						}
						break;
					}
					case "preview": {
						$("#eds_matrix_preview", $mainWrapper).remove();
						createViewPreview(members);
						break;
					}
					case "preview_close": {
						$("#eds_matrix_preview", $mainWrapper).remove();
						break;
					}
				}

                updateHiddenField();
				$validationInfoSpan.html('').hide();
			},
			init = function () {
				defaultSettings.validate.push([$mainWrapper.attr("id"), validateAll]);

				var data = $hfState.val();
				if (data) {
					var matrixData = JSON.parse(data);

					for (var i = 0; i < matrixData.structure.x.length; i++) {
						//create table columns
						createDateColumn(matrixData.structure.x[i].value);
					}

					for (var i = 0; i < matrixData.structure.y.length; i++) {
						//create table rows
						createNameRow(matrixData.structure.y[i].name);
					}

					for (var i = 0; i < matrixData.structure.x.length; i++) {
						//fill matrix
						for (var j = 0; j < matrixData.structure.y.length; j++) {
							//create table rows
							setMatrixValue(i, j, matrixData.matrix[i][j]);
							//$('tbody > tr:eq(' + i + ')', $dateRestrictionTable).find('td:eq(' + j + ')').text(matrixData.matrix[i][j]);
							$('tbody > tr:eq(' + j + ') > td:eq(' + (i + leftDataCellOffset) + ') > input', $dateRestrictionTable).val(matrixData.matrix[i][j]);
							//$('tbody > tr:nth-child(' + i + ') td:nth-child(' + j + ')', $dateRestrictionTable).val(matrixData.matrix[i][j]);
						}
					}
				}
			}

		init();

		$mainWrapper
			.on('click', '#eds__AddDateRestrictionName', function (e) {
				action($(this), 'addRow');
			})
			.on('click', '#eds__AddDateRestrictionDate', function (e) {
				action($(this), 'addColumn');
			})
			.on('click', '.eds__RemoveRow', function (e) {
				action($(this), 'removeRow');
			})
			.on('click', '.eds__RemoveCell', function (e) {
				action($(this), 'removeColumn');
			})
            .on("propertychange change keyup paste input", '.eds__table_cell_input_name', function (e) {
				action($(this), 'updateName');
			})
			.on("propertychange change keyup paste input", '.eds__table_cell_input_value', function (e) {
				action($(this), 'updateValue');
			})
			.on('click', '#eds_dateRestrictionPayment_preview', function (e) {
				action($(this), 'preview');
			})
			.on('click', '#eds_dateRestrictionPayment_preview_close', function (e) {
				action($(this), 'preview_close');
			});
	}

	edsMatrix.prototype = {};

	$.fn.eds2_2_DateRestrictionPayment_Edit_1_0_0 = function (settings) {
		var instanceKey = 'eds2_2_DateRestrictionPayment_Edit_1_0_0';
		settings = $.extend(true, {}, defaultSettings, settings);

		$.fn.eds2_2_DateRestrictionPayment_Edit_1_0_0.Validate = function (id) {
			for(var i = 0; i < defaultSettings.validate.length; i++)
			 {
				if(defaultSettings.validate[i][0] === id){
					returnValidationMeta = defaultSettings.validate[i][1](id);
					return returnValidationMeta.success;
				}				
			};
			return false;
		}

		return this.each(function () {
			var elem = this;
			if (!$.data(elem, instanceKey)) {
				$.data(elem, instanceKey, new edsMatrix(elem, settings));
			}
		});
	};
})(eds2_2, window);