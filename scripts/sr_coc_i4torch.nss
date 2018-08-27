#include "sr_i0_tools"

void main()
{
    object oPC = GetLastUsedBy();
    int iFound = GetLocalInt(OBJECT_SELF, "Found");
    FloatingTextStringOnCreature("This torch bracket appears to be broken and makes a rattling sound when used, as if something might be stuck in it.",
            oPC);
    if (SkillCheck(oPC, 20, SKILL_SEARCH) && !iFound) {
        SendMessageToPC(oPC, "A jagged key falls out into your hand as you examine the torch bracket.");
        SetLocalInt(OBJECT_SELF, "Found", TRUE);
        CreateItemOnObject("jaggedkey", oPC);
    }
}
