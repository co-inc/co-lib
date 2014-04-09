package co.debug 
{
	/**
	 * ...
	 * @author chitose
	 */
	public class CoTrace 
	{
		
		public function CoTrace() 
		{
			
		}
		
		static public function log(... args):void 
		{
			var str:String = "log:";
			var i:uint = 0;
			while (true){
				var obj:Object = args[i];
				str += obj;
				
				i++;
				if (i == args.length) {
					break;
				}else {
					str += " , ";
				}
			}
			//trace(new Error().getStackTrace());
			trace(str);
		}
		
		
		
	}

}