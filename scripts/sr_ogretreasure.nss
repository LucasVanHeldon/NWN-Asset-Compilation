#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetLastOpenedBy();

    if (!iTripped && GetIsPC(oPC)) {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        if (SkillCheck(oPC, 20, SKILL_SEARCH)) {
            RewardPartyXP(25, oPC);
            FloatingTextStringOnCreature(GetName(oPC) + " spotted a trap and marked it to avoid.", oPC);
        } else {
            FloatingTextStringOnCreature(GetName(oPC) + " triggered a trap!!!", oPC);
            ActionCastSpellAtObject(SPELL_WEB, GetLastOpenedBy(), METAMAGIC_ANY, TRUE);
        } // Search
    } // Tripped?
}
