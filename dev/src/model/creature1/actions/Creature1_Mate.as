package model.creature1.actions 
{
	import mas.agent.action.Action;
	import model.AgentEvent;
	import model.BioAction;
	import model.BioAgent;
	import model.creature1.Creature1;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1_Mate extends Action
	{
				
		public var couple:BioAgent
		public function Creature1_Mate(agt:BioAgent, duration:Number, couple:BioAgent) 
		{
			super(agt, duration, BioAction.ACTION_MATING)
			this.couple = couple;
			
		}
		
		override public function onStart():void {
			BioAgent(agent).direction = direction;
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, agent);
			ev.duration = duration;
			ev.actionType = BioAction.ACTION_MATING;
			ev.tag = couple;
			agent.eventDispatcher.dispatchEvent(ev);
		}
		
		override public function onFinish():void {
			var ev:AgentEvent = new AgentEvent(AgentEvent.MATING_COMPLETE, agent, true);
			agent.eventDispatcher.dispatchEvent(ev);
			calculateEnergyCost();
		}	
		
		
	}
	
}