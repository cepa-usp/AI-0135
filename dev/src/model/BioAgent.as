package model 
{
	import flash.display.Sprite;
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BioAgent implements Agent
	{
		private var _energy:Number = 0;
		private var initial_maxenergy:Number = 100;
		private var current_maxenergy:Number = 100;
		private var _age:int = 0; // age in turns
		private var _isMoving:Boolean = false;
		private var _velocity:int = Config.DEFAULT_BIOAGENT_MAXVEL;
		private var turnsToRefresh = 10; private var refreshTurn = 0;
		private var limitingFactors:Vector.<LimitingFactor> = new Vector.<LimitingFactor>();
		
		
		public function BioAgent() 
		{
			
		}
		
		public function recoverEnergy() {
			energy = current_maxenergy;
		}
		
		private function calculateMaxEnergy():void {
			current_maxenergy = initial_maxenergy * Math.pow(Math.E, (age * -1) / Config.DEFAULT_BIOAGENT_OLDAGE);
		}
		
		private function calculateVelocity():void {
			velocity = Config.DEFAULT_BIOAGENT_MAXVEL * (1 - Math.pow(Math.E, (energy * -1)/Config.DEFAULT_BIOAGENT_EV))
		}
		
		private function 
		
		
		public function init():void
		{
			refreshTurn = Math.random() * turnsToRefresh;
			initial_maxenergy  = Config.createBioAgentEnergy();
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function actuate():void
		{
			
		}
		
		public function refresh():void
		{
			if (age % turnsToRefresh == refreshTurn) { // dessa forma, os agentes não processarão todos ao mesmo tempo, diminuindo possível latência
				calculateMaxEnergy();
				calculateVelocity();
			}
			
			
		}
		
		public function calculateEnergyExpenditure():void {
			var x:int = 1;
			energy = energy - x;
		}
		
	

		
		public function get energy():Number 
		{
			return _energy;
		}
		
		public function set energy(value:Number):void 
		{
			_energy = value;
		}
		
		public function get maxenergy():Number 
		{
			return current_maxenergy;
		}
		
		public function set maxenergy(value:Number):void 
		{
			current_maxenergy = value;
		}
		
		public function get isMoving():Boolean 
		{
			return _isMoving;
		}
		
		public function set isMoving(value:Boolean):void 
		{
			_isMoving = value;
		}
		
		public function get age():int 
		{
			return _age;
		}
		
		public function set age(value:int):void 
		{
			_age = value;
		}
		
		public function get velocity():int 
		{
			return _velocity;
		}
		
		public function set velocity(value:int):void 
		{
			_velocity = value;
		}
		
		private static const STATE_IDLE:int = 0;		
		private static const STATE_SEARCHING_FOOD:int = 1;
		private static const STATE_OBTAINING_FOOD:int = 2;		
		private static const STATE_SEARCHING_MATE:int = 3;
		private static const STATE_MATING:int = 4;		
		private static const STATE_DEAD:int = 5;
		
	}
	
}