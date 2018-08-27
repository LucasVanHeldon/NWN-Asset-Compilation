#include "sk_alchemy_inc"

void main()
{
    object oPC = GetPCSpeaker();
    int nTL    = GetToolLevel(oPC)+1;
    int nMaxTL = GetMaxSkillLevel(oPC);
    int nSkillCost = GetSkillCost(nTL);

    SetCustomToken(2000,IntToString(nTL));
    SetCustomToken(2001,IntToString(nSkillCost));
    SetLocalInt(oPC,"SK_ALC_COST",nSkillCost);
}
