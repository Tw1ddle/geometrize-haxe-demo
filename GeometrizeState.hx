package;

import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import haxe.io.Bytes;
import openfl.utils.ByteArray;
import geometrize.Model.ShapeResult;
import geometrize.Util;
import geometrize.bitmap.Bitmap;
import geometrize.bitmap.Rgba;
import geometrize.runner.ImageRunner;
import geometrize.runner.ImageRunnerOptions;
import geometrize.shape.Circle;
import geometrize.shape.Ellipse;
import geometrize.shape.Line;
import geometrize.shape.Rectangle;
import geometrize.shape.RotatedEllipse;
import geometrize.shape.RotatedRectangle;
import geometrize.shape.Triangle;
import flixel.math.FlxPoint;

/**
 * Simple image conversion demo state for Geometrize Haxe. Recreates an image as a collection of shapes.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class GeometrizeState extends FlxSubState {
	/**
	 * The input image that will be be approximated as a collection of shapes.
	 */
	private var sourceImage:FlxSprite;
	/**
	 * Sprite that has the image data from the Geometrize Haxe model rendered to it continually.
	 */
	private var currentImage:FlxSprite;
	/**
	 * Sprite that has the shape data from the Geometrize Haxe model rendered to it continually.
	 */
	private var initialShapeImageFilled:Bool = false;
	private var shapeImage:FlxSprite;
	/**
	 * Sprite that has only shape data from the most recent step of the Geometrize Haxe model rendered to it.
	 */
	private var currentShapeImage:FlxSprite;
	
	/**
	 * The runner that will do the image conversion.
	 */
	private var runner:ImageRunner;
	/**
	 * The runtime options that the runner uses.
	 */
	private var runnerOptions:ImageRunnerOptions;
	
	public function new(sourceImagePath:String, runnerOptions:ImageRunnerOptions) {
		super();
		sourceImage = new FlxSprite(0, 0, sourceImagePath); // Load the source/target image
		this.runnerOptions = runnerOptions;
	}
	
	#if flash
	private var pixelConversionFunc:Bytes->Bytes = PixelFormatHelpers.rgbaToBgra;
	#else
	private var pixelConversionFunc:Bytes->Bytes = PixelFormatHelpers.rgbaToArgb;
	#end
	
	/**
	 * The background color of the source image.
	 */
	private var backgroundColor:Rgba;
	
	/**
	 * Setup the demo.
	 */
	override public function create():Void {
		super.create();
		bgColor = FlxColor.WHITE;
		
		// Display the original image
		add(sourceImage);
		
		var width:Int = Std.int(sourceImage.width);
		var height:Int = Std.int(sourceImage.height);
		
		var makeSprite = function(x:Float = 0, y:Float = 0):FlxSprite {
			var sprite = new FlxSprite(x, y);
			sprite.makeGraphic(width, height, FlxColor.TRANSPARENT, true);
			return sprite;
		}
		
		// Convert and draw the original image using Geometrize Haxe, to check this much works properly
		var sourceBitmap:Bitmap = Bitmap.createFromBytes(width, height, sourceImage.graphic.bitmap.getPixels(new openfl.geom.Rectangle(0, 0, width, height)));
		var sourceBytes:Bytes = sourceBitmap.clone().getBytes();
		
		currentImage = makeSprite(sourceImage.x + width);
		add(currentImage);
		
		shapeImage = makeSprite(currentImage.x + width, 0);
		add(shapeImage);
		
		currentShapeImage = makeSprite(shapeImage.x + width, 0);
		add(currentShapeImage);
		
		// Specify the conversion options
		var sourceCopy = PixelFormatHelpers.argbToRgba(sourceBitmap.clone().getBytes());
		var sourceBitmap:Bitmap = Bitmap.createFromBytes(width, height, sourceCopy);
		backgroundColor = Util.getAverageImageColor(sourceBitmap);
		runner = new ImageRunner(sourceBitmap, backgroundColor);
	}
	
	/**
	 * Update the state.
	 * @param	dt	Frame time delta.
	 */
	override public function update(dt:Float):Void {
		super.update(dt);
		
		var shapeData:Array<ShapeResult> = runner.step(runnerOptions); // Step the algorithm
		
		// Draw the image onto a HaxeFlixel sprite, setting the Geometrize Haxe data directly
		var imageData:Bitmap = runner.getImageData().clone();
		currentImage.graphic.bitmap.setPixels(new openfl.geom.Rectangle(0, 0, currentImage.width, currentImage.height), ByteArray.fromBytes(pixelConversionFunc(imageData.getBytes())));
		currentImage.dirty = true;
		currentImage.updateFramePixels();
		
		// Draw new shape data into some Flixel sprites
		if (!initialShapeImageFilled) {
			FlxSpriteUtil.fill(shapeImage, FlxColor.fromRGB(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a));
			initialShapeImageFilled = true;
		}
		
		FlxSpriteUtil.fill(currentShapeImage, FlxColor.fromRGB(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)); // Clear the current shape image
		
		for (result in shapeData) {
			var color:FlxColor = FlxColor.fromRGB(result.color.r, result.color.g, result.color.b, result.color.a);
			
			switch(Type.getClass(result.shape)) {
				case Rectangle:
					var rect:Rectangle = cast result.shape;
					var drawRect = function(sprite:FlxSprite) {
						FlxSpriteUtil.drawRect(sprite,
						Util.min(rect.x1, rect.x2), Util.min(rect.y1, rect.y2),
						Util.max(rect.x1, rect.x2) - Util.min(rect.x1, rect.x2) + 1, Util.max(rect.y1, rect.y2) - Util.min(rect.y1, rect.y2) + 1,
						color);
					};
					drawRect(shapeImage);
					drawRect(currentShapeImage);
				case Circle, Ellipse:
					var ellipse:Ellipse = cast result.shape;
					var drawEllipse = function(sprite:FlxSprite) {
						FlxSpriteUtil.drawEllipse(sprite, ellipse.x - ellipse.rx, ellipse.y - ellipse.ry, ellipse.rx * 2, ellipse.ry * 2, color);
					}
					drawEllipse(shapeImage);
					drawEllipse(currentShapeImage);
				case RotatedEllipse:
					var ellipse:RotatedEllipse = cast result.shape;
					var drawRotatedEllipse = function(sprite:FlxSprite) {
						trace("Flixel rendering of rotated ellipses not implemented"); //TODO
					}
					drawRotatedEllipse(shapeImage);
					drawRotatedEllipse(currentShapeImage);
				case RotatedRectangle:
					var rotatedRectangle:RotatedRectangle = cast result.shape;
					var drawRotatedRectangle = function(sprite:FlxSprite) {
						trace("Flixel rendering of rotated rectangles not implemented"); // TODO
					}
					drawRotatedRectangle(shapeImage);
					drawRotatedRectangle(currentShapeImage);
				case Triangle:
					var triangle:Triangle = cast result.shape;
					var drawTriangle = function(sprite:FlxSprite) {
						FlxSpriteUtil.drawPolygon(sprite, [ new FlxPoint(triangle.x1, triangle.y1), new FlxPoint(triangle.x2, triangle.y2), new FlxPoint(triangle.x3, triangle.y3) ], color);
					}
					drawTriangle(shapeImage);
					drawTriangle(currentShapeImage);
				case Line:
					var line:Line = cast result.shape;
					var drawLine = function(sprite:FlxSprite) {
						FlxSpriteUtil.drawLine(sprite, line.x1, line.y1, line.x2, line.y2, { thickness: 1.0, color: color });
					}
					drawLine(shapeImage);
					drawLine(currentShapeImage);
				default:
					throw "Cannot render, unhandled shape type";
			}
		}
	}
}