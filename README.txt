FFIO - Fireworks File IO

This library is intended to make developing custom panels for Adobe Fireworks a little bit easier. It provides a library of actionscript functions to do file io from the Fireworks custom panels you develop.

This is a library of actionscript file-io functions which wrap javascript file-io functions capable of executing inside the Fireworks javascript environment.


Get Started

Reference the FireworksFileIO.swc in the bin folder from your Flash Builder project.
Instantiate the FireworksFileIO project like so:

	var fileIO = new FireworksFileIO();
	fileIO.appendToFile("some text to write", "file:///some/file.txt");
	
Or, if you know you will be working with a single file, you could do:

	var fileIO = new FireworksFileIO("file:///some/file.txt");		//you can still specify a file name to write to at any point, even if you set a default here
	fileIO.appendToFile("some text to write");						
	
The rest of the API is below:

	public function FireworksFileIO(fileName:String = "")	//constructor
		
	public function readFile(fileName:String = ""):String
		
	public function appendToFile( text:String, fileName:String = ""):Boolean
		
	public function overwriteFile( text:String, fileName:String = ""):Boolean
		
	public static function exists( fileUrl:String):Boolean
	
	//get and set the source file	
	public function get source():String		
		
	public function set source(fileName:String):void
	
	
The Problem

Fireworks has a 2-tiered development workflow. 
Panels must be written in actionscript. At the same time the Fireworks API provided by Adobe to manipulate and extend Fireworks is javascript.
To execute that javascript, panels must pass it as a string argument to the MMExecute function, eg. MMExecute('alert("hi");');

Besides the development workflow challenges this creates, there are also problems when passing strings as arguments to the javascript functions you will be executing.
This is because those javascript functions are also being passed as a string, so you get into a nested string situation and all the annoyances that this entails like having to escape characters, and writing things like this:

actionscript...

	var greeting = "hello";
	MMExecute('alert("greeting: ' + greeting + '");');

the string being passed to MMExecute is javascript.

This nested string situation is a little bit nightmarish, especially when you have to start dealing with multiple variables, and newlines, which have to be encoded and escaped on their journey through this string maze.
This library takes care of all that for you and lets you just pass the strings you want written, and the files you want read, to the appropriate actionscirpt read/write methods.



		

