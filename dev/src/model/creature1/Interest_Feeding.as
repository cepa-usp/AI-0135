package model.creature1 
{
	import model.Config;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Interest_Feeding extends Interest
	{
		
		public function Interest_Feeding(min:Number, max:Number) 
		{
			super(min, max);
		}
		
		override public function getValue(e:Number):Number {
			return ((max - min) * (Config.DEFAULT_BIOAGENT_EC - e))/(Config.DEFAULT_BIOAGENT_EC - Config.DEFAULT_BIOAGENT_Ec);
		}		
	}
	
}