package model.creature1 
{
	import flash.geom.Point;
	import model.IExpenditure;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1Expenditures implements IExpenditure
	{
		
		public function Creature1Expenditures() 
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
			return new Point(150, 550)
		}
		
		public function get expDefault():Point 
		{
			return new Point(50, 70)
		}
		
	}
	
}