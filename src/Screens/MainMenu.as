package Screens
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import Engine.EntryPoint;
	import Engine.Screens.Screen;
	
	public class MainMenu extends Screen
	{
		public function MainMenu()
		{
			super("MainMenuScreen");
			this._model.x = EntryPoint.instance.stage.stageWidth/2;
			this._model.y = EntryPoint.instance.stage.stageHeight/2;
		}
		
		override public function enter():void
		{
			//Inicializar lo que respecta al menu
			EntryPoint.instance.stage.addChild(this._model);
			this._model.btnMusic.addEventListener(MouseEvent.CLICK, toogleMusic);
			this._model.btnSettings.addEventListener(MouseEvent.CLICK, toogleSettings);
			EntryPoint.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, startGame);
		}
		
		private function startGame(ev:KeyboardEvent):void
		{
			if(ev.keyCode == Keyboard.ENTER)
			{
				EntryPoint.instance.stage.removeEventListener(KeyboardEvent.KEY_DOWN, startGame);
				this.change("Level_1");
			}
		}
		
		private function toogleMusic(ev:MouseEvent):void
		{
			trace("Encender/Apagar Musica");
		}
		
		private function toogleSettings(ev:MouseEvent):void
		{
			trace("Mostrar/Ocultar Opciones");
		}
		
		override public function exit():void
		{
			this._model.btnMusic.removeEventListener(MouseEvent.CLICK, toogleMusic);
			this._model.btnSettings.removeEventListener(MouseEvent.CLICK, toogleSettings);
			EntryPoint.instance.stage.removeChild(this._model);			
		}
	}
}