package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	public class AbstractAnimation extends EventDispatcher implements IAnimation {
		private var _target:DisplayObject;
		private var _easer:IEaser;
		private var _startTime:Number;
		private var _duration:Number;
		private var _reverse:Boolean;
		
		public function AbstractAnimation( target:DisplayObject = null ) {
			this.target = target;
			duration = 500;
		}

		private function handleEnterFrame( event:Event ):void {
			var elapsed:Number = getTimer() - _startTime;
			var currentPosition:Number = elapsed/duration;
			if( easer != null ) { 
				currentPosition = easer.ease(currentPosition);
			}
			if( _reverse ) {
				currentPosition = 1 - currentPosition;
			}
			if( currentPosition < 1 && currentPosition > 0 ) {
				tick( currentPosition );
			} else if ( !_reverse && currentPosition >= 1 )  {
				tick(1); // in case there is some rounding error
				target.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
				dispatchAnimationEvent( AnimationEvent.ANIMATION_COMPLETED );
			} else if ( _reverse && currentPosition <= 0 ) {
				tick(0);
				target.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
				dispatchAnimationEvent( AnimationEvent.ANIMATION_COMPLETED );
			}
		}
		
		
		public function get easer():IEaser {
			return _easer;
		}
		
		public function set easer( easer:IEaser ):void {
			_easer = easer;
		}
		
		public function get target():DisplayObject {
			return _target;
		}
		
		public function set target( target:DisplayObject ):void {
			_target = target;
		}
		
		public function get duration():Number {
			return _duration;
		}
		
		public function set duration( duration:Number ):void {
			_duration = duration;
		}

		protected function tick( time:Number ):void {
			throw new Error("AbstractAnimation cannot animate on it's own.");
		}

		public function start():void {
			_reverse = false;
			_startTime = getTimer();
			_target.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			dispatchAnimationEvent( AnimationEvent.ANIMATION_STARTED );
		}
		
		public function reverse():void {
			_reverse = true;
			_startTime = getTimer();
			_target.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			dispatchAnimationEvent( AnimationEvent.ANIMATION_STARTED );
		}

		
		private function dispatchAnimationEvent( type:String ):void {
			var event:AnimationEvent = new AnimationEvent( type );
			event.animation = this;
			dispatchEvent( event );
		}
	}
}