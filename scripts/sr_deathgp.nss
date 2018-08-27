#include "NW_I0_PLOT"
#include "sr_constants_inc"

int StartingConditional()
{
    int iGoldReq = DEATHGP * GetHitDice(GetPCSpeaker()) * GetHitDice(GetPCSpeaker());
    return (HasGold(iGoldReq, GetPCSpeaker()));
}


