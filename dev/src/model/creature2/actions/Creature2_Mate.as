package model.creature2.actions 
{
	import mas.agent.action.Action;
	import model.AgentEvent;
	import model.BioAction;
	import model.BioAgent;

	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature2_Mate extends Action
	{
				
		private var couple:BioAgent
		private var start:Boolean = false;
		public function Creature2_Mate(agt:BioAgent, duration:Number, couple:BioAgent) 
		{
			super(agt, duration, BioAction.ACTION_MATING)
			this.couple = couple;
			start = (couple.mindState == BioAgent.MINDSTATE_MATING)
			
		}
		
		override public function onStart():void {
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, agent);
			ev.duration = duration;
			ev.actionType = BioAction.ACTION_MATING;
			ev.tag = couple;			
			agent.eventDispatcher.dispatchEvent(ev);
		}
		
		override public function onFinish():void {
			if(start){
				var ev:AgentEvent = new AgentEvent(AgentEvent.MATING_COMPLETE, agent, true);
				agent.eventDispatcher.dispatchEvent(ev);
			}
			
			calculateEnergyCost();
		}	
		
		private function calculateEnergyCost():void 
		{
			BioAgent(agent).calculateEnergyExpenditure(BioAgent(agent).expenditures.expMating);
		}
		
		
	}
	
}