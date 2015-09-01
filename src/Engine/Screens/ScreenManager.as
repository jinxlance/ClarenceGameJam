package Engine.Screens
{
	import flash.utils.Dictionary;

	public final class ScreenManager
	{
		private var _screens:Dictionary;
		private var _currentScreen:Screen;
		
		public function ScreenManager()
		{
			this._screens = new Dictionary(true);
		}
		
		public function registerScreen(name:String, screenClass:Class):void
		{
			this._screens[name] = screenClass;
		}
		
		public function loadScreen(name:String):void
		{
			if(this._currentScreen)
			{
				this._currentScreen.removeEventListener(ScreenEvent.CHANGE, screenChange);
				this._currentScreen.exit();
				this._currentScreen = null;
			}
			var screenClass:Class = this._screens[name];
			if(screenClass)
			{
				this._currentScreen = new screenClass();
				this._currentScreen.addEventListener(ScreenEvent.CHANGE, screenChange);
				this._currentScreen.enter();
			}
			else
				throw new Error("Screen '" + name + "' no encontrada o no registrada!");
		}
		
		public function screenChange(event:ScreenEvent):void
		{
			loadScreen(event.destinyScreen);
		}
	}
}