#include "inc_mmp"
#include "inc_prestigator"

int FighterThreatEngaged()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,25.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsFighter(oC) )
           {
               if(D > 3.0)
               {
                    __TurnCombatRoundOn(TRUE);
                    MMP_Daze(oC);
                    __TurnCombatRoundOn(FALSE);

                    return 1;
               }
               else if(D > 0.0)
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



int MageThreatEngaged()
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
                PRESTIGATOR_SpecialDmg(oC);
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

    if(FighterThreatEngaged()) return;
    if(MageThreatEngaged())return;

    object oE = PickEnemy(OBJECT_SELF);
    float D=GetDistanceToObject(oE);
    if(D >0.0 && D < 25.0 && d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        PRESTIGATOR_SpecialAttack();
        __TurnCombatRoundOn(FALSE);
    }
}


void main()
{
    Think();
}
