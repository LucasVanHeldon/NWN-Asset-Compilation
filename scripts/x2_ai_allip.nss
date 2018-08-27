// Allip touch attack

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
                __TurnCombatRoundOn(TRUE);

                effect eWis = EffectAbilityDecrease(ABILITY_WISDOM,d4());
                eWis = SupernaturalEffect(eWis);
                effect eVis = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);

                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eWis, oEnemy);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oEnemy);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectTemporaryHitpoints(5),OBJECT_SELF);
                ActionAttack(oEnemy);
                __TurnCombatRoundOn(FALSE);

            }
        }

    }
}
