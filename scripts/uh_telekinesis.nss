// Telekinesis
// By Weed Wizard

#include "ai_inc"

int ProcessBeam(object oVictim,object oSelf)
{
 int nRet=0;
 int nRolls;
 vector vVictim=GetPosition(oVictim);
 vector vMyPosition=GetPosition(OBJECT_SELF);
 vector vMove;
 float fVictim_Orientation=GetFacingFromLocation(GetLocation(oVictim));
 location lMoveTo;
 effect eBeam=EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
 float fDist;
 int nStore; // number storage variable
 float fStartDist=GetLocalFloat(oVictim,"fMyStartDist");
 int nPulls=GetLocalInt(oVictim,"nTractorBeam");

 if(WillSave(oVictim,18))
 {
    return -1;
 }

 // Pull victim closer
 nPulls++;
 SetLocalInt(oVictim,"nTractorBeam",nPulls);
 fDist=GetDistanceBetween(OBJECT_SELF,oVictim);
 fDist=fStartDist-(3.0*IntToFloat(nPulls));
 if (fDist<1.0) fDist=1.0;
 ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oVictim,2.0);

 SendMessageToPC(oVictim,"You are caught in a tractor beam.");
 if(GetDistanceToObject(oVictim) > 3.0)
     vMove=vMyPosition-vVictim;
 else
     vMove=vMyPosition+vVictim;

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

 return nRet;
} // fnProcessStrand()


void GrabItem(object oTarget)
{
    effect eBeam=EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    object oItem;
    object oCopy;

    switch(d6())
    {
    case 1:
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget);
        break;
    case 2:
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oTarget);
        break;
    case 3:
        oItem = GetItemInSlot(INVENTORY_SLOT_HEAD,oTarget);
        break;
    case 4:
        oItem = GetItemInSlot(INVENTORY_SLOT_NECK,oTarget);
        break;
    case 5:
        oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING,oTarget);
        break;
    case 6:
        oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING,oTarget);
        break;
    }
    if(GetIsObjectValid(oItem))
    {
        location oLoc = GetLocation(oTarget);
        vector vPos = GetPosition(oTarget);
        vPos.x = vPos.x + IntToFloat(Random(10));
        vPos.y = vPos.y + IntToFloat(Random(10));

        if(!ReflexSave( oTarget,22))
        {
            SendMessageToPC(oTarget,"You have lost an item");
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0);
            oCopy = CopyObject(oItem,
                            Location(GetArea(oTarget),vPos,GetFacing(oTarget)));
            DestroyObject(oItem);
        }
        else
            SendMessageToPC(oTarget,"Tractor beam failed.");
    }
    else
        ProcessBeam(oTarget,OBJECT_SELF);
}


//////////////////////////////////////////// MAIN //////////////////
void main()
{
   object oTarget = PickEnemy(OBJECT_SELF);
   int nL;
   object oVictim=GetLocalObject(OBJECT_SELF,"oBeam");

    // don't interrupt if casting a spell
   if(GetCurrentAction(OBJECT_SELF) == ACTION_CASTSPELL)
    return;

   // process entangled victims
   if((!GetIsObjectValid(oVictim) && d6()==1) || GetCurrentHitPoints(oVictim) <= 0)
   {
        SetLocalObject(OBJECT_SELF,"oBeam",oTarget);
        oVictim = oTarget;
   }
   else
   {
        if(d6() < 4)
           nL=ProcessBeam(oVictim,OBJECT_SELF);
        else
            GrabItem(oVictim);
    }
}
