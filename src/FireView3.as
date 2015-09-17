package {
	import flash.geom.Rectangle;

	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	import fl.events.DataChangeEvent;

	class FireView3 extends Sprite
	{
		private var bg:Image;
		
		private var _particles:Vector.<PDParticleSystem>;

		function FireView3()
		{
			DataSet.init();
			_particles = new Vector.<PDParticleSystem>();
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		public function get numParticles():int { return _particles.length; }
		
		public function showParticle(name:String, x:Number, y:Number, duration:Number = Number.MAX_VALUE):PDParticleSystem {
			var data:Array = DataSet.getData(name);
			if (!data) {
				trace("Invalid particle name:", name);
				return null;
			}
			
			var ps:PDParticleSystem = new PDParticleSystem(
				XML(new data[1]),
				Texture.fromBitmap(new data[2])
			);
			ps.start(duration);
			ps.x = x;
			ps.y = y;
			ps.addEventListener(starling.events.Event.COMPLETE, _onParticleComplete);
			Starling.juggler.add(ps);
			addChild(ps);
			_particles.push(ps);
			
			return ps;
		}
		
		public function hideParticle(index:int, remove:Boolean = false):void {
			if (index < 0 || index >= _particles.length) {
				trace("hideParticle invalid index", index);
				return;
			}
			var ps:PDParticleSystem = _particles[index];
			ps.stop();
			if (remove) {
				_removeParticle(ps);
			} else {
				_particles.splice(index, 1);
			}
		}
		
		private function _removeParticle(ps:PDParticleSystem):void {
			if (ps.hasEventListener(starling.events.Event.COMPLETE)) {
				ps.removeEventListener(starling.events.Event.COMPLETE, _onParticleComplete);
			}
			var index:int = _particles.indexOf(ps);
			if (index != -1) {
				_particles.splice(index, 1);
			}
			Starling.juggler.remove(ps);
			if (ps.parent) {
				removeChild(ps);
			}
		}
		
		private function _onParticleComplete(event:starling.events.Event):void {
			var ps:PDParticleSystem = event.currentTarget as PDParticleSystem;
			trace("_onParticleComplete", ps);
			_removeParticle(ps);
		}
		
		private function addedToStageHandler(event:Event):void
		{
			// bg
//			bg = Image.fromBitmap(new BackgroundImage());
//			bg.width = stage.stageWidth;
//			bg.height = stage.stageHeight;
//			addChild(bg);

			stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
			stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
		}
		
		private function stage_resizeHandler(event:ResizeEvent):void
		{
			Starling.current.viewPort = new Rectangle(0, 0, event.width, event.height);
			stage.stageWidth = event.width;
			stage.stageHeight = event.height;

			bg.width = event.width;
			bg.height = event.height;
		}

		private function stage_touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.getTouch(stage);
		}
	}
}
