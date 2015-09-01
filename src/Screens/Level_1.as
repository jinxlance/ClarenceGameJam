package Screens
{
	import Engine.EntryPoint;
	import Engine.Screens.Screen;
	
	public final class Level_1 extends Screen
	{		
		
		public function Level_1()
		{
			super("Level_01");
			this._model.x = 0;
			this._model.y = 395;						
		}
		
		override public function enter():void
		{
			//Inicializar lo que respecta al nivel 1
			EntryPoint.instance.stage.addChild(this._model);			
			EntryPoint.instance.updateManager.init();
		}
	}
}