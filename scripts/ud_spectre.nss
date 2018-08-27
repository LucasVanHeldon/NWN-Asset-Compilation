#include "inc_ai"

void RaiseSpectre()
{
    EffectSummonCreature("nw_spectre",
                          VFX_FNF_SUMMON_MONSTER_1);
}

void Touch()
{
    object oPC = FindNearestEnemy(OBJECT_SELF);
    float D = GetDistanceToObject(oPC);
    if(D > 0.0 && D < 5.0 && TouchAttackMelee(oPC,TRUE))
    {
        effect eLvl = EffectNegativeLevel(2);
        effect eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                            ExtraordinaryEffect(EffectLinkEffects(eVis,eLvl)),
                            oPC);
    }
    if(GetCurrentHitPoints(oPC) <= 0)
    DelayCommand(1.0, RaiseSpectre());

}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();


    switch(nCalledBy)
    {
    case 1003:
        Touch();
        break;
    case 1011:
        {
            SendMessageToPC(GetFirstPC(),"Spell Event");
            int nSpellID = GetLastSpell();
            object oSC = GetLastSpellCaster();
            int nLvl = GetCasterLevel(oSC);

            int nDmg = nLvl/2+1;
            if(nDmg > 5) nDmg = 5;

            effect eFear = EffectTurned();
            effect eDmg  = EffectDamage(d6(nDmg));
            effect eVis  = EffectVisualEffect(VFX_IMP_FEAR_S );
            effect eLink = EffectLinkEffects(eVis,eFear);
            effect eLink2 = EffectLinkEffects(eVis,eDmg);


            switch(nSpellID)
            {
            case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,eLink),OBJECT_SELF,RoundsToSeconds(d4()));
                break;
            case SPELL_BLESS:
                SendMessageToPC(GetFirstPC(),"Bless");

                if(GetAlignmentGoodEvil(oSC) != ALIGNMENT_EVIL)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDispelMagicAll(),OBJECT_SELF);
                    DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,OBJECT_SELF,RoundsToSeconds(d2())));
                }
                break;
            case SPELL_PRAYER:
                if(GetAlignmentGoodEvil(oSC) != ALIGNMENT_EVIL)
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink2,OBJECT_SELF);
                    DelayCommand(0.1,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDispelMagicAll(),OBJECT_SELF));
                    DelayCommand(0.2,
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,OBJECT_SELF,RoundsToSeconds(d4())));
                }
                break;
            }
        }
    }
}

