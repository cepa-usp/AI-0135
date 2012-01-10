package model 
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface LimitingFactorCurve
	{
		function get getFactorName():String;
		function calculateTolerance(val:Number):Number;

	}
	
}