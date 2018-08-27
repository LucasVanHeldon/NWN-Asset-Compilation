// Mohrg Tongue attack
// by Weed Wizard

#include "x2_inc_switches"
#include "nw_i0_generic"

void main()
{
    object oEnemy = bkAcquireTarget();
    if (GetIsObjectValid(oEnemy))
    {
        object oSelf = OBJECT_SELF;
        float D = GetDistanceToObject(oEnemy);
        if(D > 0.0 && D < 2.5)
        {
            if(TouchAttackMelee(oEnemy,TRUE))
            {
                if(!FortitudeSave(oEnemy,17))
                {
                    effect ePar = EffectParalyze();
                    ePar = SupernaturalEffect(ePar);
                    effect eVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD );
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectLinkEffects(eVis,ePar), oEnemy, RoundsToSeconds(d4()));
                }
            }
        }

    }
}
