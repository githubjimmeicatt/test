(function ($, window, document) {
	var pluginName = 'chameleonSlider_1_7';

	$.fn[pluginName] = function (options) {
		var defaults = {
				content_source: '',
				container_dimensions: {
					width: 750,
					height: 400,
					w_as_ratio: false,
					h_as_ratio: false,
					height_references_width: false
				},
				autoplay: {
					enable: true,
					interval: 4000,
					pause_on_hover: true,
					autostart_video_playback: false,
					indicator: {
						display: true,
						position: {
							vertical: 'top',
							horizontal: 'left',
							h_offset: 0,
							v_offset: 0,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						},
						dimensions: {
							height: 2,
							width: 750,
							h_as_ratio: false,
							w_as_ratio: false
						},
						orientation: 'horizontal',
						flip_direction: false
					}
				},
				arrows: {
					display: true,
					auto_hide: true,
					hide_speed: 250,
					prev: {
						position: {
							vertical: 'top',
							horizontal: 'left',
							h_offset: 0,
							v_offset: 183,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					},
					next: {
						position: {
							vertical: 'top',
							horizontal: 'right',
							h_offset: 0,
							v_offset: 183,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					}
				},
				autoplay_toggle: {
					display: true,
					auto_hide: true,
					hide_speed: 250,
					position: {
						vertical: 'top',
						horizontal: 'left',
						h_offset: 347,
						v_offset: 130,
						h_as_ratio: false,
						v_as_ratio: false,
						v_center_point: false,
						h_center_point: false
					}
				},
				scrollable_boxes: {
					item_info: {
						display: true,
						container: {
							dimensions: {
								height: 100,
								width: 750,
								h_as_ratio: false,
								w_as_ratio: false
							},
							resize_to_content: true,
							show_on_hover: false,
							position: {
								vertical: 'top',
								horizontal: 'left',
								h_offset: 0,
								v_offset: 2,
								h_as_ratio: false,
								v_as_ratio: false,
								v_center_point: false,
								h_center_point: false
							}
						}
					},
					gallery_info: {
						display: false,
						container: {
							dimensions: {
								height: 100,
								width: 750,
								h_as_ratio: false,
								w_as_ratio: false
							},
							resize_to_content: true,
							show_on_hover: false,
							position: {
								vertical: 'top',
								horizontal: 'left',
								h_offset: 0,
								v_offset: 2,
								h_as_ratio: false,
								v_as_ratio: false,
								v_center_point: false,
								h_center_point: false
							}
						}
					}
				},
				thumbs: {
					display: true,
					auto_hide: false,
					hide_speed: 250,
					width: 100,
					height: 46,
					captions: true,
					display_item_types: false,
					pagination: {
						direction: 'horizontal',
						duration: 250,
						easing: 'swing'
					},
					tooltips: {
						enabled: false,
						title: true,
						description: false,
						position: {
							my: 'bottom center',
							at: 'top center'
						},
						classes: ''
					},
					container: {
						transparent: true,
						dimensions: {
							height: 20,
							width: 679,
							h_as_ratio: false,
							w_as_ratio: false
						},
						position: {
							vertical: 'bottom',
							horizontal: 'left',
							h_offset: 35,
							v_offset: 0,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					}
				},
				categories: {
					display: false,
					auto_hide: false,
					hide_speed: 250,
					width: 100,
					height: 46,
					pagination: {
						direction: 'horizontal',
						duration: 250,
						easing: 'swing'
					},
					container: {
						dimensions: {
							height: 20,
							width: 679,
							h_as_ratio: false,
							w_as_ratio: false
						},
						position: {
							vertical: 'bottom',
							horizontal: 'left',
							h_offset: 35,
							v_offset: 0,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					}
				},
				pagination: {
					display: true,
					pages_at_once: 7,
					direction: 'horizontal',
					position: {
						vertical: 'bottom',
						horizontal: 'right',
						h_offset: 35,
						v_offset: 58,
						h_as_ratio: false,
						v_as_ratio: false,
						v_center_point: false,
						h_center_point: false
					}
				},
				title_boxes: {
					current_item: {
						display: false,
						height: 35,
						position: {
							vertical: 'bottom',
							horizontal: 'left',
							h_offset: 0,
							v_offset: 200,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					},
					current_gallery: {
						display: false,
						height: 35,
						position: {
							vertical: 'top',
							horizontal: 'left',
							h_offset: 0,
							v_offset: 0,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					}
				},
				buttons: {
					email: {
						display: false,
						position: {
							vertical: 'top',
							horizontal: 'right',
							h_offset: 35,
							v_offset: 58,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						},
						email_subject: 'Look at this link'
					},
					download: {
						display: false,
						position: {
							vertical: 'top',
							horizontal: 'left',
							h_offset: 35,
							v_offset: 58,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					},
					fullscreen: {
						display: false,
						position: {
							vertical: 'top',
							horizontal: 'left',
							h_offset: 35,
							v_offset: 58,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					},
					exit_fullscreen: {
						display: false,
						position: {
							vertical: 'bottom',
							horizontal: 'right',
							h_offset: 35,
							v_offset: 58,
							h_as_ratio: false,
							v_as_ratio: false,
							v_center_point: false,
							h_center_point: false
						}
					}
				},
				social_buttons: {
					display: false,
					direction: 'horizontal',
					load_after_effect: true,
					position: {
						vertical: 'bottom',
						horizontal: 'right',
						h_offset: 35,
						v_offset: 58,
						h_as_ratio: false,
						v_as_ratio: false,
						v_center_point: false,
						h_center_point: false
					},
					buttons: {
						facebook: {
							display: true,
							html: '<iframe src="//www.facebook.com/plugins/like.php?href={location_href_encoded}&amp;layout=button_count&amp;show_faces=true&amp;action=like&amp;font&amp;colorscheme=light&amp;height=20" scrolling="no" frameborder="0" style="border:none; overflow:hidden; height:20px; width: 100px;" allowTransparency="true"></iframe>'
						},
						google: {
							display: true,
							html: '<g:plusone size="medium" href="{location_href}" annotation="bubble"></g:plusone><script type="text/javascript">gapi.plusone.go();</' + 'script>'
						},
						twitter: {
							display: true,
							html: '<a href="//twitter.com/share" class="twitter-share-button" data-url="{location_href}" data-count="horizontal">Tweet</a><script type="text/javascript" src="//platform.twitter.com/widgets.js"></' + 'script>'
						}
					},
					hideable: false,
					container: {
						width: 100,
						height: 100
					}
				},
				main_panel: {
					display: true,
					fill_panel: false,
					stretch_small_image: false,
					top_left_align: false,
					drag_navigation: false,
					dimensions: {
						width: 750,
						height: 400,
						h_as_ratio: false,
						w_as_ratio: false
					},
					position: {
						vertical: 'top',
						horizontal: 'left',
						h_offset: 0,
						v_offset: 0,
						h_as_ratio: false,
						v_as_ratio: false,
						v_center_point: false,
						h_center_point: false
					},
					trim: {
						top: 0,
						bottom: 0,
						left: 0,
						right: 0
					},
					transition: {
						duration: 800,
						effects: []
					}
				},
				lightbox_title: false,
				lightbox_description: false,
				key_browse: true,
				redirect_on_click: false,
				redirect_on_click_target: '_self',
				lightbox_on_click: false,
				module_id: 0,
				portal_id: 0,
				article_id: 0,
				filter_values: '',
				filter_types: '',
				locale: '',
				inhouse_player: 'flowplayer',
				flowplayer_src: '',
				fullscreen_provider: 'pp',
				pretty_photo_options: {},
				smb_options: {},
				smbLight_options: {},
				cycle_current_category: true,
				open_at: null,
				modify_browser_history: false
			},
			option = $.extend(true, {}, defaults, options),

			location = window.history.location || window.location;

		return this.each(function () {
			var $t = $(this),
				$slider_container,

				slider_resize_interval,

				ajax = {
					trys: 0
				},
				$loading_overlay = $('<div class="loading_slider_overlay" />'),
				$loading_indicator = $('<div class="indicator" />'),
				$loading_msg = $('<p />'),

				slider_content,
				all_items_count = 0,
				selected_categories,
				current = {
					category: {},
					item: {}
				},

				previous_item_index = 0,

				item_panels = {},

				$main_panel,
				$main_panel_items_wrapper,
				$main_panel_media_link = $(),
				$lightbox_links_container,
				$lightbox_links,

				$pagination,
				$pagination_pages_container,
				$pagination_pages,

				$social_buttons,
				$social_buttons_toggle,

				$autoplay_indicator,
				$autoplay_container,
				$autoplay_toggle,

				autoplay = {
					interval: '',
					last_started: 0,
					pause_time: 0,
					start_pause_delta: 0,
					time_remaining: 0,
					pause: false,
					user_paused: false,
					fade_in: false,
					reset: false,
					transition_in_progres: false,
					video_playing: false
				},

				$navigation_prev,
				$navigation_next,

				rendering = {
					container_dimensions: {},
					thumbs: {
						page: {
							vertical_space: 0,
							horizontal_space: 0,
							width: 0,
							height: 0,
							count: 0
						},
						container: {},
						width: 0,
						height: 0,
						per_page: 0,
						per_row: 0,
						row_count: 0,
						window_width: 0,
						window_height: 0
					},
					categories: {
						page: {
							vertical_space: 0,
							horizontal_space: 0,
							width: 0,
							height: 0,
							count: 0
						},
						container: {},
						width: 0,
						height: 0,
						per_page: 0,
						per_row: 0,
						row_count: 0,
						window_width: 0,
						window_height: 0,
						render_categories: true
					},
					autoplay: {
						indicator: {}
					},
					title_boxes: {
						current_item: {},
						current_gallery: {}
					},
					scrollable_boxes: {
						item_info: {},
						gallery_info: {}
					},
					pagination: {
						pages_at_once: 0,
						page: {
							width: 0,
							height: 0
						}
					},
					main_panel: {
						dimensions: {},
						initialized: false,
						disable_clicking: false,
						disable_clicking_interval: ''
					},
					preloaded_images: {},
					preloading_item: false,
					buttons: {
						email: {},
						download: {},
						fullscreen: {},
						exit_fullscreen: {}
					},
					html5: {
						video: false
					},
					youtube_iframe_api: {
						called: false,
						loaded: false
					},
					youtube_player_object: undefined,
					ios: false,
					mouse_entered: false
				},

			slider = {
				init: function () {
					var video_elem = document.createElement('video');

					if (option.container_dimensions.w_as_ratio || option.container_dimensions.h_as_ratio) {
						$slider_container = $t.parent();

						rendering.container_dimensions = {
							width: option.container_dimensions.w_as_ratio ? Math.round($slider_container.width() * option.container_dimensions.width) : option.container_dimensions.width,
							height: 0
						};
						rendering.container_dimensions.height = option.container_dimensions.h_as_ratio
							? Math.round(
								(option.container_dimensions.height_references_width
									? rendering.container_dimensions.width
									: $slider_container.height()
								) * option.container_dimensions.height
							)
							: option.container_dimensions.height;

						$(window).bind('resize.chameleonSlider', function () {
							clearTimeout(slider_resize_interval);
							slider_resize_interval = setTimeout(function () {
								rendering.container_dimensions = {
									width: option.container_dimensions.w_as_ratio ? Math.round($slider_container.width() * option.container_dimensions.width) : option.container_dimensions.width,
									height: 0
								};
								rendering.container_dimensions.height = option.container_dimensions.h_as_ratio
									? Math.round(
										(option.container_dimensions.height_references_width
											? rendering.container_dimensions.width
											: $slider_container.height()
										) * option.container_dimensions.height
									)
									: option.container_dimensions.height;

								$t.trigger('resize_slider');
							}, 200);
						});
					} else
						rendering.container_dimensions = {
							width: option.container_dimensions.width,
							height: option.container_dimensions.height
						};

					$t
						.width(rendering.container_dimensions.width)
						.height(rendering.container_dimensions.height)
						.append($loading_overlay)
						.bind('destroy', function () {
							clearTimeout(autoplay.interval);
						});

					$loading_overlay
						.width(rendering.container_dimensions.width)
						.height(rendering.container_dimensions.height)
						.append($loading_indicator)
						.show(0);

					try {
						rendering.html5.video = !!video_elem.canPlayType;
					} catch(e) {}

					if ((navigator.userAgent.match(/iPhone/i)) || (navigator.userAgent.match(/iPod/i)) || (navigator.userAgent.match(/iPad/i)))
						rendering.ios = true

					if (option.modify_browser_history)
						$(window).on('popstate', function(e) {
							slider.parse_slider_url_hash(location.hash);
							slider.show_item(current.item.index, true, undefined, true);
						});

					slider.get_content_source();
				},

				get_content_source: function () {
					if (ajax.trys > 3) {
						if ($loading_msg.is(':visible')) {
							$loading_msg.html('Unable to display the items (requesting the items failed)');
						} else {
							$loading_indicator.fadeOut(250, function () {
								$loading_msg = $('<p>Unable to display the items (requesting the items failed)</p>');
								$loading_msg
									.appendTo($loading_overlay)
									.css({
										display: 'block',
										top: Math.floor((rendering.container_dimensions.height - $loading_msg.outerHeight(true)) / 2)
									});
							});
						}

						return;
					}

					ajax.trys += 1;

					$.ajax({
						dataType: 'json',
						type: 'get',
						url: option.content_source,
						timeout: 15000,
						data: 'mid=' + option.module_id + '&portal_id=' + option.portal_id + '&locale=' + option.locale + '&article_id=' + option.article_id + '&html5_player=' + (rendering.html5.video && rendering.ios ? '1' : '0') + (option.filter_values === '' ? '' : '&filter_values=' + option.filter_values + '&filter_types=' + option.filter_types),
						success: slider.load,
						complete: slider.ajax_callback,
						cache: false
					});
				},

				ajax_callback: function (xhr, status) {
					if (status !== 'success') {
						slider.get_content_source();
					}
				},

				parse_slider_url_hash: function (hash) {
					var url_hash = hash.substring(1),
						first_slash_position = url_hash.indexOf('/'),
						categories_to_open,
						item_to_open = undefined;

					categories_to_open = url_hash.substring(first_slash_position + 1);

					first_slash_position = categories_to_open.indexOf('/');

					if (first_slash_position !== -1) {
						item_to_open = categories_to_open.substring(first_slash_position + 1);
						first_slash_position = item_to_open.indexOf('/');

						if (first_slash_position !== -1)
							item_to_open = item_to_open.substring(0, first_slash_position);

						if (!item_to_open) {
							item_to_open = undefined;
						}

						categories_to_open = categories_to_open.substring(0, categories_to_open.indexOf('/'));
					}

					selected_categories = {
						ids: categories_to_open.split('-'),
						indexes: []
					};

					selected_categories.indexes = slider.category_indexes_from_ids($.extend([], selected_categories.ids), slider_content);
					if (selected_categories.indexes.length == 0) {
						selected_categories.indexes = [0];
						selected_categories.ids = [slider_content[0].id];
					}

					current.category = slider.get_category(selected_categories.indexes);
					current.category.item_count = current.category.items.length;

					current.item = {
						id: 0,
						index: slider.item_index_from_id(item_to_open)
					};

					current.item.id = current.category.items[current.item.index].id;
				},

				load: function(data) {
					var url_hash = location.hash.substring(1),
						first_slash_position = url_hash.indexOf('/'),
						hashStart = first_slash_position == -1 ? '' : url_hash.substring(0, first_slash_position);

					if (data.content.length == 0) {
						$loading_indicator.fadeOut(250, function () {
							$loading_msg = $('<p>' + (data.user_friendly_msg ? data.user_friendly_msg : 'There are no items to display.') + '</p>');
							$loading_msg
								.appendTo($loading_overlay)
								.css({
									display: 'block',
									top: Math.floor((rendering.container_dimensions.height - $loading_msg.outerHeight(true)) / 2)
								});
						});

						return;
					}

					slider_content = data.content;

					if (option.open_at != null) {
						selected_categories = {
							ids: option.open_at.categories,
							indexes: []
						};

						selected_categories.indexes = slider.category_indexes_from_ids($.extend([], selected_categories.ids), slider_content);
						if (selected_categories.indexes.length == 0) {
							selected_categories.indexes = [0];
							selected_categories.ids = [slider_content[0].id];
						}

						current.category = slider.get_category(selected_categories.indexes);
						current.category.item_count = current.category.items.length;

						current.item = {
							id: 0,
							index: slider.item_index_from_id(option.open_at.item)
						};

						current.item.id = current.category.items[current.item.index].id;
					} else if (hashStart == 'slider_' + option.module_id || hashStart == 'gallery_' + option.module_id) {
						slider.parse_slider_url_hash('#' + url_hash);

						if (
							option.fullscreen_provider == 'smb'
							&& hashStart == 'gallery_' + option.module_id
							&& current.category.item_count > 0
						) {
							(function () {
								var smb_items = [];

								option.smb_options.openAt = 0;

								$.each(current.category.items, function (i, item) {
									if (item.id === current.item.id) {
										option.smb_options.openAt = i;
									}

									smb_items.push(item.smb_object);
								});

								$('<div />')
									.data('socialMediaBox', smb_items)
									.socialMediaBox(option.smb_options);
							})();
						}
					} else {
						selected_categories = {
							ids: [slider_content[0].id],
							indexes: [0]
						};

						current.category = slider_content[0];
						current.category.item_count = current.category.items.length;

						current.item = {
							id: undefined,
							index: slider.item_index_from_id(undefined)
						};
					}

					if ('YT' in window && 'Player' in window.YT) {
						rendering.youtube_iframe_api.called = true;
						rendering.youtube_iframe_api.loaded = true;
					}

					if (option.buttons.exit_fullscreen.display)
						slider.exit_fullscreen.init();

					if (option.autoplay.enable)
						slider.autoplay.init();

					if (option.pagination.display)
						slider.pagination.init();

					if (option.social_buttons.display)
						slider.social_buttons.init();

					if (option.buttons.email.display)
						slider.email_button.init();

					if (option.buttons.download.display)
						slider.download_button.init();

					if (option.buttons.fullscreen.display)
						slider.fullscreen_button.init();

					if (option.autoplay_toggle.display)
						slider.autoplay_toggle.init();

					if (option.arrows.display)
						slider.arrows.init();

					if (option.categories.display)
						slider.categories.init();

					if (option.thumbs.display)
						slider.thumbnails.init();

					if (option.title_boxes.current_item.display)
						slider.item_title.init();

					if (option.title_boxes.current_gallery.display)
						slider.gallery_title.init();

					if (option.scrollable_boxes.item_info.display)
						slider.item_info.init();

					if (option.scrollable_boxes.gallery_info.display)
						slider.gallery_info.init();

					if (option.main_panel.display)
						slider.main_panel.init();
					else
						slider.triggers();
				},

				show_item: function (index, force, transition, noPushState) {
					var hash_location,
						newHref;

					index = parseInt(index, 10);

					force = typeof force == 'undefined' ? false : true;

					if (index === current.item.index && !force)
						return;

					if (typeof slider._on_pre_item_change == 'function') {
						slider._on_pre_item_change();
						slider._on_pre_item_change = undefined;
					}

					autoplay.video_playing = false;

					if (index < 0) {
						index = current.category.item_count - 1;
					} else if (index >= current.category.item_count) {
						index = 0;
					}

					slider.autoplay.reset();

					previous_item_index = current.item.index;

					current.item.index = index;
					current.item.id = current.category.items[index].id;

					slider.pagination.select(index);
					slider.social_buttons.display(index);
					slider.thumbnails.select(index);
					slider.item_title.select(index);
					slider.item_info.display(index);
					slider.download_button.display(index);
					slider.email_button.display(index);

					if (option.modify_browser_history && !noPushState) {
						hash_location = location.href.indexOf('#');

						if (hash_location == -1)
							newHref = location.href
						else
							newHref = location.href.substring(0, hash_location);

						newHref += '#slider_' + option.module_id + '/' + selected_categories.ids.join('-') + '/' + current.item.id;

						history.pushState(null, null, newHref);
					}

					if (option.main_panel.display) {
						if (!rendering.preloading_item)
							if (typeof transition == 'undefined')
								slider.main_panel.display(index);
							else
								slider.main_panel.display(index, transition);
					} else
						$t.trigger('slider_transition_finnished');
				},

				next: function () {
					var next_cat_index,
						num_of_categories = slider_content.length;

					if (!option.cycle_current_category && current.item.index == current.category.item_count - 1) {
						next_cat_index = selected_categories.indexes.pop() + 1;

						if (selected_categories.indexes.length != 0)
							num_of_categories = slider.get_category(selected_categories.indexes).children.length;

						if (next_cat_index < num_of_categories)
							selected_categories.indexes.push(next_cat_index);
						else
							selected_categories.indexes.push(0);

						selected_categories.ids = slider.category_ids_from_indexes(selected_categories.indexes);

						current.category = slider.get_category(selected_categories.indexes);
						current.category.item_count = current.category.items.length;

						current.item = {
							id: current.category.items[0].id,
							index: 0
						};

						rendering.categories.render_categories = false;

						slider.change_category();

						return;
					}

					slider.show_item(current.item.index + 1);
				},

				prev: function () {
					var prev_cat_index,
						num_of_categories = slider_content.length;

					if (!option.cycle_current_category && current.item.index == 0) {
						prev_cat_index = selected_categories.indexes.pop() - 1;

						if (selected_categories.indexes.length != 0)
							num_of_categories = slider.get_category(selected_categories.indexes).children.length;

						if (prev_cat_index < 0)
							selected_categories.indexes.push(num_of_categories - 1);
						else
							selected_categories.indexes.push(prev_cat_index);

						selected_categories.ids = slider.category_ids_from_indexes(selected_categories.indexes);

						current.category = slider.get_category(selected_categories.indexes);
						current.category.item_count = current.category.items.length;

						current.item = {
							id: current.category.items[current.category.items.length - 1].id,
							index: current.category.items.length - 1
						};

						rendering.categories.render_categories = false;

						slider.change_category();

						return;
					}

					slider.show_item(current.item.index - 1);
				},

				pagination: {
					init: function () {
						var $page;

						$pagination = $('<div class="pagination" />');
						$pagination_pages_container = $('<ul class="pages_container" />');

						$pagination.append($pagination_pages_container);

						$pagination.css('visibility', 'hidden');

						$t.prepend($pagination);

						slider.position_element($pagination, option.pagination.position);

						$page = $('<li><span></span></li>');
						$pagination_pages_container.append($page);

						rendering.pagination.page.width = $page.outerWidth(true);
						rendering.pagination.page.height = $page.outerHeight(true);

						$pagination.css('visibility', '');

						slider.pagination.display_category();
						slider.pagination.select(current.item.index);

						$pagination_pages_container
							.delegate('li', 'click', function () {
								slider.show_item($(this).index());

								return false;
							});
					},

					display_category: function () {
						if (!option.pagination.display)
							return;

						var i = 0,
							pages_html = '';

						$pagination.css('display', 'none');

						$pagination_pages_container.html('');

						rendering.pagination.pages_at_once = current.category.item_count < option.pagination.pages_at_once ? current.category.item_count : option.pagination.pages_at_once;

						if (option.pagination.direction === 'horizontal') {
							$pagination.addClass('horizontal');

							$pagination.width(rendering.pagination.pages_at_once * rendering.pagination.page.width);
							$pagination.height(rendering.pagination.page.height);

							$pagination_pages_container.width(current.category.item_count * rendering.pagination.page.width);
							$pagination_pages_container.height(rendering.pagination.page.height);
						} else {
							$pagination.addClass('vertical');

							$pagination.width(rendering.pagination.page.width);
							$pagination.height(rendering.pagination.pages_at_once * rendering.pagination.page.height);

							$pagination_pages_container.width(rendering.pagination.page.width);
							$pagination_pages_container.height(current.category.item_count * rendering.pagination.page.height);
						}

						for (; i < current.category.item_count; i++)
							pages_html += '<li><span></span></li>';

						$pagination_pages = $(pages_html);
						$pagination_pages_container.append($pagination_pages);

						$pagination.css('display', '');
					},

					select: function (index) {
						if (!option.pagination.display)
							return;

						var offset_pages = Math.floor(rendering.pagination.pages_at_once / 2),
							align_to_page = index - offset_pages,
							to_animate = {};

						if (align_to_page < 0) {
							align_to_page = 0;
						} else if (index >= current.category.item_count - offset_pages) {
							align_to_page = current.category.item_count - rendering.pagination.pages_at_once;
						}

						if (option.pagination.direction == 'horizontal') {
							to_animate = {
								left: - (align_to_page * rendering.pagination.page.width)
							};
						} else {
							to_animate = {
								top: - (align_to_page * rendering.pagination.page.height)
							};
						}

						$pagination_pages_container.stop().animate(to_animate, 250);

						$pagination_pages.removeClass('current');
						$pagination_pages.eq(index).addClass('current');
					}
				},

				social_buttons: {
					init: function () {
						$social_buttons = $('<div class="social_buttons ' + option.social_buttons.direction + '" />');

						if (option.social_buttons.hideable) {
							$social_buttons_toggle = $('<div class="social_buttons_toggle ' + option.social_buttons.direction + '" />');
							$t.prepend($social_buttons_toggle);
							slider.position_element($social_buttons_toggle, option.social_buttons.position);

							$social_buttons
								.fadeTo(200, 0, function () {
									$social_buttons.hide();
								})
								.data('visible', false);
							$t.prepend($social_buttons);
							slider.position_element($social_buttons, $.extend({}, option.social_buttons.position, {h_offset: option.social_buttons.position.h_offset + $social_buttons_toggle.outerWidth(true) + 5}));

							$social_buttons_toggle.click(function () {
								if ($social_buttons.data('visible')) {
									$social_buttons
										.data('visible', false)
										.stop()
										.fadeTo(200, 0, function () {
											$social_buttons
												.empty()
												.hide();
										});

									$social_buttons_toggle.removeClass('active');
								} else {
									$social_buttons
										.data('visible', true)
										.stop()
										.fadeTo(200, 1);

									slider.social_buttons.display(current.item.index);

									$social_buttons_toggle.addClass('active');
								}
							});
						} else {
							$t.prepend($social_buttons);
							slider.position_element($social_buttons, option.social_buttons.position);
						}

						slider.social_buttons.display(current.item.index);
					},

					display: function (index) {
						if (!option.social_buttons.display || (option.social_buttons.hideable && !$social_buttons.data('visible')))
							return;

						var button_html = '',
							social_button_href = '';

						$social_buttons.html('');

						if (typeof current.category.items[index].social_button_url == 'string') {
							social_button_href = current.category.items[index].social_button_url;
						} else {
							if (location.href.indexOf('#') == -1) {
								social_button_href = location.href;
							} else {
								social_button_href = location.href.substring(0, location.href.indexOf('#'));
							}

							social_button_href = slider.set_url_param(slider.set_url_param(social_button_href, 'edgpid', current.category.items[index].id), 'edgmid', option.module_id) + '#slider_' + option.module_id + '/' + selected_categories.ids.join('-') + '/' + current.category.items[index].id + '/';
						}

						for (button in option.social_buttons.buttons) {
							if (option.social_buttons.buttons[button].display) {
								button_html += '<div class="social_button">';

								button_html += option.social_buttons.buttons[button].html
									.replace(/{location_href}/g, social_button_href)
									.replace(/{location_href_encoded}/g, encodeURIComponent(social_button_href));

								button_html += '</div>';
							}
						}

						if (autoplay.transition_in_progres && option.social_buttons.load_after_effect) {
							$t.unbind('slider_transition_finnished.social_buttons');

							$t.bind('slider_transition_finnished.social_buttons', function () {
								$social_buttons
									.html('')
									.append(button_html);
							});
						} else {
							$social_buttons.append(button_html);
						}
					}
				},

				_button: {
					init: function (params) {
						rendering.buttons[params.type] = $('<a class="standalone_button' + (params.custom_class ? ' ' + params.custom_class : '') + '" href="#">' + params.text + '</a>');

						$t.prepend(rendering.buttons[params.type]);
						slider.position_element(rendering.buttons[params.type], option.buttons[params.type].position);
					},

					display: function (params) {
						params.target = typeof params.target == 'string' ? params.target : '_self'

						rendering.buttons[params.type].attr({
							href: params.href,
							target: params.target
						});
					}
				},

				email_button: {
					init: function () {
						slider._button.init({
							type: 'email',
							custom_class: 'email',
							text: 'Email this'
						});

						slider.email_button.display(current.item.index);
					},

					display: function (index) {
						var hash_location = location.href.indexOf('#'),
							href;

						if (!option.buttons.email.display)
							return;

						if (hash_location == -1)
							href = location.href
						else
							href = location.href.substring(0, hash_location);

						href += '#slider_' + option.module_id + '/' + selected_categories.ids.join('-') + '/' + current.category.items[current.item.index].id;

						slider._button.display({
							type: 'email',
							href: 'mailto:?subject=' + escape(option.buttons.email.email_subject) + '&body=' + encodeURIComponent(href)
						});
					}
				},

				download_button: {
					init: function () {
						slider._button.init({
							type: 'download',
							custom_class: 'download',
							text: 'Download'
						});

						slider.download_button.display(current.item.index);
					},

					display: function (index) {
						var url = current.category.items[index].download_url;

						if (!option.buttons.download.display)
							return;

						url = !url ? '#' : url;

						slider._button.display({
							type: 'download',
							href: url,
							target: '_blank'
						});

						if (url == '#')
							rendering.buttons.download.stop().fadeTo(200, 0);
						else
							rendering.buttons.download.stop().fadeTo(200, 1);
					}
				},

				fullscreen_button: {
					init: function () {
						slider._button.init({
							type: 'fullscreen',
							custom_class: 'fullscreen',
							text: 'Fullscreen'
						});

						rendering.buttons.fullscreen.click(function () {
							$(this).chameleonSliderFullscreen(option.fullscreen_options);

							return false;
						});
					}
				},

				exit_fullscreen: {
					init: function () {
						slider._button.init({
							type: 'exit_fullscreen',
							custom_class: 'exit_fullscreen',
							text: 'Exit fullscreen'
						});
					}
				},

				main_panel: {
					init: function () {
						var touch_events_present,
							mousedown = 'mousedown',
							mousemove = 'mousemove',
							mouseup = 'mouseup';

						$main_panel = $('<div class="main_panel" />');

						slider.main_panel.size();

						$main_panel_items_wrapper = $('<div class="items_wrapper" />');

						$main_panel.append($main_panel_items_wrapper);

						$t.prepend($main_panel);

						if (option.redirect_on_click || option.lightbox_on_click) {
							$main_panel_media_link = $('<a href="#" class="media_link" />');

							if (option.redirect_on_click)
								$main_panel_media_link.attr('target', option.redirect_on_click_target);

							$main_panel.append($main_panel_media_link);
						}

						if (!option.redirect_on_click && option.lightbox_on_click) {
							$lightbox_links_container = $('<div class="lightbox_links_container" style="display: none;"></div>');
							$main_panel_items_wrapper.append($lightbox_links_container);
						}

						$t.bind('slider_transition_finnished.main_panel', function () {
							autoplay.transition_in_progres = false;
						});

						slider.main_panel.display_category(true);

						if (!rendering.preloading_item) {
							slider.main_panel.display(current.item.index, '');
							slider.triggers();
						}

						if (option.main_panel.drag_navigation) {
							touch_events_present = 'ontouchstart' in window;

							if (touch_events_present) {
								mousedown = 'touchstart';
								mousemove = 'touchmove';
								mouseup = 'touchend';
							}

							$main_panel
								.delegate('a', 'click', function (e) {
									if (rendering.main_panel.disable_clicking)
										e.preventDefault();
								})
								.bind(mousedown + '.chameleon_' + option.module_id, function (e) {
									if (touch_events_present)
										if (e.originalEvent.touches && e.originalEvent.touches.length)
											e = e.originalEvent.touches[0];
										else if (e.originalEvent.changedTouches && e.originalEvent.changedTouches.length)
											e = e.originalEvent.changedTouches[0];

									$main_panel.data('dragging', {
										start_position: {
											left: e.pageX,
											top: e.pageY
										}
									});

									e.preventDefault();
								});

							$(document)
								.bind(mousemove + '.chameleon_' + option.module_id, function (e) {
									var position_delta,
										start_position;

									if (typeof $main_panel.data('dragging') != 'object')
										return;

									start_position = $main_panel.data('dragging').start_position;

									rendering.main_panel.disable_clicking = true;

									if (touch_events_present)
										if (e.originalEvent.touches && e.originalEvent.touches.length)
											e = e.originalEvent.touches[0];
										else if (e.originalEvent.changedTouches && e.originalEvent.changedTouches.length)
											e = e.originalEvent.changedTouches[0];

									if (Math.abs((start_position.top - e.pageY)/(e.pageX - start_position.left)) >= 1)
										return;

									position_delta = start_position.left - e.pageX;

									if (Math.abs(position_delta) < 50)
										return false;

									$main_panel.data('dragging', false);

									if (position_delta < 0)
										slider.prev();
									else
										slider.next();
								})
								.bind(mouseup + '.chameleon_' + option.module_id, function (e) {
									$main_panel.data('dragging', false);

									rendering.main_panel.disable_clicking_interval = setTimeout(function () {
										rendering.main_panel.disable_clicking = false;
									}, 10);
								});
						}

						rendering.main_panel.initialized = true;
					},

					size: function () {
						if (!option.main_panel.display)
							return;

						rendering.main_panel.dimensions = slider.get_dimensions(option.main_panel.dimensions);

						rendering.main_panel.dimensions.height -= option.main_panel.trim.top + option.main_panel.trim.bottom;
						rendering.main_panel.dimensions.width -= option.main_panel.trim.left + option.main_panel.trim.right;

						slider.position_element($main_panel, option.main_panel.position);

						$main_panel
							.width(rendering.main_panel.dimensions.width)
							.height(rendering.main_panel.dimensions.height);
					},

					display_category: function (first_run) {
						var lightbox_links_html = '',
							i = 0,
							item,
							item_href,
							item_download,
							item_image,
							current_item = current.category.items[current.item.index],
							smb_items = [];

						if (!option.main_panel.display)
							return;

						if (current_item.type == 'image' || ((current_item.type == 'video' || current_item.type == 'audio') && option.lightbox_on_click)) {
							rendering.preloading_item = true;

							if (first_run) {
								$('<img />')
									.load(function () {
										rendering.preloading_item = false;

										slider.main_panel.display(current.item.index, '');
										slider.triggers();
									})
									.error(function () {
										rendering.preloading_item = false;

										slider.triggers();
									})
									.attr('src', current_item.src);
							} else {
								$main_panel.append('<div class="preloading_item" />');

								$('<img />')
									.load(function () {
										rendering.preloading_item = false;

										slider.main_panel.display(current.item.index, '');
										$main_panel.find('.preloading_item')
											.fadeOut(1000, function () {
												$(this).remove();
											});
									})
									.error(function () {
										rendering.preloading_item = false;

										slider.main_panel.display(current.item.index, '');
										$main_panel.find('.preloading_item')
											.fadeOut(1000, function () {
												$(this).remove();
											});
									})
									.attr('src', current_item.src);
							}
						}

						for (; i < current.category.item_count; i++) {
							item = current.category.items[i];

							if ((item.type == 'image' || ((item.type == 'video' || item.type == 'audio') && option.lightbox_on_click)) && !rendering.preloaded_images[item.src]) {
								rendering.preloaded_images[item.src] = {
									loading: true,
									loaded: false
								};

								$('<img />')
									.load({src: item.src}, function (e) {
										rendering.preloaded_images[e.data.src] = {
											loading: false,
											loaded: true,
											width: this.width,
											height: this.height
										};
									})
									.attr('src', item.src);
							}

							if (!option.redirect_on_click && option.lightbox_on_click) {
								if (item.type == 'image' || item.type == 'video' || item.type == 'audio') {
									item_href = item.lightbox_url;
									item_download = item.download_url ? item.download_url : '';
									item_image = item.src;
								} else {
									item_href = '';
									item_download = '';
									item_image = '';
								}

								if (option.fullscreen_provider == 'pp') {
									if (item_href)
										lightbox_links_html += '<a href="' + item_href +
											'" rel="prettyPhoto_M' + option.module_id +
											'" edgmid="' + option.module_id +
											'" edgpid="' + item.id +
											'" downhref="' + item_download +
											(option.lightbox_description && item.info ? '" pptitle="' + item.info.replace('"', '&quot;') : '') +
											'"><img src="' + item_image + '" alt="' +
											(option.lightbox_title && item.title ? item.title : '') + '" /></a>';
								} else if (option.fullscreen_provider == 'smb') {
									if ($.isPlainObject(item.smb_object) && !$.isEmptyObject(item.smb_object))
										smb_items.push(item.smb_object);
								} else if (option.fullscreen_provider == 'smbLight') {
									if ($.isPlainObject(item.smbLight_object) && !$.isEmptyObject(item.smbLight_object))
										smb_items.push(item.smbLight_object);
								}
							}
						}

						if (!option.redirect_on_click && option.lightbox_on_click) {
							if (option.fullscreen_provider == 'pp') {
								$lightbox_links_container.html(lightbox_links_html);
								$lightbox_links = $lightbox_links_container.find('> a');

								$lightbox_links.prettyPhoto(option.pretty_photo_options);
							} else if (option.fullscreen_provider == 'smb') {
								$lightbox_links_container.data('socialMediaBox', smb_items);
							} else if (option.fullscreen_provider == 'smbLight') {
								$lightbox_links_container.data('smbLightItems', smb_items);
							}
						}
					},

					display: function (item_index) {
						var transition_effect = '',
							effect_object = '',
							random_effect_index,
							item = current.category.items[item_index];

						if (!option.main_panel.display)
							return;

						autoplay.transition_in_progres = true;

						$main_panel_media_link.unbind('click');

						if (item.type == 'image') {
							if (arguments.length == 2) {
								effect_object = transition_effect = arguments[1];
							} else if (option.main_panel.transition.effects.length == 1) {
								effect_object = transition_effect = option.main_panel.transition.effects[0];
							} else if (option.main_panel.transition.effects.length > 1) {
								random_effect_index = Math.floor(Math.random() * option.main_panel.transition.effects.length);

								effect_object = transition_effect = option.main_panel.transition.effects[random_effect_index];
							}

							$main_panel_media_link.css('display', 'block');

							if (option.redirect_on_click)
								$main_panel_media_link.attr('href', (typeof item.on_click_url == 'string' && item.on_click_url ? item.on_click_url : '#'));
						} else if (item.type == 'video' || item.type == 'audio') {
							transition_effect = '';

							if (option.redirect_on_click || (typeof item.html != 'undefined' && item.html != '')) {
								$main_panel_media_link.css('display', 'none');
							} else {
								$main_panel_media_link.css('display', 'block');
							}
						}

						if (!option.redirect_on_click && option.lightbox_on_click) {
							$main_panel_media_link
								.attr('href', '#')
								.click(function () {
									var smbLightItems;

									if (rendering.main_panel.disable_clicking)
										return false;

									if (option.fullscreen_provider == 'pp')
										$lightbox_links.filter('a[edgpid="' + item.id + '"]').trigger('click');
									else if (option.fullscreen_provider == 'smb') {
										option.smb_options.openAt = 0;
										$.each($lightbox_links_container.data('socialMediaBox'), function (i, smb_item) {
											if (smb_item.id === item.id) {
												option.smb_options.openAt = i;
												return false;
											}
										});
										$lightbox_links_container.socialMediaBox(option.smb_options);
									} else if (option.fullscreen_provider == 'smbLight') {
										smbLightItems = $lightbox_links_container.data('smbLightItems');

										option.smbLight_options.openAt = 0;
										$.each(smbLightItems, function (i, smb_item) {
											if (smb_item.id === item.id) {
												option.smbLight_options.openAt = i;
												return false;
											}
										});

										new SmbLight_1(smbLightItems, option.smbLight_options);
									}

									return false;
								});
						}

						if (typeof effect_object == 'object')
							transition_effect = effect_object.type;
						else if (transition_effect == '')
							transition_effect = 'show';

						if (rendering.youtube_player_object != undefined) {
							rendering.youtube_player_object.getIframe().src = '';
							rendering.youtube_player_object.stopVideo();
							rendering.youtube_player_object = undefined;
						}

						slider.main_panel._transitions[transition_effect](item_index, effect_object);

						if (option.main_panel.fill_panel && (item.type == 'image' || ((item.type == 'video' || item.type == 'audio') && option.lightbox_on_click)))
							slider.main_panel._fit_image($main_panel_items_wrapper.find('> .item_container').filter(':last').find('> img'));
					},

					_fit_image: function ($img) {
						var src = $img.attr('src'),
							img_preload = rendering.preloaded_images[src],
							fit_image = function ($img, img_preload) {
								var mpw = rendering.main_panel.dimensions.width,
									mph = rendering.main_panel.dimensions.height,
									resize_ratio,
									image_height,
									image_width;

								if (img_preload.width == mpw && img_preload.height == mph)
									return;

								$img.css({
									position: 'relative'
								});

								if (img_preload.width > mpw || img_preload.height > mph || option.main_panel.stretch_small_image) {
									$img.css({
										width: '100%',
										height: 'auto'
									});

									resize_ratio = mpw / img_preload.width;
									image_height = Math.floor(img_preload.height * resize_ratio);

									if (image_height < mph) {
										resize_ratio = mph / img_preload.height;
										image_width = Math.floor(img_preload.width * resize_ratio);

										$img.css({
											height: '100%',
											width: 'auto'
										});

										if (!option.main_panel.top_left_align)
											$img.css({
												left: -Math.floor((image_width - mpw) / 2)
											});
									} else if (image_height > mph && !option.main_panel.top_left_align)
										$img.css({
											top: -Math.floor((image_height - mph) / 2)
										});
								} else {
									if (!option.main_panel.top_left_align) {
										if (img_preload.width < mpw)
											$img.css({
												left: Math.floor((mpw - img_preload.width) / 2)
											});

										if (img_preload.height < mph)
											$img.css({
												top: Math.floor((mph - img_preload.height) / 2)
											});
									}
								}
							};

						if (img_preload && img_preload.loaded) {
							fit_image($img, img_preload);
						} else {
							$('<img />')
								.load({'src': src, '$img': $img}, function (e) {
									rendering.preloaded_images[e.data.src] = {
										loading: false,
										loaded: true,
										width: this.width,
										height: this.height
									};

									fit_image(e.data.$img, rendering.preloaded_images[e.data.src]);
								})
								.attr('src', src);
						}
					},

					_transitions: {
						show: function (item_index) {
							var next_item_html = '<div class="item_container new_item">',
								current_item = current.category.items[item_index],
								$next_item,
								$last_item = $main_panel_items_wrapper.find('> .item_container').eq(0),
								item_html = typeof current_item.html == 'undefined' || current_item.html == '' ? '' : current_item.html,
								video_src,
								video_provider = '',
								video_id,
								video_container_id,
								flash_autoplay_manipulation = false,
								image_alt = '';

							if ((current_item.type == 'video' || current_item.type == 'audio') && item_html) {
								video_src = typeof current_item.video_src == 'undefined' || current_item.video_src == '' ? '' : current_item.video_src;

								if (video_src == '') {
									if (option.autoplay.enable) {
										video_provider = slider._video.get_provider(item_html);
										video_id = slider._video.get_video_id(video_provider, item_html);
									}
								} else {
									video_provider = option.inhouse_player;
									video_id = video_src;
								}

								if ((rendering.html5.video && rendering.ios) || video_provider === '') {
									next_item_html += item_html;
								} else {
									flash_autoplay_manipulation = true;
									video_container_id = 'chameleon_video_container_' + option.module_id + '_' + selected_categories.indexes.join('-') + '_' + current.item.index + '_' + Math.round(Math.random() * 100000);
									next_item_html += '<div id="' + video_container_id + '"></div>';
								}
							} else {
								image_alt = typeof current_item.thumb == 'object' && current_item.thumb.caption ? current_item.thumb.caption : '';
								next_item_html += '<img alt="' + image_alt + '" src="' + current_item.src + '" />';
							}

							next_item_html += '</div>';

							$next_item = $(next_item_html);

							$main_panel_items_wrapper.find('> .item_container.new_item').removeClass('new_item');

							$next_item
								.css({
									width: rendering.main_panel.dimensions.width,
									height: rendering.main_panel.dimensions.height
								})
								.appendTo($main_panel_items_wrapper);

							if (flash_autoplay_manipulation)
								slider._video.player_setup({
									container: video_container_id,
									provider: video_provider,
									id: video_id,
									dimensions: rendering.main_panel.dimensions
								});

							if (!$last_item.hasClass('new_item'))
								$last_item.remove();

							if (!flash_autoplay_manipulation)
								$t.trigger('slider_transition_finnished');
						},

						fade: function (item_index) {
							var current_item = current.category.items[item_index],
								image_alt = typeof current_item.thumb == 'object' && current_item.thumb.caption ? current_item.thumb.caption : '',
								$next_item = $('<div class="item_container"><img alt="' + image_alt + '" src="' + current_item.src + '" /></div>');

							$main_panel_items_wrapper.find('> .item_container.new_item').removeClass('new_item');

							$next_item
								.css({
									width: rendering.main_panel.dimensions.width,
									height: rendering.main_panel.dimensions.height,
									display: 'none'
								})
								.appendTo($main_panel_items_wrapper)
								.fadeIn(option.main_panel.transition.duration, function () {
									var $last_item = $main_panel_items_wrapper.find('> .item_container').eq(0);

									if (!$last_item.hasClass('new_item')) {
										$last_item.remove();
									}

									$t.trigger('slider_transition_finnished');
								});
						},

						slide: function (item_index, fx_prop) {
							var current_item = current.category.items[item_index],
								image_alt = typeof current_item.thumb == 'object' && current_item.thumb.caption ? current_item.thumb.caption : '',
								$next_item = $('<div class="item_container new_item"><img alt="' + image_alt + '" src="' + current_item.src + '" /></div>'),
								$prev_item = $main_panel_items_wrapper.find('> .item_container').filter(':last'),
								slide_direction = 'left',
								slide_ended = function () {
									var $last_item = $main_panel_items_wrapper.find('> .item_container').eq(0);

									if (!$last_item.hasClass('new_item')) {
										$last_item.remove();
									}

									$t.trigger('slider_transition_finnished');
								};

							if (fx_prop.force_horizontal) {
								if (previous_item_index < item_index)
									slide_direction = 'left';
								else
									slide_direction = 'right';
							} else if (fx_prop.force_vertical) {
								if (previous_item_index < item_index)
									slide_direction = 'up';
								else
									slide_direction = 'down';
							} else {
								if (fx_prop.directions.length == 1) {
									slide_direction = fx_prop.directions[0];
								} else if (fx_prop.directions.length > 1) {
									slide_direction = fx_prop.directions[Math.floor(Math.random() * fx_prop.directions.length)];
								}
							}

							$main_panel_items_wrapper.find('> .item_container.new_item').removeClass('new_item');

							$next_item
								.css({
									width: rendering.main_panel.dimensions.width,
									height: rendering.main_panel.dimensions.height
								});

							switch (slide_direction) {
							case 'down':
								$next_item
									.css('top', - (rendering.main_panel.dimensions.height))
									.appendTo($main_panel_items_wrapper)
									.animate({top: 0}, option.main_panel.transition.duration, 'swing', slide_ended);

								$prev_item
									.animate({top: rendering.main_panel.dimensions.height}, option.main_panel.transition.duration, 'swing');
								break;

							case 'up':
								$next_item
									.css('top', rendering.main_panel.dimensions.height)
									.appendTo($main_panel_items_wrapper)
									.animate({top: 0}, option.main_panel.transition.duration, 'swing', slide_ended);

								$prev_item
									.animate({top: - (rendering.main_panel.dimensions.height)}, option.main_panel.transition.duration, 'swing');
								break;

							case 'right':
								$next_item
									.css('left', - (rendering.main_panel.dimensions.width))
									.appendTo($main_panel_items_wrapper)
									.animate({left: 0}, option.main_panel.transition.duration, 'swing', slide_ended);

								$prev_item
									.animate({left: rendering.main_panel.dimensions.width}, option.main_panel.transition.duration, 'swing');
								break;

							default:
								$next_item
									.css('left', rendering.main_panel.dimensions.width)
									.appendTo($main_panel_items_wrapper)
									.animate({left: 0}, option.main_panel.transition.duration, 'swing', slide_ended);

								$prev_item
									.animate({left: - (rendering.main_panel.dimensions.width)}, option.main_panel.transition.duration, 'swing');
							}
						},

						stripes: function (item_index, fx_prop) {
							var stripe_width = 0,
								stripe_height = 0,
								last_stripe_width = 0,
								last_stripe_height = 0,
								strip_top = 0,
								strip_left = 0,
								strip_background_top = 0,
								strip_background_left = 0,
								$stripe,

								image_top_offset = 0,
								image_left_offset = 0,

								item_src = current.category.items[item_index].src,

								fx_duration = Math.floor(option.main_panel.transition.duration / fx_prop.num_of_stripes),

								$next_item = $('<div class="item_container new_item"></div>'),
								slide_ended = function () {
									var $last_item = $main_panel_items_wrapper.find('> .item_container').eq(0);

									if (!$last_item.hasClass('new_item')) {
										$last_item.remove();
									}

									$t.trigger('slider_transition_finnished');
								},

								create_stripe = function ($stripe, i) {
									var w = stripe_width,
										h = stripe_height,
										start_animation = function () {
											var props;

											if (fx_prop.orientation == 'horizontal') {
												props = {left: 0, opacity: 1};
											} else {
												props = {top: 0, opacity: 1};
											}

											$stripe.animate(props, {
												duration: option.main_panel.transition.duration,
												easing: 'swing',
												complete: function () {
													if (fx_prop.start_at == 0 || fx_prop.start_at == 2) {
														if (i + 1 == fx_prop.num_of_stripes) {
															slide_ended();
														}
													} else if (fx_prop.start_at == 1) {
														if (i == 0) {
															slide_ended();
														}
													} else {
														if (i == Math.floor(fx_prop.num_of_stripes / 2)) {
															slide_ended();
														}
													}
												}
											});
										};

									if (fx_prop.orientation == 'horizontal') {
										strip_top = i * stripe_height;

										if (fx_prop.direction === 0) {
											strip_left = - (stripe_width);
										} else if (fx_prop.direction === 1) {
											strip_left = stripe_width;
										} else {
											if (i % 2 == 0) {
												strip_left = - (stripe_width);
											} else {
												strip_left = stripe_width;
											}
										}

										strip_background_top = image_top_offset - strip_top;
										strip_background_left = image_left_offset;
									} else {
										strip_left = i * stripe_width;

										if (fx_prop.direction === 0) {
											strip_top = - (stripe_height);
										} else if (fx_prop.direction === 1) {
											strip_top = stripe_height;
										} else {
											if (i % 2 == 0) {
												strip_top = - (stripe_height);
											} else {
												strip_top = stripe_height;
											}
										}

										strip_background_top = image_top_offset;
										strip_background_left = image_left_offset - strip_left;
									}

									if (i + 1 == fx_prop.num_of_stripes) {
										w = last_stripe_width;
										h = last_stripe_height;
									}

									$stripe = $('<div class="fancy_effect_element" />');

									$stripe.css({
											width: w,
											height: h,
											top: strip_top,
											left: strip_left,
											opacity: 0,
											background: 'url(\'' + item_src + '\') no-repeat '+strip_background_left+'px '+strip_background_top+'px ' + $t.css('background-color')
										})
										.appendTo($next_item);

									if (fx_prop.start_at === 0) {
										setTimeout(start_animation, (i * fx_duration + 1));
									} else if (fx_prop.start_at == 1) {
										setTimeout(start_animation, ((fx_prop.num_of_stripes - 1 - i) * fx_duration + 1));
									} else if (fx_prop.start_at == 2 || fx_prop.start_at == 3) {
										var multiplyer = 0,
											middle;

										if (fx_prop.num_of_stripes % 2 == 0) {
											middle = fx_prop.num_of_stripes / 2;
											if (i < middle) {
												if (fx_prop.start_at == 3) {
													multiplyer = i;
												} else {
													multiplyer = Math.abs(i - middle + 1);
												}
											} else {
												multiplyer = i - middle;
												if (fx_prop.start_at == 3) {
													multiplyer = middle - 1 - multiplyer;
												}
											}
										} else {
											middle = Math.floor(fx_prop.num_of_stripes / 2);
											if (i < middle) {
												multiplyer = middle - i;
											} else {
												multiplyer = i - middle;
											}
											if (fx_prop.start_at == 3) {
												multiplyer = middle - multiplyer;
											}
										}

										setTimeout(start_animation, (multiplyer * fx_duration + 1));
									}
								};

							fx_prop = $.extend(true, {
								orientation: 'vertical',
								num_of_stripes: 12,
								direction: 0, // 0 = bottom/right, 1 = top/left, 2 = alternating
								start_at: 0, // 0 = top/left, 1 = bottom/right, 2 = center, 3 = outer
								randomize: {
									orientation: false,
									direction: false,
									start_at: false
								}
							}, fx_prop);

							if (fx_prop.randomize.orientation) {
								if (Math.floor(Math.random() * 2) == 0) {
									fx_prop.orientation = 'horizontal';
								} else {
									fx_prop.orientation = 'vertical';
								}
							}

							if (fx_prop.randomize.direction) {
								fx_prop.direction = Math.floor(Math.random() * 3);
							}

							if (fx_prop.randomize.start_at) {
								fx_prop.start_at = Math.floor(Math.random() * 4);
							}

							$main_panel_items_wrapper.find('> .item_container.new_item').removeClass('new_item');

							$next_item
								.css({
									width: rendering.main_panel.dimensions.width,
									height: rendering.main_panel.dimensions.height
								})
								.appendTo($main_panel_items_wrapper);

							if (fx_prop.orientation == 'horizontal') {
								last_stripe_width = stripe_width = rendering.main_panel.dimensions.width;

								stripe_height = Math.ceil(rendering.main_panel.dimensions.height / fx_prop.num_of_stripes);
								last_stripe_height = stripe_height * fx_prop.num_of_stripes - rendering.main_panel.dimensions.height;
								if (last_stripe_height == 0) {
									last_stripe_height = stripe_height;
								} else {
									last_stripe_height = stripe_height - last_stripe_height;
								}
							} else {
								last_stripe_height = stripe_height = rendering.main_panel.dimensions.height;

								stripe_width = Math.ceil(rendering.main_panel.dimensions.width / fx_prop.num_of_stripes);
								last_stripe_width = stripe_width * fx_prop.num_of_stripes - rendering.main_panel.dimensions.width;
								if (last_stripe_width == 0) {
									last_stripe_width = stripe_width;
								} else {
									last_stripe_width = stripe_width - last_stripe_width;
								}
							}

							(function (img) {
								var mpw = rendering.main_panel.dimensions.width,
									mph = rendering.main_panel.dimensions.height;

								if (img.width == mpw && img.height == mph)
									return;

								if (img.width < mpw)
									image_left_offset = Math.floor((mpw - img.width) / 2);
								else if (img.width > mpw)
									image_left_offset = - Math.floor((img.width - mpw) / 2);

								if (img.height < mph)
									image_top_offset = Math.floor((mph - img.height) / 2);
								else if (img.height > mph)
									image_top_offset = - Math.floor((img.height - mph) / 2);
							})(rendering.preloaded_images[item_src]);

							for (var i = 0; i < fx_prop.num_of_stripes; i++) {
								create_stripe($stripe, i);
							}
						}
					}
				},

				_on_pre_item_change: undefined,

				_video: {
					get_provider: function (embed_code) {
						if (embed_code.substring(0, 7) == '<iframe')
							if (embed_code.indexOf('youtube.com/embed/', 7) !== -1)
								return 'youtube';
							else if (embed_code.indexOf('player.vimeo.com/video/', 7) !== -1)
								return 'vimeo';

						return '';
					},

					get_video_id: function (provider, embed_code) {
						var url,
							url_has_params;

						switch (provider) {
						case 'youtube':
						case 'vimeo':
							url = $('<div>' + embed_code + '</div>').find('iframe:first').attr('src');
							url_has_params = url.indexOf('?');

							if (url_has_params !== -1)
								url = url.substring(0, url_has_params);

							if (url[url.length - 1] == '/')
								url = url.substring(0, url.length - 1);

							return url.substring(url.lastIndexOf('/') + 1);

						default:
							return '';
						}
					},

					player_setup: function (param) {
						var $container = $('#' + param.container);

						$container.css(param.dimensions);

						param.container = $container;

						switch (param.provider) {
						case 'youtube':
							slider._video._youtube_player(param);
							break;

						case 'vimeo':
							slider._video._vimeo_player(param);
							break;

						case 'flowplayer':
							slider._video._flow_player(param);
							break;

						default:
						}
					},

					_youtube_player: function (param) {
						var player_id = param.container.attr('id') + '_object',
							player_html = '<iframe id="' + player_id + '" type="text/html" width="' + param.dimensions.width + '" height="' + param.dimensions.height + '" ' +
								'src="//www.youtube.com/embed/' + param.id + '?enablejsapi=1&amp;wmode=transparent&amp;origin=' + location.protocol + '//' + location.host + '" ' +
								'frameborder="0"></iframe>',

							srcipt_tag,
							first_script_tag,

							yt_player,
							setup_player = function () {
								yt_player = new YT.Player(player_id, {
									events: {
										'onReady': function () {
											rendering.youtube_player_object = yt_player;
											$t.trigger('slider_transition_finnished');

											if (option.autoplay.autostart_video_playback)
												yt_player.playVideo();
										},
										'onStateChange': function (e) {
											switch (e.data) {
											case YT.PlayerState.PLAYING:
												autoplay.video_playing = true;
												slider.autoplay.reset();
												break;

											case YT.PlayerState.ENDED:
												setTimeout(slider.next, 1000);
												break;

											default:
											}
										}
									}
								});
							};

						param.container.append(player_html);

						if (!rendering.youtube_iframe_api.called) {
							rendering.youtube_iframe_api.called = true;

							srcipt_tag = document.createElement('script');
							srcipt_tag.src = "//www.youtube.com/iframe_api";
							first_script_tag = document.getElementsByTagName('script')[0];
							first_script_tag.parentNode.insertBefore(srcipt_tag, first_script_tag);
						}

						if (rendering.youtube_iframe_api.loaded) {
							setup_player();
						} else {
							window.onYouTubeIframeAPIReady = function () {
								rendering.youtube_iframe_api.loaded = true;
								setup_player();
							};
						}
					},

					_vimeo_player: function (param) {
						var video_base_url = '//player.vimeo.com/video/' + param.id,
							playback_initialized = false,

							post = function (action, value) {
								var data = {method: action};

								if (value) {
									data.value = value;
								}

								$player[0].contentWindow.postMessage(JSON.stringify(data), video_base_url);
							}

							onPlayerEvent = function (e) {
								var data = JSON.parse(e.data);

								switch (data.event) {
								case 'ready':
									$t.trigger('slider_transition_finnished');

									post('addEventListener', 'finish');
									post('addEventListener', 'play');

									if (option.autoplay.autostart_video_playback)
										post('play');
									break;

								case 'play':
									if (playback_initialized)
										break;

									autoplay.video_playing = playback_initialized = true;
									slider.autoplay.reset();
									break;

								case 'finish':
									setTimeout(slider.next, 1000);
									break;
								}
							},

							$player = $(
								'<iframe src="' + video_base_url +
								'?api=1" width="' + param.dimensions.width + '" height="' + param.dimensions.height +
								'" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
							);

						slider._on_pre_item_change = function () {
							if (window.addEventListener)
								window.removeEventListener('message', onPlayerEvent, false);
							else
								window.detachEvent('onmessage', onPlayerEvent);
						};

						if (window.addEventListener)
							window.addEventListener('message', onPlayerEvent, false);
						else
							window.attachEvent('onmessage', onPlayerEvent);

						param.container.append($player);
					},

					_flow_player: function (param) {
						var started_playing = false;

						param.container
							.html('<video src="' + param.id + '" />')
							.flowplayer({
								swf: option.flowplayer_src
							})
							.bind('ready', function () {
								$t.trigger('slider_transition_finnished');

								if (option.autoplay.autostart_video_playback)
									param.container.flowplayer().play();
							})
							.bind('resume', function () {
								if (!option.autoplay.enable || started_playing)
									return;

								started_playing = true;

								autoplay.video_playing = true;
								slider.autoplay.reset();
							})
							.bind('finish', function () {
								if (!option.autoplay.enable)
									return;

								setTimeout(slider.next, 1000);
							});
					}
				},

				key_browse: function () {
					$(document).keyup(function(e) {
						if (e.keyCode === 37){
							slider.prev();
						}
						if (e.keyCode === 39){
							slider.next();
						}

						return false;
					});
				},

				_scrollable_boxes: {
					init: function (props) {
						var box,
							box_options = option.scrollable_boxes[props.box];

						box = rendering.scrollable_boxes[props.box] = {
							jq: {
								container: $('<div class="scrollable_box' + (props.custom_class ? ' ' + props.custom_class : '') + '" />').data('disabled', false),
								viewport: $('<div class="viewport" />'),
								content: $('<div class="overview" />'),
								scrollbar: $()
							}
						};

						box.jq.container.append(box.jq.viewport);
						box.jq.viewport.append(box.jq.content);
						$t.prepend(box.jq.container);

						slider._scrollable_boxes.size(props.box);

						if (!box_options.container.resize_to_content)
							box.jq.container.height(box.dimensions.height);

						slider._scrollable_boxes.display(props);

						if (box_options.container.show_on_hover)
							$t.hover(
								function () {
									rendering.mouse_entered = true;

									if (box.jq.container.data('disabled') == false)
										box.jq.container.stop(true).fadeTo(200, 1, function () {box.jq.container.css('display', 'block');});
								},
								function () {
									rendering.mouse_entered = false;

									if (box.jq.container.data('disabled') == false)
										box.jq.container.stop(true).fadeTo(200, 0, function () {box.jq.container.css('display', 'none');});
								}
							);
					},

					size: function (box) {
						var obj = rendering.scrollable_boxes[box],
							box_options = option.scrollable_boxes[box];

						if (!box_options.display)
							return;

						obj.jq.scrollbar.remove();

						obj.jq.scrollbar = $('<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>');

						obj.dimensions = slider.get_dimensions(box_options.container.dimensions);

						slider.position_element(obj.jq.container, box_options.container.position);

						if (obj.dimensions.height > rendering.container_dimensions.height)
							obj.dimensions.height = rendering.container_dimensions.height;

						if (obj.dimensions.width > rendering.container_dimensions.width)
							obj.dimensions.width = rendering.container_dimensions.width;

						obj.jq.container
							.width(obj.dimensions.width)
							.css({
								maxHeight: obj.dimensions.height
							})
							.append(obj.jq.scrollbar)
							.eds_tinyscrollbar({
								size: obj.dimensions.height - (obj.jq.scrollbar.outerHeight(true) - obj.jq.scrollbar.height())
							})
							.hide(0);

						obj.jq.viewport.css({
							maxHeight: (obj.dimensions.height - obj.jq.viewport.outerHeight(true))
						});

						if (!box_options.container.resize_to_content)
							obj.jq.container.height(obj.dimensions.height);
					},

					display: function (props) {
						var box = rendering.scrollable_boxes[props.box],
							box_options = option.scrollable_boxes[props.box],
							show_content = function () {
								var fade_in = function () {
									box.jq.viewport.stop(true).fadeTo(200, 1, function () {box.jq.scrollbar.css('display', 'block');});

									if (!box.jq.scrollbar.hasClass('disable'))
										box.jq.scrollbar.stop(true).fadeTo(200, 1, function () {box.jq.scrollbar.css('display', 'block');});
								};

								box.jq.viewport.css({ visibility: '', display: 'none' });

								if (box_options.container.show_on_hover)
									if (rendering.mouse_entered) {
										fade_in();
									} else {
										box.jq.viewport.css({display: 'block'});

										if (!box.jq.scrollbar.hasClass('disable'))
											box.jq.scrollbar.css({display: 'block'});
									}
								else
									fade_in();
							};

						if (!box_options.display)
							return;

						if (typeof props.content == 'string' && props.content) {
							box.jq.container.data('disabled', false);

							if (box.jq.container.is(':visible')) {
								box.jq.container.css({ height: box.jq.container.height() });

								box.jq.scrollbar.stop(true).fadeTo(200, 0, function () {box.jq.scrollbar.css('display', 'none');});
								box.jq.viewport.stop(true).fadeTo(200, 0, function () {
									box.jq.content.html(props.content);
									box.jq.viewport
										.css({ visibility: 'hidden', display: 'block' })
										.removeClass('scrollable');
									box.jq.container.eds_tinyscrollbar_update();

									if (!box.jq.scrollbar.hasClass('disable')) {
										box.jq.viewport.addClass('scrollable');
										box.jq.container.eds_tinyscrollbar_update();
									}

									if (box_options.container.resize_to_content && (!box_options.container.show_on_hover || rendering.mouse_entered)) {
										box.jq.container.animate({
												height: box.jq.viewport.outerHeight(true)
											}, 200, show_content);
									} else {
										box.jq.container.height(box.dimensions.height);
										show_content();
									}
								});
							} else {
								box.jq.container.css({ visibility: 'hidden', display: 'block' });

								box.jq.viewport.removeClass('scrollable');

								box.jq.content.html(props.content);
								box.jq.container.eds_tinyscrollbar_update();

								if (box.jq.scrollbar.hasClass('disable')) {
									box.jq.scrollbar.css({ display: 'none' });
								} else {
									box.jq.viewport.addClass('scrollable');
									box.jq.scrollbar.css({ display: 'block', opacity: 1 });
									box.jq.container.eds_tinyscrollbar_update();
								}

								box.jq.container
									.css({
										visibility: '',
										display: 'none',
										height: (box_options.container.resize_to_content ? box.jq.viewport.outerHeight(true) : box.dimensions.height)
									});

								if (!box_options.container.show_on_hover || rendering.mouse_entered)
									box.jq.container.stop(true).fadeTo(200, 1, function () {box.jq.container.css('display', 'block');});
							}
						} else
							box.jq.container
								.data('disabled', true)
								.stop(true)
								.fadeTo(200, 0, function () {box.jq.container.css('display', 'none');});
					}
				},

				item_info: {
					init: function () {
						slider._scrollable_boxes.init({
							box: 'item_info',
							custom_class: 'item_info',
							content: current.category.items[current.item.index].info
						});
					},

					display: function (index) {
						slider._scrollable_boxes.display({
							box: 'item_info',
							content: current.category.items[index].info
						});
					}
				},

				gallery_info: {
					init: function () {
						slider._scrollable_boxes.init({
							box: 'gallery_info',
							custom_class: 'gallery_info',
							content: current.category.info
						});
					},

					display: function () {
						slider._scrollable_boxes.display({
							box: 'gallery_info',
							content: current.category.info
						});
					}
				},

				autoplay_toggle: {
					init: function () {
						$autoplay_toggle = $('<a href="#" class="autoplay_toggle">Play/Pause</a>');

						if (option.autoplay.enable) {
							$autoplay_toggle.addClass('pause');
						} else {
							autoplay.user_paused = true;
						}

						$autoplay_toggle
							.prependTo($t)
							.click(function () {
								if (autoplay.user_paused) {
									autoplay.user_paused = false;
									$autoplay_toggle.addClass('pause');

									if (!option.autoplay.enable) {
										autoplay.fade_in = true;
										option.autoplay.enable = true;
										slider.autoplay.init();
									}

									if (!option.autoplay.pause_on_hover) {
										slider.autoplay.start();
									}
								} else {
									$autoplay_toggle.removeClass('pause');
									autoplay.user_paused = true;
									if (!autoplay.pause) {
										slider.autoplay.pause();
									}
								}

								return false;
							});

						slider.position_element($autoplay_toggle, option.autoplay_toggle.position);

						if (current.category.item_count < 2)
							$autoplay_toggle.css('display', 'none');

						if (option.autoplay_toggle.auto_hide) {
							$autoplay_toggle.css('display', 'none');
							$t.hover(function () {
								if (current.category.item_count < 2)
									return;

								$autoplay_toggle.stop().fadeTo(option.autoplay_toggle.hide_speed, 1);
							}, function () {
								$autoplay_toggle.stop().fadeTo(option.autoplay_toggle.hide_speed, 0);
							});
						}
					},

					display_category: function () {
						var display = '';

						if (!option.autoplay_toggle.display)
							return;

						if (current.category.item_count < 2)
							display = 'none';

						$autoplay_toggle.css('display', display);
					}
				},

				autoplay: {
					init: function () {
						if (option.autoplay.indicator.display) {
							$autoplay_indicator = $('<div class="indicator" />');
							$autoplay_container = $('<div class="autoplay_container" />');

							slider.autoplay.size();

							if (option.autoplay.indicator.orientation == 'vertical' && !option.autoplay.indicator.flip_direction)
								$autoplay_indicator.css({
									top: 'auto',
									bottom: 0
								});
							else if (option.autoplay.indicator.flip_direction)
								$autoplay_indicator.css({
									left: 'auto',
									right: 0
								});

							$autoplay_container
								.append($autoplay_indicator)
								.css('display', 'none');

							if (autoplay.fade_in) {
								$t.append($autoplay_container);
								$autoplay_container.fadeIn(300);
							} else {
								$t.prepend($autoplay_container);
								$autoplay_container.css('display', '');
							}
						}

						$t.bind('slider_transition_finnished', function () {
							if (autoplay.user_paused || autoplay.pause)
								return;

							slider.autoplay.start();
						});
					},

					size: function () {
						if (!option.autoplay.enable || !option.autoplay.indicator.display)
							return;

						rendering.autoplay.indicator = slider.get_dimensions(option.autoplay.indicator.dimensions);

						slider.position_element($autoplay_container, option.autoplay.indicator.position);

						if (option.autoplay.indicator.orientation == 'vertical')
							$autoplay_indicator.width(rendering.autoplay.indicator.width);
						else
							$autoplay_indicator.height(rendering.autoplay.indicator.height);

						$autoplay_container.css(rendering.autoplay.indicator)
					},

					start: function () {
						var interval = option.autoplay.interval,
							reset_indicator = true;

						if (current.category.item_count < 2) {
							if (option.autoplay.indicator.display)
								$autoplay_container.css('display', 'none');

							return;
						}

						if (option.autoplay.enable && autoplay.interval == '') {
							autoplay.last_started = new Date().getTime();

							autoplay.reset = false;

							if (autoplay.time_remaining != 0) {
								reset_indicator = false;
								interval = autoplay.time_remaining;
							}

							if (option.autoplay.indicator.display) {
								$autoplay_container.css('display', '');

								$autoplay_indicator.stop();
								if (option.autoplay.indicator.orientation == 'vertical') {
									if (reset_indicator) {
										$autoplay_indicator.height(0);
									}

									$autoplay_indicator.animate({height: rendering.autoplay.indicator.height}, interval, 'linear');
								} else {
									if (reset_indicator) {
										$autoplay_indicator.width(0);
									}

									$autoplay_indicator.animate({width: rendering.autoplay.indicator.width}, interval, 'linear');
								}
							}

							autoplay.interval = setTimeout(slider.next, interval);
						}
					},

					pause: function () {
						if (!option.autoplay.enable || autoplay.reset)
							return;

						autoplay.pause_time = new Date().getTime();
						autoplay.start_pause_delta = autoplay.pause_time - autoplay.last_started;

						if (option.autoplay.indicator.display)
							$autoplay_indicator.stop();

						autoplay.time_remaining = (autoplay.time_remaining == 0 ? option.autoplay.interval : autoplay.time_remaining) - autoplay.start_pause_delta;

						clearTimeout(autoplay.interval);
						autoplay.interval = '';
					},

					reset: function () {
						if (!option.autoplay.enable)
							return;

						clearTimeout(autoplay.interval);
						autoplay.interval = '';
						autoplay.time_remaining = 0;

						autoplay.reset = true;

						if (option.autoplay.indicator.display) {
							$autoplay_indicator.stop();
							if (option.autoplay.indicator.orientation == 'vertical') {
								$autoplay_indicator.height(0);
							} else {
								$autoplay_indicator.width(0);
							}
						}
					},

					display_category: function () {
						if (!option.autoplay.enable)
							return;

						if (option.autoplay.indicator.display)
							if (current.category.item_count < 2)
								$autoplay_container.css('display', 'none');
							else
								$autoplay_container.css('display', '');
					}
				},

				_items_panel: {
					init: function (params) {
						params.page
							.append(params.item)
							.appendTo(item_panels[params.panel].container);

						rendering[params.panel].width = params.item.outerWidth(true);
						rendering[params.panel].height = params.item.outerHeight(true);

						rendering[params.panel].page.horizontal_space = params.page.outerWidth(true) - params.page.width();
						rendering[params.panel].page.vertical_space = params.page.outerHeight(true) - params.page.height();

						params.page.remove();

						if (!option[params.panel].container.transparent)
							item_panels[params.panel].wrapper.addClass('not_transparent');
					},

					calculate_pages: function (params) {
						var minimum_container_dimension;

						rendering[params.panel].container = slider.get_dimensions(option[params.panel].container.dimensions);

						rendering[params.panel].page.width = rendering[params.panel].width + rendering[params.panel].page.horizontal_space;
						if (rendering[params.panel].page.width > rendering[params.panel].container.width) {
							rendering[params.panel].container.width = rendering[params.panel].page.width;
						} else {
							rendering[params.panel].page.width = rendering[params.panel].container.width - rendering[params.panel].page.horizontal_space;
						}

						rendering[params.panel].page.height = rendering[params.panel].height + rendering[params.panel].page.vertical_space;
						if (rendering[params.panel].page.height > rendering[params.panel].container.height) {
							rendering[params.panel].container.height = rendering[params.panel].page.height;
						} else {
							rendering[params.panel].page.height = rendering[params.panel].container.height - rendering[params.panel].page.vertical_space;
						}

						// Calculate page dimensions
						rendering[params.panel].per_row = Math.floor(rendering[params.panel].page.width / rendering[params.panel].width);
						rendering[params.panel].page.width = rendering[params.panel].per_row * rendering[params.panel].width;

						rendering[params.panel].row_count = Math.floor(rendering[params.panel].page.height / rendering[params.panel].height);
						rendering[params.panel].page.height = rendering[params.panel].row_count * rendering[params.panel].height;

						rendering[params.panel].per_page = rendering[params.panel].per_row * rendering[params.panel].row_count;

						rendering[params.panel].page.count = Math.ceil(params.item_count / rendering[params.panel].per_page);

						// If there are multiple pages, setup the thumbnail navigation and recalculate page and container dimensions
						if (rendering[params.panel].page.count > 1) {
							if (item_panels[params.panel].pagination) {
								item_panels[params.panel].pagination.next.css('display', 'block');
								item_panels[params.panel].pagination.prev.css('display', 'block');
							} else {
								item_panels[params.panel].wrapper.append('<a href="#" class="navigation ' + option[params.panel].pagination.direction + ' prev">Previous</a><a href="#" class="navigation ' + option[params.panel].pagination.direction + ' next">Next</a>');
								item_panels[params.panel].pagination = {
									prev: item_panels[params.panel].wrapper.find('> a.navigation.prev'),
									next: item_panels[params.panel].wrapper.find('> a.navigation.next')
								};

								item_panels[params.panel].pagination.next.click(function () {
									var current_page_index = item_panels[params.panel].pages.filter('.current').index();

									slider._items_panel.move_to_page(params.panel, current_page_index + 1);

									return false;
								});

								item_panels[params.panel].pagination.prev.click(function () {
									var current_page_index = item_panels[params.panel].pages.filter('.current').index();

									slider._items_panel.move_to_page(params.panel, current_page_index - 1);

									return false;
								});
							}

							if (option[params.panel].pagination.direction == 'vertical') {
								minimum_container_dimension = rendering[params.panel].height + rendering[params.panel].page.vertical_space + 2 * item_panels[params.panel].pagination.prev.outerHeight(true);
								if (minimum_container_dimension > rendering[params.panel].container.height)
									rendering[params.panel].container.height = minimum_container_dimension;

								item_panels[params.panel].pagination.next.css({ top: (rendering[params.panel].container.height - item_panels[params.panel].pagination.next.height())});

								rendering[params.panel].row_count = Math.floor((rendering[params.panel].container.height - 2 * item_panels[params.panel].pagination.prev.outerHeight(true) - rendering[params.panel].page.vertical_space) / rendering[params.panel].height);
								rendering[params.panel].page.height = rendering[params.panel].row_count * rendering[params.panel].height;
							} else {
								minimum_container_dimension = rendering[params.panel].width + rendering[params.panel].page.horizontal_space + 2 * item_panels[params.panel].pagination.prev.outerWidth(true);
								if (minimum_container_dimension > rendering[params.panel].container.width)
									rendering[params.panel].container.width = minimum_container_dimension;

								rendering[params.panel].per_row = Math.floor((rendering[params.panel].container.width - 2 * item_panels[params.panel].pagination.prev.outerWidth(true) - rendering[params.panel].page.horizontal_space) / rendering[params.panel].width);
								rendering[params.panel].page.width = rendering[params.panel].per_row * rendering[params.panel].width;
							}

							rendering[params.panel].per_page = rendering[params.panel].per_row * rendering[params.panel].row_count;

							rendering[params.panel].page.count = Math.ceil(params.item_count / rendering[params.panel].per_page);
						} else {
							if (item_panels[params.panel].pagination) {
								item_panels[params.panel].pagination.next.css('display', 'none');
								item_panels[params.panel].pagination.prev.css('display', 'none');
							}
						}

						item_panels[params.panel].wrapper.css(rendering[params.panel].container);

						rendering[params.panel].window_width = rendering[params.panel].page.width + rendering[params.panel].page.horizontal_space;
						rendering[params.panel].window_height = rendering[params.panel].page.height + rendering[params.panel].page.vertical_space;

						item_panels[params.panel].window
							.width(rendering[params.panel].window_width)
							.height(rendering[params.panel].window_height)
							.css({ top: Math.floor((rendering[params.panel].container.height - rendering[params.panel].window_height) / 2) });

						// Set page container dimensions and position it
						if (option[params.panel].pagination.direction == 'vertical') {
							item_panels[params.panel].container
								.width(rendering[params.panel].window_width)
								.height(0);
						} else {
							item_panels[params.panel].container
								.width(0)
								.height(rendering[params.panel].window_height);
						}

						slider.position_element(item_panels[params.panel].wrapper, option[params.panel].container.position);
					},

					move_to_page: function (panel, page_index) {
						var properties,
							max_page_index = item_panels[panel].pages.length - 1,
							move_to_nonexistant_offset = 10;

						if (max_page_index < 0)
							return;

						if (item_panels[panel].pages.eq(page_index).hasClass('current'))
							return;

						if (page_index > max_page_index) {
							if (option[panel].pagination.direction == 'vertical') {
								properties = {
									top: max_page_index * -(rendering[panel].page.height + rendering[panel].page.vertical_space) - move_to_nonexistant_offset
								};
							} else {
								properties = {
									left: max_page_index * -(rendering[panel].page.width + rendering[panel].page.horizontal_space) - move_to_nonexistant_offset
								};
							}

							item_panels[panel].container.animate(properties, 40, 'swing', function () {
								if (option[panel].pagination.direction == 'vertical') {
									properties = {
										top: max_page_index * -(rendering[panel].page.height + rendering[panel].page.vertical_space)
									};
								} else {
									properties = {
										left: max_page_index * -(rendering[panel].page.width + rendering[panel].page.horizontal_space)
									};
								}

								item_panels[panel].container.animate(properties, 50, 'swing');
							});

							return;
						} else if (page_index < 0) {
							if (option[panel].pagination.direction == 'vertical') {
								properties = {
									top: move_to_nonexistant_offset
								};
							} else {
								properties = {
									left: move_to_nonexistant_offset
								};
							}

							item_panels[panel].container.animate(properties, 40, 'swing', function () {
								if (option[panel].pagination.direction == 'vertical') {
									properties = {
										top: 0
									};
								} else {
									properties = {
										left: 0
									};
								}
								item_panels[panel].container.animate(properties, 50, 'swing');
							});

							return;
						}

						item_panels[panel].pages.removeClass('current').eq(page_index).addClass('current');

						if (option[panel].pagination.direction == 'vertical') {
							properties = {
								top: page_index * -(rendering[panel].page.height + rendering[panel].page.vertical_space)
							};
						} else {
							properties = {
								left: page_index * -(rendering[panel].page.width + rendering[panel].page.horizontal_space)
							};
						}

						item_panels[panel].container.stop(true, false).animate(properties, option[panel].pagination.duration, option[panel].pagination.easing);
					}
				},

				thumbnails: {
					init: function () {
						item_panels.thumbs = {
							container: $('<div class="thumb_container" />'),
							window: $('<div class="thumb_window" />'),
							wrapper: $('<div class="thumb_wrapper" />')
						}

						item_panels.thumbs.window.append(item_panels.thumbs.container);
						item_panels.thumbs.wrapper.append(item_panels.thumbs.window);

						$t.prepend(item_panels.thumbs.wrapper);

						slider._items_panel.init({
							panel: 'thumbs',
							page: $('<ul />'),
							item: $('<li><img src="' + slider_content[0].items[0].thumb.src + '" alt="" style="width: ' + option.thumbs.width + 'px !important; height: ' + option.thumbs.height + 'px !important;" /></li>')
						});

						if (option.thumbs.auto_hide) {
							item_panels.thumbs.wrapper.css({
								display: 'none'
							});

							$t.hover(function () {
								item_panels.thumbs.wrapper.stop().fadeTo(option.thumbs.hide_speed, 1);
							}, function () {
								item_panels.thumbs.wrapper.stop().fadeTo(option.thumbs.hide_speed, 0);
							});
						}

						slider.thumbnails.display_category(false);
						slider.thumbnails.select(current.item.index);
					},

					display_category: function () {
						var $page,
							thumb_html,
							thumb_caption,
							thumb_type_html,
							i = 0,
							preload_images = arguments.length > 0 && arguments[0] === false ? false : true,
							tooltip_content,
							empty_tooltip;

						if (!option.thumbs.display)
							return;

						slider._items_panel.calculate_pages({
							panel: 'thumbs',
							item_count: current.category.item_count
						});

						item_panels.thumbs.container.html('');

						for (; i < current.category.item_count; i++) {
							if (i % rendering.thumbs.per_page === 0) {
								if (option.thumbs.pagination.direction == 'vertical')
									item_panels.thumbs.container.height(item_panels.thumbs.container.height() + rendering.thumbs.window_height);
								else
									item_panels.thumbs.container.width(item_panels.thumbs.container.width() + rendering.thumbs.window_width);

								$page = $('<ul />');
								$page
									.width(rendering.thumbs.page.width)
									.height(rendering.thumbs.page.height)
									.appendTo(item_panels.thumbs.container);
							}

							thumb_caption = option.thumbs.captions && typeof current.category.items[i].thumb.caption == 'string' && current.category.items[i].thumb.caption ? '<div class="caption_wrapper"><div class="caption">' + current.category.items[i].thumb.caption + '</div></div>' : '';
							thumb_type_html = option.thumbs.display_item_types ? '<span class="item_type_icon ' + current.category.items[i].type + '"></span>' : '';

							thumb_html = '<li><img style="width: ' + option.thumbs.width + 'px !important; height: ' + option.thumbs.height + 'px !important;" src="' + current.category.items[i].thumb.src + '" alt="" />' + thumb_type_html + thumb_caption;

							if (preload_images) {
								$('<img />')
									.load(
										{
											index: i
										}, function (e) {
											item_panels.thumbs.pages.find('.thumb_preloading').eq(e.data.index).fadeTo(500, 0, function () {
												$(this).remove();
											});
										}
									)
									.attr('src', current.category.items[i].thumb.src);

								thumb_html += '<div class="thumb_preloading"></div>';
							}

							$page.append(thumb_html + '</li>');

							if (option.thumbs.tooltips.enabled && $.fn.qtip) {
								empty_tooltip = true;
								tooltip_content = '';

								if (current.category.items[i].thumb.tooltip) {
									if (option.thumbs.tooltips.title && current.category.items[i].thumb.tooltip.title) {
										tooltip_content = '<p class="title">' + current.category.items[i].thumb.tooltip.title + '</p>';
										empty_tooltip = false;
									}

									if (option.thumbs.tooltips.description && current.category.items[i].thumb.tooltip.description) {
										tooltip_content += '<div class="description">' + current.category.items[i].thumb.tooltip.description + '</div>';
										empty_tooltip = false;
									}

									if (!empty_tooltip)
										$page.find('> li').filter(':last').qtip({
											content: {
												text: tooltip_content
											},
											position: option.thumbs.tooltips.position,
											style: {
												classes: 'chameleon_slider_tooltip ' + option.thumbs.tooltips.classes,
												tip: {
													corner: true
												}
											}
										});
								}
							}
						}

						item_panels.thumbs.pages = item_panels.thumbs.container.find('> ul');
					},

					trigger: function () {
						item_panels.thumbs.container.delegate('ul > li', 'click', function () {
							var $clicked = $(this);

							slider.show_item($clicked.parent().index() * rendering.thumbs.per_page + $clicked.index());

							return false;
						});
					},

					select: function (index) {
						if (!option.thumbs.display)
							return;

						var $new_item = item_panels.thumbs.pages.find('> li').eq(index);

						slider._items_panel.move_to_page('thumbs', $new_item.parent().index());

						item_panels.thumbs.pages.find('> li.on').removeClass('on');
						$new_item.addClass('on');
					}
				},

				categories: {
					init: function () {
						item_panels.categories = {
							container: $('<div class="categories_container" />'),
							window: $('<div class="categories_window" />'),
							wrapper: $('<div class="categories_wrapper ' + option.categories.pagination.direction + '" />')
						}

						item_panels.categories.window.append(item_panels.categories.container);
						item_panels.categories.wrapper.append(item_panels.categories.window);

						$t.prepend(item_panels.categories.wrapper);

						slider._items_panel.init({
							panel: 'categories',
							page: $('<ul />'),
							item: $('<li style="width: ' + option.categories.width + 'px; height: ' + option.categories.height + 'px;" />')
						});

						if (option.categories.auto_hide) {
							item_panels.categories.wrapper.css({
								display: 'none'
							});

							$t.hover(function () {
								item_panels.categories.wrapper.stop().fadeTo(option.categories.hide_speed, 1);
							}, function () {
								item_panels.categories.wrapper.stop().fadeTo(option.categories.hide_speed, 0);
							});
						}

						slider.categories.display_categories();
					},

					display_categories: function () {
						var $page,
							category_html,
							categories = [],
							num_of_categories,
							i = 0,
							category_opened = selected_categories.indexes[selected_categories.indexes.length - 1],
							category_indexes,
							has_children,
							$first_category,
							$category_links,
							category_height;

						if (!option.categories.display)
							return;

						if (rendering.categories.render_categories) {
							if (selected_categories.indexes.length == 1) {
								categories = slider_content;
							} else {
								category_indexes = $.extend([], selected_categories.indexes);
								category_indexes.pop();
								categories = slider.get_category(category_indexes).children;

								categories = [{
									id: -1,
									name: '&lt;Back',
									open_parent: true
								}].concat(categories);

								category_opened++;
							}

							num_of_categories = categories.length;

							slider._items_panel.calculate_pages({
								panel: 'categories',
								item_count: num_of_categories
							});

							item_panels.categories.container.empty();

							for (i = 0; i < num_of_categories; i++) {
								if (i % rendering.categories.per_page === 0) {
									if (option.categories.pagination.direction == 'vertical')
										item_panels.categories.container.height(item_panels.categories.container.height() + rendering.categories.window_height);
									else
										item_panels.categories.container.width(item_panels.categories.container.width() + rendering.categories.window_width);

									$page = $('<ul />');
									$page
										.width(rendering.categories.page.width)
										.height(rendering.categories.page.height)
										.appendTo(item_panels.categories.container);
								}

								has_children = typeof categories[i].children != 'undefined' && categories[i].children.length > 0;

								category_html = '<li' + (categories[i].open_parent ? ' class="open_parent"' : '') + (has_children ? ' class="has_children"' : '') + ' style="width: ' + option.categories.width + 'px; height: ' + option.categories.height + 'px;"><a href="#" class="' + (categories[i].open_parent ? 'back_button' : 'category') + '"><span>' + categories[i].name + '</span></a>';

								if (has_children)
									category_html += '<a href="#" class="open_children"></a>';

								category_html += '</li>';

								$page.append(category_html);
							}

							item_panels.categories.pages = item_panels.categories.container.find('> ul');

							$category_links = item_panels.categories.pages.find('> li > a.category');
							$first_category = $category_links.eq(0);
							category_height = option.categories.height - ($first_category.outerHeight(true) - $first_category.height());

							$category_links.height(category_height);

							$category_links.each(function () {
								var $link = $(this),
									$span = $link.find('span'),
									height = $span.height();

								if (category_height > height)
									$span.css({
										top: Math.floor((category_height - height) / 2)
									});
								else
									$span.css({
										top: 0
									});
							});
						} else {
							if (selected_categories.indexes.length > 1)
								category_opened++;

							rendering.categories.render_categories = true;
						}

						slider.categories.select(category_opened);
					},

					trigger: function () {
						item_panels.categories.container.delegate('li > a', 'click', function () {
							var $clicked = $(this),
								$first_category,
								$parent = $clicked.parent(),
								$page = $parent.parent(),
								index = $page.index() * rendering.categories.per_page + $parent.index();

							$first_category = item_panels.categories.pages.find('> li').eq(0);

							if ($first_category.hasClass('open_parent'))
								index--;

							if ($clicked.hasClass('category')) {
								if ($parent.hasClass('on'))
									return false;

								selected_categories.indexes.pop();
								selected_categories.indexes.push(index);

								selected_categories.ids = slider.category_ids_from_indexes(selected_categories.indexes);

								current.category = slider.get_category(selected_categories.indexes);
								current.category.item_count = current.category.items.length;

								current.item = {
									id: current.category.items[0].id,
									index: 0
								};

								rendering.categories.render_categories = false;

								slider.change_category();
							} else if ($clicked.hasClass('open_children')) {
								selected_categories.indexes.pop();
								selected_categories.indexes.push(index);
								selected_categories.indexes.push(0);

								selected_categories.ids = slider.category_ids_from_indexes(selected_categories.indexes);

								current.category = slider.get_category(selected_categories.indexes);
								current.category.item_count = current.category.items.length;

								current.item = {
									id: current.category.items[0].id,
									index: 0
								};

								slider.change_category();
							} else if ($clicked.hasClass('back_button')) {
								selected_categories.indexes.pop();

								selected_categories.ids = slider.category_ids_from_indexes(selected_categories.indexes);

								current.category = slider.get_category(selected_categories.indexes);
								current.category.item_count = current.category.items.length;

								current.item = {
									id: current.category.items[0].id,
									index: 0
								};

								slider.change_category();
							}

							return false;
						});
					},

					select: function (index) {
						var $new_item = item_panels.categories.pages.find('> li').eq(index);

						slider._items_panel.move_to_page('categories', $new_item.parent().index());

						item_panels.categories.pages.find('> li.on').removeClass('on');
						$new_item.addClass('on');
					}
				},

				change_category: function () {
					slider.main_panel.display_category();
					slider.categories.display_categories();
					slider.thumbnails.display_category();
					slider.pagination.display_category();
					slider.gallery_title.select();
					slider.gallery_info.display();
					slider.arrows.display_category();
					slider.autoplay_toggle.display_category();
					slider.autoplay.display_category();

					slider.show_item(current.item.index, true);
				},

				arrows: {
					init: function () {
						$navigation_prev = $('<a href="#" class="navigation_button prev">Previous</a>');
						$navigation_next = $('<a href="#" class="navigation_button next">Next</a>');

						$t.prepend($navigation_prev, $navigation_next);

						slider.position_element($navigation_prev, option.arrows.prev.position);
						slider.position_element($navigation_next, option.arrows.next.position);

						slider.arrows.display_category();
					},

					trigger: function () {
						$navigation_prev.click(function () {
							slider.prev();

							return false;
						});
						$navigation_next.click(function () {
							slider.next();

							return false;
						});

						if (option.arrows.auto_hide) {
							$navigation_prev.fadeTo(0, 0);
							$navigation_next.fadeTo(0, 0);
							$t.hover(function () {
								if (current.category.item_count == 1)
									return;

								$navigation_prev.stop().fadeTo(option.arrows.hide_speed, 1);
								$navigation_next.stop().fadeTo(option.arrows.hide_speed, 1);
							}, function () {
								$navigation_prev.stop().fadeTo(option.arrows.hide_speed, 0);
								$navigation_next.stop().fadeTo(option.arrows.hide_speed, 0);
							});
						}
					},

					display_category: function () {
						var display = '';

						if (current.category.item_count == 1)
							display = 'none';

						$navigation_prev.css('display', display);
						$navigation_next.css('display', display);
					}
				},

				_title_box: {
					init: function (props) {
						var $text_span,
							text_span_top;

						rendering.title_boxes[props.box] = $('<span class="title_box' + (props.custom_class ? ' ' + props.custom_class : '') + '" style="height: ' + option.title_boxes[props.box].height + 'px;"><span>T</span></span>');

						$text_span = rendering.title_boxes[props.box].find('> span');

						rendering.title_boxes[props.box].css('visibility', 'hidden');

						$t.prepend(rendering.title_boxes[props.box]);

						slider.position_element(rendering.title_boxes[props.box], option.title_boxes[props.box].position);

						text_span_top = Math.floor((option.title_boxes[props.box].height - $text_span.height()) / 2);

						if (text_span_top < 0)
							text_span_top = 0

						$text_span
							.css({
								top: text_span_top
							})
							.empty();

						rendering.title_boxes[props.box].css('visibility', '');
					},

					change_text: function (props) {
						if (!props.text) {
							rendering.title_boxes[props.box]
								.stop()
								.fadeTo(200, 0);
						} else {
							if (rendering.title_boxes[props.box].is(':visible')) {
								rendering.title_boxes[props.box]
									.stop()
									.fadeTo(200, 0, function () {
										rendering.title_boxes[props.box]
											.fadeTo(400, 1)
											.find('> span')
												.html(props.text);
									});
							} else {
								rendering.title_boxes[props.box]
									.stop()
									.fadeTo(400, 1)
									.find('> span')
										.html(props.text);
							}
						}
					}
				},

				item_title: {
					init: function () {
						slider._title_box.init({
							box: 'current_item',
							custom_class: 'current_item'
						});

						slider.item_title.select(current.item.index);
					},

					select: function (index) {
						if (!option.title_boxes.current_item.display)
							return;

						slider._title_box.change_text({
							box: 'current_item',
							text: current.category.items[index].title
						});
					},

					size: function () {
						if (!option.title_boxes.current_item.display)
							return;

						slider.position_element(rendering.title_boxes.current_item, option.title_boxes.current_item.position);
					}
				},

				gallery_title: {
					init: function () {
						slider._title_box.init({
							box: 'current_gallery',
							custom_class: 'current_gallery'
						});

						slider.gallery_title.select();
					},

					select: function () {
						if (!option.title_boxes.current_gallery.display)
							return;

						slider._title_box.change_text({
							box: 'current_gallery',
							text: current.category.name
						});
					},

					size: function () {
						if (!option.title_boxes.current_gallery.display)
							return;

						slider.position_element(rendering.title_boxes.current_gallery, option.title_boxes.current_gallery.position);
					}
				},

				triggers: function () {
					if (option.arrows.display) {
						slider.arrows.trigger();
					}
					if (option.thumbs.display) {
						slider.thumbnails.trigger();
					}
					if (option.categories.display) {
						slider.categories.trigger();
					}
					if (option.key_browse) {
						slider.key_browse();
					}
					if (option.autoplay.enable) {
						slider.autoplay.start();
					}
					if (option.autoplay.pause_on_hover) {
						$t.hover(function () {
							if (current.category.item_count < 2)
								return;

							if (autoplay.user_paused || autoplay.pause)
								return;

							autoplay.pause = true;
							slider.autoplay.pause();
						}, function () {
							if (current.category.item_count < 2)
								return;

							autoplay.pause = false;

							if (autoplay.video_playing || autoplay.user_paused || autoplay.transition_in_progres)
								return;

							slider.autoplay.start();
						});
					}

					$t.bind('resize_slider', function () {
						slider.autoplay.reset();

						$t.css(rendering.container_dimensions);

						slider.main_panel.size();
						slider.autoplay.size();

						slider._scrollable_boxes.size('gallery_info');
						slider._scrollable_boxes.size('item_info');

						slider.gallery_title.size();
						slider.item_title.size();

						slider.thumbnails.display_category(false);
						slider.categories.display_categories();

						if (option.pagination.display)
							slider.position_element($pagination, option.pagination.position);

						if (option.autoplay_toggle.display)
							slider.position_element($autoplay_toggle, option.autoplay_toggle.position);

						if (option.arrows.display) {
							slider.position_element($navigation_prev, option.arrows.prev.position);
							slider.position_element($navigation_next, option.arrows.next.position);
						}

						slider.show_item(current.item.index, true, '');
					});

					$loading_overlay.fadeOut(200, function () {
						$loading_overlay.remove();
					})

					$t.trigger('slider_initialized');
				},

				get_dimensions: function (d) {
					var reference;

					if (arguments.length > 1 && typeof arguments[1] == 'object')
						reference = arguments[1];
					else
						reference = {
							width: rendering.container_dimensions.width,
							height: rendering.container_dimensions.height
						};

					return { width: (d.w_as_ratio ? Math.floor(reference.width * d.width) : d.width), height: (d.h_as_ratio ? Math.floor(reference.height * d.height) : d.height) };
				},

				position_element: function (element, position) {
					var v_offset = position.v_as_ratio ? Math.floor(position.v_offset * rendering.container_dimensions.height) : position.v_offset,
						h_offset = position.h_as_ratio ? Math.floor(position.h_offset * rendering.container_dimensions.width) : position.h_offset;

					if (position.v_center_point)
						v_offset -= Math.floor(element.outerHeight() / 2);

					if (position.h_center_point)
						h_offset -= Math.floor(element.outerWidth() / 2);

					if (position.vertical == 'top') {
						element.css('top', v_offset);
					} else {
						element.css({
							top: 'auto',
							bottom: v_offset
						});
					}

					if (position.horizontal == 'left') {
						element.css('left', h_offset);
					} else {
						element.css({
							left: 'auto',
							right: h_offset
						});
					}
				},

				category_indexes_from_ids: function (ids, categories) {
					var i = 0,
						num_of_cats,
						next_index = [];

					if (ids.length == 0) {
						return [];
					}

					num_of_cats = $.isArray(categories) ? categories.length : 0;
					for (; i < num_of_cats; i++) {
						if (categories[i].id == ids[0]) {
							ids.shift();
							if (ids.length != 0) {
								next_index = slider.category_indexes_from_ids(ids, categories[i].children);
								if (next_index.length == 0) {
									return [];
								}
							}
							return [i].concat(next_index);
						}
					}

					return [];
				},

				category_ids_from_indexes: function (indexes) {
					var m = indexes.length,
						i = 1,
						ids,
						selected = slider_content[indexes[0]];

					ids = [selected.id];

					for (; i < m; i++) {
						selected = selected.children[indexes[i]];
						ids.push(selected.id);
					}

					return ids;
				},

				get_category: function (indexes) {
					var m = indexes.length,
						i = 1,
						selected;

					if (!$.isArray(indexes) || indexes.length == 0)
						return slider_content[0];

					selected = slider_content[indexes[0]];

					for (; i < m; i++)
						selected = selected.children[indexes[i]];

					return selected;
				},

				item_index_from_id: function (id) {
					var items = current.category.items,
						num_of_items = items.length,
						i = 0;

					if (id == undefined)
						return 0;

					for (; i < num_of_items; i++)
						if (items[i].id == id)
							return i;

					return 0;
				},

				set_url_param: function (url, param) {
					var url_hash = '',
						return_url = '',
						param_string = param + (arguments.length > 2 ? '=' + arguments[2] : ''),
						params,
						segment = false,
						found = false,
						i;

					url = url.split('#');

					if (url.length == 1) {
						url_hash = false;
					} else {
						url_hash = url[1];
					}

					url = url[0].split('?');
					if (url.length == 1 || url[1] == '') {
						return_url = url[0] + '?' + param_string;
					} else {
						return_url = url[0] + '?';

						params = url[1].split('&');
						for (i in params) {
							if (typeof params[i] != 'string')
								continue;

							segment = params[i].split('=');

							if (segment[0] == param) {
								found = true;
								return_url += param_string + '&';
							} else {
								if (segment.length == 1) {
									return_url += segment[0] + '&';
								} else {
									return_url += segment[0] + '=' + segment[1] + '&';
								}
							}
						}

						if (found)
							return_url = return_url.substring(0, return_url.length - 1);
						else
							return_url += param_string;
					}

					return return_url + (url_hash === false ? '' : '#' + url_hash);
				}
			};

			slider.init();
		});
	};

	$.fn.chameleonSliderFullscreen = function (options) {
		var $fullscreenContainer,
			$theSlider,
			resize_deley_timeout,
			close_fullscreen = function () {
				$fullscreenContainer.fadeTo(500, 0, function () {
					$theSlider.trigger('destroy');
					$fullscreenContainer.remove();
				});

				$(document).unbind('keydown.chameleonslider_fullscreen');
			};

		$fullscreenContainer = $('<div id="chameleonSliderFullscreen_' + options.module_id + '" style="z-index: 15000; overflow: hidden; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, .5);"><div class="chameleon_slider ' + options.theme + '" /></div>');

		$('body').append($fullscreenContainer);

		$theSlider = $fullscreenContainer.find('> .chameleon_slider');

		$.extend(true, options, {
			container_dimensions: {
				width: 1,
				height: 1,
				w_as_ratio: true,
				h_as_ratio: true
			},
			autoplay: {
				pause_on_hover: false
			},
			buttons: {
				exit_fullscreen: {
					display: true
				},
				fullscreen: {
					display: false
				}
			},
			main_panel: {
				stretch_small_image: true
			}
		});

		$theSlider.bind('slider_initialized', function () {
			$theSlider.find('> .exit_fullscreen').click(function () {
				close_fullscreen();
				return false;
			});

			$(document).bind('keydown.chameleonslider_fullscreen', function(e) {
				if (e.which == 27)
					close_fullscreen();
			});
		});

		$theSlider[pluginName](options);
	};
}(eds1_8, window, document));
