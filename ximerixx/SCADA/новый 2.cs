// $License: NOLICENSE
//--------------------------------------------------------------------------------
/**
  @file $relPath
  @copyright $copyright
  @author ximerix
*/

//--------------------------------------------------------------------------------
// Libraries used (#uses)

//--------------------------------------------------------------------------------
// Variables and Constants

//--------------------------------------------------------------------------------
/**
*/
main()
{

  dpConnect("unpackingparse", false, "System1:TL1.trafficlights.drisnyaAnswer");
  //initDefault();
  dpConnect("switchSignal", "System1:CrossTraffic1.stateTF.state1");
  dpConnect("unregOff",false, "TL1.a");

}
blinkG(bool infinity, string dp){
	if (!infinity){
		for (int i; i<3; i++ ){
			dpSet(dp, True);
			delay(0,500);
			dpSet(dp, False);
		}
		else{
			
		}
	}
}


swithchSignal(string dp, bool swt){
	  //THE CRAPPYDINNENCKO
    //setValue("Control.Switch", "enabled", false);//блок  кнопки смены режима работы светофора
    //setValue("Control.unreg", "enabled", false);//блок кнопки нерегулируемого
	
	
	//if swt goes true, ew switch from red to green otherwise green to red
	
    dpSet("System1:TrafficLight1.state.red", (swt) ? True : False);
	dpSet("System1:TrafficLight1.state.yellow", False);
	dpSet("System1:TrafficLight1.state.green", (swt) ? False : blinkG("System1:TrafficLight1.state.green"););
	dpSet("System1:TrafficLight2.state.red", (swt) ? False : True);
	dpSet("System1:TrafficLight2.state.yellow", False);
	dpSet("System1:TrafficLight2.state.green", (swt) ? blinkG(False, "System1:TrafficLight2.state.green"); : False);
	delay(3);


    dpSet((swt) ? "System1:TrafficLight2.state.yellow" : "System1:TrafficLight1.state.yellow", True);
    dpSet((swt) ? "System1:TrafficLight2.state.green" : "System1:TrafficLight1.state.green" , False);
    delay(1);

	bool i;
	dpGet("System1:CrossTraffic1.switchDisabled", i);
   if (i) {
	   disabledAnimation()
   }

}
}