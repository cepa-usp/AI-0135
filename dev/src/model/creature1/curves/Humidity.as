package model.creature1.curves 
{
	import model.LimitingFactorCurve;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Humidity implements LimitingFactorCurve
	{
		
		public function Humidity() 
		{
			
		}
		
		/* INTERFACE model.LimitingFactorCurve */
		
		public function get getFactorName():String 
		{
			return "humidity"
		}
		private var _xlo:Number  = 30
		private var _xhi:Number = 100
		
		
		public function calculateTolerance(val:Number):Number 
		{
			var res:Number = ((4 * (val - xhi) * (val - xlo)) / Math.pow(xhi - xlo, 2)) * -1;
			res = cut(res);
			return res;
		}
		
		public function cut(val:Number):Number {
			return Math.max(0, Math.min(val, 1));
		}
		

		public function get f():Number 
		{
			return 0.2;
		}
		
		public function get xlo():Number 
		{
			return _xlo;
		}
		
		public function set xlo(value:Number):void 
		{
			_xlo = value;
		}
		
		public function get xhi():Number 
		{
			return _xhi;
		}
		
		public function set xhi(value:Number):void 
		{
			_xhi = value;
		}
		
	}
	
}