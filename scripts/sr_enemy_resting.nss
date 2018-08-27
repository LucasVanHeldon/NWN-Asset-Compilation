#include "sr_constants_inc"
void EnemyRest()
{
    object oPC = OBJECT_SELF;
    int nCurrHP = GetCurrentHitPoints(oPC);
    int nHD = GetHitDice(oPC);
    if (nHD<1) nHD=1;

    effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);

    ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 12.0);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 6.0);
    int iHeal = nHD;
    if (iHeal+nCurrHP > GetMaxHitPoints(oPC)) iHeal = GetMaxHitPoints(oPC) - GetCurrentHitPoints(oPC);
    effect eHeal = EffectHeal(iHeal);
    if (iHeal>0)
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
}
