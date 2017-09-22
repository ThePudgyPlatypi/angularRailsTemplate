app.factory('posts', ['$http', function($http) {
	var o = {
		posts: []
	};

	o.get = function(id) {
		return $http.get('/posts/' + id + '.json').then(function(response) {
			return response.data
		});
	};

	o.getAll = function() {
		return $http.get('/posts.json').then(function(response) {
			angular.copy(response.data, o.posts);
		});
	};

	o.create = function(post) {
		return $http.post('/posts.json', post).then(function(response) {
			o.posts.push(response.data);
		});
	};

	o.addComment = function(id, comment) {
		return $http.post('/posts/' + id + '/comments.json', comment)
	}

	o.upvote = function(post) {
		return $http.put('/posts/' + post.id + '/upvote.json').then(function(response) {
			post.upvotes += 1;
		});
	};

	o.upvoteComment = function(post, comment) {
		return $http.put('/posts/' + post.id + '/comments/' + comment.id + '/upvote.json').then(function(response) {
			comment.upvotes += 1;
		});
	};

	return o;
}]);