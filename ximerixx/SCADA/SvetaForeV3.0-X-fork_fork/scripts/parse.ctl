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
  dpConnect("parse", true, "System1:CrossTraffic1.dreysnya");
  dpConnect("fix", true, "System1:CrossTraffic1.dresynyaVotvet");
  connect();
}
fix(string dpSource, int parsedata){
  if (parsedata > 10){
    dpSet("System1:CrossTraffic1.dresynyaVotvet", 0);}
}
parse(string dpSource, int parsedata){
  bit32 data;
  data=parsedata;
  dpSet("System1:TrafficLight1.state.red", getBit(data, 0));
  dpSet("System1:TrafficLight1.state.yellow", getBit(data, 1));
  dpSet("System1:TrafficLight1.state.green", getBit(data, 2));
  dpSet("System1:TrafficLight2.state.red", getBit(data, 3));
  dpSet("System1:TrafficLight2.state.yellow", getBit(data, 4));
  dpSet("System1:TrafficLight2.state.green", getBit(data, 5));

  dpSet("System1:CrossTraffic1.isControl", getBit(data, 6)); //is auto
  dpSet("System1:CrossTraffic1.isBusy", getBit(data, 7)); //lockx
}



connect(){
    //dpConnect("transControlSwitch", false, "System1:CrossTraffic1.isControlSwitch");
  //dpConnect("transSwitchInManualState", false, "System1:CrossTraffic1.switchState");
//  dpConnect("transSwitchDisabledState", false, "System1:CrossTraffic1.switchDisabled");

 dpConnect("trans", false, "System1:CrossTraffic1.isControlSwitch", "System1:CrossTraffic1.switchState", "System1:CrossTraffic1.switchDisabled");
//  dpConnect("transControlSwitch", true, "System1:CrossTraffic1.isControlSwitch");
}


trans(string dpAutoswitch, bool AutoswitchValue, string dpSwitchState, bool SwitchStateValue, string dpSwitchDisabled, bool SwitchDisabledValue){
  int write;
    AutoswitchValue ? (write += 1) : (write += 0);
    SwitchDisabledValue ?  (write += 2) : (write += 0);
    SwitchStateValue ?  (write += 4) : (write += 0);
  dpSet("System1:CrossTraffic1.dresynyaVotvet", write);
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
