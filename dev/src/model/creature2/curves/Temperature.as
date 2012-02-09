package model.creature2.curves 
{
	import model.LimitingFactorCurve;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Temperature implements LimitingFactorCurve
	{
		
		public function Temperature() 
		{
			
		}
		
		/* INTERFACE model.LimitingFactorCurve */
		
		public function get getFactorName():String 
		{
			return "temperature"
		}
		private var xlo:Number  = 5
		private var xhi:Number = 45
		
		public function get f():Number 
		{
			return 0.2;
		}		
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