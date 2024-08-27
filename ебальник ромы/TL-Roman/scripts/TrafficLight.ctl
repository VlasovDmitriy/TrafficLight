main()
{
   dpConnect("TL","CR-1.drisnyaVotvet");
}

TL(string dp, int drisnyaVotvet){

      bit32 twoD = drisnyaVotvet;

      dpSet("CR-1.trafficlight1.r1", getBit(twoD, 0));
      dpSet("CR-1.trafficlight1.y1", getBit(twoD, 1));
      dpSet("CR-1.trafficlight1.g1", getBit(twoD, 2));
      dpSet("CR-1.trafficlight2.r2", getBit(twoD, 3));
      dpSet("CR-1.trafficlight2.y2", getBit(twoD, 4));
      dpSet("CR-1.trafficlight2.g2", getBit(twoD, 5));

}
