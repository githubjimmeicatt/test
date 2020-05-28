(function ($, window, undefined) {
	'use strict';

	var hideItemClass = 'edn__recentComments_hide',
		activeItemClass = 'edn__recentComments_active',
		itemsHiddenClass = 'edn__recentComments_itemsHidden',
		pageReadyClass = 'edn__recentComments_pageReady',
		loadingClass = 'edn__recentComments_loading',
		noContentClass = 'edn__recentComments_noContent',
		contentErrorClass = 'edn__recentComments_contentError',
		disablePreviousPageClass = 'edn__recentComments_disablePreviousPage',
		disableNextPageClass = 'edn__recentComments_disableNextPage',
		triggeredPreviousPageClass = 'edn__recentComments_triggeredPreviousPage',
		triggeredNextPageClass = 'edn__recentComments_triggeredNextPage',

		postShow = function () {
			var self = this;

			if (self.verticalLayout)
				self.resize();
		},

		showPage = function (contentKey, page) {
			var self = this;

			var itemCache = self.itemCache[contentKey],
				pageCache = itemCache.pages[page + ''];

			if (itemCache.activePage != page) {
				return;
			}

			self.$moduleWrapper
				.removeClass(pageReadyClass)
				.removeClass(loadingClass)
				.removeClass(noContentClass)
				.removeClass(contentErrorClass)
				.removeClass(disablePreviousPageClass)
				.removeClass(disableNextPageClass);

			clearTimeout(self.pageReadyTimeout);

			self.pageReadyTimeout = setTimeout(function () {
				self.$moduleWrapper.addClass(pageReadyClass);
			}, 100);

			if (itemCache.totalItemCount == 0) {
				self.$moduleWrapper.addClass(noContentClass);
				postShow.call(self);
				return;
			}

			if (itemCache.totalItemCount == -1 || (!pageCache.loaded && pageCache.requestError)) {
				self.$moduleWrapper.addClass(contentErrorClass);
				postShow.call(self);
				return;
			}

			if (pageCache.loaded) {
				if (page == 1)
					self.$moduleWrapper.addClass(disablePreviousPageClass);

				if (Math.ceil(itemCache.totalItemCount / self.options.itemsPerPage) <= page)
					self.$moduleWrapper.addClass(disableNextPageClass);

				self.$contentWrapper.replaceWith(pageCache.content);
				self.$contentWrapper = $('.edn__recentCommentsListContainer', self.$moduleWrapper);

				postShow.call(self);
			}
		},

		requestPage = function (contentKey, page) {
			var self = this,
				itemCache = self.itemCache[contentKey],
				pageCache;

			if (!itemCache) {
				itemCache = {
					pages: {},
					totalItemCount: -1,
					activePage: -1
				};

				self.itemCache[contentKey] = itemCache;
			}

			if (page < 1)
				page = 1;

			if (itemCache.totalItemCount != -1) {
				var numOfPages = Math.ceil(itemCache.totalItemCount / self.options.itemsPerPage);

				if (page > numOfPages)
					page = numOfPages;
			}

			itemCache.activePage = page;

			if (itemCache.totalItemCount == 0) {
				showPage.call(self, contentKey, page);
				return;
			}

			var pageKey = page + ''

			pageCache = itemCache.pages[pageKey];

			if (pageCache) {
				if (pageCache.loaded) {

					showPage.call(self, contentKey, page);
					return;
				}

				if (pageCache.requesting) {
					self.$moduleWrapper.addClass(loadingClass);
					return;
				}
			} else {
				itemCache.pages[pageKey] = pageCache = {
					content: '',
					loaded: false,
					requesting: true,
					requestError: false
				};
			}

			if (itemCache.totalItemCount == -1) {
				self.$moduleWrapper.addClass(disablePreviousPageClass + ' ' + disableNextPageClass);
			}

			self.$moduleWrapper.addClass(loadingClass);
			pageCache.requesting = true;

			var requestSuccessful = false,
				requestTotalItemCount = itemCache.totalItemCount == -1;

			$.ajax({
				type: 'GET',
				url: self.options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/RecentComments.ashx',
				cache: false,
				dataType: 'json',
				timeout: 15000,
				data: {
					portalId: self.options.portalId,
					moduleId: self.options.moduleId,
					tabId: self.options.tabId,
					contentPage: page,
					getPaginationMeta: requestTotalItemCount
				}
			})
				.done(function (response, status) {
					requestSuccessful = true;

					if (status == 'nocontent' || !$.isPlainObject(response)) {
						itemCache.totalItemCount = 0;
						pageCache.loaded = true;
						return;
					}

					if (requestTotalItemCount) {
						if (!response.contentCount) {
							requestSuccessful = false;
							return;
						}

						itemCache.totalItemCount = response.contentCount;
					}

					pageCache.content = response.contentHtml;
					pageCache.loaded = true;
				})
				.always(function () {
					pageCache.requesting = false;
					pageCache.requestError = !requestSuccessful;

					showPage.call(self, contentKey, page);
				});
		};

	function RecentComments(elem, options) {
		var self = this;

		self.options = options;
		self.itemCache = {};

		self.$moduleWrapper = $(elem);
		self.$contentWrapper = $('.edn__recentCommentsListContainer', self.$moduleWrapper);

		self.$moduleWrapper
			.on('click', '.edn__recentComments_previousPage, .edn__recentComments_nextPage', function () {
				var $this = $(this),
					nextPage = false;

				if ($this.hasClass('edn__recentComments_previousPage') && self.$moduleWrapper.hasClass(disablePreviousPageClass)) {
					return;
				}

				if ($this.hasClass('edn__recentComments_nextPage')) {
					if (self.$moduleWrapper.hasClass(disableNextPageClass)) {
						return;
					}

					nextPage = true;

					self.$moduleWrapper
						.addClass(triggeredNextPageClass)
						.removeClass(triggeredPreviousPageClass);
				} else {
					self.$moduleWrapper
						.addClass(triggeredPreviousPageClass)
						.removeClass(triggeredNextPageClass);
				}

				var activeItemContentKey = 'CommentsCache';

				var itemCache = self.itemCache[activeItemContentKey],
					page = 1;

				if (itemCache) {
					if (itemCache.totalItemCount <= 0)
						return;

					page = itemCache.activePage;
				}

				if (nextPage)
					page++;
				else
					page--;

				requestPage.call(self, activeItemContentKey, page);
			});

		self.itemCache['CommentsCache'] = {
			pages: {
				'1': {
					content: self.$contentWrapper[0].outerHTML,
					loaded: true,
					requesting: false,
					requestError: false
				}
			},
			totalItemCount: options.initialContentItemCount,
			activePage: 1
		};

		self.resize();

		self.$moduleWrapper.addClass('edn__recentComments_ready');

		$(window).on('resize', function () {
			self.resize();
		});
	}

	RecentComments.prototype = {
		resize: function (skipTimeout) {

			var self = this,
				hideItems = false;
		}
	};

	var instanceKey = 'edNewsRecentComments',
		defaultOptions = {
			websiteClientRoot: '/',
			portalId: 0,
			moduleId: 0,
			tabId: 0,
			itemsPerPage: 5,
			initialContentItemCount: 0
		};

	$.fn.edNewsRecentComments = function (options) {
		options = $.extend({}, defaultOptions, options);

		return this.each(function () {
			var $self = $(this);

			if ($self.data(instanceKey))
				return;

			$self.data(instanceKey, new RecentComments(this, options));
		});
	};

})(eds3_5_jq, window);