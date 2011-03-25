package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;
	
	public interface IAnimation {
		function get target():DisplayObject;
		function set target( target:DisplayObject ):void;
		
		function get duration():Number;
		function set duration( time:Number ):void;
		
		function get easer():IEaser;
		function set easer( easer:IEaser ):void;
		
		function start():void;
		function reverse():void;
	}
}