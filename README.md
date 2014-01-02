# urlBind

Easily bind AngularJS scope properties to your URL hash.

AngularJS's two-way binding allows you to bind data from a model to the DOM and back. urlBind allows you to additionally bind data from an AngularJS model to the URL hash and back. I guess that makes it four-way binding?

## Why?

urlBind is useful during development where you want to be able to hit refresh on your browser (or use livereload) without having AngularJS lose its scope state, or at least certain parts of it.

It is also useful in production, if you want your users to persist and exchange certain aspects of Angular's state. For instance think about exchange of URLs over email of IM, or just simple bookmarking.

urlBind is not for everything, and it's not for everywhere. But it's got its uses.

I haven't done any performance testing, but I wouldn't be surprised if it wasn't fantastic at this point. In object.Observer() we trust.

## How does it work?

urlBind's principle of operation is simple. Selected model properties are reflected to the url hash as the application is being used. They are then seeded back to the model when the page is loaded with the appropriate hash. We use the very elegant [jsurl](https://github.com/Sage/jsurl) to serialise JSON data to the URL as it becomes both more readable and shorter than using Base64.

## Binding a property

All you need is to inject the urlBind service into your controller and call

`urlBind($scope, 'propertyName')`

That's it. This will bind the user property of your current controller's scope to the URL hash.

Here's a more complete example:

```
angular.module('urlBindExample', ['urlBind'])
    .controller('mainCtrl', function($scope, urlBind){
        $scope.user = {}
        urlBind($scope, 'user')
    })
```

This will bind the state of the user property to the URL hash. Refreshing the page will restore the state of the user object through the URL hash.

## Installation

`bower install urlBind`

make sure urlBind/dist/urlBind.js is loaded before your angular module. urlBind is wrapped in the Universal Module Definition so it supports AMD, CommonJS, and plain ol' global declaration.

Make your angular module require the 'urlScope' module and inject the urlBind service into your controller. You're ready to go.

## Development

You'll need gulp installed globally and then run `npm install`. Once you're set up run `gulp build` to convert the source to a js file in /dist or simply run `gulp` to build continuously with a watcher.