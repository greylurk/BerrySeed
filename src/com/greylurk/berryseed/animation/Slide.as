package com.greylurk.berryseed.animation {
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class Slide extends AbstractAnimation {
		private var _startPoint : Point;
		private var _endPoint : Point;
		
		public function Slide( target:DisplayObject = null, startPoint : Point = null, endPoint : Point = null ) {
			this.target = target;
			if( startPoint == null && target ) this.startPoint = new Point(0,0-target.height);
			else this.startPoint = startPoint;
			if( endPoint == null ) this.endPoint = new Point(0,0);
			else this.endPoint = endPoint;
		}


		public function set startPoint( value : Point ) : void {
			this._startPoint = value;
			moveToStart();
		}
		
		public function get startPoint() : Point {
			return this._startPoint;
		}
		
		public function get endPoint() : Point {
			return this._endPoint;
		}
		
		public function set endPoint( value : Point ) : void {
			this._endPoint = value;
		}
		
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
		
		protected override function tick( time:Number ):void {
			var percentComplete : Number = time;
			var xDiff : int = Math.abs(endPoint.x - startPoint.x);
			var yDiff : int = Math.abs(endPoint.y - startPoint.y);
			target.x = startPoint.x + xDiff * percentComplete;
			target.y = startPoint.y + yDiff * percentComplete;
		}
	}

}