package com.greylurk.berryseed
{
	
	import flash.events.Event;
	
	import qnx.ui.core.UIComponent;
	
	public class NavigationEvent extends Event
	{
		public static const NAVIGATE:String = "Navigate";
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public var destinationScreen:Screen = null;
	}
}