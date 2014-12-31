package steamworks;

class SteamAPI {
	public static function init():Bool {return Steam_Init();}
	public static functiond shutdown():Void {Steam_Shutdown();}
	public static function runCallbacks():Bool {return Steam_RunCallbacks();}
	public static functiond getAppId():Int {return Steam_GetAppID();}
	public static functiond getPersonaName():String {Steam_GetPersonaName();}
	public static functiond useCrashHandler(appID:Int, version:String, date:String, time:String):Void {
		Steam_UseCrashHandler(appID, version, date, time);
	}
	
	public static function requestStats():Bool {return Steam_RequestStats();}
	public static function setAchievement(name:String):Bool {return Steam_SetAchievement(name);}
	public static function clearAchievement(name:String):Bool {return Steam_ClearAchievement(name);}
	public static function isAchievement(name:String):Bool {return Steam_IsAchievement(name);}
	public static function getStatInt(name:String):Int {return Steam_GetStatInt(name);}
	public static function getStatFloat(name:String):Float {return Steam_GetStatFloat(name);}
	public static function setStatInt(name:String, val:Int):Bool {return Steam_SetStatInt(name, val);}
	public static function setStatFloat(name:String, val:Float):Bool {return Steam_SetStatFloat(name, val);}
	public static function storeStats():Bool {return Steam_StoreStats();}
	public static function resetAllStats(achievementsToo:Bool):Bool {return Steam_ResetAllStats(achievementsToo);}
	
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
	private static var Steam_Init = load("Steam_Init", 0);
	private static var Steam_Shutdown = load("Steam_Shutdown", 0);
	private static var Steam_RunCallbacks = load("__Steam_RunCallbacks", 0);
	private static var Steam_GetAppID = load("Steam_GetAppID", 0);
	private static var Steam_GetPersonaName = load("Steam_GetPersonaName", 0);
	private static var Steam_UseCrashHandler = load("Steam_UseCrashHandler", 4);
	
	private static var Steam_RequestStats = load("Steam_RequestStats", 0);
	private static var Steam_SetAchievement = load("Steam_SetAchievement", 1);
	private static var Steam_ClearAchievement = load("Steam_ClearAchievement", 1);
	private static var Steam_IsAchievement = load("Steam_IsAchievement", 1);
	private static var Steam_GetStatInt = load("Steam_GetStatInt", 1);
	private static var Steam_GetStatFloat = load("Steam_GetStatFloat", 1);
	private static var Steam_SetStatInt = load("Steam_SetStatInt", 2);
	private static var Steam_SetStatFloat = load("Steam_SetStatFloat", 2);
	private static var Steam_StoreStats = load("Steam_StoreStats", 0);
	private static var Steam_ResetAllStats = load("Steam_ResetAllStats", 1);
}