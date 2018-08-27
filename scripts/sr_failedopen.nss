#include "nw_i0_generic"

void main()
{
    object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
    object oPC = GetLastAttacker();

    if (GetObjectSeen(oPC, oNPC)) //&& GetObjectSeen(OBJECT_SELF, oNPC))
        AssignCommand(oNPC, ActionSpeakString("Leave that alone!"));
}
