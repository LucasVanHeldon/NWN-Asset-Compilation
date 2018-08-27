//#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iFound = GetLocalInt(OBJECT_SELF, "Found");
    object oPC = GetClickingObject();

    if (!iFound && GetIsPC(oPC))
        if (SkillCheck(oPC, 20, SKILL_SEARCH))
        {
            SendMessageToPC(oPC, "You found a gem caught in folds of the victim's rags.");
            CreateItemOnObject("adventurine", oPC, 3);
            SetLocalInt(OBJECT_SELF, "Found", 1);
        }
}
