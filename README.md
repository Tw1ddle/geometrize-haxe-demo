[![Project logo](https://github.com/Tw1ddle/primitive-haxe-demo/blob/master/screenshots/logo.png?raw=true "Primitive Haxe recreating images as geometric primitives logo")](http://tw1ddle.github.io/primitive-haxe-demo/)

HaxeFlixel demo code for [Primitive Haxe](https://github.com/Tw1ddle/primitive-haxe/), a cross-platform Haxe library for recreating images with geometric primitives. Try the demo live in your browser [here](http://tw1ddle.github.io/primitive-haxe-demo/).

[![The Lady of Shalott](https://github.com/Tw1ddle/primitive-haxe/blob/master/screenshots/the_lady_of_shalott_waterhouse.jpg?raw=true "The Lady of Shalott as circles")](https://github.com/Tw1ddle/primitive-haxe-demo/)

## Usage

This demo shows how images can be converted to shapes using Primitive Haxe and then rendered using HaxeFlixel sprites. In the demo, the leftmost sprite shows the *target image*, the second shows the *current image* rendered by the Primitive Haxe library, the third shows a version of the *current image* with shapes rendered by the HaxeFlixel game engine, and the rightmost image shows shape(s) that were added during the last step of the algorithm.

Open the live demo in a web browser, and watch and wait. Left click to cycle the example image being geometrized.

Note that the first shapes that are added usually take longest, since these shapes take the longest to rasterize.

## Notes
* Got an idea or suggestion? Open an issue on GitHub, or send Sam a message on [Twitter](https://twitter.com/Sam_Twidale).
* Primitive Haxe is based on [primitive](https://github.com/fogleman/primitive), a Go library created by [Michael Fogleman](https://github.com/fogleman).
* Primitive Haxe is available as a [haxelib](https://lib.haxe.org/p/primitive-haxe).
* This demo should work on all targets that HaxeFlixel supports.
