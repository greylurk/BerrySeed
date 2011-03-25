package com.greylurk.berryseed
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import qnx.ui.buttons.Button;
	import qnx.ui.text.Label;
	
	public class IconLabelButton extends Button
	{
		private var _label:String;
		private var _embedFonts:Boolean;
		private var _textFormatForStates:Object;
		private var _icon:Object;
		private var imageBlock:Sprite;
		private var labelTextField:Label;
		
		public function IconLabelButton()
		{
			super();
			_textFormatForStates = new Object();
			imageBlock = new Sprite();
			addChild( imageBlock );

			labelTextField = new Label();
			addChild( labelTextField );
		}

		public function get label():String {
			return _label;
		}
		
		public function set label( value:String ):void {
			_label = value;
			labelTextField.text = value;
			width = (width < labelTextField.width)?labelTextField.width:width;
			height = (height < labelTextField.height)?labelTextField.height:height;
		}

		public function get embedFonts():Boolean {
			return labelTextField.embedFonts;
		}
		
		public function set embedFonts( value:Boolean ):void {
			labelTextField.embedFonts = value;
		}
		
		public function getTextFormatForState( state:String ):TextFormat {
			return _textFormatForStates[state] as TextFormat;
		}
		
		public function setTextFormatForState( format:TextFormat, state:String ):void {
			_textFormatForStates[state] = format;			
		} 
		
		public function setIcon( value:Object ):void {
			_icon = value;
			var hasChildren:Boolean = true;
			while( hasChildren ) {
				try{
					imageBlock.removeChildAt(0);
				} catch ( error:RangeError ) {
					hasChildren = false;
				}
			}
			if( value == null ) {
				imageBlock.visible = false;
			} else if ( value is Bitmap ) {
				var bitmap:Bitmap = value as Bitmap;
				imageBlock.addChild( bitmap );
			} else if ( value is BitmapData) {
				var bitmapData:BitmapData = value as BitmapData;
				imageBlock.addChild( new Bitmap( bitmapData ) );
			} else if ( value is String ) {
				var ldr:Loader = new Loader();
				var urlRequest:URLRequest = new URLRequest( value.toString() );
				ldr.load( urlRequest );
				imageBlock.addChild( ldr );
			}
		}
		
		override protected function draw():void {
			if( imageBlock && imageBlock.visible ) {
				imageBlock.x = (width - imageBlock.width) / 2;
				imageBlock.y = (height - imageBlock.height) / 2;
				labelTextField.x = (width - labelTextField.textWidth) / 2;
				labelTextField.y = imageBlock.y + imageBlock.height + labelTextField.textHeight;
			} else if ( labelTextField ) {
				labelTextField.x = (width - labelTextField.textWidth) / 2;
				labelTextField.y = (height - labelTextField.textHeight) / 2;
			}
			super.draw();
		}
	}
}