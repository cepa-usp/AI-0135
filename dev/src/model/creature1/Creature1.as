package model.creature1
{
	import mas.agent.action.Action;
	import mas.agent.reasoning.IReasoning;
	import mas.agent.sensor.ISensor;
	import model.BioAgent;
	import model.creature1.curves.Temperature;
	
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
			this.expenditures = new Creature1Expenditures();
			this.limitingFactors.push(new Temperature());
		}
		
		private function createReasoning():void 
		{
			reasoning.push(new Reasoning_AutoEvaluate());
			reasoning.push(new Reasoning_SearchFood());
			reasoning.push(new Reasoning_SearchMate());
			
		}
		
		public function createSensors():void {
			var s:ISensor;
			s = new SimpleEyes();
			sensors.push(s);
		}
		
		
		
	}
	
}