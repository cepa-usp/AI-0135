package model.creature1 
{
	import model.Config;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Interest_Mating extends Interest
	{
		
		public function Interest_Mating(min:Number, max:Number) 
		{
			super(min, max);
		}
		
		override public function getValue(e:Number):Number {
			return ((max - min) * (e - Config.DEFAULT_BIOAGENT_Ea))/(Config.DEFAULT_BIOAGENT_EC - Config.DEFAULT_BIOAGENT_Ea);
		}			
	}
	
}