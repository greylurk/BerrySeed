package com.greylurk.berryseed.animation
{
	import flash.events.Event;
	
	public class AnimationEvent extends Event
	{
		public static const ANIMATION_STARTED:String = "Animation Started";
		public static const ANIMATION_COMPLETED:String = "Animation Completed";
		
		public function AnimationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var animation:IAnimation;
	}
}