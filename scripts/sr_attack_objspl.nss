#include "nw_i0_generic"

void main()
{
    object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
    object oPC = GetLastSpellCaster();

    if (GetObjectSeen(oPC, oNPC)) //&& GetObjectSeen(OBJECT_SELF, oNPC))
    {
        AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 1);
        AdjustReputation(oPC, OBJECT_SELF, -100);

        AssignCommand(oNPC, ActionSpeakString("How dare you!"));
        SetLocalInt(OBJECT_SELF, "sr_objectattack", 3);

        AssignCommand(oNPC, ActionAttack(oPC));
        DetermineCombatRound(oPC);
    }
}
