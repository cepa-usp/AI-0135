package model 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import mas.agent.action.Action;
	import mas.agent.Agent;
	import mas.agent.reasoning.IReasoning;
	import mas.enviro.Environment;
	import mas.agent.sensor.ISensor;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BioAgent implements Agent 
	{
		private var _eventDispatcher:EventDispatcher = new EventDispatcher();
		private var _energy:Number = 0;
		private var _id:int = 0;
		private var _direction:int = 2;
		private var _initial_maxenergy:Number = 100;
		private var _current_maxenergy:Number = 100;
		private var _age:int = 0; // age in turns
		private var _velocity:int = Config.DEFAULT_BIOAGENT_MAXVEL;
		private var turnsToRefresh:int = 10; private var refreshTurn:int = 0;
		private var _limitingFactors:Vector.<LimitingFactorCurve> = new Vector.<LimitingFactorCurve>();		
		private var _mindState:int = MINDSTATE_IDLE;
		private var _position:Point = new Point();
		private var _environment:Environment;
		private var currentAction:Action;
		
		protected var mindVars:Object;
		private var actionQueue:Vector.<Action> = new Vector.<Action>();
		protected var reasoning:Vector.<IReasoning> = new Vector.<IReasoning>();
		protected var sensors:Vector.<ISensor> = new Vector.<ISensor>();
		
		///private var sensors:Vector.<>
		
		
		public function BioAgent() 
		{
			id = Config.getId();
		}
		
		private function executeAction(e:TimerEvent= null):void {
			if(currentAction!=null) currentAction.onFinish();
			var skip:Boolean = false;
			if (actionQueue.length > 0) {
				currentAction = actionQueue.shift();
				if (currentAction.cancelOthers) clearActionQueue();
			} else {
				if (currentAction!=null) {
					if (currentAction.action == BioAction.ACTION_IDLE) skip = true;
				}
				currentAction = new Action(this, 1000, BioAction.ACTION_IDLE);
			}
			var timer:Timer = new Timer(currentAction.duration);						
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, executeAction);
			if (!skip) sendActionEvent(currentAction.action, currentAction.duration); 
			if(currentAction!=null) currentAction.onStart();
		}
		
		
		
		protected function clearActionQueue():void {
			actionQueue = new Vector.<BioAction>();
		}
		
		public function recoverEnergy():void {
			energy = current_maxenergy;
		}
		
		private function calculateMaxEnergy():void {
			current_maxenergy = initial_maxenergy * Math.pow(Math.E, (age * -1) / Config.DEFAULT_BIOAGENT_OLDAGE);
		}
		
		private function calculateVelocity():void {
			velocity = Config.DEFAULT_BIOAGENT_MAXVEL * (1 - Math.pow(Math.E, (energy * -1)/Config.DEFAULT_BIOAGENT_EV))
		}
		
		public function init(env:Environment, init_position:Point):void
		{
			refreshTurn = Math.random() * turnsToRefresh;
			initial_maxenergy  = Config.createBioAgentEnergy();
			environment = env;			
			_position = init_position;
			eventDispatcher.dispatchEvent(new Event(AgentEvent.INITIALIZED));
			executeAction();
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
		
		public function get eventDispatcher():EventDispatcher 
		{
			return _eventDispatcher;
		}
		
		public function get mindState():int 
		{
			return _mindState;
		}
		
		
		public function get limitingFactors():Vector.<LimitingFactorCurve> 
		{
			return _limitingFactors;
		}
		
		public function set limitingFactors(value:Vector.<LimitingFactorCurve>):void 
		{
			_limitingFactors = value;
		}
		

		

		public function changeMindState(state:int):void {
			this._mindState = state;
			var ev:AgentEvent = new AgentEvent(AgentEvent.MINDSTATE_CHANGED, this);
			ev.mindstate = state;
			_eventDispatcher.dispatchEvent(ev);
		}
		
		public function sendActionEvent(action:int, duration:Number, destination:Point=null, direction:int=-1):void {
			var str:String = "";
			var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, this);
			ev.actionType = action;
			ev.duration = duration;			
			ev.destination = destination;
			ev.walkingDirection = direction;	
			_eventDispatcher.dispatchEvent(ev);

		}
		
		/* INTERFACE mas.agent.Agent */
		
		
		public function think():void 
		{
			for each(var sens:ISensor in sensors) {
				sens.receive(this);
			}
			for each(var reas:IReasoning in reasoning) {
				reas.think(this);
			}
		}		
		
		public function get environment():Environment 
		{
			return _environment;
		}
		
		public function set environment(enviro:Environment):void 
		{
			_environment = enviro;
		}
		
		public function get position():Point 
		{
			return _position;
		}
		
		public function get initial_maxenergy():Number 
		{
			return _initial_maxenergy;
		}
		
		public function set initial_maxenergy(value:Number):void 
		{
			_initial_maxenergy = value;
		}
		
		public function get current_maxenergy():Number 
		{
			return _current_maxenergy;
		}
		
		public function set current_maxenergy(value:Number):void 
		{
			_current_maxenergy = value;
		}
		
		public function get id():int 
		{
			return _id;
		}
		
		public function set id(value:int):void 
		{
			_id = value;
		}
		
		public function get direction():int 
		{
			return _direction;
		}
		
		public function set direction(value:int):void 
		{
			_direction = value;
		}


		
		public static const MINDSTATE_IDLE:int = 0;		
		public static const MINDSTATE_SEARCHING_FOOD:int = 1;
		public static const MINDSTATE_OBTAINING_FOOD:int = 2;		
		public static const MINDSTATE_SEARCHING_MATE:int = 3;
		public static const MINDSTATE_MATING:int = 4;		
		public static const MINDSTATE_DEAD:int = 5;
		
		public static const DIR_UP = 8;
		public static const DIR_DOWN = 2;
		public static const DIR_LEFT = 6;
		public static const DIR_RIGHT = 4;
		

		
	}
	
}