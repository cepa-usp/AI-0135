package model
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Interest 
	{
		
		protected var min:Number = 0;
		protected var max:Number = 1;
	
		public function Interest(min:Number, max:Number) 
		{
			this.min = min;
			this.max = max;
		}
		
		public function getValue(e:Number):Number {
			return max;
		}
		
	}
	
}