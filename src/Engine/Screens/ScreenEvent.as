package Engine.Screens
{
	import flash.events.Event;
	
	internal final class ScreenEvent extends Event
	{
		public static const ENTER:String = "ENTER";
		public static const CHANGE:String = "CHANGE";
		public static const EXIT:String = "EXIT";
		
		public var destinyScreen:String;
		public var parameters:Array;
		
		public function ScreenEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.parameters = new Array();
		}
		
		override public function clone():Event
		{
			return this;
		}
	}
}