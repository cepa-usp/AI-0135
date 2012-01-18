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
	public class Creature1_Die  extends Action
	{
		
		public function Creature1_Die(agt:BioAgent, duration:int) 
		{
			super(agt, duration, BioAction.ACTION_DEAD);
		}
		
		override public function onStart():void{

		}			
		
		override public function onFinish():void {
			
			var ev:AgentEvent = new AgentEvent(AgentEvent.TERMINATED, agent);
			BioAgent(agent).eventDispatcher.dispatchEvent(ev);
			BioAgent(agent).stopTimer()
		}	

		
	}
	
}