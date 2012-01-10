package mas.agent.sensor 
{
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface ISensor 
	{
		function receive(agt:Agent):void;
	}
	
}