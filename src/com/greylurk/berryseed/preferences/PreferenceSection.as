package com.greylurk.berryseed.preferences
{
	import qnx.ui.data.DataProvider;
	
	import spark.components.Group;

	public class PreferenceSection
	{
		public function PreferenceSection()
		{
		}
		
		/**
		 * The name of the preference section
		 */
		public var name:String;
		/**
		 * A 32x32 icon representing the preference section
		 */
		public var icon:Class;
	}
}