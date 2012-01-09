package model 
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Config 
	{
		public static const DEFAULT_MAX_BIOAGENT_ENERGY = 200;
		public static const DEFAULT_MAX_BIOAGENT_ENERGY_MODIFIER = 20;
		public static const DEFAULT_BIOAGENT_OLDAGE = 120; // em turnos; é o tE, onde a energia do ser seja aprox. 37% da máxima;
		public static const DEFAULT_BIOAGENT_MAXVEL = 50; // velocidade maxima de desloc. do individuo (u.d.s por turno)
		public static const DEFAULT_BIOAGENT_EV = 20; // velocidade do individuo qdo tiver 63% da vel max
		
		
		public static const t = 0.5 // tempo de cada round, em segundos
		
		
		public function Config() 
		{
			
		}
		
		public static function createBioAgentEnergy():int {
			var dif:int = (DEFAULT_MAX_BIOAGENT_ENERGY / 100) * DEFAULT_MAX_BIOAGENT_ENERGY_MODIFIER;
			var q:int = Math.random(dif);
			var sig:int = (Math.random(1000)>500? 1: -1);
			return DEFAULT_MAX_BIOAGENT_ENERGY + (q * sig);			
		}
		
	}
	
}