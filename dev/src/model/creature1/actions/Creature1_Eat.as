package model.creature1.actions 
{
	import mas.agent.action.Action;
	import mas.agent.Agent;
	import model.AgentEvent;
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
		
		override public function onStart():void{
			var bioag:BioAgent = BioAgent(agent);
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, bioag, true);
			ev.tag = food;
			ev.duration = this.duration;
			ev.actionType = BioAction.ACTION_EATING;
			ev.mindstate = bioag.mindState;
			//trace("pediu pra comer")
			bioag.eventDispatcher.dispatchEvent(ev);
		}			
		
		
		private function calculateEnergyCost():void 
		{
			BioAgent(agent).calculateEnergyExpenditure(BioAgent(agent).expenditures.expFeeding);
		}
		
		override public function onFinish():void {
			
			var ev:AgentEvent = new AgentEvent(AgentEvent.FEEDING_COMPLETE, agent);
			ev.tag = food;
			ev.duration = 0;
			BioAgent(agent).eventDispatcher.dispatchEvent(ev);
		}	
		
	}
	
}