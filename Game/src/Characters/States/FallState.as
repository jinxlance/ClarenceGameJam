package Characters.States
{
	import flash.events.Event;
	import flash.geom.Point;
	
	import Characters.MainCharacter;
	
	import Engine.EntryPoint;
	import Engine.Input.InputHandler;
	
	internal final class FallState implements IState
	{
		private var _mainCharacter:MainCharacter;		
		private var _speedX:Number;
		private var _speedY:Number;
		
		public function FallState(mainCharacter:MainCharacter)
		{
			this._mainCharacter = mainCharacter;			
			this._speedX = 5.4;
			this._speedY = 0;
		}
		
		public function enter():void
		{
			this._mainCharacter.canJump = false;
			this._mainCharacter.changeAnimation("Fall");
			this._mainCharacter.model.addEventListener("ANIMATION_END",this.animationEnd);
		}
		
		public function update(inputHandler:InputHandler):void
		{
			this._mainCharacter.model.y += this._speedY;
			this._speedY += 0.8;
			//Si toco una plataforma cambio a idle
			for (var i:int = 0; i < EntryPoint.instance.gameManager.platformsUp.length; i++) 
			{
				if(this._mainCharacter.model.foots.hitTestObject( EntryPoint.instance.gameManager.platformsUp[i] ))
				{
					var globalY:Number = EntryPoint.instance.gameManager.platformsUp[i].parent.localToGlobal(new Point(0, EntryPoint.instance.gameManager.platformsUp[i].y)).y;					
					this._mainCharacter.model.y = globalY - this._mainCharacter.model.height/2 - EntryPoint.instance.gameManager.platformsUp[i].height/2;
					this._mainCharacter.fsm.changeState(new IdleState(this._mainCharacter));					
				}
			}		
			
			if(this._mainCharacter.frontHitPlatform())
				this._speedX = 0;
			
			if(inputHandler.getKeyValue("Adelante"))			
				this._mainCharacter.model.x += this._speedX; 
			if(inputHandler.getKeyValue("Atras"))
				this._mainCharacter.model.x += -this._speedX;
		}
		
		private function animationEnd(ev:Event):void
		{	
			this._mainCharacter.model.stop();
			this._mainCharacter.model.removeEventListener("ANIMATION_END",this.animationEnd);			
		}
		
		public function exit():void
		{
			this._mainCharacter.canJump = true;
		}
	}
}