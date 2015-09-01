package Controllers
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import Characters.MainCharacter;
	
	import Engine.EntryPoint;
	import Engine.Components.IUpdateable;
	import Engine.Input.InputHandler;

	public final class UserController implements IUpdateable
	{
		private var _inputHandler:InputHandler;
		private var _mainCharacter:MainCharacter;		
		
		public function UserController(mainCharacter:MainCharacter)
		{
			this._inputHandler = new InputHandler();
			this._inputHandler.addRelationKey(Keyboard.D, "Adelante");
			this._inputHandler.addRelationKey(Keyboard.A, "Atras");
			this._inputHandler.addRelationKey(Keyboard.W, "Arriba");
			this._inputHandler.addRelationKey(Keyboard.S, "Abajo");			
			this._mainCharacter = mainCharacter;			
							
			EntryPoint.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, this._inputHandler.evKeyDown);
			EntryPoint.instance.stage.addEventListener(KeyboardEvent.KEY_UP, this._inputHandler.evKeyUp);
			//Suscribir el update del userController al updateManager
			EntryPoint.instance.stage.addEventListener(Event.ENTER_FRAME, update);		
		}
		
		//IUpdateable
		public function init():void
		{
			this._mainCharacter.spawn(140,468);			
		}
		
		/**
		 * Ejecuta el update del currentState
		 */
		public function update(ev:Event = null):void
		{					
			//Correr el update del currentState. Las transiciones las define el inputHandler 
			this._mainCharacter.fsm.update(this._inputHandler);						
		}
		
		public function die():void
		{
			trace("UserController die");
		}
	}
}