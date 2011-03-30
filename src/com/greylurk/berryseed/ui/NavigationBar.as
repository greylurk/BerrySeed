package com.greylurk.berryseed.ui
{
	import com.greylurk.berryseed.animation.AnimationEvent;
	import com.greylurk.berryseed.animation.Slide;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	
	import qnx.events.QNXApplicationEvent;
	import qnx.system.QNXApplication;
	import qnx.ui.buttons.IconButton;
	import qnx.ui.buttons.LabelButton;
	import qnx.ui.core.Container;
	import qnx.ui.core.ContainerAlign;
	import qnx.ui.core.ContainerFlow;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.UIComponent;
	import qnx.ui.listClasses.DropDown;
	import qnx.ui.skins.SkinStates;
	import qnx.ui.skins.buttons.DropDownButtonSkinBlack;
	import qnx.ui.skins.buttons.RoundedButtonSkinBlack;
	import qnx.ui.skins.listClasses.DropDownBackgroundSkinBlack;
	import qnx.ui.text.Label;
	import com.greylurk.berryseed.event.NavigationEvent;

	/**
	 * The NavigationBar does not dispatch NavigationEvents from itself, 
	 * however it does dispatch them to the associated messageBus.
	 * 
	 * @see messageBus
	 */
	[Event(name="navigateTo", type="com.greylurk.berryseed.event.NavigationEvent")]
	
	/**
	 * The NavigationBar class provides both the swipe down navigation stack 
	 * for moving between different screens in your application, as well as 
	 * a toolbar which screens can define tools for.  It also displays the 
	 * title of the current screen on top of the application stack.
	 */
	public class NavigationBar extends Panel
	{
		private var _shim:Sprite;
		private var _animation:Slide;
		private var _navBar:Panel;
		private var _toolBar:Panel;
		private var _extended:Boolean;
		private var _navButtons:Dictionary;		
		private var _messageBus:EventDispatcher;
		private var _currentScreen:Screen;
		private var _screenLabel:Label;
		private var _buttonContainer:qnx.ui.core.Container;
		
		/**
		 * Create a new NavivationBar object.  
		 */
		public function NavigationBar()
		{
			QNXApplication.qnxApplication.addEventListener(QNXApplicationEvent.SWIPE_DOWN, swipeDownHandler);
			initializeUI();
			_extended = false;
			_navButtons = new Dictionary();
		}

		/**
		 * The messageBus is a mechanism for passing events between the 
		 * screens, the application, and the NavigationBar.  
		 * NavigationEvents generated from the NavigationBar are broadcast
		 * over this interface.
		 */
		public function get messageBus():EventDispatcher
		{
			return _messageBus;
		}

		public function set messageBus(value:EventDispatcher):void
		{
			_messageBus = value;
		}
		
		/**
		 * Positions the navigation bar slightly off screen
		 */
		protected override function onAdded():void {
			super.onAdded();
			
			setPosition(0,-128);
			_navBar.setSize( stage.fullScreenWidth, 128 );
			_toolBar.setSize( stage.fullScreenWidth, 64 );
			setSize( stage.fullScreenWidth, 192 );
		}
		
		private function initializeUI():void {
			
			_navBar = new Panel();
			_navBar.size = 128;
			_navBar.sizeUnit = SizeUnit.PIXELS;
			_navBar.sizeMode = SizeMode.FLOW;
			_navBar.flow = ContainerFlow.HORIZONTAL;
			_navBar.align = ContainerAlign.NEAR;
			_navBar.containment = Containment.CONTAINED;
			_navBar.margins = Vector.<Number>([8,8,8,8]);
			addChild( _navBar );

			_toolBar = new Panel();
			_toolBar.size = 64;
			_toolBar.sizeUnit = SizeUnit.PIXELS;
			_toolBar.sizeMode = SizeMode.FLOW;
			_toolBar.containment = Containment.CONTAINED;
			_toolBar.flow = ContainerFlow.VERTICAL;
			addChild( _toolBar );
			
			_screenLabel = new Label();
			_screenLabel.autoSize = TextFieldAutoSize.CENTER;
			_screenLabel.format = new TextFormat( "BBAlpha Sans", 16, 0xFFFFFF, true );
			_toolBar.addChild( _screenLabel );
			
			_buttonContainer = new Container();
			_buttonContainer.flow = ContainerFlow.HORIZONTAL;
			_buttonContainer.margins = Vector.<Number>([0,10,0,10]);
			_buttonContainer.padding = 10;
			_toolBar.addChild( _buttonContainer );
			
			_toolBar.layout();
			
			flow = ContainerFlow.VERTICAL;

			_animation = new Slide( this, new Point(0,-128), new Point(0,0) );

			_shim = new Sprite();
			_shim.graphics.beginFill( 0x000000, 0 );
			_shim.graphics.drawRect(0,0,1,1);
			_shim.addEventListener( MouseEvent.CLICK, shimClickHandler );
		}
				
		private function showNavButtons():void {
			if( _extended ) return;
			_animation.addEventListener(AnimationEvent.ANIMATION_COMPLETED, showAnimationCompleteHandler );
			_animation.start();
		}
				
		private function hideNavButtons():void {
			if( !_extended ) return;
			_animation.addEventListener(AnimationEvent.ANIMATION_COMPLETED, hideAnimationCompleteHandler );
			_animation.reverse();
		}
		
		private function clearToolBarItems():void {
			while( _buttonContainer.numChildren > 0 ) {
				_buttonContainer.removeChildAt( 0 );
			}
		}
		
		/**
		 * Set the current Screen which should be reflected in the tool bar 
		 * and title of the NavigationBar.
		 */
		public function set currentScreen( value:Screen ):void {
			_currentScreen = value;
			setToolBarElements(value.toolBarElements);
			setTitle( value.title );
		}
		
		private function setTitle( value:String ):void {
			_screenLabel.text = value;
			layout();
		}
		
		private function setToolBarElements( elements:Vector.<UIComponent> ):void {
			clearToolBarItems();
			var format:TextFormat = new TextFormat("BBAlpha Sans",12,0xcccccc,null,null,null,null,null,TextFormatAlign.CENTER);
			var formatDown:TextFormat = new TextFormat("BBAlpha Sans",12,0xffffff,null,null,null,null,null,TextFormatAlign.CENTER);
			for each (var i:UIComponent in elements ) {
				i.setSize( i.width, Math.min( i.height, 32) );
				if( i is LabelButton ) {
					var labelButton:LabelButton = i as LabelButton;
					labelButton.setSkin(RoundedButtonSkinBlack);
					labelButton.setTextFormatForState(format,SkinStates.DISABLED);
					labelButton.setTextFormatForState(format,SkinStates.UP);
					labelButton.setTextFormatForState(formatDown,SkinStates.DOWN);
					labelButton.setTextFormatForState(format,SkinStates.SELECTED);
					labelButton.setTextFormatForState(format,SkinStates.DISABLED_SELECTED);
				} else if( i is DropDown ) {
					var dropDown:DropDown = i as DropDown;
					dropDown.setButtonSkin( DropDownButtonSkinBlack );
					dropDown.setBackgroundSkin( DropDownBackgroundSkinBlack );
				}
				_buttonContainer.addChild( i );
			}
			_buttonContainer.layout();
		}
		
		/**
		 * Add a navigation button to the NavigationBar. The Buttons will be 
		 * displayed in the order that they are added to the NavigationBar
		 * 
		 * @param icon The graphic icon which will represent the screen in the 
		 * navigation bar
		 * 
		 * @param screen The screen which should be transitioned to
		 */
		public function addNavigationButton( icon:Object, screen:UIComponent ):void {
			var button:IconButton = new IconButton();
		
			button.addEventListener( MouseEvent.CLICK, navButtonClickHandler );
			button.setIcon( icon );
			button.size = 112;
			button.sizeUnit = SizeUnit.PIXELS;
			button.sizeMode = SizeMode.BOTH;
			button.containment = Containment.CONTAINED;
			button.setSkin( RoundedButtonSkinBlack );
			_navButtons[button] = screen;

			_navBar.addChild( button );
			_navBar.layout();
		}
		
		/*
		 * Event Handlers
		 */
		
		private function swipeDownHandler( event:QNXApplicationEvent ) : void {
			showNavButtons();
		}
		
		private function shimClickHandler( event:MouseEvent ) : void {
			hideNavButtons();
		}
		
		private function showAnimationCompleteHandler( event:AnimationEvent ) : void {
			_extended = true;
			_animation.removeEventListener(AnimationEvent.ANIMATION_COMPLETED, showAnimationCompleteHandler );
			_shim.scaleX = stage.fullScreenWidth;
			_shim.scaleY = stage.fullScreenHeight;
			addChild(_shim);
			layout();
		}
		
		private function hideAnimationCompleteHandler( event:AnimationEvent ):void {
			_extended = false;
			_animation.removeEventListener(AnimationEvent.ANIMATION_COMPLETED, hideAnimationCompleteHandler );
			removeChild(_shim);
			layout();
		}
		
		private function navButtonClickHandler( event:MouseEvent ):void {
			var button:IconButton = event.target as IconButton;
			var navEvent:NavigationEvent = new NavigationEvent( NavigationEvent.NAVIGATE );
			var screen:Screen = _navButtons[button];
			hideNavButtons()
			if( screen ) {
				navEvent.destinationScreen = screen;
				messageBus.dispatchEvent(navEvent);
			}
		}
	
	}
}