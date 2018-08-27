#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

void main()
{
    SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
    SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
    GiveGoldToCreature(OBJECT_SELF, d6(2));
    SetLocked(GetObjectByTag("c4chest"), TRUE);
    CreateItemOnObject("goldpiece154", GetObjectByTag("c4chest"));
    CreateItemOnObject("fireagate5", GetObjectByTag("c4chest"));
}


