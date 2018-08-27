void main()
{
    //If PC has not opened the pool, keep going...
    if(!(GetLocalInt(GetLastUsedBy(), "nPoolAUsed")==1))
    {
        //Okay, the PC is about to use the pool, let's give them a 1
        SetLocalInt(GetLastUsedBy(), "nPoolAUsed", 1);
        //Heal and remove disease of the PC
        //Heal and remove disease of PC
        effect eHeal = EffectVisualEffect(VFX_IMP_HEALING_L);
        ActionCastSpellAtObject(SPELL_CURE_LIGHT_WOUNDS, GetLastUsedBy(), TRUE, TRUE);
        ActionCastSpellAtObject(SPELL_REMOVE_DISEASE, GetLastUsedBy(), TRUE, TRUE);

    }
    else
    {
      //Let's do something if they've already used the pool
      SpeakString("The liquid from this pool no longer seems to affect you.");
      }
}
