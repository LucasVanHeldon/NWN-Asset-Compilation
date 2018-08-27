#include "nw_i0_generic"

void main()
{
    object oNPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_NOT_PC);
    AdjustReputation(GetLastAttacker(), OBJECT_SELF, -1);
    if (GetLocalInt(GetLastAttacker(), "sr_gateattack") == 0)
    {
        AssignCommand(oNPC, ActionSpeakString("STOP YOUR ASSAULT IMMEDIATELY!"));
        SetLocalInt(GetLastAttacker(), "sr_gateattack", 1);
    }
    else if (GetLocalInt(GetLastAttacker(), "sr_gateattack") == 1)
    {
        AssignCommand(oNPC, ActionSpeakString("LAST WARNING!  STOP IMMEDIATELY!"));
        SetLocalInt(GetLastAttacker(), "sr_gateattack", 1);
    }
    else
    {
        AssignCommand(oNPC, ActionSpeakString("Attack at the Gates!  To Arms!", TALKVOLUME_SHOUT));
        SetLocalInt(GetLastAttacker(), "sr_gateattack", 2);
        AdjustReputation(GetLastAttacker(), OBJECT_SELF, -100);
    }
}
