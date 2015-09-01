package Engine.Screens
{
	import flash.display.MovieClip;
	import flash.events.EventDispatcher;
	
	import Engine.EntryPoint;
	
	[Event(name="ENTER", type="Engine.Screens.ScreenEvent")]
	[Event(name="CHANGE", type="Engine.Screens.ScreenEvent")]
	[Event(name="EXIT", type="Engine.Screens.ScreenEvent")]
	
	public class Screen extends EventDispatcher
	{
		protected var _model:MovieClip;
		private var _destinyScreen:String;
		
		public function Screen(model:String)
		{
			this._model = EntryPoint.instance.assetsManager.getMovieClip(model);
		}
		
		public function enter():void
		{
			throw new Error("Implementar enter");
		}
		
		public function change(destinyScreen:String):void
		{
			var screenEvent:ScreenEvent = new ScreenEvent(ScreenEvent.CHANGE);
			screenEvent.destinyScreen = destinyScreen;
			dispatchEvent(screenEvent);
		}
		
		public function exit():void
		{
			this._model = null;
		}
	}
}