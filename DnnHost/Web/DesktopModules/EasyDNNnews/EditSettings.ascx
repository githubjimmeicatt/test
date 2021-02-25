<%@ control language="C#" inherits="EasyDNNSolutions.Modules.EasyDNNNews.Administration.EditSettings, App_Web_editsettings.ascx.d988a5ac" autoeventwireup="true" %>
<%@ Register TagPrefix="dnn" TagName="TextEditor" Src="~/controls/TextEditor.ascx" %>

<script type="text/javascript">
	//<![CDATA[

	<%=CustomFieldFilterJSFunctions%>

	<%=PortalSharingJS%>

	function CategoryClientValidate(source, arguments) {
		if ($('#<%=cbDisplayAllCategories.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}
		var checkedCount = $('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length;
		if (checkedCount > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
		}
	}

	function CfFilterToogleLogicalOperation(ControlClientID, AllControls) {
		var selectedDdl = document.getElementById(ControlClientID);
		if (selectedDdl.options[selectedDdl.selectedIndex].value == '') {
			for (i = 0; i < AllControls.length; i++) {
				jQuery('#' + AllControls[i]).prop('disabled', true);
			}
		}
		else {
			for (i = 0; i < AllControls.length; i++) {
				jQuery('#' + AllControls[i]).prop('disabled', false);
			}
		}
	}

	function ClientValidateAuthors(source, arguments) {
		if ($('#<%=cbShowAllAuthors.ClientID%>')[0].checked) {
			arguments.IsValid = true;
			return;
		}

		if ($('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').find('input[type="checkbox"]').filter(':checked').length > 0) {
			arguments.IsValid = true;
		} else {
			arguments.IsValid = false;
			jQuery('#<%=pnlArticleSettingsTable.ClientID%>').show(0);
		}
	}

	function showWarnningEdit() {
		alert("You are editing the default settings. This will affect all modules that use the default settings.");
	}

	function AMPArticleTemplateValidation(source, arguments) {
		if ($('#<%=cbCreateAMPArticles.ClientID%>')[0].checked) {
			if ($("#<%=ddlAMPArticleTemplate.ClientID%> option:selected").val())
				arguments.IsValid = true;
			else {
				$("#<%=pnlCanonicalURLsSettingsSource.ClientID%>").removeClass("edNews__collapsed");
				$("#<%=hfCanonicalURLs.ClientID%>").val("");
				$("#<%=pnlCanonicalURLsSettings.ClientID%>").attr('style', 'display: block;');
				arguments.IsValid = false;
			}
			return;
		}
		else {
			arguments.IsValid = true;
		}
	}

	var edn_all_categories = <%=GetAllCategoriesObject() %>;
	var edn_customize_add_edit = <%=getcustomize_add_edit() %>;

	var generate_category_list_items = function (selected_categories, items) {
		var all_categories = jQuery.extend(true, [], items),
			category_list = '',
			i = 0,
			selected;

		for (; i < all_categories.length; i++) {
			selected = selected_categories.indexOf(',' + all_categories[i].id + ',') != -1;
			category_list += '<li style="margin-left: ' + (all_categories[i].level * 15) + 'px"><label><input type="checkbox"' + (selected ? ' checked="checked"' : '') + ' name="edn_permission_for_category_' + all_categories[i].id + '" value="' + all_categories[i].id + '" /><span>' + all_categories[i].name + '</span></label></li>';
		}

		return category_list;
	}

	var generate_add_edit_list_items = function (selected_categories, items) {
		var all_categories = jQuery.extend(true, [], items),
			category_list = '',
			i = 0,
			selected_html,
			hide_checkbox = false;

		for (; i < all_categories.length; i++) {
			selected_html = '';

			if (all_categories[i].id == 'Title' || all_categories[i].id == 'Categories') {
				selected_html = ' checked="checked" disabled="disabled"';
			} else {
				if (selected_categories.indexOf(',' + all_categories[i].id + ',') != -1)
					selected_html = ' checked="checked"';
			}

			if (all_categories[i].id == 'DetailType' || all_categories[i].id == 'Gallery' || all_categories[i].id == 'AdvancedSettings')
				hide_checkbox = true;
			else
				hide_checkbox = false;

			category_list += '<li style="margin-left: ' + (all_categories[i].level * 15) + 'px;' + (hide_checkbox ? ' margin-top: 5px;' : '') + '"><label><input type="checkbox"' + selected_html + (hide_checkbox ? ' style="display: none;"' : '') + ' name="edn_permission_for_category_' + all_categories[i].id + '" value="' + all_categories[i].id + '" /><span>' + all_categories[i].name + '</span></label></li>';
		}

		return category_list;
	}

	jQuery().ready(function ($) {
		$('.edNews__toggleNextTableRow').on('change', 'input[type="checkbox"]', function () {
			var $this = $(this);
			if (!this.checked) {
				$this.closest('tr').next('tr').hide();
			} else {
				$this.closest('tr').next('tr').show();
			};
		});

		$('input[type="checkbox"]', '.edNews__toggleNextTableRow').trigger("change");

		$('#<%=cbCreateAMPArticles.ClientID%>,#<%=cbEnableCanonicalLink.ClientID%>').on('change', function () {
			if (!this.checked) {
				$(this).closest("tr").nextAll().hide();
			}
			else {
				$(this).closest("tr").nextAll().show();
			}
		});
		$('#<%=cbCreateAMPArticles.ClientID %>').trigger("change");
		$('#<%=cbEnableCanonicalLink.ClientID %>').trigger("change");

		$('#<%=cbFeaturedArticles.ClientID %>').on('change', function () {
			if (this.checked) {
				$('#<%=cbFeaturedOnTop.ClientID %>')[0].checked = false;
			}
		});

		$('#<%=cbFeaturedOnTop.ClientID %>').on('change', function () {
			if (this.checked)
				$('#<%=cbFeaturedArticles.ClientID %>')[0].checked = false;
		});

		<%=includeLBJS%>;

		$('#<%= ddlOrderPostsBy.ClientID %>').change(function () {
			if (this.value == 'Random') {
				$('#<%= ddlAscOrder.ClientID %>').prop('disabled', true);
			}
			else {
				$('#<%= ddlAscOrder.ClientID %>').prop('disabled', false);
			}
		});

		if ($('#<%= rblRestrictionByDateRange.ClientID %> input:checked').val() == 0) {
			$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', 'none');
		}
		else {
			$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', '');
		}

		$('#<%= rblRestrictionByDateRange.ClientID %> input').change(function () {
			if ($(this).val() == 0) {
				$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', 'none');
			}
			else {
				$('#<%= tbxRestrictionByDateRange.ClientID %>').css('display', '');
			}
		});

		$('#<%=rblPaginationType.ClientID%> input').change(function () {
			if ($(this).val() == 0) {
				$('#<%=rowNormalPaginationOptions.ClientID %>').css('display', '');
			}
			else {
				$('#<%=rowNormalPaginationOptions.ClientID %>').css('display', 'none');
			}
		});

		eds3_5_jq('#<%=tbxPublishDate.ClientID%>').datepick({ dateFormat:"<%=dateFormat%>" });
		eds3_5_jq('#<%=tbxExpireDate.ClientID%>').datepick({ dateFormat:"<%=dateFormat%>" });

		var $permissions_show_all_items = $('.permissions_show_all_items > input'),
			$permissions_show_manual_item_selection = $('.permissions_show_manual_item_selection > input'),
			$permissions_show_no_items = $('.permissions_show_no_items > input'),
			$edn_permission_selection_dialog = $('.permission_selection_dialog'),
			$permission_list_items = $edn_permission_selection_dialog.find('> ul'),
			$permissions_show_selection_dialog = $('a.permissions_show_selection_dialog'),
			$customize_add_edit_show_selection_dialog = $('a.customize_add_edit_show_selection_dialog'),
			$contentLimitsTrigger = $('a.contentLimitsTrigger');

		$edn_permission_selection_dialog
			.dialog({
				autoOpen: false,
				buttons: { 'Close': function () { $(this).dialog('close'); } },
				resizable: false,
				width: 'auto'
			});

		$contentLimitsTrigger.on('click', function (e) {
			'use strict';
			var $clicked = $(this),
				$currentSettings = $clicked.prev('input[type="hidden"]'),
				listHtml = '',
				limits = JSON.parse($currentSettings.val()),
				expireDateDays = 0,
				expireDateHours = 0,
				expireDateMinutes = 0;

			if (limits.ExpireDateLimit > -1) {
				if (limits.ExpireDateLimit > 59) {
					expireDateMinutes = limits.ExpireDateLimit % 60;

					expireDateHours = Math.floor(limits.ExpireDateLimit / 60);

					if (expireDateHours > 23) {
						expireDateDays = Math.floor(expireDateHours / 24);
						expireDateHours = expireDateHours % 24;
					}
				} else
					expireDateMinutes = limits.ExpireDateLimit;
			}

			listHtml = '<li class="contentLimit articles' + (limits.ArticleLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.ArticleLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfArticles%></label><input type="text" value="' + (limits.ArticleLimit > -1 ? limits.ArticleLimit : '0') + '" /></li>' +
				'<li class="contentLimit images' + (limits.ImageLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.ImageLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfImagesPerArticle%></label><input type="text" value="' + (limits.ImageLimit > -1 ? limits.ImageLimit : '0') + '" /></li>' +
				'<li class="contentLimit video' + (limits.VideoLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.VideoLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfVideosPerArticle%></label><input type="text" value="' + (limits.VideoLimit > -1 ? limits.VideoLimit : '0') + '" /></li>' +
				'<li class="contentLimit audio' + (limits.AudioLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.AudioLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfAudiosPerArticle%></label><input type="text" value="' + (limits.AudioLimit > -1 ? limits.AudioLimit : '0') + '" /></li>' +
				'<li class="contentLimit document' + (limits.DocumentLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.DocumentLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfDocumentsPerArticle%></label><input type="text" value="' + (limits.DocumentLimit > -1 ? limits.DocumentLimit : '0') + '" /></li>' +
				'<li class="contentLimit link' + (limits.LinkLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.LinkLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfLinksPerArticle%></label><input type="text" value="' + (limits.LinkLimit > -1 ? limits.LinkLimit : '0') + '" /></li>' +
				'<li class="contentLimit tag' + (limits.TagLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.TagLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfTagsPerArticle%></label><input type="text" value="' + (limits.TagLimit > -1 ? limits.TagLimit : '0') + '" /></li>' +
				'<li class="contentLimit category' + (limits.CategoryLimit > -1 ? ' activeLimit' : '') + '"><label><input type="checkbox" value=""' + (limits.CategoryLimit > -1 ? ' checked="checked"' : '') + ' /><%=MaximumNumberOfCategoriesPerArticle%></label><input type="text" value="' + (limits.CategoryLimit > -1 ? limits.CategoryLimit : '1') + '" /></li>' +
				'<li class="contentLimit expireDate' + (limits.ExpireDateLimit > -1 ? ' activeLimit' : '') + '">' +
				'<label><input type="checkbox" value=""' + (limits.ExpireDateLimit > -1 ? ' checked="checked"' : '') + ' /><%=SetExpireDate%></label>' +
				'<div>' +
				'<label class="days"><input type="text" value="' + expireDateDays + '" /><%=Days%></label>' +
				'<label class="hours"><input type="text" value="' + expireDateHours + '" /><%=Hours%></label>' +
				'<label class="minutes"><input type="text" value="' + expireDateMinutes + '" /><%=Minutes%></label>' +
				'</div>' +
				'</li>';

			$permission_list_items.html(listHtml);

			$('input[type="checkbox"]', $permission_list_items).change(function () {
				var $changed = $(this),
					$li = $changed.parent().parent(),
					$textBox = $('> input[type="text"]', $li),
					inputValue = parseInt($textBox.val());

				if ($li.is('div'))
					$li = $li.parent();

				if (this.checked) {
					$li.addClass('activeLimit');

					if (isNaN(inputValue) || inputValue < 0) {
						$textBox.val(0);
						inputValue = 0;
					}
				} else {
					$li.removeClass('activeLimit');
					inputValue = -1;
				}

				if ($li.hasClass('articles'))
					limits.ArticleLimit = inputValue;
				else if ($li.hasClass('images'))
					limits.ImageLimit = inputValue;
				else if ($li.hasClass('video'))
					limits.VideoLimit = inputValue;
				else if ($li.hasClass('audio'))
					limits.AudioLimit = inputValue;
				else if ($li.hasClass('document'))
					limits.DocumentLimit = inputValue;
				else if ($li.hasClass('link'))
					limits.LinkLimit = inputValue;
				else if ($li.hasClass('tag'))
					limits.TagLimit = inputValue;
				else if ($li.hasClass('category')) {
					if (this.checked && inputValue < 1) {
						$textBox.val(1);
						inputValue = 1;
					}

					limits.CategoryLimit = inputValue;
				} else if ($li.hasClass('expireDate')) {
					var days = parseInt($('> div > label.days > input', $li).val()),
						hours = parseInt($('> div > label.hours > input', $li).val()),
						minutes = parseInt($('> div > label.minutes > input', $li).val());

					limits.ExpireDateLimit = minutes + hours * 60 + days * 1440;
				}

				$currentSettings.val(JSON.stringify(limits));
			});

			$('input[type="text"]', $permission_list_items).on('change blur', function () {
				var $textBox = $(this),
					$li = $textBox.parent(),
					inputValue = parseInt($textBox.val());

				if ($li.is('label'))
					$li = $li.parent().parent();

				if (isNaN(inputValue) || inputValue < 0) {
					$textBox.val(0);
					inputValue = 0;
				}

				if ($li.hasClass('articles'))
					limits.ArticleLimit = inputValue;
				else if ($li.hasClass('images'))
					limits.ImageLimit = inputValue;
				else if ($li.hasClass('video'))
					limits.VideoLimit = inputValue;
				else if ($li.hasClass('audio'))
					limits.AudioLimit = inputValue;
				else if ($li.hasClass('document'))
					limits.DocumentLimit = inputValue;
				else if ($li.hasClass('link'))
					limits.LinkLimit = inputValue;
				else if ($li.hasClass('tag'))
					limits.TagLimit = inputValue;
				else if ($li.hasClass('category')) {
					if (inputValue < 1) {
						$textBox.val(1);
						inputValue = 1;
					}

					limits.CategoryLimit = inputValue;
				} else if ($li.hasClass('expireDate')) {
					var days = parseInt($('> div > label.days > input', $li).val()),
						hours = parseInt($('> div > label.hours > input', $li).val()),
						minutes = parseInt($('> div > label.minutes > input', $li).val());

					limits.ExpireDateLimit = minutes + hours * 60 + days * 1440;
				}

				$currentSettings.val(JSON.stringify(limits));
			});

			$edn_permission_selection_dialog
				.dialog('open');

			return false;
		});

		$permissions_show_all_items.change(function () {
			var $this = $(this),
				$parent = $this.parent().parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection
				.hide(200)
				.children('input[type="hidden"]').val('')
				.siblings('textarea').html('');

			$edn_permission_selection_dialog.dialog('close');

			if ($parent.children().hasClass('add_edit')) {
				$('> a.customize_add_edit_show_selection_dialog', $parent.parent().siblings()).css('visibility', 'visible');
				$parent.siblings('a.contentLimitsTrigger').css('display', 'block');
			}
		});

		$permissions_show_manual_item_selection.change(function () {
			var $this = $(this),
				$parent = $this.parent().parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.show(200);

			$edn_permission_selection_dialog.dialog('close');

			if ($parent.children().hasClass('add_edit')) {
				$('> a.customize_add_edit_show_selection_dialog', $parent.parent().siblings()).css('visibility', 'hidden');
				$parent.siblings('a.contentLimitsTrigger').css('display', 'block');
			}
		});

		$permissions_show_no_items.change(function () {
			var $this = $(this),
				$parent = $this.parent().parent(),
				$permissions_manual_item_selection = $parent.siblings('.permissions_manual_item_selection');

			$permissions_manual_item_selection.find('> input[type="hidden"]').val('');
			$permissions_manual_item_selection.find('> .selected_categories').html('');

			$permissions_manual_item_selection.hide(200);

			$edn_permission_selection_dialog.dialog('close');

			if ($parent.children().hasClass('add_edit')) {
				$('> a.customize_add_edit_show_selection_dialog', $parent.parent().siblings()).css('visibility', 'hidden');
				$parent.siblings('a.contentLimitsTrigger').css('display', 'none');
			}
		});

		$permissions_show_selection_dialog.click(function () {
			var $clicked = $(this),
				$parent = $clicked.parent(),
				$selected_categories_field = $clicked.siblings('input[type="hidden"]'),
				$selected_categories_text = $parent.find('textarea.selected_categories'),
				$add_edit_field_selection_trigger;

			$add_edit_field_selection_trigger = $parent.hasClass('add_edit') ? $('> .customize_add_edit_show_selection_dialog', $parent.parent().siblings()) : $();

			$permission_list_items
				.html(generate_category_list_items($selected_categories_field.val(), ($clicked.hasClass('custom_fields') ? edn_all_custom_fields : edn_all_categories)))
				.find('input[type="checkbox"]')
				.change(function () {
					var $selected_categories = $permission_list_items.find('input[type="checkbox"]:checked'),
						selected_ids = ',',
						selected_categories_names = '';

					if ($selected_categories.length) {
						$selected_categories.each(function () {
							var $this = $(this);

							selected_ids += $this.val() + ',';
							selected_categories_names += $this.siblings('span:first').html() + ', ';
						});
						$selected_categories_field.val(selected_ids);
						$selected_categories_text.html(selected_categories_names.substring(0, selected_categories_names.length - 2));

						$add_edit_field_selection_trigger.css('visibility', 'visible');
					} else {
						$selected_categories_field.val('');
						$selected_categories_text.html('');

						$add_edit_field_selection_trigger.css('visibility', 'hidden');
					}
				});

			$edn_permission_selection_dialog
				.dialog('open');

			return false;
		});

		$customize_add_edit_show_selection_dialog.click(function () {
			var $clicked = $(this),
				$selected_categories_field = $clicked.siblings('input[type="hidden"]'),
				$selected_categories_text = $clicked.parent().find('textarea.selected_categories');

			$permission_list_items
				.html(generate_add_edit_list_items($selected_categories_field.val(), edn_customize_add_edit))
				.find('input[type="checkbox"]')
				.change(function () {
					var $selected_categories = $permission_list_items.find('input[type="checkbox"]:checked'),
						selected_ids = ',',
						selected_categories_names = '';

					if ($selected_categories.length) {
						$selected_categories.each(function () {
							var $this = $(this);

							selected_ids += $this.val() + ',';
							selected_categories_names += $this.siblings('span:first').html() + ', ';
						});
						$selected_categories_field.val(selected_ids);
						$selected_categories_text.html(selected_categories_names.substring(0, selected_categories_names.length - 2));
					} else {
						$selected_categories_field.val('');
						$selected_categories_text.html('');
					}
				});

			$edn_permission_selection_dialog
				.dialog('open');

			return false;
		});

		$('#<%=upArticleTags.ClientID %>')
			.delegate('#<%=dlListOfExistingTags.ClientID %> a.tag_link', 'click', function () {
				var $this = $(this),
					tag_id = $this.data('edsTagId') || $this.data('eds-tag-id'),
					$filterContentByTagsWrapper = $('#filterContentByTagsWrapper'),
					$hfSelectedTags = $('#<%=hfSelectedTags.ClientID %>'),
					id_list = $hfSelectedTags.val();

				$('#<%=filterContentByTagsNoTagsMsg.ClientID %>').css('display', 'none');

				if (id_list.indexOf(',' + tag_id + ',') === -1) {
					$('> ul', $filterContentByTagsWrapper).append('<li data-eds-tag-id="' + tag_id + '" class="tag-' + tag_id + '">' + $this.text() + '<span>Delete</span></li>');

					if (id_list == '')
						id_list = ',' + tag_id + ',';
					else
						id_list += tag_id + ',';

					$hfSelectedTags.val(id_list);
				}

				return false;
			})
			.delegate('#<%=dlListOfExistingTags.ClientID %> a.tag_link', 'mouseenter mouseleave', function (e) {
				var $this = $(this),
					$target = $('#filterContentByTagsWrapper li.tag-' + ($this.data('edsTagId') || $this.data('eds-tag-id')));

				if (e.type == 'mouseenter')
					$target.addClass('already_present');
				else
					$target.removeClass('already_present');
			});

		$('#filterContentByTagsWrapper').delegate('li > span', 'click', function () {
			var $li = $(this).parent(),
				$hfSelectedTags = $('#<%=hfSelectedTags.ClientID %>'),
				id_list = $hfSelectedTags.val();

			id_list = id_list.replace(',' + ($li.data('edsTagId') || $li.data('eds-tag-id')) + ',', ',');
			if (id_list == ',') {
				id_list = '';
				$('#<%=filterContentByTagsNoTagsMsg.ClientID %>').css('display', 'block');
			}

			$hfSelectedTags.val(id_list);
			$li.remove();
		});

		$('#<%=upFilterPerArticle.ClientID %>')
			.delegate('#<%=dlFilterPerArticle.ClientID %> a.articleid_link', 'click', function () {
				var $this = $(this),
					article_id = $this.data('edsArticleId') || $this.data('eds-article-id'),
					$filterContentByArticlesWrapper = $('#filterContentByArticlesWrapper'),
					$hfSelectedArticles = $('#<%=hfSelectedArticles.ClientID %>'),
					id_list = $hfSelectedArticles.val();

				$('#<%=filterContentByArticlesNoTagsMsg.ClientID %>').css('display', 'none');

				if (id_list.indexOf(',' + article_id + ',') === -1) {
					$('> ul', $filterContentByArticlesWrapper).append('<li data-eds-article-id="' + article_id + '" class="article-' + article_id + '">' + $this.text() + '<span>Delete</span></li>');

					if (id_list == '')
						id_list = ',' + article_id + ',';
					else
						id_list += article_id + ',';

					$hfSelectedArticles.val(id_list);
				}

				return false;
			})
			.delegate('#<%=dlFilterPerArticle.ClientID %> a.articleid_link', 'mouseenter mouseleave', function (e) {
				var $this = $(this),
					$target = $('#filterContentByArticlesWrapper li.article-' + ($this.data('edsArticleId') || $this.data('eds-article-id')));

				if (e.type == 'mouseenter')
					$target.addClass('already_present');
				else
					$target.removeClass('already_present');
			})
			.delegate('#filterContentByArticlesWrapper li > span', 'click', function () {
				var $li = $(this).parent(),
					$hfSelectedArticles = $('#<%=hfSelectedArticles.ClientID %>'),
					id_list = $hfSelectedArticles.val();

				id_list = id_list.replace(',' + ($li.data('edsArticleId') || $li.data('eds-article-id')) + ',', ',');
				if (id_list == ',') {
					id_list = '';
					$('#<%=filterContentByArticlesNoTagsMsg.ClientID %>').css('display', 'block');
				}

				$hfSelectedArticles.val(id_list);
				$li.remove();
			});

		TemplateEditLink_Init();

		InitAutoCompleateSearch(eds3_5_jq, '<%=tbUserNameToAdd.ClientID%>', '<%=hfUserIdToAdd.ClientID%>', 'SearchUsers.ashx', { portalid: '<%=PortalId%>', moduleId: '<%=ModuleId%>', tabId: '<%=TabId%>' });

		$('#<%=phDinamicTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAddCatChilds.ClientID %>')
		});

		$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {

			if (this.checked)
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), false);
			else
				ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), true);

			$('#<%=tblSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
		});

		if ($('#<%=cbDisplayAllCategories.ClientID %>').length)
			$('#<%=tblSelectCategories.ClientID%>').css('display', ($('#<%=cbDisplayAllCategories.ClientID %>')[0].checked ? 'none' : ''));

		$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
			state_checkbox: $('#<%=cbAutoAdd.ClientID %>')
		});

		if ($('#<%=cbShowAllAuthors.ClientID %>').length)
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', ($('#<%=cbShowAllAuthors.ClientID %>')[0].checked ? 'none' : ''));

		$('#<%=cbShowAllAuthors.ClientID %>').on('change', function () {
			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', (this.checked ? 'none' : ''));
		});

		FilterByContent_Init();

		$('#<%=rblFilterContent.ClientID %> input').change(function () {
			FilterByContent_Init()
		});
	});

	function InitAutoCompleateSearch($, tbSearch, hfId, HttpHandler, params) {
		$('#' + tbSearch).autocomplete('/DesktopModules/EasyDNNnews/Ashx/' + HttpHandler, {
			remoteDataType: 'json',
			minChars: 1,
			filter: false,
			sort: false,
			useCache: false,
			matchSubset: false,
			matchCase: false,
			resultsClass: 'edsNewsAdmin_searchAutocomplete',
			extraParams: params,
			showResult: function (value, data) {
				return '<span>' + value + '</span>';
			},
			onItemSelect: function (value) {
				document.getElementById(hfId).value = value.data[0];
				document.getElementById(tbSearch).value = value.data[1];
			}
		})
	};

	function EditTemplateLinkChange($ddlTemplate, $editTemplateLink) {
		var newTemplateHrefPart = $ddlTemplate.val();

		$ddlTemplate.find('option').each(function () {
			var editTemplateHref = $editTemplateLink.attr('href');

			var templateLinkPart = encodeURIComponent($(this).val());

			if (editTemplateHref.indexOf(templateLinkPart) > 0) {
				$editTemplateLink.attr('href', editTemplateHref.replace(templateLinkPart, encodeURIComponent(newTemplateHrefPart)));
			}
		});
	};

	function FilterByContent_Init() {

		if ($('#<%=rblFilterArticlesBy.ClientID %> input:checked').val() == 'False') {
			$rblFilterContent = $('#<%=rblFilterContent.ClientID %> input:checked');
			$ddlOrderArticlesBy = $('#<%= ddlOrderPostsBy.ClientID %>');

			if ($rblFilterContent.val() == 0) {
				$('#<%= rowFilterByEvents.ClientID %>').css('display', 'none');

				if ($ddlOrderArticlesBy.val() == 'StartDate')
					$ddlOrderArticlesBy.val('PublishDate')

				$("#<%= ddlOrderPostsBy.ClientID %> option[value='StartDate']").prop('disabled', true);
				ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), false);
				ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), false);
			}
			else {
				$('#<%= rowFilterByEvents.ClientID %>').css('display', '');
				$("#<%= ddlOrderPostsBy.ClientID %> option[value='StartDate']").prop('disabled', false);
				ValidatorEnable(document.getElementById('<%=rfvPastEventLimit.ClientID %>'), true);
				ValidatorEnable(document.getElementById('<%=cvPastEventLimit.ClientID %>'), true);
			}
		}
	};

	function TemplateEditLink_Init() {
		$("#<%=ddlArticleListTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditHtmlTemplate.ClientID %>"));
		});
		$("#<%=ddlListDocumentsTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditListDocumentsHtmlTemplate.ClientID %>"));
		});
		$("#<%=ddlListLinksTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditListLinksTemplate.ClientID %>"));
		});
		$("#<%=ddlListRelatedArticlesTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditListRelatedArticlesTemplate.ClientID %>"));
		});

		$("#<%=ddlArticleDetailsTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditArticleDetailsTemplate.ClientID %>"));
		});
		$("#<%=ddlDetailsDocumentsTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditDetailsDocumentsTemplate.ClientID %>"));
		});
		$("#<%=ddlDetailsLinksTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditDetailsLinksTemplate.ClientID %>"));
		});
		$("#<%=ddlDetailsRelatedArticlesTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlDetailsRelatedArticlesTemplate.ClientID %>"));
		});
		$("#<%=ddlArticleCommentsTheme.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditArticleCommentsTemplate.ClientID %>"));
		});
		$("#<%=ddlGravityGallerySelectTemplate.ClientID %>").change(function () {
			EditTemplateLinkChange($(this), $("#<%=hlEditGravityGallerySelectTemplate.ClientID %>"));
		});
	}

	function pageLoad(sender, args) {
		if (args.get_isPartialLoad()) {

			$('#<%=cbFeaturedArticles.ClientID %>').on('change', function () {
				if (this.checked) {
					$('#<%=cbFeaturedOnTop.ClientID %>')[0].checked = false;
				}
			});
			$('#<%=cbFeaturedOnTop.ClientID %>').on('change', function () {
				if (this.checked)
					$('#<%=cbFeaturedArticles.ClientID %>')[0].checked = false;
			});

			eds3_5_jq('.edNews_tooltip').eds_tooltipster();

			FilterByContent_Init();

			$('#<%=cbDisplayAllCategories.ClientID %>').on('change', function () {

				if (this.checked)
					ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), false);
				else
					ValidatorEnable(document.getElementById('<%=cvCategoriesTreeview.ClientID %>'), true);

				$('#<%=tblSelectCategories.ClientID%>').css('display', (this.checked ? 'none' : ''));
			});

			$('#<%=rblFilterContent.ClientID %> input').change(function () {
				FilterByContent_Init()
			});

			$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').EDS_TreeViewSelector({
				state_checkbox: $('#<%=cbAutoAdd.ClientID %>')
			});

			if ($('#<%=cbShowAllAuthors.ClientID %>').length)
				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', ($('#<%=cbShowAllAuthors.ClientID %>')[0].checked ? 'none' : ''));

			$('#<%=cbShowAllAuthors.ClientID %>').on('change', function () {
				$('#<%=phGroupsAndAuthorsTreeView.ID%>advanced_tree_view_categor_selector').css('display', (this.checked ? 'none' : ''));
			});

			InitAutoCompleateSearch(eds3_5_jq, '<%=tbUserNameToAdd.ClientID%>', '<%=hfUserIdToAdd.ClientID%>', 'SearchUsers.ashx', { portalid: '<%=PortalId%>', moduleId: '<%=ModuleId%>', tabId: '<%=TabId%>' });

			TemplateEditLink_Init();

			eds3_5_jq('#<%=tbxPublishDate.ClientID%>').datepick({ dateFormat:"<%=dateFormat%>" });
			eds3_5_jq('#<%=tbxExpireDate.ClientID%>').datepick({ dateFormat:"<%=dateFormat%>" });

			$('#<%=upArticleTags.ClientID %>')
				.delegate('#<%=dlListOfExistingTags.ClientID %> a.tag_link', 'click', function () {
					var $this = $(this),
						tag_id = $this.data('edsTagId') || $this.data('eds-tag-id'),
						$filterContentByTagsWrapper = $('#filterContentByTagsWrapper'),
						$hfSelectedTags = $('#<%=hfSelectedTags.ClientID %>'),
						id_list = $hfSelectedTags.val();

					$('#<%=filterContentByTagsNoTagsMsg.ClientID %>').css('display', 'none');

					if (id_list.indexOf(',' + tag_id + ',') === -1) {
						$('> ul', $filterContentByTagsWrapper).append('<li data-eds-tag-id="' + tag_id + '" class="tag-' + tag_id + '">' + $this.text() + '<span>Delete</span></li>');

						if (id_list == '')
							id_list = ',' + tag_id + ',';
						else
							id_list += tag_id + ',';

						$hfSelectedTags.val(id_list);
					}

					return false;
				})
				.delegate('#<%=dlListOfExistingTags.ClientID %> a.tag_link', 'mouseenter mouseleave', function (e) {
					var $this = $(this),
						$target = $('#filterContentByTagsWrapper li.tag-' + ($this.data('edsTagId') || $this.data('eds-tag-id')));

					if (e.type == 'mouseenter')
						$target.addClass('already_present');
					else
						$target.removeClass('already_present');
				});

			$('#filterContentByTagsWrapper').delegate('li > span', 'click', function () {
				var $li = $(this).parent(),
					$hfSelectedTags = $('#<%=hfSelectedTags.ClientID %>'),
					id_list = $hfSelectedTags.val();

				id_list = id_list.replace(',' + ($li.data('edsTagId') || $li.data('eds-tag-id')) + ',', ',');
				if (id_list == ',') {
					id_list = '';
					$('#<%=filterContentByTagsNoTagsMsg.ClientID %>').css('display', 'block');
				}

				$hfSelectedTags.val(id_list);
				$li.remove();
			});
		}
	};
	//]]>
