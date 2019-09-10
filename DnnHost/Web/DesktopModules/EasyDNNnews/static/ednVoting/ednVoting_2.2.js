(function ($) {
	$.fn.ednArticleVoting = function (settings) {
		return this.each(function (i, el) {
			var votedCookie = $.cookie("EdnVoted" + settings.articleId);
			if (votedCookie) {
				$(this).addClass('edn__voted');
				if (votedCookie == "votedown" && $(this).hasClass('edn__voteArticleDown'))
					$(this).addClass('edn__votedDown');
				else if (votedCookie == "voteup" && $(this).hasClass('edn__voteArticleUp'))
					$(this).addClass('edn__votedUp');
			}

			var requestInProgress = false;

			$(this).on('click', function () {
				if ($(this).hasClass('edn__voted'))
					return false;

				if ($.cookie("EdnVoted" + settings.articleId))
					return false;

				if (requestInProgress)
					return false;

				var voteAction = '',
					$voteElement = $(this),
					requestInProgress = true;

				if ($(this).hasClass("edn__voteArticleUp")) {
					voteAction = "voteup";
				}
				else if ($(this).hasClass("edn__voteArticleDown")) {
					voteAction = "votedown";
				}
				else {
					requestInProgress = false;
					return;
				}

				$.ajax({
					type: 'GET',
					url: settings.sourceUrl,
					cache: false,
					dataType: 'json',
					timeout: 150000,
					data: {
						portalId: settings.portalId,
						moduleId: settings.moduleId,
						tabId: settings.tabId,
						articleId: settings.articleId,
						action: voteAction
					},
					success: function (response) {
						$($voteElement).find('.eds__voteCount').eq(0).text(response.message);
						$.cookie("EdnVoted" + settings.articleId, voteAction, { path: '/' });
						$("[class ^= 'edn__voteArticle']", '.eds_news_module_' + settings.moduleId).addClass('edn__voted');
						if (voteAction == "votedown")
							$(".edn__voteArticleDown", '.eds_news_module_' + settings.moduleId).addClass('edn__votedDown');
						else if (voteAction == "voteup")
							$(".edn__voteArticleUp", '.eds_news_module_' + settings.moduleId).addClass('edn__votedUp');
					},
					error: function (response) {
						console.log('error', response)
					},
					complete: function (response) {
						requestInProgress = false;
					}
				});
			});
		});
	};
})(eds2_2);
