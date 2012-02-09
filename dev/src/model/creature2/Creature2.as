package model.creature2
{
	import mas.agent.action.Action;
	import mas.agent.reasoning.IReasoning;
	import mas.agent.sensor.ISensor;
	import model.BioAgent;
	import model.creature2.curves.Humidity;
	import model.creature2.curves.Ph;
	import model.creature2.curves.Temperature;
	import model.Reasoning_AutoEvaluate;
	import model.Reasoning_SearchFood;
	import model.SimpleEyes;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Creature2 extends BioAgent
	{
		
		public function Creature2() 
		{
			super();
			createSensors();
			createReasoning();
			this.expenditures = new Creature2Expenditures();
			this.limitingFactors.push(new Temperature());
	//		this.limitingFactors.push(new Ph());
			this.limitingFactors.push(new Humidity());
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