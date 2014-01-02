angular.module('ngUrlBind', [])
.factory 'ngUrlBind', ($location) ->
	(scope, property) ->
		if $location.search()[property]
			if typeof scope[property] == 'object'
				angular.extend(scope[property], JSURL.parse($location.search()[property]))
			else
				scope[property] = JSURL.parse($location.search()[property])

		scope.$watch (-> angular.toJson(scope[property])), (v) ->
			querystring = $location.search()
			querystring[property] = JSURL.stringify(JSON.parse(v))
			$location.search(querystring)
		, true

		scope.$watch (-> $location.absUrl()), ->
			if typeof scope[property] == 'object'
				newObject = JSON.stringify(JSURL.parse($location.search()[property]))
				oldObject = angular.toJson(scope[property])
				if newObject != oldObject
					angular.extend(scope[property], JSON.parse(newObject))
			else
				newValue = JSURL.parse($location.search()[property])
				oldValue = scope[property]
				if newValue != oldValue
					scope[property] = newValue