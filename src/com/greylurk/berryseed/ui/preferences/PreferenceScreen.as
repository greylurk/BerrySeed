package com.greylurk.berryseed.ui.preferences
{	
	import com.greylurk.berryseed.preferences.PreferenceSection;
	
	import flash.events.Event;
	
	import qnx.ui.core.Container;
	import qnx.ui.core.Containment;
	import qnx.ui.core.SizeMode;
	import qnx.ui.core.SizeUnit;
	import qnx.ui.core.UIComponent;
	import qnx.ui.listClasses.List;
	import qnx.ui.listClasses.SectionList;
	import com.greylurk.berryseed.ui.Screen;
	
	public class PreferenceScreen extends Screen
	{
		private var _preferenceSectionList:List;
		private var _preferenceScreens:Vector.<SectionList>;
		private var _preferenceSectionContainer:Container;
		
		public function PreferenceScreen()
		{
			super("Preferences");
			initializeControl();
		}
		
		private function initializeControl():void {
			_preferenceSectionList = new List();
			_preferenceSectionList.containment = Containment.DOCK_LEFT;
			_preferenceSectionList.size = 240;
			_preferenceSectionList.sizeUnit = SizeUnit.PIXELS;
			
			addChild( _preferenceSectionList );
			
			_preferenceSectionContainer = new Container();
			_preferenceSectionContainer.containment = Containment.CONTAINED;
			_preferenceSectionContainer.size = 100;
			_preferenceSectionContainer.sizeUnit = SizeUnit.PERCENT;
			_preferenceSectionContainer.sizeMode = SizeMode.BOTH;
			
			addChild( _preferenceSectionContainer );
		}
		
		public function addSection( section:PreferenceSection ):void {
			
		}
		
	}
}