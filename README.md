[![Project logo](https://github.com/Tw1ddle/geometrize-haxe-demo/blob/master/screenshots/logo.png?raw=true "Geometrize Haxe recreating images as geometric primitives logo")](http://tw1ddle.github.io/geometrize-haxe-demo/)

[Geometrize Haxe](https://github.com/Tw1ddle/geometrize-haxe/) is a Haxe library for recreating images with geometric primitives. This demo shows the library working with HaxeFlixel - run it [in your browser](http://tw1ddle.github.io/geometrize-haxe-demo/).

[![Geometrized Lady of Shalott](https://github.com/Tw1ddle/geometrize-haxe-demo/blob/master/screenshots/lady.jpg?raw=true "The Lady of Shalott ~300 Triangles and Ellipses")](http://tw1ddle.github.io/geometrize-haxe-demo/)

## Usage

The [demo](http://tw1ddle.github.io/geometrize-haxe-demo/) shows how images can be converted to shapes using Geometrize Haxe and then rendered as HaxeFlixel sprites. Open the demo and left click to cycle the example image being geometrized.

[![Geometrized Mona Lisa](https://github.com/Tw1ddle/geometrize-haxe-demo/blob/master/screenshots/monalisa.jpg?raw=true "Mona Lisa - Ellipses")](https://github.com/Tw1ddle/geometrize-haxe-demo/)

The leftmost sprite shows the input image, the second shows the shapes image rendered by the Geometrize Haxe library, the third shows the shape image rendered by the HaxeFlixel game engine, and the rightmost show the most recently added shape.

## Screenshots

[![Geometrized Chomsky](https://github.com/Tw1ddle/geometrize-haxe-demo/blob/master/screenshots/chomsky.jpg?raw=true "Chomsky")](https://github.com/Tw1ddle/geometrize-haxe-demo/)
[![Geometrized Surfer](https://github.com/Tw1ddle/geometrize-haxe-demo/blob/master/screenshots/surfer.jpg?raw=true "Surfer")](https://github.com/Tw1ddle/geometrize-haxe-demo/)

## Resources

* See the Geometrize [resources](https://github.com/Tw1ddle/geometrize-resources) and [template](https://github.com/Tw1ddle/geometrize-templates) repositories.
* See the Geometrize [haxelib code](https://github.com/Tw1ddle/geometrize-haxe) and library [documentation](http://tw1ddle.github.io/geometrize-haxe/).
* See the Geometrize [web demo](http://www.samcodes.co.uk/project/geometrize-haxe-web/) and web [demo code](https://github.com/Tw1ddle/geometrize-haxe-web/).
* See the HaxeFlixel Geometrize [demo](http://tw1ddle.github.io/geometrize-haxe-demo/) and the [demo code](https://github.com/Tw1ddle/geometrize-haxe-demo/).

## Notes
* This implementation is single-threaded, and performance varies by target platform. The first shapes usually take the longest to add, since larger shapes take longer to rasterize. Small target images are recommended - you probably do not need the detail anyway.
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Geometrize Haxe is based on [primitive](https://github.com/fogleman/primitive), a Go library created by [Michael Fogleman](https://github.com/fogleman).
* Geometrize Haxe is available as a [haxelib](https://lib.haxe.org/p/geometrize-haxe).
* This demo should work on all targets that HaxeFlixel supports.