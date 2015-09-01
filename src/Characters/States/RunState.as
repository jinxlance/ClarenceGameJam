package Characters.States
{
	import Characters.MainCharacter;
	
	import Engine.Input.InputHandler;
	
	internal final class RunState implements IState
	{
		private var _mainCharacter:MainCharacter;
		private var _speed:Number;
		
		public function RunState(mainCharacter:MainCharacter, speed:Number = 3.5)
		{
			this._mainCharacter = mainCharacter;
			this._speed = speed;
		}
		
		public function enter():void
		{			
			this._mainCharacter.model.scaleX = this._mainCharacter.direction * 0.25;
		}
		
		public function update(inputHandler:InputHandler):void
		{						
			this._mainCharacter.changeAnimation("Run");
			
			if(this._mainCharacter.frontHitPlatform())
				this._speed = 0;
			
			this._mainCharacter.model.x += this._speed * this._mainCharacter.direction;			
			
			//Transiciones
			if(!this._mainCharacter.isOnGround())
				this._mainCharacter.fsm.changeState(new FallState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Shot") && this._mainCharacter.canShot)
				this._mainCharacter.fsm.changeState(new ShotState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Knife") && this._mainCharacter.canKnife)
				this._mainCharacter.fsm.changeState(new KnifeState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Dive"))
				this._mainCharacter.fsm.changeState(new DiveState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Jump") && this._mainCharacter.canJump)
				this._mainCharacter.fsm.changeState(new JumpState(this._mainCharacter));
			
			if(inputHandler.getKeyValue("Adelante"))
			{
				this._mainCharacter.direction = 1;
				this.enter();
			}
			
			if(inputHandler.getKeyValue("Atras"))
			{
				this._mainCharacter.direction = -1;
				this.enter();
			}
			
			if(!inputHandler.getKeyValue("Adelante") && !inputHandler.getKeyValue("Atras"))
				this._mainCharacter.fsm.changeState(new IdleState(this._mainCharacter));
		}
		
		public function exit():void
		{
			//No hago nada
		}
	}
}