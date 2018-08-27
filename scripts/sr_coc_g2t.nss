//#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        if (SkillCheck(oPC, 15, SKILL_SPOT))
            FloatingTextStringOnCreature(GetName(oPC) + " has noticed something large stirring in the water to the north.", oPC);
    }
}
