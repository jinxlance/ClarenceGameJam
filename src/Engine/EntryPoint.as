package Engine
{
	import flash.display.Sprite;
	
	import Engine.Components.UpdateManager;
	import Engine.Resources.AssetsManager;
	import Engine.Screens.ScreenManager;

	public class EntryPoint extends Sprite
	{
		private static var _instance:EntryPoint;
		private var _assetsManager:AssetsManager;
		private var _screenManager:ScreenManager;
		private var _updateManager:UpdateManager;
		
		public function EntryPoint()
		{
			if(!_instance)
			{
				_instance = this;				
				this._assetsManager = new AssetsManager(new MC_Preloader(),stage.stageWidth/4,stage.stageHeight/2);
				this._screenManager = new ScreenManager();				
				this._updateManager = new UpdateManager(this.stage);				
			}
			else
				throw new Error("Ya existe la instancia.");			
		}
		
		public static function get instance():EntryPoint
		{
			if(!_instance)
				_instance = new EntryPoint();
			return _instance;
		}
		
		public function get assetsManager():AssetsManager
		{
			return this._assetsManager;
		}
		
		public function get screenManager():ScreenManager
		{
			return this._screenManager;
		}
				
		public function get updateManager():UpdateManager
		{
			return this._updateManager;
		}
	}
}