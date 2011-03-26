package com.greylurk.berryseed.animation
{
	import flash.events.Event;
	
	/**
	 * The AnimationEvent class is broadcast by animations when they are 
	 * started or completed
	 */
	public class AnimationEvent extends Event
	{
		/**
		 * The ANIMATION_STARTED constant defines the value of the type property of an animationStarted event
		 */
		public static const ANIMATION_STARTED:String = "animationStarted";

		/**
		 * The ANIMATION_COMPLETED constant defines the value of the type property of an animationCompleted event
		 */
		public static const ANIMATION_COMPLETED:String = "animationCompleted";
		
		/**
		 * Create an empty AnimationEvent
		 */
		public function AnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * The animation which is running
		 */
		public var animation:IAnimation;
	}
}