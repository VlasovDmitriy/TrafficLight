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

  dpConnect("unpackingparse", false, "System1:CrossTraffic1.dreysnya");
  //initDefault();
  dpConnect("switchSignal", "System1:CrossTraffic1.stateTF.state1");
  //dpConnect("unregOff",false, "TL1.a");

}


unpackingparse(string dpSource, int parsedata){
  bit32 data;
  data=parsedata;
  //dpSet("System1:TrafficLight1.state.red", getBit(data, 0));
  //dpSet("System1:TrafficLight1.state.yellow", getBit(data, 1));
  //dpSet("System1:TrafficLight1.state.green", getBit(data, 2));
  //dpSet("System1:TrafficLight2.state.red", getBit(data, 3));
  //dpSet("System1:TrafficLight2.state.yellow", getBit(data, 4));
  //dpSet("System1:TrafficLight2.state.green", getBit(data, 5));
//old scheme. fucking morron who said to redo everytrhin because "IT WILL BE BETTER!"
  ///bitch

  dpSet("System1:CrossTraffic1.stateTF.state1", getBit(data, 0));
  dpSet("System1:CrossTraffic1.stateTF.state2", !getBit(data, 0));
  //
  dpSet("System1:CrossTraffic1.isControl", getBit(data, 6)); //is auto
  dpSet("System1:CrossTraffic1.isBusy", getBit(data, 7)); //lockx
}

bool blinkG(bool infinity, string dp){
	if (!infinity){
		for (int i; i<3; i++ ){
			dpSet(dp, true);
			delay(0,500);
			dpSet(dp, false);
      delay(0,500);
		}
	}
  dpSet(dp, false);
  return false;
}


switchSignal(string dp, bool swt){
	  //THE CRAPPYDINNENCKO
    //setValue("Control.Switch", "enabled", false);//блок  кнопки смены режима работы светофора
    //setValue("Control.unreg", "enabled", false);//блок кнопки нерегулируемого


	//if swt goes true, ew switch from red to green otherwise green to red
	//ture lesft

  dpSet("System1:TrafficLight1.state.red",(swt) ? true : false);

	dpSet("System1:TrafficLight1.state.yellow",false);

	dpSet("System1:TrafficLight1.state.green",(swt) ? false : blinkG(false, "System1:TrafficLight1.state.green"));

	dpSet("System1:TrafficLight2.state.red", (swt) ? false : true);

	dpSet("System1:TrafficLight2.state.yellow", false);

	dpSet("System1:TrafficLight2.state.green", (swt) ? blinkG(false, "System1:TrafficLight2.state.green") : false);
	delay(3);


  dpSet((swt) ? "System1:TrafficLight2.state.yellow" : "System1:TrafficLight1.state.yellow", true);
  dpSet((swt) ? "System1:TrafficLight2.state.green" : "System1:TrafficLight1.state.green" , false);
  delay(1);

  dpSet((swt) ? "System1:TrafficLight2.state.yellow" : "System1:TrafficLight1.state.yellow", true);
  dpSet((swt) ? "System1:TrafficLight2.state.green" : "System1:TrafficLight1.state.green" , false);
  delay(1);
	bool i;
	dpGet("System1:CrossTraffic1.switchDisabled", i);
   if (i) {
	   disabledAnimation();
   }
}
