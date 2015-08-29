package Engine.Resources
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import Engine.EntryPoint;

	[Event(name="complete", type="flash.events.Event")]
	public final class AssetsManager extends EventDispatcher
	{
		//Manejo de archivo externo
		private var _loaderOfAssetsFile:URLLoader;		
		private var _numAssetsTotal:int;
		private var _numAssetsLoaded:int;
		//Assets Storage
		private var _assetsTexts:Dictionary;
		private var _assetsImages:Dictionary;
		private var _assetsSounds:Dictionary;
		private var _assetsSWFs:Dictionary;
		private var _assetsOthers:Dictionary;
		//Pre-loader (MovieClip de 100 fotogramas)
		private var _preLoader:MovieClip;
		
		public function AssetsManager(preloader:MovieClip,posX:int = -1, posY:int = -1)
		{
			this._preLoader = preloader;			
			this._preLoader.x = posX == -1 ? EntryPoint.instance.stage.stageWidth/2 : posX;
			this._preLoader.y = posX == -1 ? EntryPoint.instance.stage.stageHeight/2 : posY;
		}
		
		public function tooglePreloader():void
		{
			if(!EntryPoint.instance.stage.contains(this._preLoader))
				EntryPoint.instance.stage.addChild(this._preLoader);
			else
				EntryPoint.instance.stage.removeChild(this._preLoader);
		}
		
		public function loadLinks(fileName:String):void
		{
			this._loaderOfAssetsFile = new URLLoader();
			this._loaderOfAssetsFile.dataFormat = URLLoaderDataFormat.VARIABLES;	
			this._loaderOfAssetsFile.load(new URLRequest(fileName));
			this._loaderOfAssetsFile.addEventListener(Event.COMPLETE,loadLinksComplete);
		}
		
		private function loadLinksComplete(event:Event):void
		{
			this._loaderOfAssetsFile.removeEventListener(Event.COMPLETE,loadLinksComplete);
			
			this._assetsTexts = new Dictionary(true);
			this._assetsImages = new Dictionary(true);
			this._assetsSounds = new Dictionary(true);
			this._assetsSWFs = new Dictionary(true);
			this._assetsOthers = new Dictionary(true);			
		
			var links:Array = new Array();
			var names:Array = new Array();
			
			for(var nombre:String in this._loaderOfAssetsFile.data)
			{
				names.push(nombre);				
				links.push(escape(this._loaderOfAssetsFile.data[nombre]).split("%0D%0A")[0]);
			}
			
			this._numAssetsTotal = links.length;
			this._numAssetsLoaded = 0;			
			
			for (var i:int = 0; i < links.length; i++) 
			{
				var folder:String = links[i].split("/")[0];
				switch(folder)
				{
					case "Images":
					case "SWFs":
						var tmpImgSWF:Loader = new Loader();
						tmpImgSWF.load(new URLRequest(links[i]));
						tmpImgSWF.contentLoaderInfo.addEventListener(Event.COMPLETE, evAssetComplete);						
						tmpImgSWF.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, evAssetError);						
						tmpImgSWF.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, evAssetProgress);						
						this["_assets" + folder][names[i]] = tmpImgSWF;						
						break;
					case "Sounds":
						var tmpSound:Sound = new Sound();
						tmpSound.load(new URLRequest(links[i]));
						tmpSound.addEventListener(Event.COMPLETE, evAssetComplete);						
						tmpSound.addEventListener(IOErrorEvent.IO_ERROR, evAssetError);						
						tmpSound.addEventListener(ProgressEvent.PROGRESS, evAssetProgress);
						this._assetsSounds[names[i]] = tmpSound;						
						break;
					case "Texts":
						var tmpText:URLLoader = new URLLoader();
						tmpText.dataFormat = URLLoaderDataFormat.TEXT;
						tmpText.load(new URLRequest(links[i]));
						tmpText.addEventListener(Event.COMPLETE, evAssetComplete);						
						tmpText.addEventListener(IOErrorEvent.IO_ERROR, evAssetError);						
						tmpText.addEventListener(ProgressEvent.PROGRESS, evAssetProgress);						
						this._assetsTexts[names[i]] = tmpText;
						break;
					default:
						this._assetsOthers[names[i]] = links[i];
				}
				trace("Se agrego un asset al diccionario " + folder);
			}					
			this._loaderOfAssetsFile = null;
		}
				
		private function evAssetComplete(event:Event):void
		{
			this._numAssetsLoaded++;
			if(this._numAssetsLoaded == this._numAssetsTotal)
			{
				this._preLoader.gotoAndStop(100);
				this._preLoader.txtPercent.text = 100;				
				dispatchEvent(new Event(Event.COMPLETE));
			}			
		}
		
		private function evAssetError(event:IOErrorEvent):void
		{
			trace("¡Se me complicó! ¿Estás seguro que están todos los archivos referidos?");
			trace(event.text);
		}
		
		private function evAssetProgress(event:ProgressEvent):void
		{
			var currentFramePercent:int = this._numAssetsLoaded * 100 / this._numAssetsTotal;
			this._preLoader.gotoAndStop(currentFramePercent);
			this._preLoader.txtPercent.text = currentFramePercent;
		}
		
		public function getImage(name:String):Loader
		{
			return this._assetsImages[name];
		}
		
		public function getSound(name:String):Sound
		{
			return this._assetsSounds[name];
		}
		
		public function getText(name:String):URLLoader
		{
			return this._assetsTexts[name];
		}
		
		public function getMovieClip(name:String):MovieClip
		{
			for each(var data:Loader in this._assetsSWFs)
			{
				try
				{
					var tmpClass:Class = data.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
					trace("La clase " + name + " esta en el SWF " + data.contentLoaderInfo.url);
					return new tmpClass;
				}
				catch(e:ReferenceError)
				{
					trace("La clase " + name + " no esta en el SWF " + data.contentLoaderInfo.url);
				}
			}
			return null;
		}
	}
}