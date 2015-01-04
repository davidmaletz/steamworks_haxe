package steamworks;

class SteamAPI {
	/* response types */
	public static inline var RESPONSE_OnUserStatsReceived = 0;
	public static inline var RESPONSE_OnUserStatsStored = 1;
	public static inline var RESPONSE_OnAchievementStored = 2;
	public static inline var RESPONSE_OnGameOverlayActivated = 3;
	public static inline var RESPONSE_OnFileShared = 4;
	public static inline var RESPONSE_OnUGCDownload = 5;
	public static inline var RESPONSE_OnPublishWorkshopFile = 6;
	public static inline var RESPONSE_OnDeletePublishedFile = 7;
	public static inline var RESPONSE_OnGetPublishedFileDetails = 8;
	public static inline var RESPONSE_OnEnumerateUserPublishedFiles = 9;
	public static inline var RESPONSE_OnEnumeratePublishedWorkshopFiles = 10;
	public static inline var RESPONSE_OnEnumerateUserSubscribedFiles = 11;
	public static inline var RESPONSE_OnEnumerateUserSharedWorkshopFiles = 12;
	public static inline var RESPONSE_OnEnumeratePublishedFilesByUserAction = 13;
	public static inline var RESPONSE_OnCommitPublishedFileUpdate = 14;
	public static inline var RESPONSE_OnSubscribePublishedFile = 15;
	public static inline var RESPONSE_OnUnsubscribePublishedFile = 16;
	public static inline var RESPONSE_OnGetPublishedItemVoteDetails = 17;
	public static inline var RESPONSE_OnUpdateUserPublishedItemVote = 18;
	public static inline var RESPONSE_OnSetUserPublishedFileAction = 19;
	public static inline var RESPONSE_OnDLCInstalled = 20;
	//NOTE: handleEvent takes two arguments, the first being a response type (see above), and the second the actual response (see SteamResponse).
	public static function init(handleEvent:Int->Int->Void):Bool {return Steam_Init(handleEvent);}
	public static function runCallbacks():Bool {return Steam_RunCallbacks();}
	public static function getAppId():Int {return Steam_GetAppID();}
	public static function getPersonaName():String {return Steam_GetPersonaName();}
	public static function useCrashHandler(appID:Int, version:String, date:String, time:String):Void {
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
	private static var Steam_Init = load("Steam_Init", 1);
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