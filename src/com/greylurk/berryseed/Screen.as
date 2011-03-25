package com.greylurk.berryseed
{
	
	import flash.events.EventDispatcher;
	
	import qnx.ui.core.UIComponent;
	
	public class Screen extends Panel
	{
		private var _toolBarElements:Vector.<UIComponent>;
		private var _messageBus:EventDispatcher;
		private var _title:String = "Screen";

		public function get title():String {
			return _title;
		}
		
		public function set title( value:String ):void{
			_title = value;
		}
		
		public function get toolBarElements():Vector.<UIComponent> {
			return _toolBarElements;
		}
	
		protected function get messageBus():EventDispatcher {
			return _messageBus;
		}

		public function set messageBus( messageBus:EventDispatcher ):void {
			_messageBus = messageBus;	
		}
		
		public function Screen( _title:String )
		{
			super();
			this._toolBarElements = new Vector.<UIComponent>();
			this.title = _title;
		}
		
		protected override function onAdded():void {
			super.onAdded();
			x = 0;
			y = 64;
			height = stage.fullScreenHeight - 64;
			width = stage.fullScreenWidth;
		}
		
	}
}