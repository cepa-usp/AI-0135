package mas.enviro
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Region 
	{		
		private var resources:Object = new Object();
		public function Region() 
		{
			
		}
		public function getResourceValue(resourceName:String):Number {
			if (resources(resourceName) != null) {
				if (resources(resourceName) is Number) {
					return resources(resourceName);	
				}				
			}
			return Number.NaN;
		}
		
		public static const TYPE_TEMPERATURE:String  = "temperature";
		public static const TYPE_PH:String  = "ph";
		public static const TYPE_PRESSURE:String  = "pressure";
		
	}
	
}