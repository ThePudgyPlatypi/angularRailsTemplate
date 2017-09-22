app.controller('PostsCtrl', ['$scope', 'posts', 'post', function($scope, posts, post) {
	$scope.post = post;
	$scope.addComment = function() {
		if($scope.body === '') {
			return;
		}

		posts.addComment(post.id, {
			body: $scope.body,
		}).then(function(comment) {
			$scope.post.comments.push(comment.data);
			console.log($scope.post.comments);
		});

		$scope.body = '';
	}

	$scope.incrementUpvotes = function(comment) {
			posts.upvoteComment(post, comment);
	}		
}]);