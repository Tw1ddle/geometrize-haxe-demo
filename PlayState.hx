package;

import flixel.FlxState;
import openfl.Lib;
import openfl.events.MouseEvent;
import primitive.runner.ImageRunner.ImageRunnerOptions;

/**
 * Helper class for associating an image resource and a set of options for generating primitives from the image.
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
 * Simple image conversion demo for Primitive Haxe. Converts an image into a set of primitives.
 * @author Sam Twidale (http://samcodes.co.uk/)
 */
class PlayState extends FlxState {
	private var imageJobs:Array<ImageJob> = [
		new ImageJob("images/chomsky.png", new ImageRunnerOptions()),
		new ImageJob("images/lady_of_shalott_waterhouse.png", new ImageRunnerOptions()),
		new ImageJob("images/mona.png", new ImageRunnerOptions()),
		new ImageJob("images/pearlearring.png", new ImageRunnerOptions()),
		new ImageJob("images/pine_forest_shishkin.png", new ImageRunnerOptions()),
		new ImageJob("images/stanczyk.png", new ImageRunnerOptions()),
		new ImageJob("images/primitive_haxe.png", new ImageRunnerOptions()),
		new ImageJob("images/test/gradient_black_to_white.png", new ImageRunnerOptions()),
		new ImageJob("images/test/gradient_red_to_black.png", new ImageRunnerOptions()),
		new ImageJob("images/test/gradient_red_to_white.png", new ImageRunnerOptions())
	];
	private var imageJobIdx:Int = 0;
	
	/**
	 * Setup the demo.
	 */
	override public function create():Void {
		super.create();
		persistentUpdate = true;
		
		openNextJob();
		
		Lib.current.stage.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):Void {
			// Cycle through image jobs on mouse click
			openNextJob();
		});
	}
	
	private function openNextJob():Void {
		var job:ImageJob = imageJobs[imageJobIdx];
		imageJobIdx++;
		imageJobIdx %= imageJobs.length;
		openSubState(new PrimitiveState(job.sourceImagePath, job.imageRunnerOptions));
	}
}