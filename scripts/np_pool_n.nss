void main()
{

        effect eHeal = EffectVisualEffect(VFX_FNF_BLINDDEAF);
        ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, GetLastUsedBy(), TRUE, TRUE);

}


