package model 
{
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Arvore2 extends BaseAgent implements Agent
	{
		
		public function Arvore2() 
		{
			_block = false;			
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function think():void 
		{
			
		}
		
		public function get description():String 
		{
			return "copa arvore"
		}
		
		public function select(val:Boolean):void 
		{
			
		}
		
	}
	
}