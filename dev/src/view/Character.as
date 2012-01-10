package view 
{
	import as3isolib.display.IsoSprite;
	import flash.display.Sprite;
	import flash.events.Event;
	import mas.agent.Agent;
	import model.AgentEvent;
	import model.BioAgent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Character extends IsoSprite
	{
		
		private var _agent:Agent;
		
		
		
		public function Character() 
		{
			
		}
		
		public function get agent():Agent 
		{
			return _agent;
		}
		
		public function set agent(value:Agent):void 
		{
			_agent = value;
			_agent.eventDispatcher.addEventListener(AgentEvent.INITIALIZED, onInit)
			_agent.eventDispatcher.addEventListener(AgentEvent.TERMINATED, onTerminate)
			_agent.eventDispatcher.addEventListener(AgentEvent.STATE_CHANGED, onStateChanged)
			_agent.eventDispatcher.addEventListener(AgentEvent.AGE_COMPUTED, onAgeComputed)
			//_agent.eventDispatcher.addEventListener(AgentEvent.ENERGY_CHANGED, onEnergyChanged)
		}
		
		private function onEnergyChanged(e:AgentEvent):void 
		{
			// caso precise atualizar graficamente quando a energia mudar.
			// rodar apenas se houver necessidade.
		}
		
		private function onAgeComputed(e:AgentEvent):void 
		{
			// se precisar mudar a animação quando a criatura envelhecer (ou algum medidor de vitalidade)
		}
		
		private function onStateChanged(e:AgentEvent):void 
		{
			// IMPORTANTE. Mudar as animações mediante a alteração do estado do agente.
			// no caso do BioAgent, ver BioAgent.STATE_BLABLABLA
			// e.state = BioAgent.STATE_OBTAINING_FOOD...
		}
		
		
		public function onInit(e:AgentEvent):void {
			// rodar animação de entrando no palco (nascendo?)
		}
		
		public function onTerminate(e:AgentEvent) {
			// rodar animação de saindo do palco (morrendo?)
		}	
		
	}
	
}