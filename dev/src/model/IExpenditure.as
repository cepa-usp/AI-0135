package model 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface IExpenditure 
	{
		function get expFeeding():Point;
		function get expMating():Point;
		function get expWalking():Point;
		function get expDefault():Point;
	}
	
}