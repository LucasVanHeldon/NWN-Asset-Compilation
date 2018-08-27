#include "inc_mmp"
#include "inc_prestigator"
#include "inc_evoker"



int FighterThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,25.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsFighter(oC) || (D > 3.0 && D < 6.0))
           {
               if(D > 3.0)
               {
                    __TurnCombatRoundOn(TRUE);

                    switch(d4())
                    {
                    case 1: MMP_Sleep(oC); break;
                    case 2: MMP_Grease(oC); break;
                    case 3: MMP_CharmPerson(oC); break;
                    case 4: MMP_Daze(oC); break;
                    }
                    __TurnCombatRoundOn(FALSE);

                    return 1;
               }
               else if(D > 0.0 && !GetHasEffect(EFFECT_TYPE_FRIGHTENED))
               {
                    effect eF = EffectFrightened();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eF,OBJECT_SELF,4.0);
                    return 1;
                }
            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,25.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}



int MageThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,25.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsMagicUser(oC) )
           {
               __TurnCombatRoundOn(TRUE);
                EVOKER_SpecialDmg(oC);
                __TurnCombatRoundOn(FALSE);
                return 1;
           }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,25.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}

void Think()
{
    if(FighterThreat())
    {
        return;
    }
    if(MageThreat())
    {
        return;
    }
    object oTarget = FindNearestEnemy(OBJECT_SELF);
    if(GetDistanceToObject(oTarget) > 6.0) {

        __TurnCombatRoundOn(TRUE);
        EVOKER_SpecialAttack(oTarget);
        __TurnCombatRoundOn(FALSE);
    }
}

void _Summon(int n, string resref)
{
    effect eEff =  EffectVisualEffect(VFX_IMP_UNSUMMON);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEff,GetLocation(OBJECT_SELF)));
    int i;
    for(i = 0; i < n; i++)
    {
        object oC = CreateObject(OBJECT_TYPE_CREATURE,resref,GetLocation(OBJECT_SELF));
    }
}


void main()
{
    Think();
}
