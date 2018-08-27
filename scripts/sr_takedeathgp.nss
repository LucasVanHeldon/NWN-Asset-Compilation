#include "NW_I0_PLOT"
#include "sr_constants_inc"

void main()
{
    location lTrans = GetLocation(GetObjectByTag("RaiseDead_WP"));
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(oPC);
    int iGoldReq = DEATHGP * GetHitDice(oPC) * GetHitDice(oPC);

    TakeGold(iGoldReq,oPC);
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
    AssignCommand(oPC, JumpToLocation(lTrans));
}
