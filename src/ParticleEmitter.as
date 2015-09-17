package 
{
	import flash.geom.Rectangle;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import starling.core.Starling;
	import starling.events.Event;

	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import starling.extensions.PDParticleSystem;
	import flash.utils.getTimer;
	import flash.events.Event;
	import fl.controls.progressBarClasses.IndeterminateBar;
	
	[SWF(frameRate = "60", backgroundColor = "#080808")]
	public class ParticleEmitter extends MovieClip
	{
		public var star:Starling;
		
		private var _root:FireView3;
		private var _particles:Vector.<PDParticleSystem>;		
		
		public function ParticleEmitter()
		{
			Starling.handleLostContext = true;
			_particles = new Vector.<PDParticleSystem>();
		}
		
		public function init():void {
			if (star != null) {
				trace("Starling is already initialized.");
				return;
			}
			
			star = new Starling(FireView3, stage, null, null);
			star.enableErrorChecking = false;
			star.showStatsAt("right", "top", 2);
			star.addEventListener(starling.events.Event.ROOT_CREATED, function(event:starling.events.Event):void {
				_root = star.root as FireView3;
				dispatchEvent(new flash.events.Event(flash.events.Event.INIT));
			});
		}
		
		public function get numParticles():int { return _root.numParticles; }
		
		public function showParticle(name:String, x:Number, y:Number, duration:Number = Number.MAX_VALUE):void {
			_root.showParticle(name, x, y, duration);
		}

		public function hideParticle(index:int, remove:Boolean = false):void {
			_root.hideParticle(index, remove);
		}
	}
}


