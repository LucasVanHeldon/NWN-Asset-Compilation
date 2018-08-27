#include "sr_i0_tools"

void main()
{
    int iFound = GetLocalInt(OBJECT_SELF, "Found");
    object oPC = GetLastOpenedBy();

    if (!iFound && GetIsPC(oPC))
        if (SkillCheck(oPC, 25, SKILL_SEARCH))
        {
            SendMessageToPC(oPC, "When poking around the drawer, you find a false panel and its hidden loot.");
            CreateItemOnObject("BloodstoneGem", oPC, 3);
            SetLocalInt(OBJECT_SELF, "Found", 1);
        }
}
