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
        case SPELL_STONE_TO_FLESH:
            eEffect = EffectDamage(d12(3));
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
            break;
        case SPELL_EARTHQUAKE:
            eEffect = EffectDamage(d12(5));
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
            break;
        }
    }
}
