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
    switch(nCalledBy)
    {
    case 1011:
        int nSpell = GetLastSpell();
        switch(nSpell)
        {
        case SPELL_DESTRUCTION:
            eEffect = EffectSlow();
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,RoundsToSeconds(d4()));
            break;
        case SPELL_STONE_TO_FLESH:
            eEffect = EffectDamageReduction(0,DAMAGE_POWER_NORMAL);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,60.0);
            eEffect = EffectSpellResistanceDecrease(32);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eEffect,OBJECT_SELF,60.0);
            break;
        }
    }
}
