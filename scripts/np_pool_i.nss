void main()
{
    //If PC has not opened the pool, keep going...
    if(!(GetLocalInt(GetLastUsedBy(), "nPoolIUsed")==1))
    {
        //Okay, the PC is about to use the pool, let's give them a 1
        SetLocalInt(GetLastUsedBy(), "nPoolIUsed", 1);
        //Cast Resist Elements on PC
        effect eHeal = EffectVisualEffect(VFX_DUR_LIGHT_BLUE_20);
        ActionCastSpellAtObject(SPELL_RESIST_ELEMENTS, GetLastUsedBy(), TRUE, TRUE);


    }
    else
    {
      //Let's do something if they've already used the pool
      SpeakString("The pool does not seem to have any more effect on you.");
      }
}


