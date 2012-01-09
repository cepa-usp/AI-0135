package model 
{
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BioAgent implements Agent
	{
		private var energy:int = 0;
		private var maxenergy:int = 100;
		
		public function BioAgent() 
		{
			
		}
		
		public function recoverEnergy() {
			energy = maxenergy
		}
		
		
		public function init() 
		{
			
		}
	
		private static const STATE_IDLE:int = 0;		
		private static const STATE_SEARCHING_FOOD:int = 0;
		private static const STATE_OBTAINING_FOOD:int = 0;		
		private static const STATE_SEARCHING_MATE:int = 0;
		private static const STATE_MATING:int = 0;
		
		private static const STATE_DEAD:int = 0;
	}
	
}