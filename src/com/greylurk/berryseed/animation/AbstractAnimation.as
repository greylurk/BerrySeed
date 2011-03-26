package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	
	/**
	 * Dispatched when the Animation starts
	 * 
	 * @eventType com.greylurk.berryseed.animation.AnimationEvent
	 */
	[Event(name="animationStarted",type="com.greylurk.berryseed.animation.AnimationEvent")]
	
	/**
	 * Dispatched when the Animation completes
	 * 
	 * @eventType com.greylurk.berryseed.animation.AnimationEvent
	 */
	[Event(name="animationCompleted",type="com.greylurk.berryseed.animation.AnimationEvent")]

	/**
	 * The AbstractAnimation class provides a framework for building concrete animations off
	 * of.  It manages the easers, start time, and duration of an animation as well
	 * as the DisplayObject which should be targeted by the animation.
	 * 
	 * <p>A concrete Animation class should extend the AbstractAnimation class and override
	 * the "tick" function.  The tick function should apply a transformation to the target
	 * object based on a fractional time passed to it.  All other aspects of the animation 
	 * are managed by the AbstractAnimation, including reversing the animation.</p>
	 */
	public class AbstractAnimation extends EventDispatcher implements IAnimation {
		private var _target:DisplayObject;
		private var _easer:IEaser;
		private var _startTime:Number;
		private var _duration:Number;
		private var _reverse:Boolean;
		
		/**
		 * Create an empty AbstractAnimation
		 **/
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
		
		/**
		 * A custom easer for this animation.  If this is null, a linear
		 * easing function is applied
		 */
		public function get easer():IEaser {
			return _easer;
		}
		
		public function set easer( easer:IEaser ):void {
			_easer = easer;
		}
		
		/**
		 * The object on screen which will be animated by this Animation
		 */
		public function get target():DisplayObject {
			return _target;
		}
		
		public function set target( target:DisplayObject ):void {
			_target = target;
		}
		
		/**
		 * The number of milliseconds that this animation will complete in
		 */
		public function get duration():Number {
			return _duration;
		}
		
		public function set duration( duration:Number ):void {
			_duration = duration;
		}

		/**
		 * Abstract.  Animations must override this function to provide an 
		 * effect to the target element, based on the time passed.  The 
		 * time passed is fraction of the duration, so if the duration of 
		 * the animation was 500ms, 250ms into the animation the tick function
		 * would be executed with a time value of .5
		 */
		protected function tick( time:Number ):void {
			throw new Error("AbstractAnimation cannot animate on it's own.");
		}

		/**
		 * Start playing the animation forward from time 0 to time 1
		 */
		public function start():void {
			_reverse = false;
			_startTime = getTimer();
			_target.addEventListener( Event.ENTER_FRAME, handleEnterFrame );
			dispatchAnimationEvent( AnimationEvent.ANIMATION_STARTED );
		}
		
		/**
		 * Start playing the animation backwards from time 1 to time 0 
		 */
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