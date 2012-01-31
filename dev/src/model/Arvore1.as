package model 
{
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Arvore1 extends BaseAgent implements Agent
	{
		
		public function Arvore1() 
		{
			_block = true;
			this.addblock(0, -1)
				
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function think():void 
		{
			
		}
		
		public function get description():String 
		{
			return "arvore"
		}
		
		public function select(val:Boolean):void 
		{
			
		}
		
	}
	
}