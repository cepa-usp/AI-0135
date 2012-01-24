package model.creature1.actions 
{
	import mas.agent.action.Action;
	import model.AgentEvent;
	import model.BioAction;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1_Idle  extends Action
	{
		
		public function Creature1_Idle(agt:BioAgent, duration:int) 
		{
			super(agt, duration, BioAction.ACTION_IDLE);
		}
		
		override public function onStart():void{
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, agent);
			ev.actionType = BioAction.ACTION_IDLE;
			ev.duration = this.duration;
			ev.agent = agent;
			BioAgent(agent).eventDispatcher.dispatchEvent(ev);
			
		}			
		
		override public function onFinish():void {
			

		}	

		
	}
	
}