package Characters
{	
	import flash.display.MovieClip;
	
	import Characters.States.IdleState;
	import Characters.States.StateMachine;
	
	import Engine.EntryPoint;
	
	public class MainCharacter
	{		
		private var _model:MovieClip;		
		private var _speed:Number;		
		private var _fsm:StateMachine;
				
		public function MainCharacter()
		{
			this._model = EntryPoint.instance.assetsManager.getMovieClip("MainCharacter");		
			this._speed = 3;			
			this._fsm = new StateMachine();
		}
				
		/*GETTERS*/
		
		public function get model():MovieClip
		{
			return this._model;
		}
				
		public function get speed():int
		{
			return this._speed;
		}
		
		public function get fsm():StateMachine
		{
			return this._fsm;
		}
		
		/*SETTERS*/
		
		public function set speed(value:int):void
		{
			this._speed = value;
		}
				
		/*METODOS PUBLICOS*/		
		public function spawn(posX:int, posY:int):void
		{
			this._model.x = posX;
			this._model.y = posY;
			EntryPoint.instance.stage.addChild(this._model);
			this._fsm.changeState(new IdleState(this));
		}
		
		public function changeAnimation(label:String):void
		{
			if(this._model.currentLabel != label)
				this._model.gotoAndPlay(label);
		}		
	}
}