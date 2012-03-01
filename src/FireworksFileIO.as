package{
	
	import adobe.utils.MMExecute;
	import flash.utils.ByteArray;
	
	public class FireworksFileIO{
		/*Because a string parameter, such as text to be written, is being passed to these methods which then insert the string into another string as parameters for MMExecute there is a nesting of strings.
		This causes problems for characters like \n. Which have to be escaped at the first level like so "\\n" to make it to the nested level as "\n" newlines. To not force people using the library to escape
		characters in their parameters I am escaping and unescaping inside the methods to get the correct character to the js functions. I am using actionscript encodeURIComponent to encode in UTF8 and using
		js function unescape because decodeURIComponent seems to crash Fireworks... maybe it's a version problem?*/
		
		//embed Fireworks File IO Javascript library
		[Embed(source = "../javascript/FFIO.jsf", mimeType = "application/octet-stream")]
		private var FileIOJavascript:Class;
		
		private var sourceFile:String = "";
		
		public function FireworksFileIO(fileName:String = ""){
			source = fileName;
			MMExecute('alert("FireworksFileIO init: " + "'+source+'");');
			var jsFileIO:String = (new FileIOJavascript() as ByteArray).toString();	//instantiate embedded Fireworks File IO Javascript Library code
			MMExecute(jsFileIO);	//execute code to set up fireworks_file_io_library global variable to give access to file io methods
			MMExecute('fireworks_file_io_library.test();');		//test access to library, this will print to john dunning's console	
		}
		
		//returns string containing contents of file, or emtpy string if can't read file.
		public function readFile(fileName:String = ""):String{
			(fileName === "")? fileName = source: fileName;		//if no parameter use sourceFile, otherwise read from the passed value
			return MMExecute('fireworks_file_io_library.readFile("'+fileName+'")');
		}
		
		public function appendToFile( text:String, fileName:String = ""):Boolean{	//the params are reversed when compared to the js function so that we can make fileName optional
			text = encodeURIComponent(text);
			(fileName === "")? fileName = source: fileName;		//if no parameter use sourceFile, otherwise read from the passed value
				MMExecute('alert("aTF text: '+text+'");');
			var success:String = MMExecute('fireworks_file_io_library.appendToFile("'+fileName+'", unescape("'+text+'"));');	
			if (success === "true") return true;
			return false;
		}
		
		public function overwriteFile( text:String, fileName:String = ""):Boolean{
			text = encodeURIComponent(text);
			(fileName === "")? fileName = source: fileName;		//if no parameter use sourceFile, otherwise read from the passed value
			var success:String = MMExecute('fireworks_file_io_library.overwriteFile("'+fileName+'", unescape("'+text+'"));');	
			if (success === "true") return true;
			return false;
		}
		
		public function get source():String{
			return sourceFile;
		}
		
		public function set source(fileName:String):void{
			sourceFile = decodeURIComponent(fileName).replace("|",":");		//sometimes Windows URLs are returned as "file:///C|/"... as opposed to "file:///C:/"
		}
		
	}
}