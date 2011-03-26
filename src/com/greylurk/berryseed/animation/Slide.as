package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * A smooth transition moving an object on screen from one point to a
	 * different point elsewhere on the screen.
	 */
	public class Slide extends AbstractAnimation {
		private var _startPoint : Point;
		private var _endPoint : Point;
		
		/**
		 * Create a new Slide animation to move the target object from the 
		 * startPoint to the endPoint.
		 * 
		 * @param target The item on screen which is to be moved
		 * @param startPoint the initial position of the target element on screen
		 * @param endPoint the final position of the target on screen
		 */
		public function Slide( target:DisplayObject = null, startPoint : Point = null, endPoint : Point = null ) {
			this.target = target;
			if( startPoint == null && target ) this.startPoint = new Point(0,0-target.height);
			else this.startPoint = startPoint;
			if( endPoint == null ) this.endPoint = new Point(0,0);
			else this.endPoint = endPoint;
		}


		/**
		 * The initial location of the target element on the screen.
		 */
		public function set startPoint( value : Point ) : void {
			this._startPoint = value;
			moveToStart();
		}
		
		public function get startPoint() : Point {
			return this._startPoint;
		}
		
		/**
		 * The final location of the target element on the screen
		 */ 
		public function get endPoint() : Point {
			return this._endPoint;
		}
		
		public function set endPoint( value : Point ) : void {
			this._endPoint = value;
		}
		
		/**
		 * The object on screen which will be animated by this Animation
		 */
		public override function set target( value:DisplayObject ):void {
			super.target = value;
			if( startPoint == null && target != null  ) 
			{
				startPoint = new Point(0,0-target.height);
				moveToStart();
			}
		}
		
		private function moveToStart():void {
			if( target && startPoint ) {
				target.x = startPoint.x;
				target.y = startPoint.y;
				target.visible = true;
			}
		}
		
		/**
		 * Interpolates the new position in a straight line between
		 * the startPoint and endPoint.
		 */
		protected override function tick( time:Number ):void {
			var percentComplete : Number = time;
			var xDiff : int = Math.abs(endPoint.x - startPoint.x);
			var yDiff : int = Math.abs(endPoint.y - startPoint.y);
			target.x = startPoint.x + xDiff * percentComplete;
			target.y = startPoint.y + yDiff * percentComplete;
		}
	}

}