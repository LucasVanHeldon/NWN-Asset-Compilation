void main()
{

     //Here is the Green Slime script

         object oInfected = GetLastUsedBy();
         int oDuration = DURATION_TYPE_INSTANT;
         effect eDisease = EffectDisease(DISEASE_MUMMY_ROT);

         ApplyEffectToObject(oDuration,eDisease,oInfected);


}
