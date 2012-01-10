package model.creature1 
{
	import mas.agent.Agent;
	import mas.agent.sensor.ISensor;
	import mas.enviro.Environment;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class SimpleEyes implements ISensor
	{
		
		public function SimpleEyes() 
		{
			
		}
		
		/* INTERFACE mas.agent.sensor.ISensor */
		
		public function receive(agt:Agent):void 
		{
			var env:Environment = agt.environment;
			var qt:int = 2;
			for (var d:int  = 0; d < 9; d++) {
				
			}
		}
		
	}
	
}