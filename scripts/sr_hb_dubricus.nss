#include "nw_i0_generic"

void main()
{
    // sit down if not talking
    object oNPC = GetObjectByTag("Flinytia");

    if (GetIsInCombat(oNPC))
    {
        object oPC = GetAttackTarget(oNPC);
        ActionAttack(oPC);
        DetermineCombatRound(OBJECT_SELF);
    }
    if (IsInConversation(OBJECT_SELF) == FALSE
        && GetIsInCombat() == FALSE
        && GetIsInCombat(oNPC) == FALSE)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 4000.0);
    }
}
