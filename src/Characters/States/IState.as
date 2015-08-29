package Characters.States
{
	import Engine.Input.InputHandler;

	internal interface IState
	{
		function enter():void;		
		function update(inputHandler:InputHandler):void;
		function exit():void;
	}
}