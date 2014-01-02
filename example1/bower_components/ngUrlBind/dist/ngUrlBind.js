

(function(root, factory) {
  if (typeof define === 'function' && define.amd) {
    define(["angular","jsurl"], factory);
  } else if (typeof exports === 'object') {
    module.exports = factory(require('angular'),require('jsurl'));
  } else {
    root.ngUrlBind = factory(root.angular,root.JSURL);
  }
}(this, function() {

return angular.module('ngUrlBind', []).factory('ngUrlBind', function($location) {
  return function(scope, property) {
    if ($location.search()[property]) {
      if (typeof scope[property] === 'object') {
        angular.extend(scope[property], JSURL.parse($location.search()[property]));
      } else {
        scope[property] = JSURL.parse($location.search()[property]);
      }
    }
    scope.$watch((function() {
      return angular.toJson(scope[property]);
    }), function(v) {
      var querystring;
      querystring = $location.search();
      querystring[property] = JSURL.stringify(JSON.parse(v));
      return $location.search(querystring);
    }, true);
    return scope.$watch((function() {
      return $location.absUrl();
    }), function() {
      var newObject, newValue, oldObject, oldValue;
      if (typeof scope[property] === 'object') {
        newObject = JSON.stringify(JSURL.parse($location.search()[property]));
        oldObject = angular.toJson(scope[property]);
        if (newObject !== oldObject) {
          return angular.extend(scope[property], JSON.parse(newObject));
        }
      } else {
        newValue = JSURL.parse($location.search()[property]);
        oldValue = scope[property];
        if (newValue !== oldValue) {
          return scope[property] = newValue;
        }
      }
    });
  };
});
;

}));
