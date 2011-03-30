package com.greylurk.berryseed.event
{
	
	import flash.events.Event;
	
	import qnx.ui.core.UIComponent;
	import com.greylurk.berryseed.ui.Screen;
	
	/**
	 * Navigation events are passed over the application message bus in a 
	 * BerrySeed application in order to indicate a user gesture which 
	 * should trigger a different screen to be shown on screen.
	 */
	public class NavigationEvent extends Event
	{
		/**
		 * 
		 */
		public static const NAVIGATE:String = "navigate";
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var destinationScreen:Screen = null;
	}
}