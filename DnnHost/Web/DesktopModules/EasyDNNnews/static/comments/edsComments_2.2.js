(function ($, window) {
	'use strict';
	var $window = $(window),
		commentsDefaultOptions = {
			tabId: 0,
			portalId: 0,
			moduleId: 0,
			websiteClientRoot: '',
			comments: {
				requireAuthorInfo: true,
				useCaptcha: false,
				permissions: {
					editing: false,
					deleting: false
				}
			}
		},
		emailValidation = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/,
		commentVotedClass = 'edNews__commentVoting_voted',
		commentGoodVoteClass = 'edNews__commentVoting_upvote',
		commentBadVoteClass = 'edNews__commentVoting_downvote';

	$.fn.edsNewsComments = function (options) {
		options = $.extend({}, commentsDefaultOptions, options);

		var $mainListWrapper = this,
			requestInProgress = false,
			allCommentsLoaded = false;

		$mainListWrapper.on('click', '.edNews__commentVoting_trigger', function () {
			var $this = $(this),
				$commentContentWrapper = $this.parents('.edNews__commentContentWrapper').eq(0),
				$itemContainer = $this.parents('.edNews__itemCommentsWrapper').eq(0),
				$commentContainer = $commentContentWrapper.parent(),
				goodVotes = $commentContainer.data('goodVotes'),
				badVotes = $commentContainer.data('badVotes'),
				goodVoteTriggered = $this.hasClass(commentGoodVoteClass),
				userVoted = $commentContainer.data('userVoted'),
				previousRequest = $commentContainer.data('commentVoteRequest'),
				articleInfo = $itemContainer.data('articleInfo');

			if (previousRequest && previousRequest.readyState != 4)
				previousRequest.abort();

			if ($this.hasClass(commentVotedClass)) {
				$this.removeClass(commentVotedClass);
				userVoted = '';

				if (goodVoteTriggered) {
					if (goodVotes > 0)
						goodVotes -= 1;
				} else {
					if (badVotes > 0)
						badVotes -= 1;
				}
			} else {
				$this.addClass(commentVotedClass);

				if (goodVoteTriggered) {
					goodVotes += 1;

					if (userVoted == 'bad' && badVotes > 0)
						badVotes -= 1;

					userVoted = 'good';

					$('.' + commentBadVoteClass, $commentContentWrapper).removeClass(commentVotedClass);
				} else {
					badVotes += 1;

					if (userVoted == 'good' && goodVotes > 0)
						goodVotes -= 1;

					userVoted = 'bad';

					$('.' + commentGoodVoteClass, $commentContentWrapper).removeClass(commentVotedClass);
				}
			}

			$commentContainer
				.data('commentVoteRequest', $.ajax({
					type: 'GET',
					url: options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/Comments.ashx',
					dataType: 'json',
					data: {
						portalId: options.portalId,
						moduleId: options.moduleId,
						tabid: options.tabId,
						articleid: articleInfo.id,
						action: 'comment_vote',
						commentId: $commentContainer.data('commentId'),
						voteType: goodVoteTriggered ? 'good' : 'bad'
					},
					complete: function () {
						$commentContainer.data('commentVoteRequest', undefined);
					}
				}))
				.data('badVotes', badVotes)
				.data('goodVotes', goodVotes)
				.data('userVoted', userVoted);

			$('.edNews__commentVoting_badVotes', $commentContentWrapper).text(badVotes);
			$('.edNews__commentVoting_goodVotes', $commentContentWrapper).text(goodVotes);
		});

		$mainListWrapper
			.on('click', '.edNews__loadMoreCommentsTrigger', function (ev) {
				if (requestInProgress)
					return false;
				requestInProgress = true;
				var $this = $(this),
					$itemContainer = $this.parents('.edNews__itemCommentsWrapper').eq(0),
					articleInfo = $itemContainer.data('articleInfo'),
					position = $this.data('position');
				console.log('sada loadamo od pozicije:', position);
				$.ajax({
					type: 'GET',
					url: options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/Comments.ashx',
					dataType: 'json',
					data: {
						portalId: options.portalId,
						moduleId: options.moduleId,
						tabid: options.tabId,
						position: position,
						action: 'load_comments',
						articleId: articleInfo.id
					},
					success: function (response) {
						if (response.status != undefined && response.status == 'success') {

							$(response.responseMeta.CommentsHtml).appendTo($('.edNews__commentsListContainer', $itemContainer));
							if (response.responseMeta.ItemsRemaining < 1) {
								$this.parent().hide();
							} else {
								position = position + response.responseMeta.ItemsLoaded;
								$this.data('position', position);
								$('> .actionTextContainer > span', $this).text(response.responseMeta.ButtonText);
							}
						}
					},
					complete: function () {
						requestInProgress = false;
					}
				});
				ev.preventDefault();
				return false;
			})
			.on('click', '.edNews__commentsSubmitComment', function (e) {
				var $this = $(this),
					$commentsCommentFormWrapper = $this.parents('.edNews__commentsCommentFormWrapper').eq(0),
					$itemContainer = $this.parents('.edNews__itemCommentsWrapper').eq(0),
					$noCommentError = $('.edNews__commentsNoCommentError', $commentsCommentFormWrapper),
					$commentPendingApproval = $('.edNews__commentPendingApproval', $commentsCommentFormWrapper),
					$authorEmailInvalidError = $('.edNews__commentsInvalidEmailError', $commentsCommentFormWrapper),
					$authorNoEmailError = $('.edNews__commentsNoEmailError', $commentsCommentFormWrapper),
					$authorNoNameError = $('.edNews__commentsNoNameError', $commentsCommentFormWrapper),
					$authorNoCaptchaError = $('.edNews__commentsNoCaptchaError', $commentsCommentFormWrapper),
					$commentsListContainer = $('.edNews__commentsListContainer', $commentsCommentFormWrapper.parents('.edNews__itemCommentsWrapper')),

					$commentInput = $('.edNews__commentsCommentInput', $commentsCommentFormWrapper),
					$authorNameInput = $('.edNews__commentsAuthorNameInput', $commentsCommentFormWrapper),
					$authorEmailInput = $('.edNews__commentsAuthorEmailInput', $commentsCommentFormWrapper),

					$numberOfComments = $('.edNews__numberOfComments', $commentsCommentFormWrapper),
					captchaId = "0",
					articleInfo = $itemContainer.data('articleInfo'),
					comment = $commentInput.val(),
					authorName,
					authorEmail,
					params = {
						portalId: options.portalId,
						moduleId: options.moduleId,
						tabid: options.tabId,
						action: 'add_comment',
						articleid: articleInfo.id,
						tabid: options.tabId
					},
					errorOccurred = false,
					replyingToComment = false;

				if ($commentsCommentFormWrapper.hasClass('edNews__addingComment'))
					return;

				$noCommentError.removeClass('show');
				$authorEmailInvalidError.removeClass('show');
				$authorNoEmailError.removeClass('show');
				$authorNoNameError.removeClass('show');
				$authorNoCaptchaError.removeClass('show');
				$commentPendingApproval.removeClass('show');

				if (typeof comment != 'string' || comment == '') {
					errorOccurred = true;
					$noCommentError.addClass('show');
				}

				if (options.comments.requireAuthorInfo) {
					authorName = $authorNameInput.val();
					authorEmail = $authorEmailInput.val();

					if (typeof authorName != 'string' || authorName == '') {
						errorOccurred = true;
						$authorNoNameError.addClass('show');
					}

					if (typeof authorEmail != 'string' || authorEmail == '') {
						errorOccurred = true;
						$authorNoEmailError.addClass('show');
					} else if (!emailValidation.test(authorEmail)) {
						errorOccurred = true;
						$authorEmailInvalidError.addClass('show');
					}
				}

				if (options.comments.useCaptcha) {
					var captchaId = $(this).closest('.edNews__commentsCommentFormWrapper').find('.g-comments-recaptcha-id').text();
					params.captcha = grecaptcha.getResponse(captchaId);
					if (params.captcha.length == 0) {
						$authorNoCaptchaError.addClass('show');
						errorOccurred = true;
					}
				}

				if (!errorOccurred) {
					params.comment = comment;

					if (options.comments.requireAuthorInfo) {
						params.name = authorName;
						params.email = authorEmail;
					}

					if ($commentsCommentFormWrapper.hasClass('edNews__replyingToComment')) {
						params.parentId = $commentsCommentFormWrapper.data('parentId');
						replyingToComment = true;
					}

					$commentsCommentFormWrapper.addClass('edNews__addingComment');

					$.ajax({
						type: 'POST',
						url: options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/Comments.ashx',
						dataType: 'json',
						data: params,
						success: function (response) {
							var $itemCommentContainer;

							if (!response.status)
								return;

							$commentInput.val('');
							$authorNameInput.val('');
							$authorEmailInput.val('');

							if (response.status == 'success') {
								if (replyingToComment) {
									$itemCommentContainer = $($commentsCommentFormWrapper.data('parentElement'))
										.removeClass('edNews__noChildComments');
									$('> .edNews__childCommentsContainer', $itemCommentContainer).append(response.commentHtml);
									var $loadMoreCommentsButton = $('.edNews__loadMoreCommentsTrigger', $itemContainer),
										position = $loadMoreCommentsButton.data('position');
									if ($loadMoreCommentsButton.length > 0 && position) {
										position = position + 1;
										$loadMoreCommentsButton.data('position', position);
									}
								} else {
									$commentsListContainer
										.removeClass('noComments')
										.append(response.commentHtml);
								}

								articleInfo.commentCount += 1;
								$numberOfComments.text(articleInfo.commentCount);
							} else if (response.status == 'pendingApproval') {
								$commentPendingApproval.addClass('show');
							}
						},
						complete: function () {
							$commentsCommentFormWrapper.removeClass('edNews__addingComment edNews__replyingToComment');
							if (options.comments.useCaptcha) {
								grecaptcha.reset(captchaId);
							}
						}
					});
				}
			})
			.on('click', '.edNews__replyComment', function () {
				var $this = $(this),
					$itemCommentContainer = $this.parents('.edNews__commentContentWrapper').parent(),
					$itemCommentsWrapper = $this.parents('.edNews__itemCommentsWrapper').eq(0),
					$commentsCommentFormWrapper = $('.edNews__commentsCommentFormWrapper', $itemCommentsWrapper);

				$commentsCommentFormWrapper
					.addClass('edNews__replyingToComment')
					.data('parentId', $itemCommentContainer.data('commentId'))
					.data('parentElement', $itemCommentContainer[0]);
				$('.edNews__replyingToMessage > a', $commentsCommentFormWrapper).attr('href', '#' + $itemCommentContainer[0].id);
				$('.edNews__commentsCommentInput', $commentsCommentFormWrapper).val('').focus();
				$('.edNews_addComment > p', $commentsCommentFormWrapper).eq(0).append(' ' + $itemCommentContainer.data('authorName'));
			});

		if (options.comments.permissions.deleting) {
			var $commentsListContainer = $('.edNews__commentsListContainer', $mainListWrapper);
			$commentsListContainer.on('click', '.edNews__itemCommentContainer .edNews__deleteComment', function () {
				var $this = $(this),

					$commentsCommentFormWrapper = $this.parents('.edNews__itemCommentsWrapper').eq(0),
					$itemCommentContainer = $this.parents('.edNews__commentContentWrapper').parent(),
					$itemContainer = $itemCommentContainer.parents('.edNews__itemCommentContainer'),
					$numberOfComments = $('.edNews__numberOfComments', $commentsCommentFormWrapper),
					articleInfo = $commentsCommentFormWrapper.data('articleInfo'),
					commentRemoved = false,
					commentId = $itemCommentContainer.data('commentId');

				if (confirm('Do you really want to delete this comment?')) {
					if ($itemCommentContainer.hasClass('edNews__deletingComment'))
						return;

					$itemCommentContainer.addClass('edNews__deletingComment');

					$.ajax({
						type: 'GET',
						url: options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/Comments.ashx',
						dataType: 'json',
						data: {
							portalId: options.portalId,
							moduleId: options.moduleId,
							tabid: options.tabId,
							action: 'delete_comment',
							articleId: articleInfo.id,
							commentId: commentId
						},
						success: function (response) {
							if (response.status != undefined && response.status == 'success') {
								commentRemoved = true;
								console.log('delete response', response.result);
								if (response.result == "deleted") {
									var $loadMoreCommentsButton = $('.edNews__loadMoreCommentsTrigger', $commentsCommentFormWrapper),
										position = $loadMoreCommentsButton.data('position');
									if ($loadMoreCommentsButton.length > 0 && position) {
										position = position - 1;
										$loadMoreCommentsButton.data('position', position);
									}
								}

								if ($('.edNews__childCommentsContainer >', $itemCommentContainer).length == 0)
									$itemCommentContainer.slideUp(200, function () {
										var $commentContainerParent = $itemCommentContainer.parent(),
											noMoreChildComments = false;

										if ($commentContainerParent.hasClass('edNews__childCommentsContainer') && $itemCommentContainer.siblings().length == 0)
											noMoreChildComments = true;

										$itemCommentContainer.remove();

										if (noMoreChildComments)
											$commentContainerParent.parent().addClass('edNews__noChildComments');
									});
								else {
									$(".edNews__commentContent", $itemCommentContainer).eq(0).html(response.commentHtml);
									$(".edNews_commentActions", $itemCommentContainer).eq(0).remove();
									$itemCommentContainer.addClass('edNews__deleted');
								}

								if (articleInfo.commentCount > 0)
									articleInfo.commentCount -= 1;

								$numberOfComments.text(articleInfo.commentCount);

								if (commentId == $commentsCommentFormWrapper.data('parentId'))
									$commentsCommentFormWrapper
									.removeClass('edNews__replyingToComment')
									.data('parentId', undefined);
							}
						},
						complete: function () {
							$itemCommentContainer.removeClass('edNews__deletingComment');
						}
					});
				}
			});
		}

		if (options.comments.permissions.editing) {
			var $commentsListContainer = $('.edNews__commentsListContainer', $mainListWrapper);
			$commentsListContainer.on('click', '.edNews__itemCommentContainer .edNews__editComment', function () {
				var $this = $(this),
					$commentContentWrapper = $this.parents('.edNews__commentContentWrapper'),
					$itemCommentContainer = $commentContentWrapper.parent();

				if ($itemCommentContainer.hasClass('edNews__editingComment'))
					return;
				$('.edNews__editCommentContainer .edNews__editCommentContent', $commentContentWrapper).val($itemCommentContainer.data('rawComment'));

				$itemCommentContainer.addClass('edNews__editingComment');
			});

			$commentsListContainer.on('click', '.edNews__itemCommentContainer .edNews__editCommentContainer .edNews__editCommentCancelTrigger', function () {
				var $this = $(this),
					$editCommentContainer = $this.parents('.edNews__editCommentContainer');

				$editCommentContainer.parents('.edNews__commentContentWrapper').parent().removeClass('edNews__editingComment');

				$('.edNews__editCommentContent', $editCommentContainer).val('');
			});

			$commentsListContainer.on('click', '.edNews__itemCommentContainer .edNews__editCommentContainer .edNews__editCommentSaveTrigger', function () {
				var $this = $(this),
					$itemContainer = $this.parents('.edNews__itemCommentsWrapper').eq(0),
					$editCommentContainer = $this.parents('.edNews__editCommentContainer'),
					$commentContentWrapper = $editCommentContainer.parents('.edNews__commentContentWrapper'),
					$itemCommentContainer = $commentContentWrapper.parent(),
					$newComment = $('.edNews__editCommentContent', $editCommentContainer),
					articleInfo = $itemContainer.data('articleInfo'),
					commentId = $itemCommentContainer.data('commentId'),
					commentContent = $newComment.val();

				if ($itemCommentContainer.hasClass('edNews__savingChanges'))
					return;

				if (commentContent == '') {
					$('.edNews__commentsNoCommentError', $editCommentContainer).addClass('show');
					return;
				}

				$itemCommentContainer.addClass('edNews__savingChanges');

				$('.edNews__commentsNoCommentError', $editCommentContainer).removeClass('show');

				$.ajax({
					type: 'GET',
					url: options.websiteClientRoot + 'DesktopModules/EasyDNNnews/ashx/Comments.ashx',
					dataType: 'json',
					data: {
						portalId: options.portalId,
						moduleId: options.moduleId,
						tabid: options.tabId,
						articleid: articleInfo.id,
						action: 'edit_comment',
						comment: commentContent,
						commentId: commentId
					},
					success: function (response) {
						if (response.status != undefined && response.status == 'success') {
							$('.edNews__commentContent', $commentContentWrapper).html(response.comment);
							$newComment.val('');

							$itemCommentContainer.data('rawComment', commentContent);
						}
					},
					complete: function () {
						$itemCommentContainer.removeClass('edNews__savingChanges edNews__editingComment')
					}
				});
			});
		}
		return this;
	};
})(eds2_2, window);