package model 
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Config 
	{
		public static const DEFAULT_MAX_BIOAGENT_ENERGY:int = 200;
		public static const DEFAULT_MAX_BIOAGENT_ENERGY_MODIFIER:int = 20;
		public static const DEFAULT_BIOAGENT_OLDAGE:int = 120; // em turnos; é o tE, onde a energia do ser seja aprox. 37% da máxima;
		public static const DEFAULT_BIOAGENT_MAXVEL:int = 50; // velocidade maxima de desloc. do individuo (u.d.s por turno)
		public static const DEFAULT_BIOAGENT_EV:int = 20; // velocidade do individuo qdo tiver 63% da vel max
		
		public static const DEFAULT_BIOAGENT_EATING_TIME:int = 3000; // velocidade do individuo qdo tiver 63% da vel max
		public static const DEFAULT_BIOAGENT_MATING_TIME:int = 3000; // velocidade do individuo qdo tiver 63% da vel max
		
		private static var lastId:int = 0;
		
		
		public static const t:int = 500 // tempo de cada round, em milisegundos

		public static function cut(x:Number):Number {
			return Math.max(0, Math.min(x, 1));
		}
		
		
		public static function calcPermissividadeNascimento(n:int, nmax:int, deltaN:int):Number {
			return 1;
		}
		
		
		public static function myTrace(...rest) : void {
			trace(rest)
		}
			
		
		
		public function Config() 
		{
			
		}
		
		public static function getId():int {
			return ++lastId;
		}
		
		public static function createBioAgentEnergy():int {
			var dif:int = (DEFAULT_MAX_BIOAGENT_ENERGY / 100) * DEFAULT_MAX_BIOAGENT_ENERGY_MODIFIER;
			var q:int = Math.random() * dif;
			var sig:int = ((Math.random()*1000)>500? 1: -1);
			return DEFAULT_MAX_BIOAGENT_ENERGY + (q * sig);			
		}
		
	}
	
}