</script>
<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAdd" runat="server" Checked="true" Style="display: none" />
<div class="edNews_topBarWrapper">
	<div class="edNews_wrapper">
		<ul class="edNews_topActions">
			<li class="edNews_save">
				<asp:LinkButton ID="btnSave" runat="server" OnClick="btnSaveSettings_Click" Text="Save settings" ValidationGroup="vgSettings" resourcekey="btnSaveSettingsResource1" />
			</li>
			<li class="edNews_saveAndClose">
				<asp:LinkButton ID="btnSaveAndClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSettings" resourcekey="btnSaveCloseResource1" />
			</li>
			<li class="edNews_close">
				<asp:HyperLink runat="server" ID="linkClose"><span><%=_("btnCancelResource1")%></span></asp:HyperLink>
			</li>
		</ul>
		<asp:Literal ID="literalFlashMessage" runat="server" EnableViewState="false" />
	</div>
</div>
<div id="EDNadmin" class="edNews_adminWrapper mainContentWrapper topPadded bottomPadded">
	<div class="contentSection bottomPadded">
		<div class="titleWrapper">
			<asp:Literal ID="liAdminNavigation" runat="server" />
			<span><%=NewsSettings%></span>
		</div>
		<asp:Panel ID="pnlUseGeneralSettingsAll" runat="server" Visible="False">
			<asp:Label ID="lblUseGeneralSettingsAll" runat="server" Text="You are using general settings." resourcekey="lblUseGeneralSettingsAllResource1" />
		</asp:Panel>
		<asp:Panel ID="pnlAllSettings" CssClass="module_settings" runat="server">
			<div class="edNews_settingsSourceSelection">
				<div class="edNews_settingsCollapse edNews__collapsed">
					<a href="#" class="edNews__expand"><%=Expandall%></a>
					<a href="#" class="edNews__collapse"><%=Collapseall%></a>
				</div>
				<div>
					<asp:Label ID="lblSettingSitle" runat="server" Text="This module instance is using:" Font-Bold="True" />
					<div class="edNews_inputGroup displayInline">
						<asp:RadioButtonList ID="rblSettingsMode" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblSettingsMode_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
							<asp:ListItem class="normalRadioButton" Value="Module" Selected="True" resourcekey="ListItemResource1">Custom settings (instance)</asp:ListItem>
							<asp:ListItem class="normalRadioButton" Value="Portal" resourcekey="ListItemResource2">Default setings (portal)</asp:ListItem>
						</asp:RadioButtonList>
					</div>
				</div>
				<div class="mainActions smallActions textLeft">
					<asp:LinkButton ID="lbEnableEditPortalSettings" runat="server" OnClientClick="showWarnningEdit();" Visible="False" CssClass="primaryAction" OnClick="lbEnableEditPortalSettings_Click" resourcekey="lbEnableEditPortalSettingsResource1">Enable default settings editing</asp:LinkButton>
				</div>
				<asp:HiddenField ID="hfIsInGeneralSettings" runat="server" Value="False" />
			</div>
			<!--sectionBox begin-->
			<div class="sectionBox noPadding">
				<asp:Panel ID="pnlPortalSharing" runat="server" CssClass="sectionBox noPadding">
					<table class="optionsList fullWidthTable noBorder">
						<tr>
							<td class="tdLabel noWidth">
								<label for="<%=lbSharingPortalID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPortalSharing.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPortalSharing.Text") %></label>
							</td>
							<td>
								<asp:ListBox runat="server" ID="lbSharingPortalID" SelectionMode="Multiple"></asp:ListBox>
								<asp:HiddenField runat="server" ID="hfSelectedSharingPortalID" />
								<div class="mainActions noMargin displayInline smallActions">
									<asp:Button CssClass="primaryAction" ID="btnSharingPortal" runat="server" resourcekey="btnSharingPortal" Text="Set portals" OnClick="btnSharingPortal_Click" />
								</div>
							</td>
						</tr>
					</table>
				</asp:Panel>
				<asp:Panel ID="pnlPerformanceSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfPerformanceSettings" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblPerformanceSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblPerformanceSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">0</span>
						<h2><%=Localization.GetString("PerformanceSettings.Text", LocalResourceFile) %></h2>
					</div>
					<asp:Panel ID="pnlPerformanceSettingsTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label class="edNews_tooltip" data-tooltip-content="<%=_("lblContentSelection.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContentSelection.Text") %></label>
								</td>
								<td>
									<div>
										<div class="switchCheckbox">
											<asp:CheckBox CssClass="normalCheckBox" runat="server" ID="cbQueryPermissionsPerArticles" resourcekey="liPermissionsPerArticles" Text="Permissions per articles" Checked="false" />
										</div>
										<label for="<%=cbQueryPermissionsPerArticles.ClientID %>"><%=_("liPermissionsPerArticles.Text") %></label>
									</div>
									<div>
										<div class="switchCheckbox">
											<asp:CheckBox CssClass="normalCheckBox" runat="server" ID="cbQueryModulePermissions" resourcekey="liModulePermissions" Text="Module permissions" Checked="false" />
										</div>
										<label for="<%=cbQueryModulePermissions.ClientID %>"><%=_("liModulePermissions.Text") %></label>
									</div>
								</td>
							</tr>
							<tr>
								<td colspan="2" style="text-align: center; vertical-align: middle"><%=Localization.GetString("InfoDisableEventsIfNotInUse.Text", LocalResourceFile) %></td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlPermissions" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfPermissionsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblPermisionsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblPermisionsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">1</span>
						<h2><%=Permissions%></h2>
					</div>
					<div class="category_content">
						<asp:Panel ID="pnlPermissionsSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
							<div class="permission_selection_dialog" title="Select items">
								<ul>
								</ul>
							</div>
							<div class="sectionBoxSubtitle highlighted3">
								<span><%=Rolepermissions%></span>
							</div>
							<asp:GridView ID="gvRolePremissions" runat="server" CssClass="optionsList strippedTable fullWidthTable textCenter edNews_permissionsTable" AutoGenerateColumns="false" DataKeyNames="PremissionSettingsID" OnRowDataBound="gvPremissions_RowDataBound">
								<Columns>
									<asp:TemplateField HeaderText="Role">
										<ItemTemplate>
											<asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>' />
										</ItemTemplate>
										<HeaderStyle CssClass="subjectTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Approve articles">
										<ItemTemplate>
											<asp:HiddenField ID="hfRoleID" runat="server" Value='<%# Eval("RoleID") %>' />
											<asp:HiddenField ID="hfPremissionID" runat="server" Value='<%# Eval("PremissionSettingsID") %>' />
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbApproveArticles" runat="server" Checked='<%#IsPortalSharingCheck(Convert.ToInt32(Eval("RoleID")), Convert.ToBoolean(Eval("ApproveArticles")))%>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Document download">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbDocumentDownload" runat="server" Checked='<%# Convert.ToBoolean(Eval("DocumentDownload")) %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Add Edit Categories">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbAddEditCategories" runat="server" Checked='<%#IsPortalSharingCheck(Convert.ToInt32(Eval("RoleID")),Convert.ToBoolean(Eval("AddEditCategories"))) %>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Allow To Comment">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbAllowToComment" runat="server" Checked='<%# Convert.ToBoolean(Eval("AllowToComment")) %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Approve Comments">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbApproveComments" runat="server" Checked='<%#IsPortalSharingCheck(Convert.ToInt32(Eval("RoleID")), Convert.ToBoolean(Eval("ApproveComments"))) %>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="View Paid Content">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbViewPaidContent" runat="server" Checked='<%# Convert.ToBoolean(Eval("ViewPaidContent")) %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Event registration">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbEventRegistration" runat="server" Checked='<%# Convert.ToBoolean(Eval("EventRegistration")) %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Custom add/edit">
										<ItemTemplate>
											<asp:LinkButton ID="lbCustomizeAddEdit" resourcekey="lbCustomizeAddEdit" runat="server" CssClass="customize_add_edit_show_selection_dialog" Text="Select fields" Visible="<%#showElementPortalSharing%>" />
											<asp:HiddenField ID="hfCustomizeAddEdit" runat="server" Value='<%#Eval("Customized")%>' />
											<asp:Panel runat="server" ID="pnlAddToCatsManualSelectionCopy" CssClass="permissions_manual_item_selection" Style="display: none">
												<asp:TextBox ID="tbxCustomizeAddEdit" runat="server" Columns="50" CssClass="selected_categories" ReadOnly="True" TextMode="MultiLine" />
											</asp:Panel>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Social autoposting" Visible="false">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbRoleSocialSharing" runat="server" Checked='<%# Convert.ToBoolean(Eval("PostToSocialNetwork")) %>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Enable add/edit articles to selected categories">
										<ItemTemplate>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbRolleAddtoAllCategories" runat="server" Checked='<%# Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="normalRadioButton permissions_show_all_items add_edit" GroupName="roleAddToCategoryPermissions" Text="All categories" resourcekey="rbRolleAddtoAllCategoriesResource1" />
											</div>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbRolleAddtoManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="normalRadioButton permissions_show_manual_item_selection add_edit" GroupName="roleAddToCategoryPermissions" Text="Select categories" resourcekey="rbRolleAddtoManualCategoriesResource1" />
											</div>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbRoleNoneAdd" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="normalRadioButton permissions_show_no_items add_edit" GroupName="roleAddToCategoryPermissions" Text="None" resourcekey="rbRoleNoneAddResource1" />
											</div>
											<asp:HiddenField ID="hfAddEditLimits" runat="server" Value='<%#Eval("Limits")%>' />
											<asp:LinkButton ID="lbAddEditLimits" CssClass="contentLimitsTrigger edNews_buttonLink" runat="server" Text="Set limits" Visible="<%#showElementPortalSharing%>" />
											<asp:Panel runat="server" ID="pnlAddToCatsManualSelection" CssClass="permissions_manual_item_selection add_edit" Style="display: none">
												<asp:HiddenField ID="hfRolesCategoriesToAdd" runat="server" />
												<asp:LinkButton ID="lbRoleManualySelectCategoriesToAdd" runat="server" CssClass="permissions_show_selection_dialog edNews_buttonLink" Text="Select categories" resourcekey="lbRoleManualySelectCategoriesToAddResource1" Visible="<%#showElementPortalSharing%>" />
												<asp:TextBox ID="tbRolesCatsToADD" runat="server" CssClass="selected_categories" TextMode="MultiLine" onkeypress="javascript:return false;" />
											</asp:Panel>
										</ItemTemplate>
										<HeaderStyle CssClass="inputsTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Select categories to view articles from">
										<ItemTemplate>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbAllCategories" runat="server" Checked='<%# Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="normalRadioButton permissions_show_all_items" GroupName="roleCategoryPermissions" Text="All categories" resourcekey="rbAllCategoriesResource1" />
											</div>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="normalRadioButton permissions_show_manual_item_selection" GroupName="roleCategoryPermissions" Text="Select categories" resourcekey="rbManualCategoriesResource1" />
											</div>
											<div class="styledRadio smallRadio">
												<asp:RadioButton ID="rbRoleNoneShow" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="normalRadioButton permissions_show_no_items" GroupName="roleCategoryPermissions" Text="None" resourcekey="rbRoleNoneShowResource1" />
											</div>
											<asp:Panel runat="server" ID="pnlShowCatsManualSelection" CssClass="permissions_manual_item_selection" Style="display: none">
												<asp:HiddenField ID="hfCategoriesToShow" runat="server" />
												<asp:LinkButton ID="lbManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog edNews_buttonLink" Text="Select categories" resourcekey="lbManualySelectCategoriesResource1" Visible="<%#showAddEditCategoriesButton%>" />
												<asp:TextBox ID="tbRolesCatsToShow" runat="server" CssClass="selected_categories" TextMode="MultiLine" resourcekey="tbRolesCatsToShowResource1" onkeypress="javascript:return false;" />
											</asp:Panel>
										</ItemTemplate>
										<HeaderStyle CssClass="inputsTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader" />
							</asp:GridView>
							<div class="sectionBoxSubtitle highlighted3">
								<span><%=Userpermissions%></span>
							</div>
							<asp:GridView ID="gvUserPremissions" runat="server" CssClass="strippedTable fullWidthTable edNews_permissionsTable" AutoGenerateColumns="false" DataKeyNames="PremissionSettingsID" CellPadding="0" OnRowDataBound="gvUserPremissions_RowDataBound" OnRowDeleting="gvUserPremissions_RowDeleting">
								<Columns>
									<asp:TemplateField HeaderText="User">
										<ItemTemplate>
											<asp:Label ID="lblUserName" runat="server" CssClass="subjectName" Text='<%#String.Format("{0} - {1}", Eval("DisplayName"), Eval("UserName")) %>' /><br />
											<div class="itemActions">
												<asp:LinkButton ID="lbUserPremissionDelete" runat="server" CssClass="deleteAction" CausesValidation="False" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete this user permissions?');" Text="Delete" resourcekey="lbUserPremissionDeleteResource1" />
											</div>
										</ItemTemplate>
										<HeaderStyle CssClass="subjectTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Approve articles">
										<ItemTemplate>
											<asp:HiddenField ID="hfPremissionID" runat="server" Value='<%# Eval("PremissionSettingsID") %>' />
											<asp:HiddenField ID="hfUserID" runat="server" Value='<%# Eval("UserID") %>' />
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbUserApproveArticles" runat="server" Checked='<%# UserCheckPortalSharing(Convert.ToBoolean(Eval("ApproveArticles"))) %>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Document download">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbUserDocumentDownload" runat="server" Checked='<%# Eval("DocumentDownload") %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Add Edit Categories">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbUserAddEditCategories" runat="server" Checked='<%# UserCheckPortalSharing(Convert.ToBoolean(Eval("AddEditCategories"))) %>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Allow To Comment">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbUserAllowToComment" runat="server" Checked='<%# Eval("AllowToComment") %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Approve Comments">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbUserApproveComments" runat="server" Checked='<%#UserCheckPortalSharing(Convert.ToBoolean(Eval("ApproveComments")))%>' Enabled="<%#!PortalSharingIsSelected%>" />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="View Paid Content">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbUserViewPaidContent" runat="server" Checked='<%# Eval("ViewPaidContent") %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Event registration">
										<ItemTemplate>
											<div class="switchCheckbox">
												<asp:CheckBox Text=" " CssClass="normalCheckBox" ID="cbEventRegistration" runat="server" Checked='<%# Convert.ToBoolean(Eval("EventRegistration")) %>' />
											</div>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Custom add/edit">
										<ItemTemplate>
											<asp:LinkButton ID="lbCustomizeAddEdit" runat="server" resourcekey="lbCustomizeAddEdit" CssClass="customize_add_edit_show_selection_dialog" Text="Select fields" Visible="<%#showElementPortalSharing%>" />
											<asp:HiddenField ID="hfCustomizeAddEdit" runat="server" Value='<%#Eval("Customized")%>' />
											<asp:Panel runat="server" ID="pnlAddToCatsManualSelectionCopy" CssClass="permissions_manual_item_selection" Style="display: none">
												<asp:TextBox ID="tbxCustomizeAddEdit" runat="server" CssClass="selected_categories" ReadOnly="True" TextMode="MultiLine" />
											</asp:Panel>
										</ItemTemplate>
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Enable add/edit articles to selected categories">
										<ItemTemplate>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbUserAddToAllCategories" runat="server" Checked='<%# Eval("AddArticleToAll") %>' CssClass="normalRadioButton permissions_show_all_items add_edit" GroupName="userAddToCategoryPermissions" Text="All categories" resourcekey="rbUserAddToAllCategoriesResource1" />
											</div>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbUserAddToManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="normalRadioButton permissions_show_manual_item_selection add_edit" GroupName="userAddToCategoryPermissions" Text="Select categories" resourcekey="rbUserAddToManualCategoriesResource1" />
											</div>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rblUserNoneAdd" runat="server" Checked='<%# !Convert.ToBoolean(Eval("AddArticleToAll")) %>' CssClass="normalRadioButton permissions_show_no_items add_edit" GroupName="userAddToCategoryPermissions" Text="None" resourcekey="rblUserNoneAddResource1" />
											</div>
											<asp:HiddenField ID="hfAddEditLimits" runat="server" Value='<%#Eval("Limits")%>' />
											<asp:LinkButton ID="lbAddEditLimits" CssClass="contentLimitsTrigger edNews_buttonLink" runat="server" Text="Set limits" Visible="<%#showElementPortalSharing%>" />
											<asp:Panel runat="server" ID="pnlUserAddToCatsManualSelection" CssClass="permissions_manual_item_selection add_edit" Style="display: none">
												<asp:HiddenField ID="hfUserCategoriesToAdd" runat="server" />
												<asp:LinkButton ID="lbManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog edNews_buttonLink" Text="Select categories" resourcekey="lbManualySelectCategories0Resource1" Visible="<%#showElementPortalSharing%>" />
												<asp:TextBox ID="tbUserCatsToAdd" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" resourcekey="tbUserCatsToAddResource1" onkeypress="javascript:return false;" />
											</asp:Panel>
										</ItemTemplate>
										<HeaderStyle CssClass="inputsTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
									<asp:TemplateField HeaderText="Select categories to view articles from">
										<ItemTemplate>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbUserAllCategories" runat="server" Checked='<%# Eval("ShowAllCategories") %>' CssClass="normalRadioButton permissions_show_all_items" GroupName="userCategoryPermissions" Text="All categories" resourcekey="rbUserAllCategoriesResource1" />
											</div>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbUserManualCategories" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="normalRadioButton permissions_show_manual_item_selection" GroupName="userCategoryPermissions" Text="Select categories" resourcekey="rbUserManualCategoriesResource1" />
											</div>
											<div class="styledRadio displayBlock smallRadio">
												<asp:RadioButton ID="rbUserNoneShow" runat="server" Checked='<%# !Convert.ToBoolean(Eval("ShowAllCategories")) %>' CssClass="normalRadioButton permissions_show_no_items" GroupName="userCategoryPermissions" Text="None" resourcekey="rbUserNoneShowResource1" />
											</div>
											<asp:Panel runat="server" ID="pnlUserShowCatsManualSelection" CssClass="permissions_manual_item_selection" Style="display: none">
												<asp:HiddenField ID="hfUserCategoriesToShow" runat="server" />
												<asp:LinkButton ID="lbUserManualySelectCategories" runat="server" CssClass="permissions_show_selection_dialog edNews_buttonLink" Text="Select categories" resourcekey="lbUserManualySelectCategoriesResource1" Visible="<%#showAddEditCategoriesButton%>" />
												<asp:TextBox ID="tbUserCatsToShow" runat="server" Columns="50" CssClass="selected_categories" TextMode="MultiLine" resourcekey="tbUserCatsToShowResource1" onkeypress="javascript:return false;" />
											</asp:Panel>
										</ItemTemplate>
										<HeaderStyle CssClass="inputsTd" />
										<ItemStyle CssClass="textLeft" />
									</asp:TemplateField>
								</Columns>
								<HeaderStyle CssClass="tableHeader" />
							</asp:GridView>
							<table class="optionsList fullWidthTable strippedTable noBorder">
								<tr>
									<td class="tdLabel width35">
										<label for="<%=tbUserNameToAdd.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUsernameToAddResource1.Help", true) %>" data-tooltip-position="top-right"><%=_("lblUsernameToAddResource1.Text") %></label>
									</td>
									<td>
										<asp:TextBox ID="tbUserNameToAdd" runat="server" />
										<asp:HiddenField ID="hfUserIdToAdd" runat="server" />
										<div class="mainActions smallActions noMargin displayInline">
											<asp:LinkButton CssClass="add" ID="lbUsernameAdd" runat="server" OnClick="lbUsernameAdd_Click" Text="Add" resourcekey="lbUsernameAddResource1" />
										</div>
										<asp:Label ID="lblAdduserMessage" runat="server" EnableViewState="false" />
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<label for="<%=cbAuthorsEditOwnArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorsEditOwnArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorsEditOwnArticles.Text") %></label>
									</td>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox CssClass="normalCheckBox" ID="cbAuthorsEditOwnArticles" runat="server" Text="Authors can only edit their own articles" />
										</div>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<label for="<%=cbShowDocumentsWithoutPermissions.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowDocumentsWithoutPermissions.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowDocumentsWithoutPermissions.Text") %></label>
									</td>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox CssClass="normalCheckBox" ID="cbShowDocumentsWithoutPermissions" runat="server" Text=" " />
										</div>
									</td>
								</tr>
								<tr>
									<td class="tdLabel">
										<label for="<%=cbPreventArticleDeletion.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPreventArticleDeletion.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPreventArticleDeletion.Text") %></label>
									</td>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox CssClass="normalCheckBox" ID="cbPreventArticleDeletion" runat="server" Text=" " />
										</div>
									</td>
								</tr>
							</table>
						</asp:Panel>
					</div>
				</asp:Panel>
				<asp:Panel ID="pnlMainDisplaySettigs" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfMainDisplaySettigsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblMainDisplaySettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblMainDisplaySettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">2</span>
						<h2><%=Maindisplay%></h2>
					</div>
					<asp:Panel ID="pnlMainDisplaySettigsTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlSelectArticleDisplayView.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectArticleView.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectArticleView.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlSelectArticleDisplayView" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlSelectArticleDisplayView_SelectedIndexChanged">
										<asp:ListItem Value="ViewEasyDNNNews.ascx" resourcekey="ListItemResource7">Article</asp:ListItem>
										<asp:ListItem Value="ViewEasyDNNNewsCatalog.ascx" resourcekey="ListItemResource8">Catalog</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbNumberOfPosts.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfPosts.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfPosts.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbNumberOfPosts" runat="server" CssClass="smallCentered" Text="5" />
									<asp:RequiredFieldValidator ID="rfvNumberOfPosts" runat="server" ControlToValidate="tbNumberOfPosts" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostsResource1.ErrorMessage" />
									<asp:RangeValidator ID="rvNumberOfPosts"
										ControlToValidate="tbNumberOfPosts"
										MinimumValue="1"
										MaximumValue="2147483647"
										Type="Integer"
										Text="The value must be integer and greater or equal than 1"
										runat="server"
										ValidationGroup="vgSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbDispalayAsTable.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRenderAsTable.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRenderAsTable.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbDispalayAsTable" Checked="false" Text="Display article layout as HTML table:" runat="server" AutoPostBack="true" OnCheckedChanged="cbDispalayAsTable_CheckedChanged" />
									</div>
									<div id="divDisplayTableProperties" runat="server" style="display: none">
										<label for="DisplayTableProperties" runat="server" id="lblDisplayTableProperties"><%=Columnproperties %></label>
										<div>
											<label for="tbNumberOfPostColumns" runat="server" id="lblNumberColumnsInTable" resourcekey="lblNumberOfPostColumns"><%=Numofcolumns%></label>
											<asp:TextBox ID="tbNumberOfPostColumns" runat="server" CssClass="smallCentered" Text="1" />
											<label for="tbxColumnWidth" runat="server" id="lblColumnWidth"><%=Columnwidth%></label>
											<asp:TextBox ID="tbxColumnWidth" runat="server" CssClass="smallCentered" Text="250" />
											<asp:RequiredFieldValidator ID="rfvNumberOfPostColumns" runat="server" ControlToValidate="tbNumberOfPostColumns" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumnsResource1.ErrorMessage" Enabled="false" />
											<asp:RequiredFieldValidator ID="rfvColumnWidth" runat="server" ControlToValidate="tbxColumnWidth" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumnsResource1.ErrorMessage" Enabled="false" />
										</div>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTotalNumberOfPosts.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfPostsToDisplay.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfPostsToDisplay.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTotalNumberOfPosts" runat="server" CssClass="smallCentered" Text="0" />
									<asp:RequiredFieldValidator ID="rfvTotalNumberOfPosts" runat="server" ControlToValidate="tbTotalNumberOfPosts" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumns0Resource1.ErrorMessage" />
									<asp:RangeValidator ID="rvTotalNumberOfPosts"
										ControlToValidate="tbTotalNumberOfPosts"
										MinimumValue="0"
										MaximumValue="2147483647"
										Type="Integer"
										Text="The value must be integer and greater or equal than 0"
										runat="server"
										ValidationGroup="vgSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlOpenDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenInAnotherModule.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenInAnotherModule.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetails" runat="server">
										<asp:ListItem Value="0" resourcekey="ListItemResource9">Current module instance</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlCustomResxFolder.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCustomResxFolder.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCustomResxFolder.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlCustomResxFolder" runat="server">
									</asp:DropDownList>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=Paginationsettings%></span>
						</div>
						<table class="optionsList fullWidthTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowPaging.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowArticlePaging.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowArticlePaging.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbShowPaging" Text="Enable pagination:" runat="server" Checked="True" AutoPostBack="true" OnCheckedChanged="cbShowPaging_CheckedChanged" />
									</div>
								</td>
							</tr>
						</table>
						<asp:Panel ID="pnlPaginationSettings" runat="server" Visible="false">
							<table class="optionsList fullWidthTable strippedTable noBorder tablePadding5">
								<tr>
									<td class="tdLabel textTop">
										<label for="<%=rblPaginationType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPaginationType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPaginationType.Text") %></label>
									</td>
									<td>
										<div class="edNews_inputGroup displayInline">
											<asp:RadioButtonList ID="rblPaginationType" runat="server" CssClass="styledRadio smallRadio verticalList" RepeatLayout="UnorderedList">
												<asp:ListItem class="normalRadioButton" Text="Classical pagination" Value="0" Selected="True" ResourceKey="rblPaginationTypeNormal" />
												<asp:ListItem class="normalRadioButton" Text="Infinite scroll pagination with Load more button" Value="1" ResourceKey="rblPaginationTypeButton" />
												<asp:ListItem class="normalRadioButton" Text="Infinite scroll pagination with automatic article loading " Value="2" ResourceKey="rblPaginationTypeButtonAndScroll" />
											</asp:RadioButtonList>
										</div>
									</td>
								</tr>
								<tr runat="server" id="rowNormalPaginationOptions">
									<td class="tdLabel">
										<label for="<%=tbNumberOfPagerLinks.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfPager.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfPager.Text") %></label>
									</td>
									<td>
										<asp:TextBox ID="tbNumberOfPagerLinks" runat="server" CssClass="smallCentered" ValidationGroup="vgSettings">10</asp:TextBox>
										<asp:RequiredFieldValidator ID="rfvNumberOfPostColumns1" runat="server" ControlToValidate="tbNumberOfPagerLinks" ErrorMessage="This filed is required." ValidationGroup="vgSettings" Display="Dynamic" resourcekey="rfvNumberOfPostColumns1Resource1.ErrorMessage" />
									</td>
								</tr>
							</table>
						</asp:Panel>
						<asp:Panel ID="pnlLocalization" runat="server" Visible="false">
							<div class="sectionBoxSubtitle highlighted3">
								<span><%=LocalizationText %></span>
							</div>
							<table class="optionsList fullWidthTable noBorder">
								<tr>
									<td class="tdLabel width50">
										<label for="<%=cbHideUnlocalizedItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblHideUnlocalizedItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblHideUnlocalizedItems.Text") %></label>
									</td>
									<td>
										<div class="switchCheckbox">
											<asp:CheckBox CssClass="normalCheckBox" ID="cbHideUnlocalizedItems" Text="Do not show articles if they do not have content for selected language" runat="server" />
										</div>
									</td>
								</tr>
							</table>
						</asp:Panel>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=Modulecontainer%></span>
						</div>
						<table class="optionsList fullWidthTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbDynamicModuleConatinerTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDynamicModuleConatinerTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDynamicModuleConatinerTitle.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbDynamicModuleConatinerTitle" Text="Dynamically create module container title:" runat="server" />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=Localization.GetString("lblDisplayControlBar", LocalResourceFile)%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder tablePadding5">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbControlBarInArticleList.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblControlBarInArticleList.Help", true) %>" data-tooltip-position="top-right"><%=_("lblControlBarInArticleList.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" Text="Display in article list" ID="cbControlBarInArticleList" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbControlBarInArticleDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblControlBarInArticleDetails.Help", true) %>" data-tooltip-position="top-right"><%=_("lblControlBarInArticleDetails.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" Text="Display in article details" ID="cbControlBarInArticleDetails" runat="server" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlAdvancedArticleSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfAdvancedArticleSettingsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblAdvancedArticleSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblAdvancedArticleSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">3</span>
						<h2><%=Advanceddisplaysettings%></h2>
					</div>
					<asp:Panel ID="pnlAdvancedArticleSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList strippedTable fullWidthTable noBorder">
							<tr>
								<td class="tdLabel width50">
									<label for="<%=tbStartingArticleNumber.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfPostsToDisplayLab.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfPostsToDisplayLab.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbStartingArticleNumber" runat="server" Text="1" CssClass="smallCentered" />
									<asp:RequiredFieldValidator ID="rfvStartingArticleNumber" runat="server" Display="Dynamic" ControlToValidate="tbStartingArticleNumber" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvNumberOfPostColumns2Resource1" />
									<asp:RangeValidator ID="rvStartingArticleNumber"
										ControlToValidate="tbStartingArticleNumber"
										MinimumValue="1"
										MaximumValue="2147483647"
										Type="Integer"
										Text="The value must be integer and greater or equal than 1"
										runat="server"
										ValidationGroup="vgSettings"
										Display="Dynamic" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbAllModules.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGlobalQuery.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGlobalQuery.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAllModules" Text="Enable opening article links from another instance" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=ddlOpenDetailsPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenInaPage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenInaPage.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetailsPage" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbPassCategoryID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPassCategoryID.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPassCategoryID.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbPassCategoryID" Text="Pass CategoryID query string in article link" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbCategoryInArticleLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCategoryInArticleLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCategoryInArticleLink.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbCategoryInArticleLink" Text="Include CategoryID and Category name querystring in article link" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbOpenCategoryFirstArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenCategoryFirstArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenCategoryFirstArticle.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenCategoryFirstArticle" Text="Open first article in category" runat="server" AutoPostBack="true" OnCheckedChanged="cbOpenCategoryFirstArticle_CheckedChanged" />
									</div>
								</td>
							</tr>
							<tr id="trOpenCategoryFirstArticleIfMorethanOne" runat="server" visible="False">
								<td class="tdLabel width50">
									<label for="<%=cbOpenCategoryFirstArticleIfMorethanOne.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenFirstKatMOreThanOne.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenFirstKatMOreThanOne.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenCategoryFirstArticleIfMorethanOne" Text="Open first article in category if there is only one article" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbOpenFirstArticleByDate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenFirstArticleByDate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenFirstArticleByDate.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenFirstArticleByDate" runat="server" Text="Open first article by date" AutoPostBack="true" OnCheckedChanged="cbOpenFirstArticleByDate_CheckedChanged" resourcekey="cbOpenFirstArticleByDateResource1" />
									</div>
								</td>
							</tr>
							<tr id="trOpenFirstArticleByDateIfMorethanOne" runat="server" visible="False">
								<td class="tdLabel width50">
									<label for="<%=cbOpenFirstArticleByDateIfMorethanOne.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenFirstByDateMorethanone.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenFirstByDateMorethanone.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenFirstArticleByDateIfMorethanOne" Text="Open first article by date if there is only one article" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbOpenFirstArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenFirstArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenFirstArticle.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenFirstArticle" Text="Open first article" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbUserIDInLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("UserIDInLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("UserIDInLink.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbUserIDInLink" Text="Pass userID querystring in article link" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbAdminFuturePostsVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("AdminFuturePostsVisible.HelpText", true) %>" data-tooltip-position="top-right"><%=_("AdminFuturePostsVisible.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAdminFuturePostsVisible" Text="Display articles with publish date in future" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbReplaceDNNTokens.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblReplaceDNNTokens.Help", true) %>" data-tooltip-position="top-right"><%=_("lblReplaceDNNTokens.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbReplaceDNNTokens" Text="Replace standard DNN tokens" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbOpenArticleLinkInListMode.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenArticleLinkInListMode.Help", true) %>" data-tooltip-position="top-right"><%=_("lblOpenArticleLinkInListMode.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenArticleLinkInListMode" Text="Open article link in list mode" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbOverrideOnlyFiltersPassedByQueryString.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("OverrideOnlyFiltersPassedByQueryString.Help", true) %>" data-tooltip-position="top-right"><%=_("OverrideOnlyFiltersPassedByQueryString.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOverrideOnlyFiltersPassedByQueryString" Text="Override only filters passed by querystring" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbReplaceDNNSharpMyTokens.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblReplaceDNNSharpMyTokens.Help", true) %>" data-tooltip-position="top-right"><%=_("lblReplaceDNNSharpMyTokens.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbReplaceDNNSharpMyTokens" Text="Replace standard DNN tokens" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableWebpImages.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddWebpImage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAddWebpImage.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox edNews__toggleNextTableRow">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableWebpImages" Checked="false" Text="Enable webp images:" runat="server" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbWebpImageQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblWebpImageQuality.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblWebpImageQuality.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbWebpImageQuality" runat="server" CssClass="smallCentered" Text="95" />
									<asp:RequiredFieldValidator ID="rfvWebpImageQuality" runat="server" ControlToValidate="tbWebpImageQuality" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvWebpImageQuality.ErrorMessage" Display="Dynamic" />
									<asp:RangeValidator ID="rvWebpImageQuality"
										ControlToValidate="tbWebpImageQuality"
										MinimumValue="0"
										MaximumValue="100"
										Type="Integer"
										Text="The value must be integer and greater or equal than 0"
										runat="server"
										ValidationGroup="vgSettings"
										resourcekey="rfvWebpImageQuality.ErrorMessage" Display="Dynamic" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbRedirectToAnotherInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRedirectToAnotherInstance.Help", true) %>" data-tooltip-position="top-right"><%=_("lblRedirectToAnotherInstance.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbRedirectToAnotherInstance" Text="Redirect to selected news instance:" runat="server" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlArticleSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfArticleSettingsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblArticleSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblArticleSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">4</span>
						<h2><%=Categoryandauthorselection%></h2>
					</div>
					<asp:Panel ID="pnlArticleSettingsTable" runat="server" CssClass="category_content">
						<table class="optionsList strippedTable fullWidthTable noBorder" runat="server">
							<tr>
								<td class="tdLabel">
									<label for="<%=rblFilterArticlesBy.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayingMethod.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayingMethod.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblFilterArticlesBy" runat="server" OnSelectedIndexChanged="rblFilterArticlesBy_SelectedIndexChanged" AutoPostBack="true" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" resourcekey="liApplyFilters" Selected="True" Value="False" Text="Apply filters" />
											<asp:ListItem class="normalRadioButton" resourcekey="liSelectSpecific" Value="True" Text="Select specific article(s)" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlOrderPostsBy.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPostOrder.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPostOrder.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOrderPostsBy" runat="server"></asp:DropDownList>
									<asp:DropDownList ID="ddlAscOrder" runat="server">
										<asp:ListItem Value="DESC" resourcekey="ListItemResource22">Descending</asp:ListItem>
										<asp:ListItem Value="ASC" resourcekey="ListItemResource23">Ascending</asp:ListItem>
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblRestrictionByDateRange.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRestrictionByDateRange.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRestrictionByDateRange.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblRestrictionByDateRange" runat="server" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="0" Text="No restriction" Selected="True" resourcekey="liNoRestriction" />
											<asp:ListItem class="normalRadioButton" Value="1" Text="Number of days from current date" resourcekey="liNumberOfDaysFromCurrentDate" />
										</asp:RadioButtonList>
									</div>
									<asp:TextBox ID="tbxRestrictionByDateRange" runat="server" CssClass="smallCentered" Style="display: none"></asp:TextBox>
								</td>
							</tr>
						</table>
						<asp:UpdatePanel ID="upFilterPerArticle" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppFilterPerArticle" runat="server" AssociatedUpdatePanelID="upFilterPerArticle" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList strippedTable fullWidthTable noBorder" runat="server" id="tblPerArticleFilter" visible="false">
										<tr>
											<td class="tdLabel">
												<label for="<%=cbFilterByArticlesOpenArticleDetails.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("FilterByArticlesOpenArticleDetails.Help", true) %>" data-tooltip-position="top-right"><%=_("FilterByArticlesOpenArticleDetails.Text") %></label>
											</td>
											<td>
												<div class="switchCheckbox">
													<asp:CheckBox ID="cbFilterByArticlesOpenArticleDetails" Text="Open details if only one article" runat="server" Checked="true" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlCategoryIDListFilterByArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCategoryIDForFilterByArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCategoryIDForFilterByArticle.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlCategoryIDListFilterByArticle" runat="server" OnSelectedIndexChanged="ddlCategoryIDListFilterByArticle_SelectedIndexChanged" AutoPostBack="true" />
											</td>
										</tr>
										<tr>
											<td colspan="2">
												<div runat="server" id="divFilterByArticles">
													<asp:DataList ID="dlFilterPerArticle" runat="server" DataKeyField="ArticleID" RepeatLayout="Flow" RepeatDirection="Horizontal" CssClass="edNews_availableItemsList">
														<ItemTemplate>
															<a class="articleid_link edNews_addItemLink" href="#" data-eds-article-id='<%#Eval("ArticleID")%>'><%#Eval("Title")%><i>(ID:<%#Eval("ArticleID") %>)</i></a>
														</ItemTemplate>
													</asp:DataList>
													<asp:Panel ID="pnlArticlePager" runat="server" CssClass="contentPagination" EnableViewState="true">
														<asp:LinkButton ID="ibArticlePagerFirst" CssClass="first" runat="server" Visible="False" OnClick="ibArticlePagerFirst_Click" Text="First" />
														<asp:LinkButton ID="ibArticlePagerLeft" CssClass="prev" runat="server" Visible="False" OnClick="ibArticlePagerLeft_Click" Text="Previous" />
														<asp:Repeater ID="repPaggeingFilterByArticle" runat="server" OnItemCommand="repPaggeingFilterByArticle_ItemCommand">
															<ItemTemplate>
																<asp:LinkButton ID="lbArticlePagerpage" runat="server" CssClass='<%# Eval("CssClass") %>' Text='<%#Eval("pagerIndex") %>' CommandArgument='<%#Eval("pagerIndex") %>' />
															</ItemTemplate>
														</asp:Repeater>
														<asp:LinkButton ID="ibArticlePagerRight" CssClass="next" runat="server" Visible="False" OnClick="ibArticlePagerRight_Click" Text="Next" />
														<asp:LinkButton ID="ibArticlePagerLast" CssClass="last" runat="server" Visible="False" OnClick="ibArticlePagerLast_Click" Text="Last" />
														<asp:HiddenField ID="hgPageIDFilterByArticleID" runat="server" Value="1" />
													</asp:Panel>
													<div class="edNews_selectedItemsList" id="filterContentByArticlesWrapper">
														<div id="filterContentByArticlesNoTagsMsg" runat="server">
															<span class="infoMessages info"><%=Selectarticles%></span>
														</div>
														<asp:Literal ID="ListOfselectedArticles" runat="server" />
													</div>
													<asp:HiddenField ID="hfSelectedArticles" runat="server" />
												</div>
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
						<table class="optionsList strippedTable fullWidthTable noBorder" runat="server" id="tblDefaultArticleFilter">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=cbDisplayAllCategories.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCategoryDisplay.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCategoryDisplay.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayAllCategories" runat="server" Checked="True" Text="Display all categories." resourcekey="cbCategoriesToDisplayResource1" />
									</div>
									<label for="<%=cbDisplayAllCategories.ClientID %>"><%=_("cbCategoriesToDisplayResource1.Text") %></label>
									<div runat="server" id="tblSelectCategories">
										<div>
											<div class="switchCheckbox">
												<asp:CheckBox CssClass="normalCheckBox" ID="cbAutoAddCatChilds" runat="server" Text="Auto select all child categories." resourcekey="cbAutoAddCatChildsResource1" />
											</div>
											<label for="<%=cbAutoAddCatChilds.ClientID %>"><%=_("cbAutoAddCatChildsResource1.Text") %></label>
										</div>
										<div>
											<div class="switchCheckbox">
												<asp:CheckBox CssClass="normalCheckBox" ID="cbUseANDOperatorByCategory" runat="server" Text="Use AND operator for categories" resourcekey="cbUseANDOperatorByCategory" />
											</div>
											<label for="<%=cbUseANDOperatorByCategory.ClientID %>"><%=_("lblUseANDOperatorByCategory.Text") %></label>
										</div>
										<asp:PlaceHolder ID="phDinamicTreeView" runat="server"></asp:PlaceHolder>
									</div>
								</td>
							</tr>
							<tr runat="server" id="rowCatalogCategories" visible="false">
								<td class="tdLabel">
									<label for="<%=cbBoundModuleToCategory.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblModuleToCat.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblModuleToCat.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbBoundModuleToCategory" runat="server" AutoPostBack="true" OnCheckedChanged="cbBoundModuleToCategory_CheckedChanged" Text=" " />
									</div>
									<asp:DropDownList ID="ddlCatogoryBound" runat="server" AppendDataBoundItems="True"></asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=cbShowAllAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterPostsbyAuthor.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterPostsbyAuthor.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbShowAllAuthors" runat="server" Checked="true" Text="Display all authors." resourcekey="cbShowAllAuthors" />
									</div>
									<asp:PlaceHolder ID="phGroupsAndAuthorsTreeView" runat="server"></asp:PlaceHolder>
									<asp:CustomValidator ID="cvAuthorsTreeview" runat="server" ClientValidationFunction="ClientValidateAuthors" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one author." resourcekey="cvAuthorsTreeview.ErrorMessage" ValidationGroup="vgSettings">
									</asp:CustomValidator>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label class="edNews_tooltip" data-tooltip-content="<%=_("lblFeaturedArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFeaturedArticles.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbFeaturedArticles" runat="server" Text="Show only featured articles" resourcekey="cbFeaturedArticlesResource1" />
									</div>
									<label for="<%=cbFeaturedArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowOnlyFeatured.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowOnlyFeatured.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbFeaturedOnTop" Text="Keep featured articles on top" runat="server" />
									</div>
									<label for="<%=cbFeaturedOnTop.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFeaturedOnTop.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFeaturedOnTop.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectArticleEvents.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectArticleEvents.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList runat="server" ID="rblFilterContent" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="0" Text="Articles" resourcekey="Articles" />
											<asp:ListItem class="normalRadioButton" Value="1" Text="Events" resourcekey="Events" />
											<asp:ListItem class="normalRadioButton" Value="2" Text="All" Selected="True" resourcekey="liAll" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr runat="server" id="rowFilterByEvents">
								<td class="tdLabel">
									<label for="<%=rblLimitBackEvents.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowOnlyEventsLimit.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowOnlyEventsLimit.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblLimitBackEvents" runat="server" CssClass="styledRadio inlineList smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="All" Text="ShowAll" resourcekey="ListItemResource24" />
											<asp:ListItem class="normalRadioButton" Value="ShowOnlyPastEvents" Text="Show only past events" resourcekey="ShowOnlyPastEvents" />
											<asp:ListItem class="normalRadioButton" Value="Limit" Text="Limit to number of days in the past:" resourcekey="ListItemResource25" Selected="True" />
										</asp:RadioButtonList>
									</div>
									<asp:TextBox ID="tbPastEventLimit" runat="server" CssClass="smallCentered" resourcekey="tbPastEventLimitResource1" Text="0" />
									<asp:RequiredFieldValidator ID="rfvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" resourcekey="ThisFiledIsRequired.ErrorMessage" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" />
									<asp:CompareValidator ID="cvPastEventLimit" runat="server" ControlToValidate="tbPastEventLimit" Display="Dynamic" resourcekey="PleaseEnterNumberOnly.ErrorMessage" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbFilterArticlesByTags.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterByTags.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterByTags.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbFilterArticlesByTags" Text="Filter articles by tags:" runat="server" AutoPostBack="true" OnCheckedChanged="cbFilterArticlesByTags_CheckedChanged" />
									</div>
								</td>
							</tr>
							<tr id="trFilterArticlesByTags" runat="server">
								<td colspan="2">
									<asp:UpdatePanel ID="upArticleTags" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
										<ContentTemplate>
											<div class="edNews_adminProgressOverlayWrapper">
												<asp:UpdateProgress ID="uppArticleTags" runat="server" AssociatedUpdatePanelID="upArticleTags" DisplayAfter="100" DynamicLayout="true">
													<ProgressTemplate>
														<div class="edNews_adminProgressOverlay">
														</div>
													</ProgressTemplate>
												</asp:UpdateProgress>
												<ul class="edNews_itemsSelectionMenu">
													<li>
														<asp:LinkButton ID="lbAllAddedTags" runat="server" OnClick="lbAllAddedTags_Click"><%=AllTags%></asp:LinkButton>
													</li>
													<li>
														<asp:LinkButton ID="lbMostPopularTags" runat="server" OnClick="lbMostPopularTags_Click"><%=MostPopularFirst%></asp:LinkButton>
													</li>
													<li>
														<asp:LinkButton ID="lbLastAddedTags" runat="server" OnClick="lbLastAddedTags_Click"><%=LastAddedDirst%></asp:LinkButton>
													</li>
												</ul>
												<asp:DataList ID="dlListOfExistingTags" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal" DataKeyField="TagID" CssClass="edNews_availableItemsList">
													<ItemTemplate>
														<a class="tag_link edNews_addItemLink edNews_addTag" href="#" data-eds-tag-id='<%#Eval("TagID")%>'><span><%#Eval("Name")%></span></a>
													</ItemTemplate>
												</asp:DataList>
												<asp:Panel ID="pnlFilterByTagsPager" runat="server" CssClass="contentPagination" EnableViewState="true">
													<asp:LinkButton ID="ibFilterByTagsFirst" CssClass="first" runat="server" Visible="False" OnClick="ibFilterByTagsFirst_Click" Text="First" />
													<asp:LinkButton ID="ibFilterByTagsLeft" CssClass="prev" runat="server" Visible="False" OnClick="ibFilterByTagsLeft_Click" Text="Previous" />
													<asp:Repeater ID="repPaggeingFilterByTags" runat="server" OnItemCommand="repPaggeingFilterByTags_ItemCommand">
														<ItemTemplate>
															<asp:LinkButton ID="lbArticlePagerpage" runat="server" CssClass='<%# Eval("CssClass") %>' Text='<%#Eval("pagerValue") %>' CommandArgument='<%#Eval("pagerIndex") %>' />
														</ItemTemplate>
													</asp:Repeater>
													<asp:LinkButton ID="ibFilterByTagsRight" CssClass="next" runat="server" Visible="False" OnClick="ibFilterByTagsRight_Click" Text="Next" />
													<asp:LinkButton ID="ibFilterByTagsLast" CssClass="last" runat="server" Visible="False" OnClick="ibFilterByTagsLast_Click" Text="Last" />
													<asp:HiddenField ID="hgPageIDFilterByTags" runat="server" Value="1" />
												</asp:Panel>
												<div class="edNews_selectedItemsList edNews_selectedTags" id="filterContentByTagsWrapper">
													<div class="edNews_selectedItemsListHeader">
														<%=Selectedtags %>
													</div>
													<span id="filterContentByTagsNoTagsMsg" runat="server" class="infoMessages info"><%=Selecttagstofilterarticles%></span>
													<asp:Literal ID="ListOfselectedTags" runat="server" />
												</div>
												<asp:HiddenField ID="hfSelectedTags" runat="server" />
											</div>
										</ContentTemplate>
									</asp:UpdatePanel>
								</td>
							</tr>
						</table>
						<asp:UpdatePanel ID="UpFilterByCustomFields" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="UppFilterByCustomFields" runat="server" AssociatedUpdatePanelID="UpFilterByCustomFields" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList strippedTable fullWidthTable noBorder" runat="server" id="tblDefaultArticleFilterCF">
										<tr id="trFilterByCustomFields" runat="server">
											<td class="tdLabel">
												<label for="<%=cbFilterArticlesByTags.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterByCustomFields.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFilterByCustomFields.Text") %></label>
											</td>
											<td>
												<div class="switchCheckbox">
													<asp:CheckBox CssClass="normalCheckBox" ID="cbFilterByCustomFields" Text="Filter by custom fields" runat="server" AutoPostBack="true" />
												</div>
											</td>
										</tr>
										<tr id="trFilterByCustomFieldsEdit" runat="server">
											<td colspan="2">
												<div class="textCenter">
													<asp:DropDownList ID="ddlFilterByCFTemplate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlFilterByCFTemplate_SelectedIndexChanged"></asp:DropDownList>&nbsp;&nbsp;
													<asp:DropDownList ID="ddlFilterByCustomField" runat="server"></asp:DropDownList>
													<div class="mainActions displayInline smallActions noMargin">
														<asp:Button ID="btnAddCFFilter" CssClass="add" runat="server" Text="Add" OnClick="btnAddCFFilter_Click" OnClientClick="return AddCFIdToHF();" />
													</div>
												</div>
												<asp:PlaceHolder ID="phCustomFieldsFilters" runat="server"></asp:PlaceHolder>
												<asp:HiddenField ID="hfAddedFields" runat="server" />
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlArticleRatingApprove" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfArticleRatingApprove" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblArticleRatingApproveSettingSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblAArticleRatingApprove_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">5</span>
						<h2><%=_("Articleratingandapproval.Text")%></h2>
					</div>
					<asp:Panel ID="pnlArticleRatingApprovalSettingsTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbArticleRating.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAproveRating.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAproveRating.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbArticleRating" runat="server" Checked="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableArticleVoting.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableArticleVoting.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableArticleVoting.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableArticleVoting" runat="server" Checked="False" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlWorkflowSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("ddlWorkflowSelect.HelpText", true) %>" data-tooltip-position="top-right"><%=_("ddlWorkflowSelect.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlWorkflowSelect" runat="server" DataTextField="Name" DataValueField="Id" />
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlThemeSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfThemeSettingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblThemeSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblThemeSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">6</span>
						<h2><%=_("Templateandthemeselection.Text")%></h2>
					</div>
					<asp:Panel ID="pnlThemeSettingsSourceTable" runat="server" CssClass="category_content">
						<asp:UpdatePanel ID="upThemeSettings" runat="server" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppThemeSettings" runat="server" AssociatedUpdatePanelID="upThemeSettings" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<div class="sectionBoxSubtitle highlighted3">
										<span><%=_("subSectionListArticlesTheme.Text") %></span>
									</div>
									<table class="optionsList fullWidthTable strippedTable noBorder">
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlArticleListTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleListTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleListTheme.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleListTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlArticleListFolder_SelectedIndexChanged" />
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlArticleListDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleListDisplayStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleListDisplayStyle.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleListDisplayStyle" runat="server" />
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlArticleListTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleListTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleListTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleListTemplate" runat="server" /><div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditHtmlTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlListDocumentsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblListDocumentsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblListDocumentsTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlListDocumentsTemplate" runat="server" /><div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditListDocumentsHtmlTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlListLinksTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblListLinksTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblListLinksTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlListLinksTemplate" runat="server" /><div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditListLinksTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlListRelatedArticlesTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblListRelatedArticlesTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblListRelatedArticlesTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlListRelatedArticlesTemplate" runat="server" /><div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditListRelatedArticlesTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlListCommentsTemplates.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblListCommentsTemplate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblListCommentsTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlListCommentsTemplates" runat="server" />
											</td>
										</tr>
									</table>
									<div class="sectionBoxSubtitle highlighted3">
										<span><%=_("subSectionArticleDetailsTheme.Text") %></span>
									</div>
									<table class="optionsList fullWidthTable strippedTable noBorder">
										<tr style="font-size: larger">
											<td class="tdLabel">
												<label for="<%=ddlArticleDetailsTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleDetailsTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleDetailsTheme.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleDetailsTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlArticleDetailsFolder_SelectedIndexChanged" />
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlArticleDetailsDisplayStyle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleCSSStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleCSSStyle.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleDetailsDisplayStyle" runat="server" />
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlArticleDetailsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleDetailsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleDetailsTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleDetailsTemplate" runat="server" />
												<asp:RequiredFieldValidator ID="rfvArticleDetails" runat="server" ControlToValidate="ddlArticleDetailsTemplate" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvArticleDetailsResource1" />
												<div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditArticleDetailsTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlDetailsDocumentsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDetailsDocumentsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDetailsDocumentsTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlDetailsDocumentsTemplate" runat="server" />
												<div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditDetailsDocumentsTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlDetailsLinksTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDetailsLinksTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDetailsLinksTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlDetailsLinksTemplate" runat="server" />
												<div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditDetailsLinksTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlDetailsRelatedArticlesTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDetailsRelatedArticlesTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDetailsRelatedArticlesTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlDetailsRelatedArticlesTemplate" runat="server" />
												<div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlDetailsRelatedArticlesTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlArticleCommentsTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleCommentsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleCommentsTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlArticleCommentsTheme" runat="server" CausesValidation="True" ValidationGroup="vgSettings" />
												<asp:RequiredFieldValidator ID="rfvCommentsTheme" runat="server" ControlToValidate="ddlArticleCommentsTheme" Display="Dynamic" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvCommentsThemeResource1" />
												<div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditArticleCommentsTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr id="trGravityGallerySelectTemplate" runat="server" visible="false">
											<td class="tdLabel">
												<label for="<%=ddlGravityGallerySelectTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGallerySelectTemplate.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGallerySelectTemplate.Text") %></label>
											</td>
											<td>
												<asp:DropDownList ID="ddlGravityGallerySelectTemplate" runat="server">
												</asp:DropDownList>
												<div class="mainActions smallActions displayInline noMargin">
													<asp:HyperLink runat="server" ID="hlEditGravityGallerySelectTemplate" Text="Edit" CssClass="primaryAction" Target="_blank" />
												</div>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=cbThemeChanging.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblThemeChangeing.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblThemeChangeing.Text") %></label>
											</td>
											<td>
												<div class="switchCheckbox">
													<asp:CheckBox CssClass="normalCheckBox" ID="cbThemeChanging" runat="server" Text=" " />
												</div>
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlArticleImageSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfArticleImageSettingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblArticleImageSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblArticleImageSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">7</span>
						<h2><%=_("Articleimage.Text")%></h2>
					</div>
					<asp:Panel ID="pnlArticleImageSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbJpegThumbnailQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblJpegQuality.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblJpegQuality.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbJpegThumbnailQuality" runat="server" CssClass="smallCentered" CausesValidation="True" MaxLength="3" ValidationGroup="vgSettings" Text="97" />
									<asp:RequiredFieldValidator ID="rfvMainImageWidth1" runat="server" ControlToValidate="tbJpegThumbnailQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvMainImageWidth1Resource1.ErrorMessage" />
									<asp:RangeValidator ID="rvJpegQuality" runat="server" ControlToValidate="tbJpegThumbnailQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings"
										resourcekey="rvJpegQualityResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblCropResizeMode.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCropResizeMode.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCropResizeMode.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblCropResizeMode" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="0" resourcekey="liLeft" Selected="True">Left</asp:ListItem>
											<asp:ListItem class="normalRadioButton" Value="1" resourcekey="liCenter">Center</asp:ListItem>
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionListArticlesTheme.Text") %></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbImageThumbWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImageThmbWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImageThmbWidth.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbImageThumbWidth" CssClass="smallCentered" runat="server" Text="150" />
									<asp:RequiredFieldValidator ID="rfvRhumbImageWidth" runat="server" ControlToValidate="tbImageThumbWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidthResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbImageThumbHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImageThmbHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImageThmbHeight.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbImageThumbHeight" CssClass="smallCentered" runat="server" Text="150" />
									<asp:RequiredFieldValidator ID="rfvThumbImageHeight" runat="server" ControlToValidate="tbImageThumbHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvThumbImageHeightResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblArticleListImageResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleListImageResizeMethod.HelpKey", true) %>" data-tooltip-position="top-right"><%=_("lblArticleListImageResizeMethod.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblArticleListImageResizeMethod" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" resourcekey="liPropotional" Value="Proportional" Text="Proportional resize" Selected="True" />
											<asp:ListItem class="normalRadioButton" resourcekey="liCrop" Value="Crop" Text="Resize and crop" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionArticleDetailsTheme.Text") %></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbMainImageWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMainImageWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMainImageWidth.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbMainImageWidth" CssClass="smallCentered" runat="server" Text="600" />
									<asp:RequiredFieldValidator ID="rfvMainImageWidth" runat="server" ControlToValidate="tbMainImageWidth" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvMainImageWidthResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbMainImageHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMainImageHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMainImageHeight.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbMainImageHeight" CssClass="smallCentered" runat="server" Text="600" />
									<asp:RequiredFieldValidator ID="rfvMainImageWidth0" runat="server" ControlToValidate="tbMainImageHeight" ErrorMessage="This filed is required." ValidationGroup="vgSettings" SetFocusOnError="True" resourcekey="rfvMainImageWidth0Resource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblArticleDetailsImageResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleDetailsImageResizeMethod.HelpKey", true) %>" data-tooltip-position="top-right"><%=_("lblArticleDetailsImageResizeMethod.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblArticleDetailsImageResizeMethod" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" resourcekey="liPropotional" Value="Proportional" Text="Proportional resize" Selected="True" />
											<asp:ListItem class="normalRadioButton" resourcekey="liCrop" Value="Crop" Text="Resize and crop" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlImageUploadSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfImageUploadSettingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblImageUploadSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblImageUploadSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">8</span>
						<h2><%=_("Articlegalleryimageupload.Text")%></h2>
					</div>
					<asp:Panel ID="pnlImageUploadSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbUploadImageResize.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImageReize.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImageReize.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbUploadImageResize" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbUploadImageWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImageReizeWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImageReizeWidth.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbUploadImageWidth" runat="server" CssClass="smallCentered" Text="800" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbUploadImageHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImageReizeHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImageReizeHeight.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbUploadImageHeight" runat="server" CssClass="smallCentered" Text="800" />
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlEasyDNNGalleyIntegrationSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfEasyDNNGalleyIntegrationSettingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblEasyDNNGalleyIntegrationSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblEasyDNNGalleyIntegrationSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">9</span>
						<h2><%=_("EasyDNNGalleryintegration.Text")%></h2>
					</div>
					<asp:Panel ID="pnlEasyDNNGalleyIntegrationSettingsSourceTable" runat="server" CssClass="category_content">
						<asp:Label ID="lblGalleryInstalled" runat="server" />
						<asp:Panel ID="pnlIntegratedGallery" runat="server">
							<div class="sectionBoxSubtitle highlighted3">
								<span><%=_("Gallerysettings.Text")%></span>
							</div>
							<asp:UpdatePanel ID="upGallerySettings" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
								<ContentTemplate>
									<div class="edNews_adminProgressOverlayWrapper">
										<asp:UpdateProgress ID="uppGallerySettings" runat="server" AssociatedUpdatePanelID="upGallerySettings" DisplayAfter="100" DynamicLayout="true">
											<ProgressTemplate>
												<div class="edNews_adminProgressOverlay">
												</div>
											</ProgressTemplate>
										</asp:UpdateProgress>
										<table class="optionsList fullWidthTable strippedTable noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=cbEnableGalleryIntegraton.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableGalleryIntegration.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableGalleryIntegration.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableGalleryIntegraton" runat="server" Checked="True" Text=" " />
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=cbUseGalleryDefaultSettings.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUseGalleryDefault.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUseGalleryDefault.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbUseGalleryDefaultSettings" runat="server" Text=" " />
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=ddlGalleryDisplayType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryDisplayType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryDisplayType.Text") %></label>
												</td>
												<td>
													<asp:DropDownList ID="ddlGalleryDisplayType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlGalleryDisplayType_SelectedIndexChanged">
														<asp:ListItem Value="gravity"> Gravity gallery</asp:ListItem>
														<asp:ListItem Value="chameleon">Chameleon gallery</asp:ListItem>
														<asp:ListItem Value="lightbox" resourcekey="ListItemResource36">Lightbox gallery</asp:ListItem>
														<asp:ListItem Value="audio" resourcekey="ListItemResource37">Audio gallery</asp:ListItem>
														<asp:ListItem Value="video" resourcekey="ListItemResource38">Video gallery</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>

										</table>
										<table runat="server" id="tblCommonGallerySettings" class="optionsList strippedTable fullWidthTable noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=ddlGalleryPosition.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryPosition.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryPosition.Text") %></label>
												</td>
												<td>
													<asp:DropDownList ID="ddlGalleryPosition" runat="server">
														<asp:ListItem Value="top" resourcekey="ListItemResource39">Top position</asp:ListItem>
														<asp:ListItem Selected="True" Value="bottom" resourcekey="ListItemResource40">Boottom position</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
											<tr id="trFixedResponsiveLayoutTypeSelect" runat="server">
												<td class="tdLabel">
													<label for="<%=rblFixedResponsiveLayoutTypeSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFixedResponsiveLayout.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFixedResponsiveLayout.Text") %></label>
												</td>
												<td>
													<div class="edNews_inputGroup">
														<asp:RadioButtonList ID="rblFixedResponsiveLayoutTypeSelect" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblFixedResponsiveLayoutTypeSelect_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
															<asp:ListItem class="normalRadioButton" resourcekey="liFixed" Value="fixed">Fixed Layout</asp:ListItem>
															<asp:ListItem class="normalRadioButton" resourcekey="liResponsive" Selected="True" Value="responsive">Responsive Layout</asp:ListItem>
														</asp:RadioButtonList>
													</div>
												</td>
											</tr>
										</table>
										<table class="optionsList fullWidthTable noBorder">
											<tr runat="server" id="trGalleryLightboxSelection">
												<td class="tdLabel textTop">
													<label for="<%=rblGalleryLightbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryLightbox.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryLightbox.Text") %></label>
												</td>
												<td>
													<div class="edNews_inputGroup">
														<asp:RadioButtonList ID="rblGalleryLightbox" runat="server" AutoPostBack="true" CssClass="styledRadio verticalList smallRadio" RepeatLayout="UnorderedList">
															<asp:ListItem class="normalRadioButton" Value="1" resourcekey="liSocialMediaBoxLite" Selected="True">SocialMediaBox Lite</asp:ListItem>
															<asp:ListItem class="normalRadioButton" Value="5" resourcekey="liSocialMediaBoxPlus">SocialMediaBox Plus</asp:ListItem>
															<asp:ListItem class="normalRadioButton" Value="2" resourcekey="liSocialMediaBox">SocialMediaBox</asp:ListItem>
															<asp:ListItem class="normalRadioButton" Value="4" resourcekey="liOpenDetailsInGravityGallery">Open details in Gravity gallery</asp:ListItem>
															<asp:ListItem class="normalRadioButton" Value="3" resourcekey="liNone">None</asp:ListItem>
														</asp:RadioButtonList>
													</div>
												</td>
											</tr>
										</table>
										<asp:Panel ID="pnlChameleonGallery" runat="server" Visible="False">
											<table class="optionsList fullWidthTable strippedTable noBorder">
												<tr>
													<td class="tdLabel">
														<label for="<%=tbxGalleryWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryWidth.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbxGalleryWidth" runat="server" CssClass="smallCentered">100</asp:TextBox>
														<asp:Label ID="lblChamMainPanelWidthType" runat="server" Text="%" Visible="True" />
														&nbsp;<asp:RequiredFieldValidator ID="rfvChameleonRhumbImageWidth" runat="server" ControlToValidate="tbxGalleryWidth" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth0Resource1.ErrorMessage"
															Display="Dynamic" Enabled="False" Visible="False" />
														<asp:CompareValidator ID="cvLightBoxGalleryNumberOfItems" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgTGSettings" resourcekey="cvLightBoxGalleryNumberOfItemsResource1.ErrorMessage" />
														<asp:RangeValidator ID="rvChameleonWidthPerct" runat="server" ControlToValidate="tbxGalleryWidth" Display="Dynamic" Enabled="True" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvAGVolume0Resource1.ErrorMessage"
															SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" Visible="True" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbxGalleryHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryHeight.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbxGalleryHeight" runat="server" CssClass="smallCentered">500</asp:TextBox>
														<asp:DropDownList ID="ddlChameleonGalleryHeightType" runat="server" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlChameleonGalleryHeightType_SelectedIndexChanged">
															<asp:ListItem Value="0">px</asp:ListItem>
															<asp:ListItem Value="1">%</asp:ListItem>
														</asp:DropDownList>
														<asp:RequiredFieldValidator ID="rfvGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" ErrorMessage="This filed is required." SetFocusOnError="True" ValidationGroup="vgSettings" resourcekey="rfvRhumbImageWidth1Resource1.ErrorMessage"
															Display="Dynamic" />
														<asp:CompareValidator ID="cvtbxGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" Type="Integer" ValidationGroup="vgSettings" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1.ErrorMessage" />
														<asp:RangeValidator ID="rvtbxGalleryHeight" runat="server" ControlToValidate="tbxGalleryHeight" Display="Dynamic" Enabled="False" ErrorMessage="Enter value between 0-100." MaximumValue="100" MinimumValue="0" resourcekey="rvtbxGalleryHeight.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" CssClass="smallInfo warning"></asp:RangeValidator>
													</td>
												</tr>
												<tr id="trChameleonResponsiveMainImageWidth" runat="server">
													<td class="tdLabel">
														<label for="<%=tbxChameleonResponsiveMainImageWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonResponsiveMainImageWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonResponsiveMainImageWidth.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbxChameleonResponsiveMainImageWidth" runat="server" CssClass="smallCentered">600</asp:TextBox>
														<asp:Label ID="lblChameleonResponsiveMainImageWidthPX" runat="server" Text="px" />
														<asp:RequiredFieldValidator ID="rfvtbxChameleonResponsiveMainImageWidth" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageWidth" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvRhumbImageWidth1Resource1.ErrorMessage"
															SetFocusOnError="True" ValidationGroup="vgSettings" />
														<asp:CompareValidator ID="cvChameleonResponsiveMainImageWidth" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageWidth" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1.ErrorMessage"
															Type="Integer" ValidationGroup="vgSettings" />
													</td>
												</tr>
												<tr id="trChameleonResponsiveMainImageHeight" runat="server">
													<td class="tdLabel">
														<label for="<%=tbxChameleonResponsiveMainImageHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonResponsiveMainImageHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonResponsiveMainImageHeight.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbxChameleonResponsiveMainImageHeight" runat="server" CssClass="smallCentered">500</asp:TextBox>
														<asp:Label ID="lblChameleonResponsiveMainImageHeightPX" runat="server" Text="px" />
														<asp:RequiredFieldValidator ID="rfvtbxChameleonResponsiveMainImageHeight" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageHeight" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvtbxChameleonResponsiveMainImageHeight.ErrorMessage"
															SetFocusOnError="True" ValidationGroup="vgSettings" />
														<asp:CompareValidator ID="cvChameleonResponsiveMainImageHeight" runat="server" ControlToValidate="tbxChameleonResponsiveMainImageHeight" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvChameleonResponsiveMainImageHeight.ErrorMessage"
															Type="Integer" ValidationGroup="vgSettings" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbChameleonJpegQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbChameleonJpegQuality.Help", true) %>" data-tooltip-position="top-right"><%=_("lbChameleonJpegQuality.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbChameleonJpegQuality" runat="server" CssClass="smallCentered">97</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvChameleonJpegQuality" runat="server" ControlToValidate="tbChameleonJpegQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvChameleonJpegQuality.ErrorMessage" />
														<asp:RangeValidator ID="rvChameleonJpegQuality" runat="server" ControlToValidate="tbChameleonJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" resourcekey="rvChameleonJpegQuality.ErrorMessage" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel textTop">
														<label for="<%=rblChameleonResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLightboxGalleryResizeMethod.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLightboxGalleryResizeMethod.Text") %></label>
													</td>
													<td>
														<div class="edNews_inputGroup">
															<asp:RadioButtonList ID="rblChameleonResizeMethod" runat="server" AutoPostBack="True" CssClass="verticalList styledRadio smallRadio" RepeatLayout="UnorderedList">
																<asp:ListItem class="normalRadioButton" resourcekey="liPropotional" Value="Proportional">Proportional resize</asp:ListItem>
																<asp:ListItem class="normalRadioButton" resourcekey="liCrop" Selected="True" Value="Crop">Resize and crop</asp:ListItem>
																<asp:ListItem class="normalRadioButton" resourcekey="liCropAndPropotional" Value="CropHorizontalProportionalVertical">Resize and crop horizontal, proportionally resize vertical images</asp:ListItem>
															</asp:RadioButtonList>
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=ddlChameleonLayout.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonLayout.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonLayout.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlChameleonLayout" runat="server" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=ddlChameleonGalleryThemeSelect.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonLayoutTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonLayoutTheme.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlChameleonGalleryThemeSelect" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlChameleonGalleryThemeSelect_SelectedIndexChanged" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=ddlChameleonGalleryThemeSelectStyling.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonLayoutThemeStyle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonLayoutThemeStyle.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlChameleonGalleryThemeSelectStyling" runat="server" DataTextField="Text" DataValueField="Value" />
													</td>
												</tr>
												<tr runat="server" id="trChameleonShowLinkToGravityGallery" visible="false">
													<td class="tdLabel">
														<label for="<%=cbChameleonOpenDetailsInGravityGallery.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonOpenDetailsInGravityGallery.Help", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonOpenDetailsInGravityGallery.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbChameleonOpenDetailsInGravityGallery" runat="server" AutoPostBack="True" OnCheckedChanged="cbChameleonOpenDetailsInGravityGallery_CheckedChanged" Text=" " />
														</div>
													</td>
												</tr>
												<tr runat="server" id="trChameleonGravityGalleryInstances" visible="false">
													<td class="tdLabel">
														<label for="<%=ddlChameleonGravityGalleryInstances.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblChameleonGravityGalleryInstances.Help", true) %>" data-tooltip-position="top-right"><%=_("lblChameleonGravityGalleryInstances.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlChameleonGravityGalleryInstances" runat="server">
															<asp:ListItem Value="0" resourcekey="liSelectGravityGalleryModuleInstance">Select Gravity gallery module instance</asp:ListItem>
														</asp:DropDownList>
														<asp:RequiredFieldValidator ID="rfvChameleonGravityGalleryInstances" runat="server" ErrorMessage="You must select Gravity gallery module" ControlToValidate="ddlChameleonGravityGalleryInstances" InitialValue="0" ValidationGroup="vgSettings" Display="Dynamic" SetFocusOnError="True" Enabled="False" />
													</td>
												</tr>
											</table>
										</asp:Panel>
										<asp:Panel ID="pnlLightboxGallery" runat="server">
											<table class="optionsList fullWidthTable strippedTable noBorder">
												<tr>
													<td class="tdLabel">
														<label for="<%=ddlGalleryTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryTheme.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlGalleryTheme" runat="server" AppendDataBoundItems="True" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGalleryThumbWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryThumbWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryThumbWidth.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGalleryThumbWidth" runat="server" CssClass="smallCentered" resourcekey="tbGalleryThumbWidthResource1">100</asp:TextBox>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGalleryThumbHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryThumbHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryThumbHeight.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGalleryThumbHeight" runat="server" CssClass="smallCentered" resourcekey="tbGalleryThumbHeightResource1">100</asp:TextBox>
													</td>
												</tr>
												<tr id="trGalleryJpegQuality" runat="server">
													<td class="tdLabel">
														<label for="<%=tbGalleryJpegQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbGalleryJpegQuality.Help", true) %>" data-tooltip-position="top-right"><%=_("lbGalleryJpegQuality.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGalleryJpegQuality" runat="server" CssClass="smallCentered">97</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGalleryJpegQuality" runat="server" ControlToValidate="tbGalleryJpegQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvGalleryJpegQuality.ErrorMessage" />
														<asp:RangeValidator ID="rvGalleryJpegQuality" runat="server" ControlToValidate="tbGalleryJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" resourcekey="rvGalleryJpegQuality.ErrorMessage" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGalleryItemsPerPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryItemsPerPage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryItemsPerPage.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGalleryItemsPerPage" runat="server" CssClass="smallCentered" Text="12" resourcekey="tbGalleryItemsPerPageResource1" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGalleryNuberOfColumns.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryNumberOfColumns.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryNumberOfColumns.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGalleryNuberOfColumns" runat="server" CssClass="smallCentered" Text="4" resourcekey="tbGalleryNuberOfColumnsResource1" />
													</td>
												</tr>
												<tr id="trLightboxGalleryResizeMethod" runat="server">
													<td class="tdLabel">
														<label for="<%=rblLightboxGalleryResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLightboxGalleryResizeMethod.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLightboxGalleryResizeMethod.Text") %></label>
													</td>
													<td>
														<div class="edNews_inputGroup">
															<asp:RadioButtonList ID="rblLightboxGalleryResizeMethod" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
																<asp:ListItem class="normalRadioButton" resourcekey="liPropotional" Value="Proportional">Proportional resize</asp:ListItem>
																<asp:ListItem class="normalRadioButton" resourcekey="liCrop" Selected="True" Value="Crop">Resize and crop</asp:ListItem>
															</asp:RadioButtonList>
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbItemTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemTitle.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbItemTitle" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbGIItemDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemDescription.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGIItemDescription" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr id="trDisplayItemTitleLightBox" runat="server">
													<td class="tdLabel">
														<label for="<%=cbGIDisplayItemTitleLightBox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemTitleLightBOx.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemTitleLightBOx.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGIDisplayItemTitleLightBox" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr id="trDisplayItemDescriptionLightBox" runat="server">
													<td class="tdLabel">
														<label for="<%=cbGIDisplayItemDescriptionLightBox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemDescriptionLightBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemDescriptionLightBox.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGIDisplayItemDescriptionLightBox" runat="server" Text=" " />
														</div>
													</td>
												</tr>
											</table>
										</asp:Panel>
										<asp:Panel ID="pnlGravityGallerySettings" runat="server">
											<table class="optionsList fullWidthTable strippedTable noBorder">
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGravityGalleryThumbnailWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryThumbnailWidth.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryThumbnailWidth.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGravityGalleryThumbnailWidth" runat="server" CssClass="smallCentered">160</asp:TextBox>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGravityGalleryThumbnailHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryThumbnailHeight.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryThumbnailHeight.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGravityGalleryThumbnailHeight" runat="server" CssClass="smallCentered">130</asp:TextBox>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGravityGalleryJpegQuality.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbGravityGalleryJpegQuality.Help", true) %>" data-tooltip-position="top-right"><%=_("lbGravityGalleryJpegQuality.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGravityGalleryJpegQuality" runat="server" CssClass="smallCentered">97</asp:TextBox>
														<asp:RequiredFieldValidator ID="rfvGravityGalleryJpegQuality" runat="server" ControlToValidate="tbGravityGalleryJpegQuality" Display="Dynamic" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvGravityGalleryJpegQuality.ErrorMessage" />
														<asp:RangeValidator ID="rvGravityGalleryJpegQuality" runat="server" ControlToValidate="tbGravityGalleryJpegQuality" Display="Dynamic" ErrorMessage="Enter value between 1 - 100." MaximumValue="100" MinimumValue="1" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" resourcekey="rvGravityGalleryJpegQuality.ErrorMessage" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=tbGravityGalleryItemsPerPage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryItemsPerPage.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryItemsPerPage.Text") %></label>
													</td>
													<td>
														<asp:TextBox ID="tbGravityGalleryItemsPerPage" runat="server" CssClass="smallCentered" Text="12" />
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbGravityGalleryEnablePagination.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryEnablePagination.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryEnablePagination.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryEnablePagination" runat="server" Checked="True" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=rblGravityGalleryResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGravityGalleryResizeMethod.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGravityGalleryResizeMethod.Text") %></label>
													</td>
													<td>
														<div class="edNews_inputGroup displayInline">
															<asp:RadioButtonList ID="rblGravityGalleryResizeMethod" runat="server" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
																<asp:ListItem class="normalRadioButton" Selected="True" Value="1" resourcekey="liResizeAndCrop">Resize and crop</asp:ListItem>
																<asp:ListItem class="normalRadioButton" Value="2" resourcekey="liProportionalResize">Proportional resize</asp:ListItem>
															</asp:RadioButtonList>
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbGravityGalleryDisplayTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemTitle.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayTitle" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbGravityGalleryDisplayDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemDescription.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayDescription" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbGravityGalleryDisplayTitleInLightbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemTitleLightBOx.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemTitleLightBOx.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayTitleInLightbox" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbGravityGalleryDisplayDescriptionInLightbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGIDisplayItemDescriptionLightBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGIDisplayItemDescriptionLightBox.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbGravityGalleryDisplayDescriptionInLightbox" runat="server" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbShowLinkToGravityGallery.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowLinkToGravityGallery.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowLinkToGravityGallery.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbShowLinkToGravityGallery" runat="server" AutoPostBack="True" OnCheckedChanged="cbShowLinkToGravityGallery_CheckedChanged" Text=" " />
														</div>
													</td>
												</tr>
												<tr runat="server" id="trGravityGalleryInstances" visible="false">
													<td class="tdLabel">
														<label for="<%=ddlGravityGalleryInstances.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lbllGravityGalleryInstances.Help", true) %>" data-tooltip-position="top-right"><%=_("lbllGravityGalleryInstances.Text") %></label>
													</td>
													<td>
														<asp:DropDownList ID="ddlGravityGalleryInstances" runat="server">
															<asp:ListItem Value="0" resourcekey="liSelectGravityGalleryModuleInstance">Select Gravity gallery module instance</asp:ListItem>
														</asp:DropDownList>
														<asp:RequiredFieldValidator ID="rfvGravityGalleryInstances" runat="server" ErrorMessage="You must select Gravity gallery module" ControlToValidate="ddlGravityGalleryInstances" InitialValue="0" ValidationGroup="vgSettings" Display="Dynamic" SetFocusOnError="True" Enabled="False" />
													</td>
												</tr>
											</table>
										</asp:Panel>
										<table class="optionsList fullWidthTable strippedTable noBorder">
											<tr>
												<td class="tdLabel">&nbsp;</td>
												<td>&nbsp;</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=cbUserCanSeeOnlyTheirGalleries.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUserCanSeeOnlyHisGalleries.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUserCanSeeOnlyHisGalleries.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbUserCanSeeOnlyTheirGalleries" runat="server" Text=" " />
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=cbUserCanOnlySeeTheirOwnImages.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUserCanSeeOnlyHisImages.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUserCanSeeOnlyHisImages.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbUserCanOnlySeeTheirOwnImages" runat="server" Text=" " />
													</div>
												</td>
											</tr>
										</table>
										<div class="sectionBoxSubtitle highlighted3">
											<span><%=_("NewsGalleryCategorySettings.Text")%></span>
										</div>
										<table class="optionsList fullWidthTable noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=ddlNewsGalleryCategorySettings.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryCategory.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryCategory.Text") %></label>
												</td>
												<td>
													<asp:DropDownList ID="ddlNewsGalleryCategorySettings" runat="server" ValidationGroup="vgSettings" />
													<asp:RequiredFieldValidator ID="rfvNewsGalleryCategorySettings" runat="server" ErrorMessage="Must select news gallery category" ControlToValidate="ddlNewsGalleryCategorySettings" InitialValue="" ValidationGroup="vgSettings" />
												</td>
											</tr>
										</table>
									</div>
								</ContentTemplate>
							</asp:UpdatePanel>
						</asp:Panel>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlImageInPostSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfImageInPostSettingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblImageInPostSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblImageInPostSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">10</span>
						<h2><%=_("Editformdefaultpresets.Text")%></h2>
					</div>
					<asp:Panel ID="pnlImageInPostSettingsSourceTable" runat="server" CssClass="category_content">
						<asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<table class="optionsList fullWidthTable strippedTable noBorder">
									<tr>
										<td class="tdLabel">
											<label for="<%=rblTextEditorType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTextEditorType.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTextEditorType.Text") %></label>
										</td>
										<td>
											<div class="edNews_inputGroup">
												<asp:RadioButtonList ID="rblTextEditorType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblTextEditorType_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
													<asp:ListItem class="normalRadioButton" Value="0" resourcekey="liDefaultDNNHTMLEditor" Text="Default DNN HTML editor" Selected="True" />
													<asp:ListItem class="normalRadioButton" Value="1" resourcekey="liMultilineTextBox" Text="Multiline text box" />
												</asp:RadioButtonList>
											</div>
										</td>
									</tr>
									<tr runat="server" id="trTextEditorMaxChar" visible="false">
										<td class="tdLabel">
											<label for="<%=tbxTextEditorMaxChar.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTextEditorMaxChar.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTextEditorMaxChar.Text") %></label>
										</td>
										<td>
											<asp:TextBox ID="tbxTextEditorMaxChar" runat="server" CssClass="smallCentered" Text="0" />
										</td>
									</tr>
									<tr runat="server" id="trTextEditorArticleMaxChar" visible="false">
										<td class="tdLabel">
											<label for="<%=tbxTextEditorArticleMaxChar.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTextEditorArticleMaxChar.Help", true) %>" data-tooltip-position="top-right"><%=_("lblTextEditorArticleMaxChar.Text") %></label>
										</td>
										<td>
											<asp:TextBox ID="tbxTextEditorArticleMaxChar" runat="server" CssClass="smallCentered" Text="0" />
										</td>
									</tr>
									<tr>
										<td class="tdLabel">
											<label for="<%=rblDirectPublishDefaultState.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDirectPublishDefaultState.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDirectPublishDefaultState.Text") %></label>
										</td>
										<td>
											<div class="edNews_inputGroup">
												<asp:RadioButtonList ID="rblDirectPublishDefaultState" runat="server" AutoPostBack="true" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
													<asp:ListItem class="normalRadioButton" Value="0" resourcekey="liPublish" Text="Publish" Selected="True" />
													<asp:ListItem class="normalRadioButton" Value="1" resourcekey="liDraft" Text="Draft" />
												</asp:RadioButtonList>
											</div>
										</td>
									</tr>
								</table>
							</ContentTemplate>
						</asp:UpdatePanel>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionTitleImageToken.Text")%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTokenWidth.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenWidth.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenWidth.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTokenWidth" runat="server" CssClass="smallCentered" Text="200" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbTokenHeight.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenHeight.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenHeight.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbTokenHeight" runat="server" CssClass="smallCentered" Text="200" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblTokenImageResizeMethod.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenResizeCrop.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenResizeCrop.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblTokenImageResizeMethod" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" resourcekey="liPropotional" Value="Proportional" Text="Proportional resize" Selected="True" />
											<asp:ListItem class="normalRadioButton" resourcekey="liCrop" Value="Crop" Text="Resize and crop" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblCSSClassPosition.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenCSSClass.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenCSSClass.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblCSSClassPosition" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="" resourcekey="liCSSClassPositionLeftClear" Text="Left clear" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="left" resourcekey="liCSSClassPositionLeftWrap" Text="Left wrap" />
											<asp:ListItem class="normalRadioButton" Value="right" resourcekey="liCSSClassPositionRightWrap" Text="Right wrap" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbTokenLighbox.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenEmbedLightBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenEmbedLightBox.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbTokenLighbox" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbTokenTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenTitle.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbTokenTitle" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbTokenDescription.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTokenDescription.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTokenDescription.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbTokenDescription" runat="server" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionTitleExpireDate.Text")%></span>
						</div>
						<asp:UpdatePanel ID="upPublishExpireDateSettings" runat="server" UpdateMode="Conditional" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppPublishExpireDateSettings" runat="server" AssociatedUpdatePanelID="upPublishExpireDateSettings" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList fullWidthTable strippedTable noBorder">
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlPublishDateSettings.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPublishDateSettings.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPublishDateSettings.Text") %></label>
											</td>
											<td>
												<div class="edNews_inputGroup displayInline">
													<asp:DropDownList ID="ddlPublishDateSettings" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlPublishDateSettings_SelectedIndexChanged">
														<asp:ListItem Value="0" resourcekey="liCurrentDateTime" Text="Current date and time" />
														<asp:ListItem Value="1" resourcekey="liDesiredDateTime" Text="Desired date and time" />
														<asp:ListItem Value="2" resourcekey="liNextMonday" Text="Next Monday" />
														<asp:ListItem Value="3" resourcekey="liNextTuesday" Text="Next Tuesday" />
														<asp:ListItem Value="4" resourcekey="liNextWednesday" Text="Next Wednesday" />
														<asp:ListItem Value="5" resourcekey="liNextThursday" Text="Next Thursday" />
														<asp:ListItem Value="6" resourcekey="liNextFriday" Text="Next Friday" />
														<asp:ListItem Value="7" resourcekey="liNextSaturday" Text="Next Saturday" />
														<asp:ListItem Value="8" resourcekey="liNextSunday" Text="Next Sunday" />
														<asp:ListItem Value="9" resourcekey="liNextDay" Text="Next Day" />
													</asp:DropDownList>
												</div>
												<asp:Panel ID="pnlDesiredPublishDate" runat="server" Visible="false" CssClass="edNews_inputGroup displayInline">
													<asp:TextBox ID="tbxPublishDate" runat="server" ValidationGroup="vgSettings" CssClass="smallRadio" />
													<asp:RequiredFieldValidator ID="rfvPublishDate" runat="server" ControlToValidate="tbxPublishDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgSettings" resourcekey="rfvPublishDate.ErrorMessage" />
													<asp:Label ID="lblPubDateError" ResourceKey="lblPubDateError" runat="server" CssClass="smallInfo error" Text="Invalid date." Visible="false" />
												</asp:Panel>
												<asp:Panel ID="pnlDesiredPublishTime" runat="server" Visible="false" CssClass="desPublishTime">
													<asp:TextBox ID="tbxPublishTime" runat="server" ValidationGroup="vgSettings" CssClass="smallCentered" Text="0:00" />
													<asp:RequiredFieldValidator ID="rfvPublishTime" runat="server" ControlToValidate="tbxPublishTime" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Time required." ValidationGroup="vgSettings" resourcekey="rfvPublishTime.ErrorMessage" />
													<asp:RegularExpressionValidator ID="revPublishTime" runat="server" ControlToValidate="tbxPublishTime" EnableClientScript="true" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgSettings" />
												</asp:Panel>
											</td>
										</tr>
										<tr>
											<td class="tdLabel">
												<label for="<%=ddlExpireDateSettings.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblExpirehDateSettings.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblExpirehDateSettings.Text") %></label>
											</td>
											<td>
												<div class="edNews_inputGroup displayInline">
													<asp:DropDownList ID="ddlExpireDateSettings" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlExpireDateSettings_SelectedIndexChanged">
														<asp:ListItem Value="0" resourcekey="liDays" Text="Days" />
														<asp:ListItem Value="1" resourcekey="liWeeks" Text="Weeks" />
														<asp:ListItem Value="2" resourcekey="liMonths" Text="Months" />
														<asp:ListItem Value="3" resourcekey="liYears" Text="Years" />
														<asp:ListItem Value="4" resourcekey="liDesiredDateTime" Text="Desired date and time" />
													</asp:DropDownList>
												</div>
												<asp:Panel ID="pnlExpireDateDaysToAdd" runat="server" Visible="false" CssClass="edNews_inputGroup displayInline">
													<asp:TextBox ID="tbxExpireDateDaysToAdd" runat="server" CssClass="smallCentered" Text="365000" />
													<asp:RequiredFieldValidator ID="rfvExpireDateDaysToAdd" runat="server" ControlToValidate="tbxExpireDateDaysToAdd" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvExpireDateDaysToAdd.ErrorMessage" ValidationGroup="vgSettings" />
													<asp:RangeValidator ID="rvExpireDateDaysToAdd" runat="server" ControlToValidate="tbxExpireDateDaysToAdd" Display="Dynamic" ErrorMessage="Enter value between 1-1000000." MaximumValue="1000000" MinimumValue="1" resourcekey="rvExpireDateDaysToAdd.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" />
												</asp:Panel>
												<asp:Panel ID="pnlDesiredExpireDate" runat="server" Visible="false" CssClass="edNews_inputGroup displayInline">
													<asp:TextBox ID="tbxExpireDate" runat="server" ValidationGroup="vgSettings" CssClass="smallRadio" />
													<asp:RequiredFieldValidator ID="rfvPublishExpireDate" runat="server" ControlToValidate="tbxExpireDate" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Date required." ValidationGroup="vgSettings" resourcekey="rfvPublishDate.ErrorMessage" />
													<asp:Label ID="lblExpireDateError" ResourceKey="lblPubDateError" runat="server" CssClass="smallInfo error" Text="Invalid date." Visible="false" />
												</asp:Panel>
												<asp:Panel ID="pnlDesiredExpireTime" runat="server" Visible="false" CssClass="edNews_inputGroup displayInline">
													<asp:TextBox ID="tbxExpireTime" runat="server" ValidationGroup="vgSettings" CssClass="smallCentered" Text="0:00" />
													<asp:RequiredFieldValidator ID="rfvPublishExpireTime" runat="server" ControlToValidate="tbxExpireTime" CssClass="NormalRed" Display="Dynamic" ErrorMessage="Time required." ValidationGroup="vgSettings" resourcekey="rfvPublishTime.ErrorMessage" />
													<asp:RegularExpressionValidator ID="revPublishExpireTime" runat="server" ControlToValidate="tbxExpireTime" EnableClientScript="true" ErrorMessage="hh:mm" ValidationExpression="([0-1]?[0-9]|2[0-3]):([0-5][0-9])" ValidationGroup="vgSettings" />
												</asp:Panel>
												<asp:Label ID="lblPublishExpireDateInfo" runat="server" CssClass="smallInfo error" EnableViewState="false" Visible="false" />
											</td>
										</tr>
									</table>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionCategoriesInAddEdit.Text")%></span>
						</div>
						<table class="optionsList fullWidthTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbCategoriesSelectionExpanded.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCategoriesSelectionExpanded.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCategoriesSelectionExpanded.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbCategoriesSelectionExpanded" runat="server" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionEventsAddEditFormDefault.Text")%></span>
						</div>
						<table class="optionsList fullWidthTable noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=rblEventsAddEditFormDefault.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEventsAddEditFormDefault.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEventsAddEditFormDefault.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblEventsAddEditFormDefault" runat="server" CssClass="styledRadio smallRadio verticalList" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="0" resourcekey="liEventsAddEditFormDefault0" Text="User can enable adding article as event" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="1" resourcekey="liEventsAddEditFormDefault1" Text="User can disable adding article as event" />
											<asp:ListItem class="normalRadioButton" Value="2" resourcekey="liEventsAddEditFormDefault2" Text="User can't disable adding article as event" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=_("subSectionGalleryAndMainArticleImage.Text")%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAutomaticallySetMainArticleImage.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAutomaticallySetMainArticleImage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAutomaticallySetMainArticleImage.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAutomaticallySetMainArticleImage" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAutomaticallyDisplayGalleryInArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAutomaticallyDisplayGalleryInArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAutomaticallyDisplayGalleryInArticle.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAutomaticallyDisplayGalleryInArticle" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbDisplayMainArticleImageInGallery.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisplayMainArticleImageInGallery.Help", true) %>" data-tooltip-position="top-right"><%=_("lblDisplayMainArticleImageInGallery.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbDisplayMainArticleImageInGallery" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlGalleryOrderBy.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGalleryOrderBy.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGalleryOrderBy.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:DropDownList ID="ddlGalleryOrderBy" runat="server">
											<asp:ListItem Value="0" resourcekey="liAscending" Text="Ascending" />
											<asp:ListItem Value="1" resourcekey="liDescending" Text="Descending" />
										</asp:DropDownList>
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlCommentSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfCommentSettingsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblCommentSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblCommentSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">11</span>
						<h2><%=_("Comments.Text")%></h2>
					</div>
					<asp:Panel ID="pnlCommentsSettingsTable" runat="server" CssClass="category_content">
						<asp:UpdatePanel ID="upCommentsSettings" runat="server" OnUnload="UpdatePanel_Unload">
							<ContentTemplate>
								<div class="edNews_adminProgressOverlayWrapper">
									<asp:UpdateProgress ID="uppCommentsSettings" runat="server" AssociatedUpdatePanelID="upCommentsSettings" DisplayAfter="100" DynamicLayout="true">
										<ProgressTemplate>
											<div class="edNews_adminProgressOverlay">
											</div>
										</ProgressTemplate>
									</asp:UpdateProgress>
									<table class="optionsList fullWidthTable strippedTable noBorder">
										<tr>
											<td class="tdLabel">
												<label for="<%=rblCommentsSettings.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCommentsSettings.HelpKey", true) %>" data-tooltip-position="top-right"><%=_("lblCommentsSettings.Text") %></label>
											</td>
											<td>
												<div class="edNews_inputGroup">
													<asp:RadioButtonList ID="rblCommentsSettings" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblCommentsSettings_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
														<asp:ListItem class="normalRadioButton" resourcekey="liCommentsEnabled" Value="Enabled" Text="Enabled" Selected="True" />
														<asp:ListItem class="normalRadioButton" resourcekey="liCommentsDisabled" Value="Disabled" Text="Disabled" />
														<asp:ListItem class="normalRadioButton" resourcekey="liCommentsShowAlreadyPosted" Value="ShowAlreadyPosted" Text="Show already posted comments" />
													</asp:RadioButtonList>
												</div>
											</td>
										</tr>
										<tr>
											<td colspan="2" class="textCenter">
												<div class="edNews_inputGroup">
													<asp:RadioButtonList ID="rblCommensSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblCommensSource_SelectedIndexChanged" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
														<asp:ListItem class="normalRadioButton" Selected="True" Value="Standard" resourcekey="ListItemResource52">Standard comments</asp:ListItem>
														<asp:ListItem class="normalRadioButton" Value="Facebook" resourcekey="ListItemResource53">Facebook comments</asp:ListItem>
														<asp:ListItem class="normalRadioButton" Value="DISQUS" resourcekey="ListItemResource54">DISQUS Comments</asp:ListItem>
													</asp:RadioButtonList>
												</div>
											</td>
										</tr>
									</table>
									<asp:Panel ID="pnlFacebookCommentsOptions" runat="server">
										<table class="optionsList fullWidthTable strippedTable noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=tbFacebookAppID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFacebookID.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFacebookID.Text") %></label>
												</td>
												<td>
													<asp:TextBox ID="tbFacebookAppID" runat="server" resourcekey="tbFacebookAppIDResource1">None</asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=tbFacebookUserID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFacebookUserID.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFacebookUserID.Text") %></label>
												</td>
												<td>
													<asp:TextBox ID="tbFacebookUserID" runat="server" resourcekey="tbFacebookUserIDResource1">None</asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=tbFacebookNumberOfComments.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFacebookNumberOfComents.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFacebookNumberOfComents.Text") %></label>
												</td>
												<td>
													<asp:TextBox ID="tbFacebookNumberOfComments" runat="server" CssClass="smallCentered" resourcekey="tbFacebookNumberOfCommentsResource1">10</asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=ddlFacebookCommentsTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFacebookCommentsTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblFacebookCommentsTheme.Text") %></label>
												</td>
												<td>
													<asp:DropDownList ID="ddlFacebookCommentsTheme" runat="server">
														<asp:ListItem Value="light" resourcekey="ListItemResource55">Light theme</asp:ListItem>
														<asp:ListItem Value="dark" resourcekey="ListItemResource56">Dark Theme</asp:ListItem>
													</asp:DropDownList>
												</td>
											</tr>
										</table>
									</asp:Panel>
									<asp:Panel ID="pnlDisqUSCommentsOptions" runat="server">
										<table class="optionsList fullWidthTable strippedTable noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=tbDisqusID.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisqusID.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisqusID.Text") %></label>
												</td>
												<td>
													<asp:TextBox ID="tbDisqusID" runat="server" resourcekey="tbDisqusIDResource1">None</asp:TextBox>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=cbDisqusOnline.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDisqusOnLine.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDisqusOnLine.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbDisqusOnline" runat="server" Checked="True" Text=" " />
													</div>
												</td>
											</tr>
										</table>
									</asp:Panel>
									<asp:Panel ID="pnlStandardComentsOptions" runat="server">
										<asp:Panel ID="pnlStandardEnabledComments" runat="server">
											<table class="optionsList fullWidthTable strippedTable noBorder">
												<tr>
													<td class="tdLabel">
														<label for="<%=cbEnableCAPTCHA.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableCAPTCA.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableCAPTCA.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableCAPTCHA" runat="server" Text=" " />
														</div>
														<asp:HyperLink ID="hlCommentsEnableCaptcha" runat="server" Target="_blank" Visible="False">You need to enter Google Recaptcha keys in API CONNECTION control.</asp:HyperLink>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbModerateComments.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCommentsMustBeApproved.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCommentsMustBeApproved.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbModerateComments" runat="server" Text=" " />
														</div>
													</td>
												</tr>
											</table>
										</asp:Panel>
										<asp:Panel ID="pnlStandardGroupSettings" runat="server">
											<table class="optionsList fullWidthTable strippedTable noBorder">
												<tr>
													<td class="tdLabel">
														<label for="<%=cbShowCommentsRating.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCommentsRAting.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowCommentsRAting.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCommentsRating" runat="server" Checked="True" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbShowThreadedComments.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowThreaedComments.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowThreaedComments.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbShowThreadedComments" runat="server" Checked="True" Text=" " />
														</div>
													</td>
												</tr>
												<tr>
													<td class="tdLabel">
														<label for="<%=cbShowCommentsFromAllPortals.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCommentsFromAllPortals.Help", true) %>" data-tooltip-position="top-right"><%=_("lblShowCommentsFromAllPortals.Text") %></label>
													</td>
													<td>
														<div class="switchCheckbox">
															<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCommentsFromAllPortals" runat="server" Checked="True" Text=" " />
														</div>
													</td>
												</tr>
												<tr id="trCommentsAvatarSelection" runat="server">
													<td class="tdLabel">
														<label for="<%=rblCommentsAvatarSource.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectCommentsAvatarSource.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSelectCommentsAvatarSource.Text") %></label>
													</td>
													<td>
														<div class="edNews_inputGroup displayInline">
															<asp:RadioButtonList ID="rblCommentsAvatarSource" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
																<asp:ListItem class="normalRadioButton" resourcekey="ligravatar" Value="gravatar" Selected="True">Gravatar</asp:ListItem>
																<asp:ListItem class="normalRadioButton" resourcekey="lidnnprofile" Value="dnnprofile">DotNetNuke user profile</asp:ListItem>
															</asp:RadioButtonList>
														</div>
													</td>
												</tr>
											</table>
										</asp:Panel>
									</asp:Panel>
									<asp:Panel ID="pnlCommentsOptions" runat="server">
										<table class="optionsList fullWidthTable strippedTable noBorder">
											<tr>
												<td class="tdLabel">
													<label for="<%=cbAllowArticleComments.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAllowArticleComments.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAllowArticleComments.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbAllowArticleComments" runat="server" Text=" " />
													</div>
												</td>
											</tr>
											<tr>
												<td class="tdLabel">
													<label for="<%=cbShowCommentsGDPRComplianceAgreement.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowCommentsGDPRComplianceAgreement.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowCommentsGDPRComplianceAgreement.Text") %></label>
												</td>
												<td>
													<div class="switchCheckbox">
														<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCommentsGDPRComplianceAgreement" runat="server" Text=" " />
													</div>
												</td>
											</tr>
										</table>
									</asp:Panel>
								</div>
							</ContentTemplate>
						</asp:UpdatePanel>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlPaidContentSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfPaidContentSettingsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblPaidContentSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblPaidContentSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">12</span>
						<h2><%=_("Paidcontent.Text")%></h2>
					</div>
					<asp:Panel ID="pnlPaidContentSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnablePaidContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnablePaidContent.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnablePaidContent.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnablePaidContent" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowCommentsOnPaidContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPaidContentShowComments.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPaidContentShowComments.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbShowCommentsOnPaidContent" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowImageGalleriesOnPaidContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblPaidContentShowImageGallery.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblPaidContentShowImageGallery.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbShowImageGalleriesOnPaidContent" runat="server" Text=" " />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlRelatedPrintRSSSetingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfRelatedPrintRSSSetingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblRelatedPrintRSSSetingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblRelatedPrintRSSSetingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">13</span>
						<h2><%=_("RelatedarticlesandRSS.Text")%></h2>
					</div>
					<asp:Panel ID="pnlRelatedPrintRSSSetingsSourceTable" runat="server" CssClass="category_content">
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=Releatedarticles%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableRelatedArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableRelatedArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableRelatedArticles.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableRelatedArticles" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbNumOfRelatedArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblNumberOfReleatedArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblNumberOfReleatedArticles.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbNumOfRelatedArticles" runat="server" CssClass="smallCentered">5</asp:TextBox>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlRelatedArticlesSorting.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSortRelatedArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblSortRelatedArticles.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlRelatedArticlesSorting" runat="server">
										<asp:ListItem Value="PublishDate" Text="Publish date" resourcekey="ListItemResource61" />
										<asp:ListItem Value="NumberOfViews" Text="Number of views" resourcekey="ListItemResource62" />
										<asp:ListItem Value="NumberOfMatchingTags" Text="Number of matching tags" resourcekey="liNumberOfMatchingTags.Text" />
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=rblFilterRelatedArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblFilterRelatedArticles.HelpKey", true) %>" data-tooltip-position="top-right"><%=_("lblFilterRelatedArticles.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup">
										<asp:RadioButtonList ID="rblFilterRelatedArticles" runat="server" CssClass="styledRadio smallRadio verticalList" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="1" resourcekey="ByModuleCategories" Text="By module categories" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="2" resourcekey="ByArticeCategories" Text="By article categories" />
											<asp:ListItem class="normalRadioButton" Value="0" resourcekey="ShowRelatedArticlesFromAllCategories" Text="Show related articles from all categories" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=RSS%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=hlRSSLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableRSSResource1.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableRSSResource1.Text") %></label>
								</td>
								<td>
									<asp:HyperLink runat="server" ID="hlRSSLink" Target="_blank">RSS Link</asp:HyperLink>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbRSSUrl.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSLinkBack.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSLinkBack.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbRSSUrl" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbRSSShowArticleImages.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSShowImages.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSShowImages.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbRSSShowArticleImages" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbRSSSInsertImageIntoSummary.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSInsertImage.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSInsertImage.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbRSSSInsertImageIntoSummary" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbRSSNumberOfArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSNumberOfArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSNumberOfArticles.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbRSSNumberOfArticles" runat="server" CssClass="smallCentered" Text="20" />
									<asp:RequiredFieldValidator ID="rfvRSSNumberOfArticles" runat="server" ControlToValidate="tbRSSNumberOfArticles" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="tbRSSNumberOfArticles.ErrorMessage" ValidationGroup="vgSettings" />
									<asp:RangeValidator ID="rvRSSNumberOfArticles" runat="server" ControlToValidate="tbRSSNumberOfArticles" Display="Dynamic" ErrorMessage="Enter value between 1-500." MaximumValue="500" MinimumValue="1" resourcekey="rvRSSNumberOfArticles.ErrorMessage" SetFocusOnError="True" Type="Integer" ValidationGroup="vgSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbRSSNumberOfCharactersInRSS.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSNumberOfCharactersInRSS.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSNumberOfCharactersInRSS.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbRSSNumberOfCharactersInRSS" runat="server" CssClass="smallCentered">200</asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvRSSNumberOfCharacters" runat="server" ControlToValidate="tbRSSNumberOfCharactersInRSS" Display="Dynamic" ErrorMessage="This filed is required." resourcekey="rfvRSSNumberOfCharacters.ErrorMessage" SetFocusOnError="True" ValidationGroup="vgSettings" />
									<asp:CompareValidator ID="cvRSSNumberOfCharactersInRSS" runat="server" ControlToValidate="tbRSSNumberOfCharactersInRSS" Display="Dynamic" ErrorMessage="Please enter number only." Operator="DataTypeCheck" resourcekey="cvLightBoxGalleryNumberOfItems0Resource1.ErrorMessage" Type="Integer" ValidationGroup="vgSettings" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbRSSShowLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSShowLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSShowLink.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbRSSShowLink" runat="server" Checked="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=rblRssArticleDetailsData.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblRSSDetailsData.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblRSSDetailsData.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblRssArticleDetailsData" runat="server" CssClass="inlineList styledRadio smallRadio" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" resourcekey="liArticle" Selected="True" Value="article">Article content (body)</asp:ListItem>
											<asp:ListItem class="normalRadioButton" resourcekey="liArticleSummary" Value="summary">Article summary</asp:ListItem>
											<asp:ListItem class="normalRadioButton" resourcekey="liNothing" Value="nothing">No description</asp:ListItem>
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbStripRSSHtml.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStripRSSHtml.Help", true) %>" data-tooltip-position="top-right"><%=_("lblStripRSSHtml.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbStripRSSHtml" runat="server" Checked="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAddFacebookInstantArticleInRss.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddFacebookInstantArticleInRss.Help", true) %>" data-tooltip-position="top-right"><%=_("lblAddFacebookInstantArticleInRss.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAddFacebookInstantArticleInRss" runat="server" Checked="False" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=ArticleSitemap%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=hlArticleSitemap.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblArticleSiteMap.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblArticleSiteMap.Text") %></label>
								</td>
								<td>
									<asp:HyperLink runat="server" ID="hlArticleSitemap" Target="_blank">Article Sitemap</asp:HyperLink>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=GoogleNewsArticleSitemap%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=hlGoogleNewsArticleSiteMap.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGoogleNewsArticleSiteMap.Help", true) %>" data-tooltip-position="top-right"><%=_("lblGoogleNewsArticleSiteMap.Text") %></label>
								</td>
								<td>
									<asp:HyperLink runat="server" ID="hlGoogleNewsArticleSiteMap" Target="_blank">Google News Article Sitemap</asp:HyperLink>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlContentFormationSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfContentFormationSettingsSourceState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblContentFormationSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblContentFormationSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">14</span>
						<h2><%=_("Limitcontentformatting.Text")%></h2>
					</div>
					<asp:Panel ID="pnlContentFormationSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLimitTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitTitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitTitle.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbLimitTitle" runat="server" CssClass="smallCentered">0</asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvTitleLImit" runat="server" ControlToValidate="tbLimitTitle" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvTitleLImitResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLimitSubTitle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitSubtitle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitSubtitle.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbLimitSubTitle" runat="server" CssClass="smallCentered">0</asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tbLimitSubTitle" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="RequiredFieldValidator2Resource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbLimitSummary.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitSummary.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitSummary.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbLimitSummary" runat="server" CssClass="smallCentered">0</asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvSummaryLimit" runat="server" ControlToValidate="tbLimitSummary" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="rfvSummaryLimitResource1.ErrorMessage" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=tbArticleLimit.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLimitArticle.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblLimitArticle.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbArticleLimit" runat="server" CssClass="smallCentered">0</asp:TextBox>
									<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbArticleLimit" ErrorMessage="This filed is required." ValidationGroup="vgSettings" resourcekey="RequiredFieldValidator1Resource1.ErrorMessage" />
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlDNNSearchIntegrationMain" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfDNNSearchIntegrationState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblDNNSearchIntegrationSettingsSource" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblDNNSearchIntegrationSettingsSource_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">15</span>
						<h2><%=_("DNNSearchintegration.Text")%></h2>
					</div>
					<asp:Panel ID="pnlDNNSearchIntegration" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbDNNSearchIntegration.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDNNSearchIntegration.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDNNSearchIntegration.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbDNNSearchIntegration" runat="server" Checked="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbGetAlreadyIndexedContent.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGetAlreadyIndexedContent.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGetAlreadyIndexedContent.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbGetAlreadyIndexedContent" runat="server" Checked="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr runat="server" id="rowClearSearchIndexer">
								<td class="tdLabel">
									<label for="<%=btnClearSearchIndexer.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblClearSearchIndexer.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblClearSearchIndexer.Text") %></label>
								</td>
								<td>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnClearSearchIndexer" resourcekey="btnClearSearchIndexer" runat="server" Text="Clear" CssClass="delete" OnClick="btnClearSearchIndexer_Click" />
									</div>
									<label runat="server" id="lblClearSearchIndexerInfo" enableviewstate="false"></label>
								</td>
							</tr>
							<tr runat="server" id="rowClearSearchIndexerAll">
								<td class="tdLabel">
									<label for="<%=btnClearSearchIndexerAll.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblClearSearchIndexerAll.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblClearSearchIndexerAll.Text") %></label>
								</td>
								<td>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnClearSearchIndexerAll" resourcekey="btnClearSearchIndexerAll" runat="server" Text="Clear" CssClass="delete" OnClick="btnClearSearchIndexerAll_Click" />
									</div>
									<label runat="server" id="lblClearSearchIndexerAllInfo" enableviewstate="false"></label>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlAuthorProfilesMain" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfAuthorProfilesState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblAuthorProfiles" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblAuthorProfiles_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">16</span>
						<h2><%=_("AuthorProfiles.Text")%></h2>
					</div>
					<asp:Panel ID="pnlAuthorProfiles" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowAuthorProfiles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowAuthorsBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowAuthorsBox.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbShowAuthorProfiles" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbCCEmailsForAuthors.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCCEmailsForAuthors.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCCEmailsForAuthors.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbCCEmailsForAuthors" runat="server" OnCheckedChanged="cbCCEmailsForAuthors_CheckedChanged" AutoPostBack="True" Text=" " />
									</div>
									<asp:TextBox ID="tbCCEmailsForAuthors" runat="server" Visible="False" MaxLength="256"></asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvCCEmailsForAuthors" runat="server" Display="Dynamic" ControlToValidate="tbCCEmailsForAuthors" ErrorMessage="This filed is required." ValidationGroup="vgSettings" Enabled="False" />
									<asp:RegularExpressionValidator ID="revCCEmailsForAuthors" runat="server" Display="Dynamic" Enabled="False" ErrorMessage="Please enter valid email." ValidationGroup="vgSettings" ControlToValidate="tbCCEmailsForAuthors" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbShowAuthorGroupProfiles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblShowAuthorsGroupBox.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblShowAuthorsGroupBox.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbShowAuthorGroupProfiles" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAuthorsCanEditThierProfile.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorcCanEditProfile.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorcCanEditProfile.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAuthorsCanEditThierProfile" runat="server" Checked="True" AutoPostBack="true" OnCheckedChanged="cbAuthorsCanEditThierProfile_CheckedChanged" Text=" " />
									</div>
								</td>
							</tr>
							<tr runat="server" id="trEOG">
								<td class="tdLabel">
									<label for="<%=cbAuthorsCanEditThierGroup.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorCanEditTheirOwnGroup.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorCanEditTheirOwnGroup.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAuthorsCanEditThierGroup" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAuthorProfileUseHtmlEditor.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorProfileUseHtmlEditor.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorProfileUseHtmlEditor.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAuthorProfileUseHtmlEditor" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableAuthorAlias.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAuthorAlias.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAuthorAlias.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableAuthorAlias" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactEmailByArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactEmailByArticle.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactEmailByArticle.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactEmailByArticle" runat="server" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<span><%=ContactFormSettings%></span>
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormCompanyVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormCompany.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormCompany.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormCompanyVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormCompanyVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormCompanyRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormCompanyRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormStreetVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormStreet.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormStreet.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormStreetVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormStreetVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormStreetRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormStreetRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormCityVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormCity.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormCity.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormCityVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormCityVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormCityRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormCityRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormRegionVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormRegion.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormRegion.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormRegionVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormRegionVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormRegionRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormRegionRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormCountryVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormCountry.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormCountry.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormCountryVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormCountryVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormCountryRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormCountryRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormPostalCodeVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormPostalCode.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormPostalCode.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormPostalCodeVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormPostalCodeVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormPostalCodeRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormPostalCodeRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormTelephoneVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormTelephone.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormTelephone.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormTelephoneVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormTelephoneVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormTelephoneRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormTelephoneRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormMobileVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormMobile.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormMobile.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormMobileVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormMobileVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormMobileRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormMobileRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormWebsiteVisible.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormWebsite.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormWebsite.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormWebsiteVisible" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormWebsiteVisible.ClientID %>"><%=_("cbVisible.Text") %></label>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormWebsiteRequired" resourcekey="cbRequired" runat="server" Checked="False" Text="Required" />
									</div>
									<label for="<%=cbContactFormWebsiteRequired.ClientID %>"><%=_("cbRequired.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormTermsAndConditionsAgreement.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormTermsAndConditionsAgreement.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormTermsAndConditionsAgreement.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormTermsAndConditionsAgreement" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormTermsAndConditionsAgreement.ClientID %>"><%=_("cbVisible.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormEmailUseAgreement.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormEmailUseAgreement.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormEmailUseAgreement.Text") %></label>
								</td>
								<td class="edNews__visibleRequiredToggles">
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormEmailUseAgreement" resourcekey="cbVisible" runat="server" Checked="False" Text="Visible" />
									</div>
									<label for="<%=cbContactFormEmailUseAgreement.ClientID %>"><%=_("cbVisible.Text") %></label>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormAddArticleUrl.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormAddArticleUrl.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormAddArticleUrl.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormAddArticleUrl" runat="server" Checked="False" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormEnableCaptcha.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormEnableCaptcha.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormEnableCaptcha.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox ID="cbContactFormEnableCaptcha" runat="server" Text=" " />
									</div>
									<asp:HyperLink ID="hlContactFormEnableCaptcha" runat="server" Target="_blank" Visible="False">You need to enter Google Recaptcha keys in API CONNECTION control.</asp:HyperLink>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbContactFormAddArticleTitleToSubject.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblContactFormAddArticleTitleToSubject.Help", true) %>" data-tooltip-position="top-right"><%=_("lblContactFormAddArticleTitleToSubject.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbContactFormAddArticleTitleToSubject" runat="server" Checked="False" Text=" " />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlImportedRSSArticlesMain" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfImportedRSSArticlesState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblImportedRSSArticles" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblImportedRSSArticles_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">17</span>
						<h2><%=_("ImportedarticlesfromRSS.Text")%></h2>
					</div>
					<asp:Panel ID="pnlImportedRSSArticles" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbImportedRSSASLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblImportetRSSAsLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblImportetRSSAsLink.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbImportedRSSASLink" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAddLinkToOrigitalText.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddLinkToOriginalRSS.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAddLinkToOriginalRSS.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox edNews__toggleNextTableRow">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAddLinkToOrigitalText" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbAddCanonicalToOriginalRSSLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddCanonicalToOriginalRSSLink.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAddCanonicalToOriginalRSSLink.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbAddCanonicalToOriginalRSSLink" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbOpenRssLinksInNewWindow.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenRssLinksInNewWindow.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenRssLinksInNewWindow.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbOpenRssLinksInNewWindow" runat="server" Text=" " />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlSocialSharingMain" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfSocialSharing" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblSocialSharing" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblSocialSharing_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">18</span>
						<h2><%=_("AutopostingtoJournal.Text")%></h2>
					</div>
					<asp:Panel ID="pnlNoSocialSharing" runat="server" CssClass="category_content" Visible="False">
						<asp:Label ID="lblNoSocialSharing" resourcekey="lblNoSocialSharing" runat="server" Text="This functionality is only available in DotNetNuke version 6.2 or higher." Font-Bold="True" />
					</asp:Panel>
					<asp:Panel ID="pnlSocialSharing" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr runat="server" id="tblRowIsSocialInstance" style="display: none;">
								<td class="tdLabel">
									<label for="<%=cbIsSocialInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblIsSocialInstance.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblIsSocialInstance.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbIsSocialInstance" runat="server" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblJournal" resourcekey="lblJournal" runat="server" Text="Journal" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=cbEnableJournalAddArticle.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableJournal.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableJournal.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableJournalAddArticle" runat="server" AutoPostBack="true" OnCheckedChanged="cbEnableJournalAddArticle_CheckedChanged" Text=" " />
									</div>
									<label for="<%=cblJournaPostingInfo.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblJournaPostingInfo.Help", true) %>" data-tooltip-position="top-right"><%=_("lblJournaPostingInfo.Text") %></label>
									<div class="edNews_inputGroup">
										<asp:CheckBoxList ID="cblJournaPostingInfo" runat="server" Enabled="False" RepeatLayout="unorderedlist" CssClass="styledCheckbox inlineList">
											<asp:ListItem class="normalCheckBox" resourcekey="liTitle" Value="Title">Title</asp:ListItem>
											<asp:ListItem class="normalCheckBox" resourcekey="liSubtitle" Value="Subtitle">Subtitle</asp:ListItem>
											<asp:ListItem class="normalCheckBox" resourcekey="liSummary" Value="Summary">Summary</asp:ListItem>
											<asp:ListItem class="normalCheckBox" resourcekey="liImage" Value="Image">Image</asp:ListItem>
										</asp:CheckBoxList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableJournalAddComment.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCommentTojournal.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCommentTojournal.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableJournalAddComment" runat="server" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlOpenDetailsFromUserJurnal.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblUserActivityModule.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblUserActivityModule.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetailsFromUserJurnal" runat="server">
									</asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlOpenDetailsFromGroupJurnal.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGroupActivityModule.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGroupActivityModule.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetailsFromGroupJurnal" runat="server">
									</asp:DropDownList>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblTwitterTopInfo" resourcekey="lblTwitterTopInfo" runat="server" Font-Bold="True" Text="Twitter" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr id="trSetupTwitterApp" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>
									<asp:HyperLink ID="hlToAppiConnection" resourcekey="hlToAppiConnection" runat="server" Target="_blank">To enable Twitter integration please setup Twitter app</asp:HyperLink>
								</td>
							</tr>
							<tr id="trEnableTwitter" runat="server">
								<td class="tdLabel">
									<label for="<%=cbTwitterSocialSharing.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableTwitter.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblEnableTwitter.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbTwitterSocialSharing" runat="server" Enabled="False" Text=" " />
									</div>
								</td>
							</tr>
							<tr id="trEnableTwitterDetails" runat="server">
								<td class="tdLabel">
									<label for="<%=ddlOpenDetailsFromTwitter.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTwitterDetails.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTwitterDetails.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetailsFromTwitter" runat="server"></asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel"></td>
								<td>
									<asp:Label ID="lblConectedToTwitter" runat="server" CssClass="smallInfo error" Text="Module Not conected to Twitter" />
									<br />
									<asp:Label ID="lblConToTwitterError" resourcekey="lblConToTwitterError" runat="server" Text="Error while connecting to Twitter. Please check your Internet connection and your Twitter app consumer key and secret." CssClass="smallInfo error" Visible="False" />
									<br />
									<asp:Button ID="btnOpenTwitterConnectionWizzard" runat="server" resourcekey="btnOpenTwitterConnectionWizzard" OnClick="btnOpenTwitterConnectionWizzard_Click" Text="Open/Close Twitter connection panel" />
								</td>
							</tr>
							<tr id="twitter0" runat="server">
								<td class="tdLabel"></td>
								<td>
									<script type="text/javascript">
										// <![CDATA[
										jQuery(document).ready(function ($) {
											$('#twitterConnectInfoSwitch').click(function () {
												$('#twitterConnectInfo').slideToggle(150);
												return false;
											});
										});
										// ]]>
									</script>
									<a href="#" id="twitterConnectInfoSwitch"><%=ShowhideTwitterconnectinfo%></a>
									<div id="twitterConnectInfo" style="display: none">
										<asp:HyperLink ID="hlVisitDetailInstrictionsTwitter" resourcekey="hlVisitDetailInstrictionsFacebook" runat="server" Font-Bold="True" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/easydnnnews-and-facebook-integration" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink><br />
										<asp:Label ID="lblTwitterSetup" resourcekey="lblTwitterSetup" runat="server" Text="To connect to Twitter you need to:&lt;br/&gt;1.Click on link &quot;Connect module to  Twitter account&quot;. New window will open and you need to login to Twitter and give your Twitter app to connect to your account&lt;br /&gt; 2. Copy the security code that Twitter will provide into field below. &lt;br/&gt3. Click on Connect to Twitter button." />
									</div>
								</td>
							</tr>
							<tr id="twitter1" runat="server">
								<td class="tdLabel"></td>
								<td>1.
									<asp:HyperLink ID="hlSetupTwitter" resourcekey="hlSetupTwitter" runat="server" Target="_blank">Connect module to Twitter account</asp:HyperLink>
								</td>
							</tr>
							<tr id="twitter2" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>2.
									<asp:Label ID="lblEnterTwitterPIN" resourcekey="lblEnterTwitterPIN" runat="server" Text="Enter security code provided by Twitter:" />
									<br />
									<asp:TextBox ID="tbTwitterPinCode" runat="server" ValidationGroup="vgTwitterConnection">
									</asp:TextBox>
									<asp:RequiredFieldValidator ID="rfvTwitterPin" runat="server" ControlToValidate="tbTwitterPinCode" ErrorMessage="Please enter number provided by Twitter." ValidationGroup="vgTwitterConnection">
									</asp:RequiredFieldValidator>
								</td>
							</tr>
							<tr id="twitter3" runat="server">
								<td class="tdLabel"></td>
								<td>
									<asp:HiddenField ID="hfTwitterRequestToken" runat="server" />
									<asp:HiddenField ID="hfTwitterRequestTokenSecret" runat="server" />
									<asp:HiddenField ID="hfTwitterAccessToken" runat="server" />
									<asp:HiddenField ID="hfTwitterAccessSecret" runat="server" />
									<asp:Label ID="lblTwitterMessage" runat="server" />
									<br />
									3.
									<asp:Button ID="btnCheckTwitterPIN" runat="server" resourcekey="btnCheckTwitterPIN" OnClick="btnCheckTwitterPIN_Click" Text="Connect to Twitter" ValidationGroup="vgTwitterConnection" />
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblFacebookTopTitle" resourcekey="lblFacebookTopTitle" runat="server" Text="Facebook" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr id="trFB1" runat="server">
								<td class="tdLabel"></td>
								<td>
									<asp:HyperLink ID="hlToAppiConnectionFB" runat="server" Target="_blank">To enable Facebook integration please setup Facebook app</asp:HyperLink>
								</td>
							</tr>
							<tr id="trFB2" runat="server">
								<td class="tdLabel">
									<label for="<%=cbFaceookSocialSharing.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableFacebook.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableFacebook.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbFaceookSocialSharing" runat="server" Enabled="False" Text=" " />
									</div>
								</td>
							</tr>
							<tr id="trFB2Details" runat="server">
								<td class="tdLabel">
									<label for="<%=ddlOpenDetailsFromFacebook.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenFacebookDetails.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenFacebookDetails.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetailsFromFacebook" runat="server">
									</asp:DropDownList>
								</td>
							</tr>
							<tr id="trFB6" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>
									<asp:Label ID="lblConectedToFacebook" runat="server" CssClass="smallInfo error" Text="Module Not conected to Facebook" />
									<br />
									<asp:Label ID="lblConToFacebookError" resourcekey="lblConToFacebookError" runat="server" CssClass="smallInfo error" Text="Error while connecting to Facebook. Please check your Internet connection and your Facebook app consumer key and secret." Visible="False" />
									<br />
									<asp:Button ID="btnOpenFacebookConnectionPanel" resourcekey="btnOpenFacebookConnectionPanel" runat="server" OnClick="btnOpenFacebookConnectionPanel_Click" Text="Open/Close Facebook connetion panel" />
								</td>
							</tr>
							<tr id="trFB3" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>
									<script type="text/javascript">
										// <![CDATA[
										jQuery(document).ready(function ($) {
											$('#fbConnectInfoSwitch').click(function () {
												$('#fbConnectInfo').slideToggle(150);
												return false;
											});
										});
										// ]]>
									</script>
									<a id="fbConnectInfoSwitch" href="#">
										<%=ShowhideFacebookconnectinfo%></a>
									<div id="fbConnectInfo" style="display: none">
										<asp:HyperLink ID="hlVisitDetailInstrictionsFacebook" resourcekey="hlVisitDetailInstrictionsFacebook" runat="server" Font-Bold="True" NavigateUrl="http://www.easydnnsolutions.com/Blog/TabId/248/ArtMID/790/ArticleID/15/default.aspx" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink><br />
										<asp:Label ID="lblFacebookSetup" runat="server" resourcekey="lblFacebookSetup" Text="To connect to Facebook you need to:&lt;br/&gt;1.Click on link &quot;Connect to Facebook account&quot;. New window will open and you need to login to Facebook and give your Facebbok app to connect to your account&lt;br /&gt; 2. Click on button Connect to Facebook. After connected select from the dropdown list where you will post on Facebook." />
									</div>
								</td>
							</tr>
							<tr id="trFB5" runat="server">
								<td class="tdLabel">
									<label for="<%=ddlFacebookAccounts.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblSelectFBPostTo.Help", true) %>" data-tooltip-position="top-right"><%=_("lblSelectFBPostTo.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlFacebookAccounts" runat="server"></asp:DropDownList>
								</td>
							</tr>
							<tr id="trFB4" runat="server">
								<td class="tdLabel"></td>
								<td>1.
									<asp:HyperLink ID="hlConnectToFacebook" resourcekey="hlConnectToFacebook" runat="server" Target="_blank">Connect to Facebook account</asp:HyperLink>
									<br />
									<asp:Label ID="lblConnectToFBMessage" runat="server" />
									<br />
									2.
									<asp:Button ID="btnConnectToFacebook" runat="server" resourcekey="btnConnectToFacebook" OnClick="btnConnectToFacebook_Click" Text="Connect to Facebook" />
									<asp:HiddenField ID="hfFacebookAccessToken" runat="server" />
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblLinkedInTopTitle" resourcekey="lblLinkedInTopTitle" runat="server" Text="LinkedIn" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr id="trLinkedIn1" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>
									<asp:HyperLink ID="hlLinkedInApiConnection" resourcekey="hlLinkedInApiConnection" runat="server" Target="_blank">To enable LinkedIn integration please setup LinkedIn app</asp:HyperLink>
								</td>
							</tr>
							<tr id="trLinkedIn2" runat="server">
								<td class="tdLabel">
									<label for="<%=cbLinkedInSocialSharing.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableLinkedIn.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableLinkedIn.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbLinkedInSocialSharing" runat="server" Enabled="False" Text=" " />
									</div>
								</td>
							</tr>
							<tr id="trLinkedIn2Details" runat="server">
								<td class="tdLabel">
									<label for="<%=ddlOpenDetailsFromLinkedIn.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenLinkedInDetails.Help", true) %>" data-tooltip-position="top-right"><%=_("lblOpenLinkedInDetails.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenDetailsFromLinkedIn" runat="server"></asp:DropDownList>
								</td>
							</tr>
							<tr id="trLinkedIn6" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>
									<asp:Label ID="lblConectedToLinkedIn" runat="server" CssClass="smallInfo error" Text="Module Not conected to LinkedIn" />
									<br />
									<asp:Label ID="lblConToLinkedInError" runat="server" CssClass="smallInfo error" Text="Error while connecting to LinkedIn. Please check your Internet connection and your LinkedIn app consumer key and secret." Visible="False" />
									<br />
									<div class="mainActions smallActions noMargin displayInline">
										<asp:Button ID="btnOpenLinkedInConnectionPanel" CssClass="primaryAction" ResourceKey="btnOpenLinkedInConnectionPanel" runat="server" Text="Open/Close LinkedIn connetion panel" OnClick="btnOpenLinkedInConnectionPanel_Click" />
									</div>
								</td>
							</tr>
							<tr id="trLinkedIn3" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>
									<script type="text/javascript">
										// <![CDATA[
										jQuery(document).ready(function ($) {
											$('#linkedInConnectInfoSwitch').click(function () {
												$('#linkedInConnectInfo').slideToggle(150);
												return false;
											});
										});
										// ]]>
									</script>
									<a id="linkedInConnectInfoSwitch" href="#">
										<%=ShowhideLinkedInconnectinfo %></a>
									<div id="linkedInConnectInfo" style="display: none">
										<asp:HyperLink ID="hlVisitDetailInstrictionsLinkedIn" runat="server" Font-Bold="True" NavigateUrl="http://help.easydnnsolutions.com/user-manuals/easydnnnews/category/integrations/how-to-setup-auto-posting-to-linkedin" Target="_blank">For more detail instructions please visit this link.</asp:HyperLink><br />
										<asp:Label ID="lblLinkedInSetup" resourcekey="lblLinkedInSetup" runat="server" Text="To connect to LinkedIn you need to:&lt;br/&gt;1.Click on link &quot;Connect to LinkedIn account&quot;. New window will open and you need to login to LinkedIn and give your LinkedIn app permission to connect to your account&lt;br /&gt; 2. Click on button Connect to LinkedIn. After connected select from the dropdown list where you will post on LinkedIn." />
									</div>
								</td>
							</tr>
							<tr id="trLinkedIn5" runat="server">
								<td class="tdLabel">
									<label for="<%=ddlLinkedInAccounts.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblLinkedInWhereToPost.Help", true) %>" data-tooltip-position="top-right"><%=_("lblLinkedInWhereToPost.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlLinkedInAccounts" runat="server"></asp:DropDownList>
								</td>
							</tr>
							<tr id="trLinkedIn4" runat="server">
								<td class="tdLabel">&nbsp;
								</td>
								<td>1.
									<asp:HyperLink ID="hlConnectToLinkedIn" ResourceKey="hlConnectToLinkedIn" runat="server" Target="_blank">Connect to LinkedIn account</asp:HyperLink>
									<br />
									<asp:Label ID="lblConnectToLinkedInMessage" runat="server" />
									<br />
									2.
									<asp:Button ID="btnConnectToLinkedIn" runat="server" Text="Connect to LinkedIn" OnClick="btnConnectToLinkedIn_Click" />
									<asp:HiddenField ID="hfLinkedInAccessToken" runat="server" />
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlCustomFieldSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfCustomFields" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblCustomFieldSettings" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblCustomFieldSettings_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">19</span>
						<h2><%=locCustomFieldsHeader%></h2>
					</div>
					<asp:Panel ID="pnlCustomFieldSettings" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=rblCFUserSelectionType.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCFUserSelectionType.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCFUserSelectionType.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputGroup displayInline">
										<asp:RadioButtonList ID="rblCFUserSelectionType" runat="server" CssClass="styledRadio smallRadio verticalList" RepeatLayout="UnorderedList">
											<asp:ListItem class="normalRadioButton" Value="0" resourcekey="liCFUserSelectionType0" Text="Author can enable custom fields within an article" Selected="True" />
											<asp:ListItem class="normalRadioButton" Value="1" resourcekey="liCFUserSelectionType1" Text="Author can disable custom fields within an article" />
											<asp:ListItem class="normalRadioButton" Value="2" resourcekey="liCFUserSelectionType2" Text="Author can't disable custom fields within an article" />
										</asp:RadioButtonList>
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlCFSelectedGroup.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCFSelectedGroup.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCFSelectedGroup.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlCFSelectedGroup" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbCFEnableGroupSelection.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCFEnableGroupSelection.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCFEnableGroupSelection.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbCFEnableGroupSelection" runat="server" Checked="true" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbCFShowOnlyFilledItems.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCFShowOnlyFilledItems.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCFShowOnlyFilledItems.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbCFShowOnlyFilledItems" runat="server" Checked="false" Text=" " />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlCanonicalURLsSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfCanonicalURLs" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblCanonicalURLsSettings" runat="server" AutoPostBack="true" OnSelectedIndexChanged="rblCanonicalURLsSettings_SelectedIndexChanged" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">20</span>
						<h2><%=_("CanonicalURLsSettings.Text")%></h2>
					</div>
					<asp:Panel ID="pnlCanonicalURLsSettings" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableCanonicalLink.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCanonicalURLs.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCanonicalURLs.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableCanonicalLink" runat="server" Enabled="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlCanonicalLinksNewsInstance.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCanonicalLinksNews.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCanonicalLinksNews.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlCanonicalLinksNewsInstance" runat="server"></asp:DropDownList>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbCreateAMPArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCreateAMPArticles.Help", true) %>" data-tooltip-position="top-right"><%=_("lblCreateAMPArticles.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbCreateAMPArticles" runat="server" Enabled="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlAMPArticleTheme.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAMPArticleTheme.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAMPArticleTheme.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlAMPArticleTheme" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlAMPArticleTheme_SelectedIndexChanged" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlAMPArticleTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAMPArticleTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAMPArticleTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlAMPArticleTemplate" runat="server" />
									<asp:CustomValidator ID="cvddlAMPArticleTemplate" runat="server" ClientValidationFunction="AMPArticleTemplateValidation" Display="Dynamic" ErrorMessage="Please select template." ValidationGroup="vgSettings"></asp:CustomValidator>
									<asp:Label ID="lblAMPArticleTemplateError" ResourceKey="lblAMPArticleTemplateError" runat="server" CssClass="smallInfo error" Text="You must select template to enable AMP articles." Visible="false" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=btnDeleteCreatedAMPArticles.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblDeleteCreatedAMPArticles.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblDeleteCreatedAMPArticles.Text") %></label>
								</td>
								<td>
									<div class="mainActions smallActions displayInline noMargin">
										<asp:Button ID="btnDeleteCreatedAMPArticles" resourcekey="btnDeleteCreatedAMPArticles" runat="server" Text="Delete" CssClass="delete" OnClick="btnDeleteCreatedAMPArticles_Click" />
									</div>
									<label runat="server" id="lblDeleteCreatedAMPPagesMessages" enableviewstate="false"></label>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlMetaAndStructuredDataSettingsSource" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfMetaAndStructuredDatas" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<asp:RadioButtonList ID="rblMetaAndStructuredDataSettings" runat="server" AutoPostBack="true" CssClass="inlineList styledRadio" RepeatLayout="UnorderedList" OnSelectedIndexChanged="rblMetaAndStructuredDataSettings_SelectedIndexChanged">
								<asp:ListItem class="normalRadioButton" Value="Portal" Selected="True" resourcekey="liDefaultSettings" Text="Default settings" />
								<asp:ListItem class="normalRadioButton" Value="Instance" resourcekey="liModuleSettings" Text="Module instance (override default)" />
							</asp:RadioButtonList>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">21</span>
						<h2><%=_("MetaAndStructuredDataSettingsHeader.Text", true) %></h2>
					</div>
					<asp:Panel ID="pnlMetaAndStructuredDataSettings" runat="server" CssClass="category_content">
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblOpenGraphTitle" resourcekey="lblOpenGraphTitle" runat="server" Text="Open Graph" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableOpenGraph.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableOpenGraph.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableOpenGraph.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableOpenGraph" runat="server" Enabled="True" Text=" " Checked="True" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlOpenGraphTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblOpenGraphTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblOpenGraphTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlOpenGraphTemplate" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableOpenGraphTemplateSelection.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableOpenGraphTemplateSelection.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableOpenGraphTemplateSelection.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableOpenGraphTemplateSelection" runat="server" Enabled="True" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblTwitterCardsTitle" resourcekey="lblTwitterCardsTitle" runat="server" Text="Twitter Cards" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableTwitterCards.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableTwitterCards.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableTwitterCards.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableTwitterCards" runat="server" Enabled="True" Text=" " Checked="True" />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlTwitterCardsTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblTwitterCardsTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblTwitterCardsTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlTwitterCardsTemplate" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableTwitterCardsTemplateSelection.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableTwitterCardsTemplateSelection.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableTwitterCardsTemplateSelection.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableTwitterCardsTemplateSelection" runat="server" Enabled="True" Text=" " />
									</div>
								</td>
							</tr>
						</table>
						<div class="sectionBoxSubtitle highlighted3">
							<asp:Label ID="lblStructuredDataTitle" resourcekey="lblStructuredDataTitle" runat="server" Text="Structured Data" />
						</div>
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableStructuredData.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableStructuredData.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableStructuredData.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableStructuredData" runat="server" Enabled="True" Text=" " />
									</div>
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=ddlStructuredDataTemplate.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblStructuredDataTemplate.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblStructuredDataTemplate.Text") %></label>
								</td>
								<td>
									<asp:DropDownList ID="ddlStructuredDataTemplate" runat="server" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel">
									<label for="<%=cbEnableStructuredDataTemplateSelection.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblEnableStructuredDataTemplateSelection.Help", true) %>" data-tooltip-position="top-right"><%=_("lblEnableStructuredDataTemplateSelection.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbEnableStructuredDataTemplateSelection" runat="server" Enabled="True" Text=" " />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlSeoURLSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfSeoURLSettingsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<label id="lblSeoUrlPortalOnly" runat="server"><%=_("lblSeoUrlPortalOnlyResource1.Text") %></label>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">22</span>
						<h2><%=_("SEOURLsettings.Text")%></h2>
					</div>
					<asp:Panel ID="pnlSeoURLSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=gvCharList.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblCharaterReplace.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblCharaterReplace.Text") %></label>
								</td>
								<td>
									<asp:GridView ID="gvCharList" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" CssClass="strippedTable tablePadding5" DataKeyNames="ItemID" DataSourceID="odsGetCharList" EnableModelValidation="True" resourcekey="gvCharListResource1">
										<Columns>
											<asp:CommandField ShowDeleteButton="True" />
											<asp:BoundField DataField="OriginalChar" HeaderText="Old character" SortExpression="OriginalChar">
												<ItemStyle CssClass="textCenter" />
											</asp:BoundField>
											<asp:BoundField DataField="NewChar" HeaderText="New character" SortExpression="NewChar">
												<ItemStyle CssClass="textCenter" />
											</asp:BoundField>
										</Columns>
										<HeaderStyle CssClass="tableHeader" />
										<PagerStyle CssClass="contentPagination" />
									</asp:GridView>
								</td>
							</tr>
							<tr>
								<td class="tdLabel textTop">
									<label for="<%=tbOldCharacter.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblAddCharacter.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblAddCharacter.Text") %></label>
								</td>
								<td>
									<div class="edNews_inputgroup">
										<asp:Label ID="lblOldCharacter" runat="server" Text="Old character:" resourcekey="lblOldCharacter0Resource1" />
										<asp:TextBox ID="tbOldCharacter" runat="server" MaxLength="3" ValidationGroup="vgAddCharacter" CssClass="smallCentered" />
										<asp:Label ID="lblNewCharacter" runat="server" Text="New character:" resourcekey="lblNewCharacter0Resource1" />
										<asp:TextBox ID="tbNewCharacter" runat="server" MaxLength="3" ValidationGroup="vgAddCharacter" CssClass="smallCentered" />
										<div class="mainActions smallActions displayInline noMargin">
											<asp:Button CssClass="add" ID="btnAddCharacter" runat="server" OnClick="btnAddCharacter_Click" Text="Add" ValidationGroup="vgAddCharacter" resourcekey="btnAddCharacterResource1" />
										</div>
										<asp:RequiredFieldValidator ID="rfvACOld" runat="server" ControlToValidate="tbOldCharacter" ErrorMessage="This field is required." ValidationGroup="vgAddCharacter" resourcekey="rfvACOld0Resource1" />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
				<asp:Panel ID="pnlGoogleMapsSettings" runat="server" CssClass="settings_category_container edNews_numberedOptions">
					<asp:HiddenField ID="hfGoogleMapsSettingsState" runat="server" Value="edNews__collapsed" />
					<div class="category_toggle edNews_numberedOptionsHeader">
						<div class="edNews_inputGroup displayInline">
							<label id="lblGoogleMapsPortalOnly" runat="server"><%=_("lblGoogleMapsPortalOnlyResource1.Text") %></label>
						</div>
						<span class="edNews_numberedOptionsHeaderNumber">23</span>
						<h2><%=_("Googlemapssettings.Text")%></h2>
					</div>
					<asp:Panel ID="pnlGoogleMapsSettingsSourceTable" runat="server" CssClass="category_content">
						<table class="optionsList fullWidthTable strippedTable noBorder">
							<tr>
								<td class="tdLabel">
									<label for="<%=tbGoogleMapsApiKey.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblGOogleAPIKey.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblGOogleAPIKey.Text") %></label>
								</td>
								<td>
									<asp:TextBox ID="tbGoogleMapsApiKey" runat="server" Width="350px" />
								</td>
							</tr>
							<tr>
								<td class="tdLabel width50">
									<label for="<%=cbMapsUserLocationRequest.ClientID %>" class="edNews_tooltip" data-tooltip-content="<%=_("lblMapsUserLocationRequest.HelpText", true) %>" data-tooltip-position="top-right"><%=_("lblMapsUserLocationRequest.Text") %></label>
								</td>
								<td>
									<div class="switchCheckbox">
										<asp:CheckBox CssClass="normalCheckBox" ID="cbMapsUserLocationRequest" runat="server" Checked="True" Text=" " />
									</div>
								</td>
							</tr>
						</table>
					</asp:Panel>
				</asp:Panel>
			</div>
			<!--end Of sectionBox-->
			<div class="mainActions">
				<p>
					<asp:Label ID="lblSaveSettings" runat="server" EnableViewState="false" />
				</p>
				<p>
					<asp:CustomValidator ID="cvCategoriesTreeview" runat="server" ClientValidationFunction="CategoryClientValidate" Display="Dynamic" Enabled="False" ErrorMessage="Please select at least one category." ValidationGroup="vgSettings"></asp:CustomValidator>
				</p>
				<asp:LinkButton ID="btnSaveSettings" CssClass="downSave" runat="server" OnClick="btnSaveSettings_Click" Text="Save settings" ValidationGroup="vgSettings" resourcekey="btnSaveSettingsResource1" />
				<asp:LinkButton ID="btnSaveClose" CssClass="downSaveClose" runat="server" OnClick="btnSaveClose_Click" Text="Save &amp; Close" ValidationGroup="vgSettings" resourcekey="btnSaveCloseResource1" />
				<asp:LinkButton ID="btnCancel" CssClass="downClose" runat="server" OnClick="btnCancel_Click" Text="Close" UseSubmitBehavior="False" resourcekey="btnCancelResource1" />
			</div>
		</asp:Panel>
	</div>
</div>
<asp:ObjectDataSource ID="odsGetCharList" TypeName="EasyDNNSolutions.Modules.EasyDNNNews.DataAccess" runat="server" DeleteMethod="DeleteCharFromList" SelectMethod="GetCharsFromListForODS">
	<DeleteParameters>
		<asp:Parameter Name="ItemID" Type="Int32" />
	</DeleteParameters>
	<SelectParameters>
		<asp:Parameter Name="PortalID" Type="Int32" />
	</SelectParameters>
</asp:ObjectDataSource>
