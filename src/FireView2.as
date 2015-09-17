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

	class FireView2 extends Sprite
	{
		function FireView2()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		[Embed(source = "assets2/bg.png")]
		public var BackgroundImage:Class;
		[Embed(source = "assets2/particle.pex", mimeType = "application/octet-stream")]
		public var ParticleData:Class;
		[Embed(source = "assets2/texture.png")]
		public var ParticleImage:Class;

		private var emitterX:int = 0;
		private var emitterY:int = 0;

		private var bg:Image;

		private var particles:PDParticleSystem;
		
/*		public function stopEmitter():void{
			particles.stop();
		}*/
		
		public function setPosition(x:int, y:int):void
		{
			this.emitterX = x;
			this.emitterY = y;
			
			particles.emitterX = emitterX;
			particles.emitterY = emitterY;
		}

		private function addedToStageHandler(event:Event):void
		{
			// bg
			bg = Image.fromBitmap(new BackgroundImage());
			bg.width = stage.stageWidth;
			bg.height = stage.stageHeight;
			addChild(bg);

			// particles
			particles = new PDParticleSystem(
				XML(new ParticleData()),
				Texture.fromBitmap(new ParticleImage()));

			particles.start();
			Starling.juggler.add(particles);
			addChild(particles);

			// setPositionに移動
/*			particles.emitterX = emitterX;
			particles.emitterY = emitterY;*/

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
			
			// マウスに追従
			//particles.emitterX = touch.globalX;
			//particles.emitterY = touch.globalY;
		}
	}
}
