package Engine.Components
{
	import flash.events.Event;

	public interface IUpdateable
	{
		function init():void;
		function update(ev:Event = null):void;
		function die():void;
	}
}