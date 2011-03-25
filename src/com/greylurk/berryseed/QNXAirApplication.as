package com.greylurk.berryseed
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	
	import qnx.ui.core.Container;
	import qnx.ui.core.Containment;

	/**
	 * This class is the application level object which acts as the display
	 * root and container for all other parts of a BerrySeed Application
	 */
	public class QNXAirApplication extends Container
	{
		private var _screens:Array;
		private var _messageBus:EventDispatcher;
		private var navBar:NavigationBar;

		protected function get messageBus():EventDispatcher {
			return _messageBus;
		}
		
		/**
		 * The message bus acts to exchange events between the root application, 
		 * it's screens, the navigation bar and the toolbar.
		 */
		public function QNXAirApplication()
		{
			super();
			_screens = new Array();
			
			_messageBus = new EventDispatcher();

			navBar = new NavigationBar();
			navBar.messageBus = _messageBus;
			navBar.setPosition(0,0);
			addChild(navBar);

			_messageBus.addEventListener( NavigationEvent.NAVIGATE, navigationEventHandler );
		}

		/**
		 * Add a screen to the navigation bar and screen stack.
		 * 
		 * @param icon The 64x64 icon which will represent the screen in the navigation bar
		 * @param screen An instance of the screen object to be managed by the QNXAirApplication
		 */
		public function addScreen( icon:Object, screen:Screen ):void {
			screen.containment = Containment.UNCONTAINED;
			screen.visible = false;
			screen.messageBus = _messageBus;
			_screens[_screens.length] = screen;
			navBar.addNavigationButton( icon, screen );
			addChild(screen);
			
			if( _screens.length == 1 ) {
				navigateTo(screen);
			}
		}
		
		private function navigationEventHandler( event:NavigationEvent ): void {
			navigateTo(event.destinationScreen);
		}
		
		/**
		 * Navigate to a specific screen.  Hides all other screens and brings 
		 * the specified screen to the front.
		 * 
		 * @param screen The screen to navigate to 
		 */		
		public function navigateTo( screen:Screen ):void {
			screen.visible = true;
			for(var i:int = 0; i< _screens.length; i++ ) {
				if( _screens[i] != screen ) {
					_screens[i].visible = false;
				}
			}
			bringChildToFront( screen );
			bringChildToFront( navBar );
			navBar.currentScreen = screen;
		}

		private function bringChildToFront( child:DisplayObject ):void {
			if( numChildren >= 1 ) {
				setChildIndex( child, numChildren - 1 );
			}
		}

	}
}