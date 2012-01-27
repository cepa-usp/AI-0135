package model.actions 
{
	import mas.agent.action.Action;
	import model.AgentEvent;
	import model.BioAction;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BioAgent_Die  extends Action
	{
		
		public function BioAgent_Die(agt:BioAgent, duration:int) 
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