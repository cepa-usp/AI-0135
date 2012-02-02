package mas.enviro
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Region 
	{		
		private var _resources:Dictionary = new Dictionary();
		private var _area:Rectangle;
		
		public function Region(r:Rectangle) 
		{
			area = r;
		}
		public function getResourceValue(resourceName:String):Number {
			if (resources[resourceName] != null) {
				if (resources[resourceName] is Number) {
					return resources[resourceName];	
				}				
			}
			return Number.NaN;
		}
		
		public function setResourceValue(resourceName:String, value:Number):void {
			if (resources[resourceName] != null) {
				resources[resourceName] = value;
			}
		}		
		
		public static const TYPE_TEMPERATURE:String  = "temperature";
		public static const TYPE_PH:String  = "ph";
		public static const TYPE_HUMIDITY:String  = "humidity";
		
		public function get area():Rectangle 
		{
			return _area;
		}
		
		public function set area(value:Rectangle):void 
		{
			_area = value;
		}
		
		public function get resources():Dictionary 
		{
			return _resources;
		}

		
	}
	
}