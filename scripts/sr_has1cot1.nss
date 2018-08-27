#include "NW_I0_PLOT"

int StartingConditional()
{
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC)) {
        if (GetArea(oPC) != GetArea(GetPCSpeaker()))
            return FALSE;
        oPC = GetNextPC();
    }
    return (HasGold(1,GetPCSpeaker()));
}


