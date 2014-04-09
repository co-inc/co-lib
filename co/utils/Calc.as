package co.utils 
{
	/**
	 * ...
	 * @author chitose
	 */
	public class Calc 
	{
		
		public function Calc() 
		{
			
		}
		
		static public function range(v:Number,min:Number, max:Number):Number 
		{
			if (v < min) {
				return min;
			}else if(v>max) {
				return max;
			}else {
				return v;
			}
		}
		
		static public function randomInt(min:int, max:int):int 
		{
			return Math.floor(Math.random() * (max - min) + min);
		}
		
	}

}