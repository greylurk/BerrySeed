package com.greylurk.berryseed
{
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	
	import qnx.ui.core.Container;
	import qnx.ui.core.Containment;

	public class QNXAirApplication extends Container
	{
		private var _screens:Array;
		private var _messageBus:EventDispatcher;
		private var navBar:NavigationBar;

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