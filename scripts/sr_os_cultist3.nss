#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

void main()
{
// OPTIONAL BEHAVIORS (Comment In or Out to Activate ) ****************************************************************************
//     SetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION);

     SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);

    SetSpawnInCondition(NW_FLAG_DEATH_EVENT);            //OPTIONAL BEHAVIOR - Fire User Defined Event 1007
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.
    WalkWayPoints();           // Optional Parameter: void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
                               // 1. Looks to see if any Way Points in the module have the tag "WP_" + NPC TAG + "_0X", if so walk them
                               // 2. If the tag of the Way Point is "POST_" + NPC TAG the creature will return this way point after
                               //    combat.
    if (GetSkillRank(SKILL_HIDE) > 0)
        ActionUseSkill(SKILL_HIDE, OBJECT_SELF);

    GiveGoldToCreature(OBJECT_SELF, d20(5));
}


