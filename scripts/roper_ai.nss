////////////////////////////////////////////////////////////
// Roper - Onheartbeat  (with some lag prevention code)
//----------------------------------------------------------
// By Deva Bryson Winblood
// 12/31/2002 - Happy New Year
//----------------------------------------------------------
// If anyone wants to provide a placeable for this let me know
// In fact if someone makes three or 4 placeables I can simulate
// movement of arms and such for this thing.  It does not work well
// for a creature
//----------------------------------------------------------

int fnProcessStrand(object oVictim,object oRoper)
{ // process a strand return -1 if dead or escaped
 int nRet=0;
 int nRolls;
 vector vVictim=GetPosition(oVictim);
 vector vRoper=GetPosition(OBJECT_SELF);
 vector vMove;
 float fVictim_Orientation=GetFacingFromLocation(GetLocation(oVictim));
 location lMoveTo;
 effect eStrand=EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
 effect eTentacles=EffectVisualEffect(VFX_DUR_TENTACLE);
 effect eStrDrain; // strength drain
 float fDist;
 int nStore; // number storage variable
 float fStartDist=GetLocalFloat(oVictim,"fRoperStartDist");
 int nPulls=GetLocalInt(oVictim,"nRoperPulls");
 // check for escape or death
 nRolls=d20()+GetAbilityModifier(ABILITY_STRENGTH,oVictim);
 if (nRolls>19||GetCurrentHitPoints(oVictim)<0)
 { // escaped or dead
   DeleteLocalInt(oVictim,"nRoperCaptured");
   DeleteLocalFloat(oVictim,"fRoperStartDist");
   DeleteLocalInt(oVictim,"nRoperPulls");
   return -1; // escaped or dead
 } // escaped or dead
 // check for strength sap - only first round
 if (nPulls==0)
 { // check for strength drain
   nStore=d8()+d8(); // strength drain amount
   nRolls=d20()+GetFortitudeSavingThrow(oVictim);
   if (nRolls<18)
   { // failed saving throw
     SendMessageToPC(oVictim,"You feel your strength sucked through the tentacle.");
     eStrDrain=EffectAbilityDecrease(ABILITY_STRENGTH,nStore);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStrDrain,oVictim,120.0);
   } // failed saving throw
 } // check for strength drain
 // Pull victim closer
 nPulls++;
 SetLocalInt(oVictim,"nRoperPulls",nPulls);
 fDist=GetDistanceBetween(OBJECT_SELF,oVictim);
 fDist=fStartDist-(3.0*IntToFloat(nPulls));
 if (fDist<1.0) fDist=1.0;
 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStrand,oVictim,2.0);
 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eTentacles,OBJECT_SELF,2.5);
 SendMessageToPC(oVictim,"The tentacle is pulling you closer.");
 vMove=vRoper-vVictim;
 if (VectorMagnitude(vMove)<=0.0) // magnitude always positive
   vMove=-1.0*AngleToVector(fVictim_Orientation);
 vMove=VectorNormalize(vMove); // normalize
 if (GetDistanceBetween(OBJECT_SELF,oVictim)>5.0)
     vMove=vMove*(3.0*IntToFloat(nPulls)); // movement amount
 else
     vMove=vMove*3.0;
 if (VectorMagnitude(vMove)>10.0) vMove=vMove/(IntToFloat(nPulls));
 vVictim=vMove+vVictim; // new location
 lMoveTo=Location(GetArea(OBJECT_SELF),vVictim,fVictim_Orientation);
 if (GetDistanceBetween(OBJECT_SELF,oVictim)>1.5)
   AssignCommand(oVictim,JumpToLocation(lMoveTo));
 // check for bite
 fDist=GetDistanceBetween(oVictim,OBJECT_SELF);
 if (fDist<2.5)
 { // bite them
   nRolls=d20()+8;
   if (nRolls>(GetAC(oVictim)-1))
   { // hit
     nRolls=d6()+d6()+2; // bite damage
     SendMessageToPC(oVictim,"You were bitten for "+IntToString(nRolls)+" damage.");
     eStrDrain=EffectDamage(nRolls,DAMAGE_TYPE_PIERCING);
     ApplyEffectToObject(DURATION_TYPE_INSTANT,eStrDrain,oVictim,1.0);
   } // hit
 } // bite them
 // NPCs - make them attack rather than just die
 if (GetIsPC(oVictim)!=TRUE)
 {
   AssignCommand(oVictim,ActionAttack(oRoper));
 }
 return nRet;
} // fnProcessStrand()

