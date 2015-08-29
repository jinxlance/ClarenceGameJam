package
{
	import flash.events.Event;
	
	import Engine.EntryPoint;
	
	import Screens.Level_1;
	import Screens.MainMenu;
	
	[SWF(width="800",height="600",frameRate="60")]
	public class Main extends EntryPoint
	{
		public function Main()
		{
			EntryPoint.instance.assetsManager.tooglePreloader();
			EntryPoint.instance.assetsManager.loadLinks("AllAssets.txt");
			EntryPoint.instance.assetsManager.addEventListener(Event.COMPLETE, loadLinksComplete);			
		}
		
		private function loadLinksComplete(event:Event):void
		{
			//Recursos listos
			EntryPoint.instance.assetsManager.tooglePreloader();
			EntryPoint.instance.assetsManager.removeEventListener(Event.COMPLETE, loadLinksComplete);
			//Registro pantallas
			EntryPoint.instance.screenManager.registerScreen("MainMenu",Screens.MainMenu);
			EntryPoint.instance.screenManager.registerScreen("Level_1",Screens.Level_1);
			//Cargo Nivel
			EntryPoint.instance.screenManager.loadScreen("MainMenu");
		}

	}
}