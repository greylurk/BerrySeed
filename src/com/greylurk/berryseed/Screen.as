package com.greylurk.berryseed
{
	import flash.events.EventDispatcher;
	import qnx.ui.core.UIComponent;
	
	/**
	 * 
	 */
	public class Screen extends Panel
	{
		private var _toolBarElements:Vector.<UIComponent>;
		private var _messageBus:EventDispatcher;
		private var _title:String = "Screen";

		/**
		 * This is the title to display in the toolbar when this screen is 
		 * active
		 */
		public function get title():String {
			return _title;
		}
		
		public function set title( value:String ):void{
			_title = value;
		}
		
		/**
		 * This is a Vector containing UI components to display in the 
		 * toolbar when this screen is active
		 */
		public function get toolBarElements():Vector.<UIComponent> {
			return _toolBarElements;
		}

		/**
		 * The message bus acts to exchange events between the root application, 
		 * it's screens, the navigation bar and the toolbar.
		 */
		protected function get messageBus():EventDispatcher {
			return _messageBus;
		}

		public function set messageBus( messageBus:EventDispatcher ):void {
			_messageBus = messageBus;	
		}
		
		public function Screen( _title:String = "" )
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