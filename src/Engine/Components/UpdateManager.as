package Engine.Components
{
	import flash.display.Stage;
	import flash.events.Event;
	
	public final class UpdateManager implements IUpdateable
	{
		private var _updateFunctions:Vector.<Function>;
		private var _isPaused:Boolean;
		private var _stageRef:Stage;
		
		public function UpdateManager(stageRef:Stage)
		{
			this._updateFunctions = new Vector.<Function>();
			this._isPaused = false;
			this._stageRef = stageRef; 			
		}
		
		public function init():void
		{			
			this._stageRef.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public function update(ev:Event=null):void
		{
			if(!this._isPaused)
			{
				for (var i:int = 0; i < this._updateFunctions.length; i++) 
					this._updateFunctions[i].call();
			}
		}
		
		public function die():void
		{
			this._stageRef.removeEventListener(Event.ENTER_FRAME, update);
			this._updateFunctions = new Vector.<Function>();
		}
		
		public function add(updateFunction:Function):void
		{
			this._updateFunctions.push(updateFunction);
		}
		
		public function remove(updateFunction:Function):void
		{
			var index:int = this._updateFunctions.indexOf(updateFunction); 
			if(index != -1)
				this._updateFunctions.splice(index,1);
		}
		
		public function set isPaused(value:Boolean):void
		{
			this._isPaused = value;
		}
		
		public function get isPaused():Boolean
		{
			return this._isPaused;
		}
	}
}