package{
	
	import adobe.utils.MMExecute;
	import flash.utils.ByteArray;
	
	public class FireworksFileIO{
		
		//embed Fireworks File IO Javascript library
		[Embed(source = "../javascript/FFIO.jsf", mimeType = "application/octet-stream")]
		private var FileIOJavascript:Class;
		
		private var sourceFile:String = "";
		
		public function FireworksFileIO(fileName:String = ""){
				MMExecute('alert("FireworksFileIO init!!");');
			source = fileName;
			var jsFileIO:String = (new FileIOJavascript() as ByteArray).toString();	//instantiate embedded Fireworks File IO Javascript Library code
			MMExecute(jsFileIO);	//execute code to set up fireworks_file_io_library global variable to give access to file io methods
			MMExecute('fireworks_file_io_library.test();');		//test access to library, this will print to john dunning's console	
		}
		
		//returns string containing contents of file, or emtpy string if can't read file.
		public function readFile(fileName:String = ""):String{
			(fileName === "")? fileName = source: fileName;
			return MMExecute('fireworks_file_io_library.readFile("'+fileName+'")');
		}
		
		public function get source():String{
			return sourceFile;
		}
		
		public function set source(fileName:String):void{
			sourceFile = fileName;
		}
		
	}
}