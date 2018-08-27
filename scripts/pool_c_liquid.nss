void main()
{
 object oPC = GetLastUsedBy();
 effect eGAG = EffectVisualEffect(VFX_DUR_AURA_DISEASE, FALSE);
 ActionCastSpellAtObject(SPELL_CONTAGION, oPC, TRUE, TRUE);
 ApplyEffectToObject(DURATION_TYPE_INSTANT, eGAG, oPC);
}
