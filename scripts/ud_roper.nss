// Monster Manual - Roper
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"


void Strands()
{
    int i;
    effect eStr = EffectAbilityDecrease(ABILITY_STRENGTH,d8(2));
    effect eVis = EffectVisualEffect(VFX_IMP_HARM);
    effect eLink = EffectLinkEffects(eVis,eStr);

    object oHit = GetFirstObjectInShape(SHAPE_CONE,50.0,GetLocation(OBJECT_SELF));

    while(GetIsObjectValid(oHit))
    {
        if(GetIsEnemy(oHit))
        {
            for(i = 0; i < 6; i++)
            {
                if(TouchAttackRanged(oHit,TRUE))
                {
                    AssignCommand(oHit,JumpToLocation(GetLocation(OBJECT_SELF)));
                    if(!FortitudeSave(oHit,18))
                    {
                        DelayCommand(0.1,
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT,eLink,oHit));
                    }
                }
            }
        }
        oHit = GetNextObjectInShape(SHAPE_CONE,20.0,GetLocation(OBJECT_SELF),TRUE);
    }
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();


    switch(nCalledBy)
    {
    case 1003:
        if(d6() < 4)
        {
            ClearAllActions(TRUE);
            Strands();
            DelayCommand(3.0,DetermineCombatRound());
        }
        break;
    }
}

