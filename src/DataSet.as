package {
	import flash.utils.Dictionary;

	class DataSet
	{
		function DataSet()
		{
	
		}
		
		// particle1
		[Embed(source = "assets/bg.png")]
		public static var BackgroundImage:Class;
		[Embed(source = "assets/particle.pex", mimeType = "application/octet-stream")]
		public static var ParticleData:Class;
		[Embed(source = "assets/texture.png")]
		public static var ParticleImage:Class;
		
		// particle2
		[Embed(source = "assets2/bg.png")]
		public static var BackgroundImage2:Class;
		[Embed(source = "assets2/particle.pex", mimeType = "application/octet-stream")]
		public static var ParticleData2:Class;
		[Embed(source = "assets2/texture.png")]
		public static var ParticleImage2:Class;
		
		private static var _dataSet:Dictionary;
		private static var _names:Vector.<String>;
		
		public static function init(){			
			if (_dataSet) {
				return;
			}
			
			// particle setup
			_dataSet = new Dictionary();
			_dataSet["Particle1"] = [BackgroundImage, ParticleData, ParticleImage];
			_dataSet["Particle2"] = [BackgroundImage2, ParticleData2, ParticleImage2];
			
			_names = new Vector.<String>();
			for (var name:String in _dataSet) {
				_names.push(name);
			}
		}
		
		public static function get names():Vector.<String> { return _names; }
		
		public static function getData(name:String):Array {
			return _dataSet[name];
		}
	}
}
