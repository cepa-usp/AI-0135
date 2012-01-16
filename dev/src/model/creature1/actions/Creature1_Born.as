package model.creature1.actions 
{
	import mas.agent.action.Action;
	import model.BioAction;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1_Born extends Action
	{
		public function Creature1_Born(agt:BioAgent, duration:int) 
		{
			super(agt, duration, BioAction.ACTION_BORN);
			
			
		}	
	}
	
}