void fnGetVictim(int nStrand)
{ // Get victim
  int nLoop=1;
  effect eStrand=EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
  effect eTentacles=EffectVisualEffect(VFX_DUR_TENTACLE);
  object oTarget=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,1);
  float fDist;
  int nCaptured;
  int nAttack;
  int nFound=FALSE;
  // Find target
  while (oTarget!=OBJECT_INVALID&&nLoop<12)
  { // look for target
    nCaptured=GetLocalInt(oTarget,"nRoperCaptured");
    if (nCaptured!=TRUE)
    { // not already caught
      fDist=GetDistanceBetween(oTarget,OBJECT_SELF);
      if (fDist<18.0&&GetCurrentHitPoints(oTarget)>0)
      { // in range
       if ((d20()+13)>(d20()+GetSkillRank(SKILL_HIDE,oTarget)))
       { // spotted
          nFound=TRUE;
          nLoop=20; // quick exit of loop
       } // spotted
       else
       { // not spotted
        nLoop++;
        oTarget=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
       } // not spotted
      } // in range
      else
      { // out of range
       nLoop++;
       oTarget=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
      } // out of range
    } // not already caught
    else
    {
      nLoop++;
      oTarget=GetNearestObject(OBJECT_TYPE_CREATURE,OBJECT_SELF,nLoop);
    }
  } // look for target
  if (nFound)
  { // okay a target was found
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStrand,oTarget,2.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eTentacles,OBJECT_SELF,2.5);
    nAttack=d20();
    if (nAttack==20)nAttack=100; // automatic hit natural 20
    else nAttack=nAttack+11;
    if (nAttack>(GetAC(oTarget)-1))
    { // it hit
      SendMessageToPC(oTarget,"You have been caught by a sticky tentacle.");
      SetLocalInt(oTarget,"nRoperCaptured",TRUE);
      SetLocalFloat(oTarget,"fRoperStartDist",GetDistanceBetween(OBJECT_SELF,oTarget));
      SetLocalInt(oTarget,"nRoperPulls",0); // how many times pulled closer
      if(GetIsPC(oTarget)!=TRUE)
      { // NPC captured
        // put NPC Attack AI here
        AssignCommand(oTarget,ActionAttack(OBJECT_SELF));
        SetIsTemporaryEnemy(OBJECT_SELF,oTarget);
      } // NPC captured
      if (nStrand==1) SetLocalObject(OBJECT_SELF,"oStrand1",oTarget);
      if (nStrand==2) SetLocalObject(OBJECT_SELF,"oStrand2",oTarget);
      if (nStrand==3) SetLocalObject(OBJECT_SELF,"oStrand3",oTarget);
      if (nStrand==4) SetLocalObject(OBJECT_SELF,"oStrand4",oTarget);
      if (nStrand==5) SetLocalObject(OBJECT_SELF,"oStrand5",oTarget);
      if (nStrand==6) SetLocalObject(OBJECT_SELF,"oStrand6",oTarget);
    } // it hit
    else
      SendMessageToPC(oTarget,"A tentacle slapped at you but, did not catch you.");
  } // okay a target was found
} // fnGetVictim()


//////////////////////////////////////////// MAIN //////////////////
void main()
{
  object oArea=GetArea(OBJECT_SELF); // area of roper
  int nPCsPresent=FALSE;
  // see if any PCs are in this area to indicate need to process HB
  object oPC=GetFirstPC();
  while(oPC!=OBJECT_INVALID)
  { // !OI PC
    if(GetArea(oPC)==oArea)
    {
     nPCsPresent=TRUE;
     oPC=OBJECT_INVALID; // quick exit
    }
    else
     oPC=GetNextPC();
  } // !OI PC
  if (nPCsPresent)
  { // go ahead and process AI for roper
   // perception and strands
   int nL;
   object oStrand1=GetLocalObject(OBJECT_SELF,"oStrand1");
   object oStrand2=GetLocalObject(OBJECT_SELF,"oStrand2");
   object oStrand3=GetLocalObject(OBJECT_SELF,"oStrand3");
   object oStrand4=GetLocalObject(OBJECT_SELF,"oStrand4");
   object oStrand5=GetLocalObject(OBJECT_SELF,"oStrand5");
   object oStrand6=GetLocalObject(OBJECT_SELF,"oStrand6");
   // process entangled victims
   if (oStrand1!=OBJECT_INVALID) nL=fnProcessStrand(oStrand1,OBJECT_SELF);
   if (nL==-1) oStrand1=OBJECT_INVALID; // escaped or dead
   if (oStrand2!=OBJECT_INVALID) nL=fnProcessStrand(oStrand2,OBJECT_SELF);
   if (nL==-1) oStrand2=OBJECT_INVALID; // escaped or dead
   if (oStrand3!=OBJECT_INVALID) nL=fnProcessStrand(oStrand3,OBJECT_SELF);
   if (nL==-1) oStrand3=OBJECT_INVALID; // escaped or dead
   if (oStrand4!=OBJECT_INVALID) nL=fnProcessStrand(oStrand4,OBJECT_SELF);
   if (nL==-1) oStrand4=OBJECT_INVALID; // escaped or dead
   if (oStrand5!=OBJECT_INVALID) nL=fnProcessStrand(oStrand5,OBJECT_SELF);
   if (nL==-1) oStrand5=OBJECT_INVALID; // escaped or dead
   if (oStrand6!=OBJECT_INVALID) nL=fnProcessStrand(oStrand6,OBJECT_SELF);
   if (nL==-1) oStrand6=OBJECT_INVALID; // escaped or dead
   // process strands not attached
   if (oStrand1==OBJECT_INVALID) fnGetVictim(1);
   if (oStrand2==OBJECT_INVALID) fnGetVictim(2);
   if (oStrand3==OBJECT_INVALID) fnGetVictim(3);
   if (oStrand4==OBJECT_INVALID) fnGetVictim(4);
   if (oStrand5==OBJECT_INVALID) fnGetVictim(5);
   if (oStrand6==OBJECT_INVALID) fnGetVictim(6);
  } // go ahead and process AI for roper
}
