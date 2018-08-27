//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
#include "x0_i0_spawncond"


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    effect eEffect;
    int n = d4();
    float x = IntToFloat(n);
    switch(nCalledBy)
    {
    case 1011:
        int nSpell = GetLastSpell();
        switch(nSpell)
        {
        case SPELL_CURE_LIGHT_WOUNDS:
        case SPELL_CURE_MODERATE_WOUNDS:
        case SPELL_CURE_CRITICAL_WOUNDS:
        case SPELL_CURE_SERIOUS_WOUNDS:
        case SPELL_HEAL:
            eEffect = EffectSlow();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,x);
            break;
        case SPELL_NEGATIVE_ENERGY_RAY:
        case SPELL_NEGATIVE_ENERGY_BURST:
            eEffect = EffectTemporaryHitpoints(d4());
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
            break;
        case SPELL_RESURRECTION:
        case SPELL_RAISE_DEAD:
            eEffect = EffectSpellResistanceDecrease(32);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,60.0);
            eEffect = EffectDamageReduction(0,DAMAGE_POWER_NORMAL);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,60.0);

        }
    }
}
