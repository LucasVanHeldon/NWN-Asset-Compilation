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
        case SPELL_FIREBALL:
        case SPELL_FLAME_ARROW:
        case SPELL_BURNING_HANDS:
        case SPELL_COMBUST:
        case SPELL_DELAYED_BLAST_FIREBALL:
        case SPELL_FIRE_STORM:
        case SPELL_FIREBRAND:
        case SPELL_FLAME_LASH:
        case SPELL_FLAME_STRIKE:
        case SPELL_FLARE:
        {
           //Remove blindness from the PC
           effect eLoop=GetFirstEffect(OBJECT_SELF);

           while (GetIsEffectValid(eLoop))
           {
               if (GetEffectType(eLoop)==EFFECT_TYPE_SLOW)
                 RemoveEffect(OBJECT_SELF, eLoop);

               eLoop=GetNextEffect(OBJECT_SELF);
           }
           break;
        }
        case SPELL_LIGHTNING_BOLT:
        case SPELL_ELECTRIC_JOLT:
        case SPELL_CALL_LIGHTNING:
        case SPELL_BALL_LIGHTNING:

            eEffect = EffectSlow();
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF,RoundsToSeconds(d6(2)));
            break;
        }
    }
}
