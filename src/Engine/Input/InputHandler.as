package Engine.Input 
{
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public final class InputHandler
	{
		private var _keys:Array;
		private var _keysByName:Dictionary;
		
		public function InputHandler()
		{
			this._keys = new Array();
			this._keysByName = new Dictionary(true);
		}
		
		public function evKeyDown(keyEvent:KeyboardEvent):void
		{
			this._keys[keyEvent.keyCode] = true;
		}
		
		public function evKeyUp(keyEvent:KeyboardEvent):void
		{
			this._keys[keyEvent.keyCode] = false;
		}
		
		public function addRelationKey(key:int, name:String):void
		{
			this._keysByName[name] = key;
		}
		
		public function getKeyValue(name:String):Boolean
		{
			return this._keys[this._keysByName[name]];
		}
	}
}