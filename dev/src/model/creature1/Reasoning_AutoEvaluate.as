package model.creature1 
{
	import mas.agent.Agent;
	import mas.agent.reasoning.IReasoning;
	import model.BioAgent;
	import model.creature1.Creature1;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Reasoning_AutoEvaluate implements IReasoning
	{
		
		public function Reasoning_AutoEvaluate() 
		{
			
		}
		
		/* INTERFACE mas.agent.reasoning.IReasoning */
		
		public function think(agt:Agent):void 
		{
			var agent:BioAgent = BioAgent(agt);
			var energy:Number = agent.energy;
		}
		
	}
	
}