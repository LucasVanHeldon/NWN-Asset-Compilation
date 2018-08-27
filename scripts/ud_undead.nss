
#include "x0_i0_spawncond"
#include "inc_demons"



void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();

    effect eT = EffectTurned();
    int time = d3();

    switch(nCalledBy)
    {
    case 1011:

        object oSC = GetLastSpellCaster();
        if(GetLastSpellHarmful())
        {
            switch(GetLastSpell())
            {
            case SPELL_PROTECTION_FROM_EVIL:
            case SPELL_MAGIC_CIRCLE_AGAINST_EVIL:
                if(GetCasterLevel(oSC) > GetHitDice(OBJECT_SELF))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eT,OBJECT_SELF,RoundsToSeconds(time));
                }
            }
        }
        break;
    }
}
