main()
{
  dpConnect("Ylogic", "System1:CrossTraffic1.stateTF.disabled");
  dpConnect("unpackingparse", false, "System1:CrossTraffic1.dreysnya");
  //initDefault();
  dpConnectUserData("animation", false, false, "System1:CrossTraffic1.stateTF.state1");
  //dpConnect("unregOff",false, "System1:CrossTraffic1.stateTF.disabled");

  transConnect();
}

animation(anytype disabled, string dp,  bool swt){
  bool lox;
  dpGet("System1:CrossTraffic1.isBusy", lox);
 if (!lox || disabled){

    dpSet("System1:TrafficLight1.state.red",  (swt) ? true : false);
    dpSet("System1:TrafficLight1.state.yellow",  false);
    dpSet("System1:TrafficLight1.state.green",  (swt) ? false : blinkG("System1:TrafficLight1.state.green"));
    dpSet("System1:TrafficLight2.state.red",  (swt) ? false : true);
    dpSet("System1:TrafficLight2.state.yellow",  false);
    dpSet("System1:TrafficLight2.state.green",  (swt) ? blinkG("System1:TrafficLight2.state.green") : false);
    //delay(3);


    if (disabled){
        dpSet("System1:TrafficLight1.state.red",  false);
        dpSet("System1:TrafficLight1.state.green",  false);

        dpSet("System1:TrafficLight2.state.red",  false);
        dpSet("System1:TrafficLight2.state.green",  false);

        startThread("blinkY", "System1:TrafficLight1.state.yellow", "System1:TrafficLight2.state.yellow");
        //blinkY("System1:TrafficLight2.state.yellow");
      }
    else{
    dpSet((swt)? "System1:TrafficLight2.state.yellow" : "System1:TrafficLight1.state.yellow" ,  true);
    dpSet((swt)?"System1:TrafficLight2.state.green":"System1:TrafficLight1.state.green" ,  false);
    delay(1);



    dpSet((swt) ? "System1:TrafficLight1.state.yellow" : "System1:TrafficLight2.state.yellow" ,  true);
    delay(2);

    dpSet("System1:TrafficLight1.state.red",(swt)?false:true);
    dpSet("System1:TrafficLight1.state.yellow",false);
    dpSet("System1:TrafficLight1.state.green",(swt)?true:false);
    dpSet("System1:TrafficLight2.state.red",(swt)?true:false);
    dpSet("System1:TrafficLight2.state.yellow",false);
    dpSet("System1:TrafficLight2.state.green",(swt)?false:true);
  }
  }

}

unregOff(string dp, bool value){
  bool red_green;


  dpGet("System1:CrossTraffic1.stateTF.state1", red_green);

    dpSet((red_green) ? "System1:TrafficLight1.state.red": "System1:TrafficLight2.state.red",  true);
    dpSet("System1:TrafficLight1.state.yellow",  true);
    dpSet("System1:TrafficLight2.state.yellow",  true);
    delay(2);

    dpSet((red_green) ? "System1:TrafficLight1.state.red" : "System1:TrafficLight2.state.red",  false);
    dpSet("System1:TrafficLight1.state.yellow",  false);
    dpSet("System1:TrafficLight2.state.yellow",  false);
    dpSet((red_green) ? "System1:TrafficLight1.state.green": "System1:TrafficLight2.state.green",  true);
    dpSet((red_green) ? "System1:TrafficLight2.state.red" : "System1:TrafficLight1.state.red",  true);}


bool blinkG(string dp){
		for (int i; i<3; i++ ){
			dpSet(dp, true);
			delay(0,500);
			dpSet(dp, false);
      delay(0,500);
		}
  return false;
}
bool YflaG;
Ylogic(string dp, bool value){
  if (value){
    bool swt;
    YflaG = true;
    dpGet("System1:CrossTraffic1.stateTF.state1", swt);
    //swt = false;
    animation(true, "", swt);
  }else{
      YflaG = false;
      //DebugN("flagDown", YflaG, value);
      unregOff("", false);}}


bool blinkY(string dp1, string dp2){
  	while (YflaG) {
      dpSet(dp1, true);
      dpSet(dp2, true);
			delay(0,500);
      //DebugN(YflaG);
			dpSet(dp1, false);
      dpSet(dp2, false);
      delay(0,500);}
    return false;}

//parser+unpacker



bool isState;
bool isDisabled;
bool isAuto;
bool isLox;
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


    //we won't update dp's if they have the same value

  if (getBit(data, 0) != isState){
  dpSet("System1:CrossTraffic1.stateTF.state1", getBit(data, 0));
  isState = getBit(data, 0);}

  if (getBit(data, 1) != isDisabled){
  dpSet("System1:CrossTraffic1.stateTF.disabled", getBit(data, 1));
  isDisabled = getBit(data, 1);}

  //dpSet("System1:CrossTraffic1.stateTF.state2", !getBit(data, 0));
  //
  if (getBit(data, 6) != isAuto){
  dpSet("System1:CrossTraffic1.isControl", getBit(data, 6)); //is auto
  isAuto = getBit(data, 6);}

  if (getBit(data, 7) != isLox){
  dpSet("System1:CrossTraffic1.isBusy", getBit(data, 7)); //lockx
  isLox = getBit(data, 7);}
}



transConnect(){
  dpConnect("transControlSwitch", false, "System1:CrossTraffic1.isControlSwitch");
  dpConnect("transSwitchInManualState", false, "System1:CrossTraffic1.switchState");
  dpConnect("transSwitchDisabledState", false, "System1:CrossTraffic1.switchDisabled");
}
transControlSwitch(string dpSource, bool parsedata){
  if (parsedata){dpSet("System1:CrossTraffic1.dresynyaVotvet", 1);}
  else{dpSet("System1:CrossTraffic1.dresynyaVotvet", 0);}
}

transSwitchInManualState(string dpSource, bool parsedata){
  if (parsedata){dpSet("System1:CrossTraffic1.dresynyaVotvet", 4);}
  else{dpSet("System1:CrossTraffic1.dresynyaVotvet", 0);}
}
transSwitchDisabledState(string dpSource, bool parsedata){
  if (parsedata){dpSet("System1:CrossTraffic1.dresynyaVotvet", 2);}
  else{dpSet("System1:CrossTraffic1.dresynyaVotvet", 0);}
}




