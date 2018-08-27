#include "nw_i0_generic"

void main()
{
    // sit down if not talking
    if (IsInConversation(OBJECT_SELF) == FALSE
        && GetIsInCombat() == FALSE)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 4000.0);
    }
}
