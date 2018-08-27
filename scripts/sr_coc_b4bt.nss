//#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC) && !GetIsInCombat(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("Evidence of some great feast still exists upon the table.", oPC);
    }
}
