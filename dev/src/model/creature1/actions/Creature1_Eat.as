package model.creature1.actions 
{
	import mas.agent.action.Action;
	import mas.agent.Agent;
	import model.BioAction;
	import model.BioAgent;
	import model.FoodAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1_Eat extends Action
	{
		
		private var food:FoodAgent;
		public function Creature1_Eat(food:FoodAgent, agt:BioAgent, duration:int) 
		{
			super(agt, duration, BioAction.ACTION_EATING);
			this.food = food;
		}
		
		override function onFinish() {
			var bioag:BioAgent = BioAgent(agent);
			bioag.recoverEnergy();
		}	
		
	}
	
}