package model 
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface LimitingFactorCurve
	{
		function get getFactorName():String;
		function get f():Number;
		function calculateTolerance(val:Number):Number;

	}
	
}