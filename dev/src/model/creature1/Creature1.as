package model.creature1
{
	import mas.agent.action.Action;
	import mas.agent.reasoning.IReasoning;
	import mas.agent.sensor.ISensor;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature1 extends BioAgent
	{
		
		public function Creature1() 
		{
			super();
			createSensors();
			createReasoning();
		}
		
		private function createReasoning():void 
		{
			var r:IReasoning;
			r = new Reasoning_AutoEvaluate();
			reasoning.push(r);
		}
		
		public function createSensors():void {
			var s:ISensor;
			s = new SimpleEyes();
			sensors.push(s);
		}
		
		
		
	}
	
}