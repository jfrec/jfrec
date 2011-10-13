import flash.media.*;
import flash.events.*;
import flash.utils.ByteArray;
import flash.net.FileReference;
import flash.external.*;
import org.bytearray.micrecorder.encoder.WaveEncoder;
import fr.kikko.lab.ShineMP3Encoder;

var start_record = ExternalInterface.addCallback("start_recording", onRecord);
var save_record = ExternalInterface.addCallback("save_recording", onSave);
var play_record = ExternalInterface.addCallback("play_recording", onPlay);

var enco:WaveEncoder=new WaveEncoder();
var file:FileReference=new FileReference()

var ch:SoundChannel;
//ByteArray in which the recorded sound data is stored
var soundBytes:ByteArray = new ByteArray();
//ByteArray from which the recorded sound data is played
var soundO:ByteArray = new ByteArray();
//Sound object which plays the recorded sound...
var sound:Sound= new Sound();

//Gets your default microphone
var mic:Microphone = Microphone.getMicrophone();
//To check whether the application is recording the sound or not
var recMode:Boolean=false;
//To check whether the application is playing the sound or not
var playMode:Boolean=false;
//function called at start of application
function init(){
	//Sets the minimum input level that should be considered sound
	mic.setSilenceLevel(0);
	//The amount by which the microphone boosts the signal.
	mic.gain = 50;
	//The rate at which the microphone is capturing sound, in kHz.
	mic.rate = 44;
}
//function called when start Record button is clicked
function startRecord():void
{
	mic.addEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
}
//function called when stop Record button is clicked
function stopRecord():void
{
	mic.removeEventListener(SampleDataEvent.SAMPLE_DATA, micSampleDataHandler);
	soundBytes.position = 0;
	soundO.length=0
	soundO.writeBytes(soundBytes);
	soundO.position = 0;
	soundBytes.length=0;	
}

function micSampleDataHandler(event:SampleDataEvent):void
{
	while (event.data.bytesAvailable)
	{
		var sample:Number = event.data.readFloat();
		soundBytes.writeFloat(sample);
	}
}

function playSound():void
{	
    soundO.position = 0;
	sound.addEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);
	ch=sound.play();
	ch.addEventListener(Event.SOUND_COMPLETE,onSC)	
}
function stopSound():void
{	
	sound.removeEventListener(SampleDataEvent.SAMPLE_DATA, playbackSampleHandler);
	ch.stop()
	ch.removeEventListener(Event.SOUND_COMPLETE,onSC)	
}
function onSC(evt:Event):void
{
	trace("SOUND_COMPLETE")
	stopSound()
	soundO.position=0
	playMode=!true
}
function playbackSampleHandler(event:SampleDataEvent):void
{
	for (var i:int = 0; i < 8192; i++)
	{
		if (soundO.bytesAvailable < 4)
		{
			break
		}
		var sample:Number = soundO.readFloat();
		event.data.writeFloat(sample);
		event.data.writeFloat(sample);
		
		
	}
}

function getSwfParam(name:String, defaultValue:String):String
{
	var paramObj:Object = LoaderInfo(stage.loaderInfo).parameters;
 
	if(paramObj[name] != null && paramObj[name] != "")
		return paramObj[name];
	else
		return defaultValue;
}

function onSave(evt:MouseEvent=null):void
{
	var save_path:String = getSwfParam("save_path", "save_wav.php");
	
	soundO.position=0
	var wav:ByteArray=enco.encode(soundO,1)
   
	//var jpgUrlRequest:URLRequest = new URLRequest( 'save_wav.php' );
	
	var mp3cont = new ShineMP3Encoder(wav);
	mp3cont.addEventListener(Event.COMPLETE, mp3EncodeComplete);
	mp3cont.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
	mp3cont.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
	mp3cont.start();
	
	
	var appheader:URLRequestHeader = new URLRequestHeader("Content-type", "application/octet-stream");
    var jpgUrlRequest:URLRequest = new URLRequest(save_path);
	jpgUrlRequest.requestHeaders.push( appheader );
	jpgUrlRequest.method = "POST";
	jpgUrlRequest.data = mp3cont.mp3Data;
        

	var urlLoader:URLLoader = new URLLoader();
	urlLoader.load( jpgUrlRequest );
}
function onRecord(evt:MouseEvent=null):void
{
	if(!recMode){
		recMode=true
		startRecord()
	}else{
		recMode=!true
		stopRecord()
	}
}
function onPlay(evt:MouseEvent=null):void
{
	if(!playMode){
		playMode=true
		playSound()
	}else{
		playMode=!true
		stopSound()
	}
}

function encodeToMP3(wavData:ByteArray):void {
                        
        var mp3Encoder = new ShineMP3Encoder(wavData);
        mp3Encoder.addEventListener(Event.COMPLETE, mp3EncodeComplete);
        mp3Encoder.addEventListener(ProgressEvent.PROGRESS, mp3EncodeProgress);
        mp3Encoder.addEventListener(ErrorEvent.ERROR, mp3EncodeError);
        mp3Encoder.start();
		//return mp3Encoder;
}

function mp3EncodeProgress(event : ProgressEvent) : void {
                        
        trace(event.bytesLoaded, event.bytesTotal);
}

function mp3EncodeError(event : ErrorEvent) : void {
                        
        trace("Error : ", event.text);
}

function mp3EncodeComplete(event : Event) : void {
                        
       // trace("Done !", mp3Encoder.mp3Data.length);
}

init()