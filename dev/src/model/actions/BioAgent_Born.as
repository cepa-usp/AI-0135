package model.actions 
{
	import mas.agent.action.Action;
	import model.BioAction;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BioAgent_Born extends Action
	{
		public function BioAgent_Born(agt:BioAgent, duration:int) 
		{
			super(agt, duration, BioAction.ACTION_BORN);			
		}	
		
	}
	
}