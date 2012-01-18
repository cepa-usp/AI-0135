package model 
{
	
	/**
	 * ...
	 * @author Arthur Tofani
	 */
	public class Config 
	{
		public static const DEFAULT_MAX_BIOAGENT_ENERGY:int = 2000; // 200e/dia
		public static const DEFAULT_MAX_BIOAGENT_ENERGY_MODIFIER:int = 10; // percentage
		public static const DEFAULT_BIOAGENT_OLDAGE:int = 10; // em anos; é o tE, onde a energia do ser seja aprox. 37% da máxima;
		public static const DEFAULT_BIOAGENT_MAXVEL:int = 100; // velocidade maxima de desloc. do individuo (u.d.s por turno)
		public static const DEFAULT_BIOAGENT_EV:int = 20; // velocidade do individuo qdo tiver 63% da vel max
		
		public static const DEFAULT_BIOAGENT_EATING_TIME:int = 2*t; // velocidade do individuo qdo tiver 63% da vel max
		public static const DEFAULT_BIOAGENT_MATING_TIME:int = 2*t; // velocidade do individuo qdo tiver 63% da vel max
		public static const DEFAULT_BIOAGENT_Ec:int = 600;
		public static const DEFAULT_BIOAGENT_Ea:int = 800;
		public static const DEFAULT_BIOAGENT_EC:int = 1200;
		
		public static var viewId:int = 1;
		
		private static var lastId:int = 0;
		
		
		public static const t:int = 1000 // tempo de cada round, em milisegundos
		public static const hourTurn:int = 3 * t; // os calculos de gasto de energia são em 'horas', baseadas no valor de t.
		public static const ageTurn:int = 4; // os calculos de idade são feitos em um determinado ciclo de 'horas'.
		
		
		public static function cut(x:Number):Number {
			return Math.max(0, Math.min(x, 1));
		}
		
		
		public static function calcPermissividadeNascimento(n:int, nmax:int, deltaN:int):Number {
			return cut(0.5 + (nmax-n)/deltaN);
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