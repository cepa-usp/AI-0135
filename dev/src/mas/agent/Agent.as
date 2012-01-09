package mas.agent 
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public interface Agent 
	{
		function actuate():void;
		function refresh():void;
		function init():void;
	}

}