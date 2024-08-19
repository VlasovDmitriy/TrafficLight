main()
{

  dpConnect("unpackingparse", false, "System1:CrossTraffic1.dreysnya");
  //initDefault();
  dpConnect("animation", "System1:CrossTraffic1.stateTF.state1");
  //dpConnect("unregOff",false, "TL1.a");

}
animation(string dp, bool swt){
bool a;


    dpSet("System1:TrafficLight1.state.red",  (swt) ? true : false);
    dpSet("System1:TrafficLight1.state.yellow",  false);
    dpSet("System1:TrafficLight1.state.green",  (swt) ? false : blinkG(false, "System1:TrafficLight1.state.green"));
    dpSet("System1:TrafficLight2.state.red",  (swt) ? false : true);
    dpSet("System1:TrafficLight2.state.yellow",  false);
    dpSet("System1:TrafficLight2.state.green",  (swt) ? blinkG(false, "System1:TrafficLight2.state.green") : false);
    //delay(3);


    dpSet((swt)? "System1:TrafficLight2.state.yellow" : "System1:TrafficLight1.state.yellow" ,  true);
    dpSet((swt)?"System1:TrafficLight2.state.green":"System1:TrafficLight1.state.green" ,  false);
    delay(1);

    //dpGet("System1:CrossTraffic1.stateTF.state2", a);
    a = false;
    if(a)
      {
        dpSet("System1:TrafficLight1.state.yellow",  blinkG(false, "System1:TrafficLight1.state.green"));
        dpSet("System1:TrafficLight1.state.yellow",  blinkG(false, "System1:TrafficLight2.state.green"));

        dpSet("System1:TrafficLight1.state.red",  false);
        dpSet("System1:TrafficLight1.state.green",  false);

        dpSet("System1:TrafficLight2.state.red",  false);
        dpSet("System1:TrafficLight2.state.green",  false);
return;}

    dpSet((swt) ? "System1:TrafficLight1.state.yellow" : "System1:TrafficLight2.state.yellow" ,  true);
    delay(2);

    dpSet("System1:TrafficLight1.state.red",  (swt) ? false : true);
    dpSet("System1:TrafficLight1.state.yellow",  false);
    dpSet("System1:TrafficLight1.state.green",  (swt)?true: false);
    dpSet("System1:TrafficLight2.state.red",  (swt) ? true: false);
    dpSet("System1:TrafficLight2.state.yellow",  false);
    dpSet("System1:TrafficLight2.state.green",  (swt)?false: true);




}

unregOff(string dp, bool value){
  bool red_green;
  bool switcher;
  dpGet("System1:CrossTraffic1.stateTF.state1", red_green);
  if(a){

    return;
    }else {


    dpSet((red_green) ? "System1:TrafficLight1.state.red": "System1:TrafficLight2.state.red",  true);
    dpSet("System1:TrafficLight1.state.yellow",  true);
    dpSet("System1:TrafficLight2.state.yellow",  true);
    delay(2);

    dpSet((red_green) ? "System1:TrafficLight1.state.red" : "System1:TrafficLight2.state.red",  false);
    dpSet("System1:TrafficLight1.state.yellow",  false);
    dpSet("System1:TrafficLight2.state.yellow",  false);
    dpSet((red_green) ? "System1:TrafficLight1.state.green": "System1:TrafficLight2.state.green",  true);
    dpSet((red_green) ? "System1:TrafficLight2.state.red" : "System1:TrafficLight1.state.red",  true);

   }
}



//parser+unpacker
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
