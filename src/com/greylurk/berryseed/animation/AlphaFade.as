package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;

	/**
	 * A smooth fading effect that slowly makes an onscreen object transparent
	 */
	public class AlphaFade extends AbstractAnimation {
		/**
		 * Create an empty AlphaFade animation
		 */
		public function AlphaFade( target:DisplayObject ) {
			super( target );
		}
	
		/**
		 * Interpolate the new alpha transparence of the target, and apply it.
		 * If the time is 1, set the visibility of the element to false.
		 */
		protected override function tick( percentDone:Number ):void {
			target.alpha = percentDone;
			if( percentDone == 1 ) {
				target.visible = false;
			} else {
				target.visible = true;
			}
		}
	}
}