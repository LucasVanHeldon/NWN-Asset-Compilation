//#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iFound = GetLocalInt(OBJECT_SELF, "Found");
    object oPC = GetLastOpenedBy();

    if (!iFound && GetIsPC(oPC))
       if (SkillCheck(oPC, 20, SKILL_SEARCH))
        {
            SendMessageToPC(oPC, "You found a hidden stash.");
            GiveGoldToCreature(oPC, d10(10));
            SetLocalInt(OBJECT_SELF, "Found", 1);
        }
}
