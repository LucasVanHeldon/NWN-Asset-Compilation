//#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iFound = GetLocalInt(OBJECT_SELF, "Found");
    object oPC = GetLastUsedBy();

    if (!iFound && GetIsPC(oPC))
       if (SkillCheck(oPC, 16, SKILL_SEARCH))
        {
            SendMessageToPC(oPC, "You found a some hidden gems in the pillow case.");
            CreateItemOnObject("nw_it_gem002", oPC, d4()+1);
            SetLocalInt(OBJECT_SELF, "Found", 1);
        }
}
