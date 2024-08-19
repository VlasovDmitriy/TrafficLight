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
}
fix(string dpSource, int parsedata){
  if (parsedata > 10){
    dpSet("System1:CrossTraffic1.dresynyaVotvet", 0);}
}
parse(string dpSource, int parsedata){
  bit32 data;
  data=parsedata;
//  dpSet("System1:TrafficLight1.state.red", getBit(data, 0));
//  dpSet("System1:TrafficLight1.state.yellow", getBit(data, 1));
//  dpSet("System1:TrafficLight1.state.green", getBit(data, 2));
//  dpSet("System1:TrafficLight2.state.red", getBit(data, 3));
//  dpSet("System1:TrafficLight2.state.yellow", getBit(data, 4));
//  dpSet("System1:TrafficLight2.state.green", getBit(data, 5));

  if (getBit(data, 0)){

  }



  dpSet("System1:CrossTraffic1.isControl", getBit(data, 6)); //is auto
  dpSet("System1:CrossTraffic1.isBusy", getBit(data, 7)); //lockx
}
