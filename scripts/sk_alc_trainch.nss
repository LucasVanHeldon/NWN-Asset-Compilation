#include "sk_alchemy_inc"

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int nTL    = GetToolLevel(oPC)+1;
    int nMaxTL = GetMaxSkillLevel(oPC);

    return nTL <= nMaxTL;
}
