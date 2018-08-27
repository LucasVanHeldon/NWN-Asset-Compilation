void main()
{
    object oPC = GetLastAttacker();
    effect eFire = EffectDamage(1, DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);
}
