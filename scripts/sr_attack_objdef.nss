#include "nw_i0_generic"

void main()
{
    object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
    object oPC = GetLastAttacker();

    if (GetObjectSeen(oPC, oNPC)) //&& GetObjectSeen(OBJECT_SELF, oNPC))
    {
        AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 1);
        AdjustReputation(oPC, OBJECT_SELF, -1);
        if (GetLocalInt(OBJECT_SELF, "sr_objectattack") == 0)
        {
            AssignCommand(oNPC, ActionSpeakString("Please stop attacking that!"));
            SetLocalInt(OBJECT_SELF, "sr_objectattack", 1);
        }
        else if (GetLocalInt(OBJECT_SELF, "sr_objectattack") == 1)
        {
            AssignCommand(oNPC, ActionSpeakString("Please stop attacking that!"));
            SetLocalInt(OBJECT_SELF, "sr_objectattack", 2);
        }
        else if (GetLocalInt(OBJECT_SELF, "sr_objectattack") == 2)
        {
            AssignCommand(oNPC, ActionSpeakString("That's it!  I've seen too much of that!"));
            SetLocalInt(OBJECT_SELF, "sr_objectattack", 3);

//            object oAngry = GetObjectByTag("AngryNPC");
//            ChangeFaction(oNPC, oAngry);
            AdjustReputation(oPC, oNPC, -100);
            AssignCommand(oNPC, ActionAttack(oPC));
            DetermineCombatRound(oPC);
        }
    }
}
