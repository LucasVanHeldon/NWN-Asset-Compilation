// Wraith touch attack

#include "x2_inc_switches"
#include "nw_i0_generic"

void main()
{
    object oEnemy = bkAcquireTarget();
    if (GetIsObjectValid(oEnemy) && d6() < 3)
    {
         object oSelf = OBJECT_SELF;
        float D = GetDistanceToObject(oEnemy);
        if(D > 0.0 && D < 2.5)
        {
            if(TouchAttackMelee(oEnemy,TRUE))
            {
                if(!FortitudeSave(oEnemy,14,SAVING_THROW_TYPE_NEGATIVE))
                {
                    __TurnCombatRoundOn(TRUE);

                    effect eDrain = EffectAbilityDecrease(ABILITY_CONSTITUTION,d6());
                    eDrain = SupernaturalEffect(eDrain);
                    effect eVis = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);

                    ActionAttack(oEnemy);
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDrain, oEnemy);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oEnemy);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(5),OBJECT_SELF);

                    __TurnCombatRoundOn(FALSE);

                }
            }
        }
    }
}
