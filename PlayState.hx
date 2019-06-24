package;

import flixel.FlxState;
import openfl.Lib;
import openfl.events.MouseEvent;
import geometrize.runner.ImageRunnerOptions;
import geometrize.shape.ShapeType;

/**
 * Helper class for associating an image resource with a set of options for generating shapes based on the image.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class ImageJob {
	public function new(sourceImagePath:String, imageRunnerOptions:ImageRunnerOptions) {
		this.sourceImagePath = sourceImagePath;
		this.imageRunnerOptions = imageRunnerOptions;
	}
	
	public var sourceImagePath:String;
	public var imageRunnerOptions:ImageRunnerOptions;
}

/**
 * Simple image conversion demo for Geometrize Haxe. Recreates images as collections of shapes.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class PlayState extends FlxState {
	private var imageJobs:Array<ImageJob> = [
		new ImageJob("images/lady_of_shalott_waterhouse.jpg", { shapeTypes: [ ShapeType.ELLIPSE, ShapeType.TRIANGLE ], alpha: 128, candidateShapesPerStep: 50, shapeMutationsPerStep: 50 }),
		new ImageJob("images/chomsky.jpg",{ shapeTypes: [ ShapeType.TRIANGLE ], alpha: 128, candidateShapesPerStep: 50, shapeMutationsPerStep: 50 }),
		new ImageJob("images/mona.jpg", { shapeTypes: [ ShapeType.ELLIPSE, ShapeType.CIRCLE ], alpha: 128, candidateShapesPerStep: 50, shapeMutationsPerStep: 50 }),
		new ImageJob("images/pearlearring.jpg", { shapeTypes: [ ShapeType.TRIANGLE ], alpha: 128, candidateShapesPerStep: 50, shapeMutationsPerStep: 50 }),
		new ImageJob("images/pine_forest_shishkin.jpg", { shapeTypes: [ ShapeType.RECTANGLE ], alpha: 128, candidateShapesPerStep: 50, shapeMutationsPerStep: 50 }),
		new ImageJob("images/stanczyk.jpg", { shapeTypes: [ ShapeType.ROTATED_ELLIPSE ], alpha: 128, candidateShapesPerStep: 50, shapeMutationsPerStep: 50 })
	];
	private var imageJobIdx:Int = 0;
	
	/**
	 * Setup the demo.
	 */
	override public function create():Void {
		super.create();
		persistentUpdate = true;
		
		openNextJob(); // Start geometrizing the initial example image
		
		// Cycle through examples images on mouse click
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):Void {
			openNextJob();
		});
	}
	
	private function openNextJob():Void {
		var job:ImageJob = imageJobs[imageJobIdx];
		imageJobIdx++;
		imageJobIdx %= imageJobs.length;
		openSubState(new GeometrizeState(job.sourceImagePath, job.imageRunnerOptions));
	}
}