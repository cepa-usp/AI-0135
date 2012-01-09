package mas.enviro
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class DefaultRegion extends Region
	{		
		private var resources:Object = new Object();
		public function DefaultRegion() 
		{
				resources(Region.TYPE_TEMPERATURE) = 22;
				resources(Region.TYPE_PH) = 7;
		}
		
	}
	
}