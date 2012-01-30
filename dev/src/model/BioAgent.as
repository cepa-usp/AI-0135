package model 
{
	import as3isolib.core.EventListenerDescriptor;
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
	import mas.enviro.Region;
	import model.actions.BioAgent_Idle;
	import model.Interest;
	import model.creature1.Interest_Feeding;
	import model.creature1.Interest_Mating;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class BioAgent extends BaseAgent implements Agent 
	{
		private var _eventDispatcher:EventDispatcher = new EventDispatcher();
		private var _energy:Number = 0;
		private var _id:int = 0;
		private var _direction:int = 2;
		private var _initial_maxenergy:Number = 2000;
		private var _current_maxenergy:Number = 2000;
		private var _age:int = 0; // age in turns
		
		private var _selected:Boolean = false;
		private var _velocity:Number = Config.DEFAULT_BIOAGENT_MAXVEL;
		private var _limitingFactors:Vector.<LimitingFactorCurve> = new Vector.<LimitingFactorCurve>();		
		private var _mindState:int = MINDSTATE_IDLE;
		private var _currentAction:Action;
		private var timer:Timer;
		private var _expenditures:IExpenditure;
		private var _intrMating:Interest_Mating = new Interest_Mating(0.2, 0.6);
		private var _intrFeeding:Interest_Feeding = new Interest_Feeding(0.1, 1);
		
		
		protected var _mindVars:Object = new Object();
		private var actionQueue:Vector.<Action> = new Vector.<Action>();
		protected var reasoning:Vector.<IReasoning> = new Vector.<IReasoning>();
		protected var sensors:Vector.<ISensor> = new Vector.<ISensor>();
		
		///private var sensors:Vector.<>
		
		public function stopTimer():void {
			timer.stop();
		}
		
		public function BioAgent() 
		{
			id = Config.getId();
		}
		
		private function executeAction(e:TimerEvent= null):void {
			if(currentAction!=null) currentAction.onFinish();
			if (actionQueue.length > 0) {
				currentAction = actionQueue.shift();
				//if (currentAction.cancelOthers) clearActionQueue();
			} else {
				think();				
				if (actionQueue.length > 0) {
					executeAction();
					return;
				} 
				//if (currentAction == null) {
					this.mindState = MINDSTATE_IDLE;
					currentAction = new BioAgent_Idle(this, Config.t*2);
					
				//}
			}
			if (currentAction.duration <= 0) return;
			timer = new Timer(currentAction.duration, 1);						
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, executeAction);
			//sendActionEvent(currentAction.action, currentAction.duration); 
			currentAction.onStart();
			timer.start();
		}
		
		
		//private function passou(e:TimerEvent = null) {
			
		//}
		
		
		protected function clearActionQueue():void {
			actionQueue = new Vector.<BioAction>();
		}
		
		public function enqueueAction(a:Action):void {
			actionQueue.push(a);
		}
		
		public function recoverEnergy(amnt:Number):void {
			energy += amnt;
			energy = Math.min(energy, current_maxenergy);
		}
		
		public function addAge():void {
			age++;
			calculateMaxEnergy();
			calculateVelocity();
			if (id == Config.viewId) {
				trace("new maxenergy/vel: ", _current_maxenergy, velocity)
			}
		}
		
		private function calculateMaxEnergy():void {
			current_maxenergy = initial_maxenergy * Math.pow(Math.E, (age * -1) / Config.DEFAULT_BIOAGENT_OLDAGE);
			energy = Math.min(current_maxenergy, energy);
		}
		
		private function calculateVelocity():void {
			velocity = Config.DEFAULT_BIOAGENT_MAXVEL * (1 - Math.pow(Math.E, (energy * -1) / Config.DEFAULT_BIOAGENT_EV))

		}
		
		override public function init(env:Environment, init_position:Point):void
		{
			initial_maxenergy  = Config.createBioAgentEnergy();
			energy = _initial_maxenergy;
			_environment = env;			
			_position = init_position;
			eventDispatcher.dispatchEvent(new Event(AgentEvent.INITIALIZED));
			think();
			executeAction();
		}
		


		public function calculateEnergyExpenditure(expense:Point):void {
			var maxret:Number = Number.NEGATIVE_INFINITY;
			for each (var c:LimitingFactorCurve in limitingFactors) {
				var parameter:String = c.getFactorName;
				var reg:Region = environment.getRegion(position);
				var valor:Number = reg.getResourceValue(parameter);				
				var f:Number = c.calculateTolerance(valor);
				var ret:Number = ((1 - f) * expense.y) - (f * expense.x);
				if (ret > maxret) maxret = ret;
			}
			if(id==Config.viewId) trace(energy.toFixed(0), " - ", maxret.toFixed(0), " -> ", parameter, "   -   " + mindstatenames[this.mindState])
			energy += maxret;
			
			
			if (energy <= 0) {
				this.mindState = MINDSTATE_DEAD;
				var ev:AgentEvent = new AgentEvent(AgentEvent.ACTION_CHANGED, this);				
				ev.actionType = BioAction.ACTION_DEAD;
				eventDispatcher.dispatchEvent(ev);
			}
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
		
		public function get velocity():Number 
		{
			return _velocity;
		}
		
		public function set velocity(value:Number):void
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
		
		public function set mindState(val:int):void 
		{
			_mindState = val;
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
		

		
		/* INTERFACE mas.agent.Agent */
		
		
		public function think():void 
		{
			//trace("ag", this.id, " thinking")
			if (mindState == MINDSTATE_DEAD) return;
			for each(var sens:ISensor in sensors) {
				sens.receive(this);
			}
			for each(var reas:IReasoning in reasoning) {
				reas.think(this);
			}
		}		
		
		/* INTERFACE mas.agent.Agent */
		
		public function select(val:Boolean):void 
		{			
			eventDispatcher.dispatchEvent(new Event(Event.SELECT));
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function get description():String 
		{
			return "creature [" + id.toString() + "]"
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function get block():Boolean 
		{
			return true;
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
		
		public function get currentAction():Action 
		{
			return _currentAction;
		}
		
		public function set currentAction(value:Action):void 
		{
			_currentAction = value;
		}
		
		public function get intrMating():Interest_Mating 
		{
			return _intrMating;
		}
		
		public function set intrMating(value:Interest_Mating):void 
		{
			_intrMating = value;
		}
		
		public function get intrFeeding():Interest_Feeding 
		{
			return _intrFeeding;
		}
		
		public function set intrFeeding(value:Interest_Feeding):void 
		{
			_intrFeeding = value;
		}
		
		public function get mindVars():Object 
		{
			return _mindVars;
		}
		
		public function set mindVars(value:Object):void 
		{
			_mindVars = value;
		}
		
		public function get expenditures():IExpenditure 
		{
			return _expenditures;
		}
		
		public function set expenditures(value:IExpenditure):void 
		{
			_expenditures = value;
		}
		
		public function get selected():Boolean 
		{
			return _selected;
		}
		
		


		
		public static const MINDSTATE_IDLE:int = 0;		
		public static const MINDSTATE_SEARCHING_FOOD:int = 1;
		public static const MINDSTATE_OBTAINING_FOOD:int = 2;		
		public static const MINDSTATE_SEARCHING_MATE:int = 3;
		public static const MINDSTATE_MATING:int = 4;		
		public static const MINDSTATE_DEAD:int = 5;
		
		public static const DIR_UP:int = 8;
		public static const DIR_DOWN:int = 2;
		public static const DIR_LEFT:int = 4;
		public static const DIR_RIGHT:int = 6;

		private var mindstatenames:Array = ["IDLE", "SEARCH FOOD", "OBT. FOOD", "SEARCH MATE", "MATING", "DEAD"];
		

		
	}
	
}