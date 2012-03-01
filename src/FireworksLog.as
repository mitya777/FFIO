package{
	
	import adobe.utils.MMExecute;
	
	public class FireworksLog{
		
		public var logF:String;
		
		public function FireworksLog(func:String = "console.log"):void{
			if (func === "console.log" || func === "alert") logF = func;		//set the logging function we will be using inside of Fireworks
		}
		
		public function log(message:String, value:String = ""):void{
			if(value !== "") value = " " + value; 	//add leading space for clarity if a value is passed
			MMExecute(logF+'(unescape("'+encodeURIComponent(message)+'" + "'+encodeURIComponent(value)+'"));');
		}		
	}
}