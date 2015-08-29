package Characters.States
{
	import Characters.MainCharacter;
	
	import Engine.Input.InputHandler;

	public final class IdleState implements IState
	{
		private var _mainCharacter:MainCharacter;		
		
		public function IdleState(mainCharacter:MainCharacter)
		{
			this._mainCharacter = mainCharacter;		
		}
		
		public function enter():void
		{			
			//No hago nada
		}
		
		public function update(inputHandler:InputHandler):void
		{
			this._mainCharacter.changeAnimation("Idle");
			
			//Transiciones
			if(inputHandler.getKeyValue("Shot") && this._mainCharacter.canShot)
				this._mainCharacter.fsm.changeState(new ShotState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Knife") && this._mainCharacter.canKnife)
				this._mainCharacter.fsm.changeState(new KnifeState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Jump") && this._mainCharacter.canJump)
				this._mainCharacter.fsm.changeState(new JumpState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Adelante"))
			{
				this._mainCharacter.direction = 1;
				this._mainCharacter.fsm.changeState(new RunState(this._mainCharacter));
			}
			
			if(inputHandler.getKeyValue("Atras"))
			{
				this._mainCharacter.direction = -1;
				this._mainCharacter.fsm.changeState(new RunState(this._mainCharacter));
			}
		}
		
		public function exit():void
		{
			//No hago nada
		}
	}
}