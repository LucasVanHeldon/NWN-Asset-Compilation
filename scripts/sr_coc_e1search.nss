//#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iFound = GetLocalInt(OBJECT_SELF, "Found");
    object oPC = GetLastUsedBy();

    if (!iFound && GetIsPC(oPC))
        if (SkillCheck(oPC, 23, SKILL_SEARCH))
        {
            SendMessageToPC(oPC, "You found a hidden stash.");
            GiveGoldToCreature(oPC, d20(20));
            CreateItemOnObject("trollwightmagicb", oPC);
            SetLocalInt(OBJECT_SELF, "Found", 1);
        }
}
