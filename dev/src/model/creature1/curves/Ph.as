package model.creature1.curves 
{
	import model.LimitingFactorCurve;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Ph implements LimitingFactorCurve
	{
		
		public function Ph() 
		{
			
		}
		
		/* INTERFACE model.LimitingFactorCurve */
		
		public function get getFactorName():String 
		{
			return "ph"
		}
		private var xlo:Number  = 0
		private var xhi:Number = 7
		
		public function calculateTolerance(val:Number):Number 
		{
			var res:Number = ((4 * (val - xhi) * (val - xlo)) / Math.pow(xhi - xlo, 2)) * -1;
			res = cut(res);
			return res;
		}
		
		public function cut(val:Number):Number {
			return Math.max(0, Math.min(val, 1));
		}
		
	}
	
}