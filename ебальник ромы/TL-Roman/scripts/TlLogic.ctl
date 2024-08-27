main()
{
  int mode, lastmode;
  dpGet("CR-1.drisnya",mode);
  dpGet("CR-1.lastmode",lastmode);
  if (lastmode != mode && mode != 0){
    dpSet("CR-1.lastmode", mode);
  }
}
