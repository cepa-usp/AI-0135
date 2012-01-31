package model 
{
	import mas.agent.Agent;
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Pedra2 extends BaseAgent implements Agent
	{
		
		public function Pedra2() 
		{
			_block = true;
			this.addblock(1, 0)
				.addblock(2, 0)
				.addblock(3, 0)
				.addblock(1, 1)
				.addblock(2, 1)
				.addblock(3, 1)
				.addblock(4, 1)
				.addblock(1, 2)

				
		}
		
		/* INTERFACE mas.agent.Agent */
		
		public function think():void 
		{
			
		}
		
		public function get description():String 
		{
			return "pedra 2"
		}
		
		public function select(val:Boolean):void 
		{
			
		}
		
	}
	
}