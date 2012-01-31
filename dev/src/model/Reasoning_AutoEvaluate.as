package model
{
	import flash.geom.Point;
	import mas.agent.Agent;
	import mas.agent.reasoning.IReasoning;
	import mas.enviro.Environment;
	import model.BioAgent;
	import model.creature1.actions.Creature1_Move;
	import model.creature1.Creature1;
	import model.FoodAgent;
	
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
			var ic:Number = agent.intrFeeding.getValue(agent.energy)
			var ia:Number = agent.intrMating.getValue(agent.energy)

			//agent.mindState = BioAgent.MINDSTATE_SEARCHING_FOOD;
			
			
			var vv:Number = Math.random();
				if (vv < ia && agent.age>0) {
					agent.mindState = BioAgent.MINDSTATE_SEARCHING_MATE;
				} else if (vv < ic || agent.age==0) {
					agent.mindState = BioAgent.MINDSTATE_SEARCHING_FOOD;
				} else {
					agent.mindState = BioAgent.MINDSTATE_IDLE;
				}
			
			
			
		}
	}
}