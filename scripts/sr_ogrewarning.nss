#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        if (GetHitDice(oPC)<4)
            FloatingTextStringOnCreature("You sense great danger ahead and a feeling of approaching doom if you continue to the south.", oPC);
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
    }
}
