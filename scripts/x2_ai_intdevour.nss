#include "ai_inc"


void main()
{

    object oTarget = FindNearestEnemy(OBJECT_SELF);
    if(!GetIsObjectValid(oTarget)) return;
    if(d6()< 3 && !GetHasEffect(EFFECT_TYPE_DOMINATED,oTarget))
    {
        __TurnCombatRoundOn(TRUE);
        ActionCastSpellAtObject(SPELL_DOMINATE_MONSTER,oTarget,METAMAGIC_ANY,TRUE);
        __TurnCombatRoundOn(FALSE);
    }
    else
        if( GetCurrentHitPoints() < 20
        && !GetHasEffect(EFFECT_TYPE_INVISIBILITY,OBJECT_SELF))
    {
        __TurnCombatRoundOn(TRUE);
        ActionCastSpellAtObject(SPELL_INVISIBILITY,OBJECT_SELF,METAMAGIC_ANY,TRUE);
        __TurnCombatRoundOn(FALSE);
    }
}
