#include "NW_O2_CONINCLUDE"
#include "NW_I0_GENERIC"

void main()
{

    SetSpawnInCondition(NW_FLAG_SHOUT_ATTACK_MY_TARGET);
    SetListeningPatterns();    // Goes through and sets up which shouts the NPC will listen to.

    // Jess has been rescued.
    FloatingTextStringOnCreature("Thank the gods I am free!", OBJECT_SELF, FALSE);
}


