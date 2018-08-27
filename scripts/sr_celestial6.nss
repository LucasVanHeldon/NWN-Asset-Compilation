#include "nw_i0_tool"

void main()
{
    object oPC = GetLastAttacker();
    object oNPC = GetObjectByTag("celestialservan");

    AddJournalQuestEntry("coc_q3_celestial", 2, oPC);
    RewardPartyXP(100, oPC);

    AssignCommand(oNPC, ActionStartConversation(oPC));
}
