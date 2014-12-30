package steamworks;

class SteamAPI {
	public static function init():Void {Steamworks_Init();}
	
	#if neko
	private static var NEKO_INIT:Bool = false;
	#end
	public static function load(name:String, args:Int):Dynamic {
		try {
			#if cpp
			return cpp.Lib.load("steamworks", name, args);
			#elseif neko
			if(!NEKO_INIT){
				NEKO_INIT = true; var init = neko.Lib.load("steamworks", "neko_init", 5);
				init(function(s) return new String(s), function(len:Int){var r = []; if (len > 0) r[len - 1] = null; return r;}, null, true, false);
			} return neko.Lib.load("steamworks", name, args);
			#end
		} catch(e:Dynamic){trace(e); return null;}
	}
	private static var Steamworks_Init = load("Steamworks_Init", 0);
}