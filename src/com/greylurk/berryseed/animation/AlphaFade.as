package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;

	public class AlphaFade extends AbstractAnimation {
		public function AlphaFade( target:DisplayObject ) {
			super( target );
		}
	
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