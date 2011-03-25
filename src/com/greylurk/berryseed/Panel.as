package com.greylurk.berryseed
{
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import qnx.ui.core.Container;
	import qnx.ui.core.UIComponent;
	
	public class Panel extends Container
	{

		public function Panel(s:Number=100, su:String="percent")
		{
			super(s, su);
			
		}
		
		protected override function draw():void {
			var matr:Matrix = new Matrix();
			matr.createGradientBox( width, height, Math.PI/2, 0 , 0);
			graphics.beginGradientFill( GradientType.LINEAR, [ 0x4D5459, 0x2C373E ], [1, 1],[0,255],matr )
			graphics.lineStyle(0,0x999999,0.5);
			graphics.drawRect(0,0,width,height);
			graphics.endFill();
		}
	}
}