package Characters.States
{
	import Engine.Input.InputHandler;

	public final class StateMachine
	{
		private var _currentState:IState;
		
		public function StateMachine()
		{
			this._currentState = null;
		}
		
		public function update(inputHandler:InputHandler):void
		{			
			if(this._currentState)
				this._currentState.update(inputHandler);
		}
		
		public function changeState(newState:IState):void
		{
			if(this._currentState)
				this._currentState.exit();
			this._currentState = newState;
			this._currentState.enter();
		}
	}
}