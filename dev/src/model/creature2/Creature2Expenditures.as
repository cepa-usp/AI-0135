package model.creature2
{
	import flash.geom.Point;
	import model.IExpenditure;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature2Expenditures implements IExpenditure
	{
		
		public function Creature2Expenditures() 
		{
			
		}
		
		/* INTERFACE model.IExpenditure */
		
		public function get expFeeding():Point 
		{
			return new Point(90, 110)
		}
		
		public function get expMating():Point 
		{
			return new Point(100, 160);
		}
		
		public function get expWalking():Point 
		{
			return new Point(6, 30)
		}
		
		public function get expDefault():Point 
		{
			return new Point(50, 70)
		}
		
	}
	
}