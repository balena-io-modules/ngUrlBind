# ngUrlBind

Easily bind AngularJS scope properties to your URL hash.

See a [simple example](http://resin-io.github.io/ngUrlBind/example1/) or an [advanced example](http://resin-io.github.io/ngUrlBind/example2/).

AngularJS's two-way binding allows you to bind data from a model to the DOM and back. ngUrlBind allows you to additionally bind data from an AngularJS model to the URL hash and back. Does that make it *four-way binding*?

While the whole Single-Page App thing is new and trendy, ngUrlBind is inspired by the "Hypermedia as the Engine of Application State" principle, one of the core components of [REST](http://en.wikipedia.org/wiki/Representational_state_transfer)'s Uniform Interface constraint.

## Why?

ngUrlBind is useful during development where you want to be able to hit refresh on your browser (or use livereload) without having AngularJS lose its scope state, or at least certain parts of it.

Subject to the limitations noted below, it is also useful in production, if you want your users to persist and exchange certain aspects of Angular's state. For instance think about exchange of URLs over email of IM, or just simple bookmarking.

We have made this as it's useful to us in both of these cases and are making it available to anyone else who may find it useful.

A major limitation is that ngUrlBind doesn't play well with AngularJS routing. We're fairly confident this can be remedied, but haven't had the need for now.

Another limitation is that the first user action creates a hash, which adds a step to the user's history. By strict HATEOAS this is correct, but this should probably be improved for the sake of UX and practicality.

ngUrlBind is not for everything, and it's not for everywhere. But it's got its uses.

I haven't done any performance testing, but I wouldn't be surprised if it wasn't fantastic at this point. In object.Observe() we trust.

## How does it work?

ngUrlBind's principle of operation is simple. Selected model properties are reflected to the URL hash as the AngularJS application is being used. They are then seeded back to the model when the page is loaded with the appropriate hash. We use the very elegant [jsurl](https://github.com/Sage/jsurl) to serialise JSON data to the URL as it becomes both more readable and shorter than using Base64.

## Binding a property

All you need is to inject the ngUrlBind service into your controller and call

`ngUrlBind($scope, 'propertyName')`

That's it. This will bind the user property of your current controller's scope to the URL hash.

Important: For the moment, only first-level properties are supported. So no dots in the 'propertyName' argument. Feel free to investigate and remove this limitation, pull requestes welcome.

Here's a more complete example:

```
angular.module('ngUrlBindExample', ['ngUrlBind'])
    .controller('mainCtrl', function($scope, ngUrlBind){
        $scope.user = {}
        ngUrlBind($scope, 'user')
    })
```

This will bind the state of the user property to the URL hash. Refreshing the page will restore the state of the user object through the URL hash.

## Installation

`bower install ngUrlBind`

make sure ngUrlBind/dist/ngUrlBind.js is loaded before your angular module. ngUrlBind is wrapped in the Universal Module Definition so it supports AMD, CommonJS, and plain ol' global declaration via script tag.

Make your angular module require the 'urlScope' module and inject the ngUrlBind service into your controller. You're ready to go.

## Development

You'll need to clone this repository, have gulp installed globally (via `npm install -g gulp`) and then run `npm install`.

Once you're set up run `gulp build` to convert the source to a js file in /dist or simply run `gulp` to build continuously with a watcher. The code in /example points to the version in /dist as a dead-simple way of testing.

## Future

At the end of the day this is a simple little module that's been used non-trivially in only one project. There's undoubtedly lots to fix, for which we welcome your pull requests and issues.