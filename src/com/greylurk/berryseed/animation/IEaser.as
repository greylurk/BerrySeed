package com.greylurk.berryseed.animation {

	/**
	 * The interface used by the AbstractAnimation class to call an Easer.  
	 */	
	public interface IEaser{
		/**
		 * Map a linear easing (from 0 to 1) into a different easing function
		 * such as sinusoidal.  currentCount is bounded by [0,1], but there is 
		 * no restriction on values returned by ease.
		 */
		function ease( currentCount:Number ):Number;
	}
}