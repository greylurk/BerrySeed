/*
Copyright (c) 2011 Adam Ness (http://www.greylurk.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package com.greylurk.berryseed.ui.preferences
{
	import com.greylurk.berryseed.preferences.PreferenceSection;
	import com.greylurk.berryseed.ui.SkinAssets;
	
	import flash.display.DisplayObject;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.geom.Transform;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import mx.core.BitmapAsset;
	
	import qnx.ui.display.Image;
	import qnx.ui.listClasses.CellRenderer;
	import qnx.ui.listClasses.ICellRenderer;
	import qnx.ui.text.Label;
	
	public class PreferenceSectionCellRenderer extends CellRenderer implements ICellRenderer
	{
		private var _background:Sprite;
		private var _label:Label;
		private var _icon:Image;
		private var _textFormat:TextFormat;
		
		public function PreferenceSectionCellRenderer()
		{
			super();
		}

		
		/**
		 * Undocumented function from CellRenderer, stolen from
		 * https://github.com/renaun/QNXUIExamples/blob/master/DataExampleApp/src/renderers/ListItemRenderer.as
		 */
		override protected function setState(state:String):void
		{
			super.setState(state);
			var g:Graphics = _background.graphics;
			g.clear();
			if (state == "selected")
			{
				var blueGradMatrix:Matrix = new Matrix();
				blueGradMatrix.createGradientBox(width,height,Math.PI/2,0,0);
				g.beginGradientFill( 
					GradientType.LINEAR, 
					[0x1766db,0x088eef],
					[1,1],
					[0,255],
					blueGradMatrix
				);
			} else {
				var image:BitmapAsset = new SkinAssets.PREFERENCE_BG() as BitmapAsset;
				g.beginBitmapFill( image.bitmapData );
			}
			g.drawRect(0, 0, width, height);
			g.endFill();
			var shadowGradMatrix:Matrix = new Matrix();
			shadowGradMatrix.createGradientBox(10,height,0,0,0);
			g.beginGradientFill(
				GradientType.LINEAR,
				[0xffffff,0xd0d0d0],
				[1,.5],
				[0,255],
				shadowGradMatrix
			);
			g.drawRect(width-10, 0, 10, height);
			g.endFill();
		}

		
		override public function set data( value:Object ):void {
			super.data = value;
			updateCell();
		}
		
		private function updateCell():void {
			if( data != null && data is PreferenceSection ) {
				var prefSection:PreferenceSection = data as PreferenceSection;
				_icon.setImage( prefSection.icon );
				_label.text = prefSection.name;
			}
		}
		
		/**
		 * Undocumented feature in CellRenderer, stolen from 
		 * https://github.com/renaun/QNXUIExamples/blob/master/DataExampleApp/src/renderers/ListItemRenderer.as
		 */
		override protected function init():void {
			_icon = new Image();
			_label = new Label();
			_background = new Sprite();
			
			_textFormat = new TextFormat();
			_textFormat.color = 0x000000;
			_textFormat.size = 18;
			
			_label.format = _textFormat;
			_label.y = 12;
			_label.x = 47;
			_label.autoSize = TextFieldAutoSize.LEFT;
			
			_icon.setPosition(7,7);
			_icon.setSize(32,32);
			
			addChild(_background);
			addChild(_label);
			addChild(_icon);
		}
	}
}