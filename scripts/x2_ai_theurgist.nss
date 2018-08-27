#include "inc_mmp"
#include "inc_prestigator"
#include "inc_evoker"
#include "inc_conjurer"
#include "inc_theurgist"

int FighterThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,35.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Fighter Threat");

    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsFighter(oC) || (D > 3.0 && D < 6.0))
           {
               if(D > 3.0)
               {
                    switch(d10())
                    {
                    case 1: MMP_Slow(oC); break;
                    case 2: MMP_HoldPerson(oC); break;
                    case 3: MMP_StinkingCloud(oC); break;
                    case 4: MMP_Web(oC); break;
                    case 5: MMP_Darkness(oC); break;
                    case 6: MMP_BlindnessDeafness(oC); break;
                    case 7: MMP_Sleep(oC); break;
                    case 8: MMP_Grease(oC); break;
                    case 9: MMP_CharmPerson(oC); break;
                    case 10: MMP_Daze(oC); break;;
                    }
                    return 1;
               }
               else if(D > 0.0 )
               {
                    switch(d8())
                    {
                    case 1: MMP_HoldPerson(oC); break;
                    case 2: MMP_VampiricTouch(oC); break;
                    case 3: MMP_Darkness(oC); break;
                    case 4: MMP_BlindnessDeafness(oC); break;
                    case 5: MMP_Sleep(oC); break;
                    case 6: MMP_Grease(oC); break;
                    case 7: MMP_CharmPerson(oC); break;
                    case 8: MMP_Daze(oC); break;;

                    }
                    return 1;
                }

            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,35.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}



int MageThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,35.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Mage Threat");
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsMagicUser(oC) )
           {
                THEURGIST_SpecialAttack(oC);
                return 1;
           }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,35.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}

int ClericThreat()
{

    object oC = GetFirstObjectInShape(SHAPE_SPHERE,35.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Cleric Threat");
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsCleric(oC) || (IsActive(oC) && (D > 3.0 && D < 6.0)))
           {
               if(D > 3.0)
               {
                    switch(d10())
                    {
                    case 1: MMP_Slow(oC); break;
                    case 2: MMP_HoldPerson(oC); break;
                    case 3: MMP_StinkingCloud(oC); break;
                    case 4: MMP_Web(oC); break;
                    case 5: MMP_Darkness(oC); break;
                    case 6: MMP_BlindnessDeafness(oC); break;
                    case 7: MMP_Sleep(oC); break;
                    case 8: MMP_Grease(oC); break;
                    case 9: MMP_CharmPerson(oC); break;
                    case 10: MMP_Daze(oC); break;;
                    }
                    return 1;
               }
               else if(D > 0.0 )
               {
                    switch(d8())
                    {
                    case 1: MMP_HoldPerson(oC); break;
                    case 2: MMP_VampiricTouch(oC); break;
                    case 3: MMP_Darkness(oC); break;
                    case 4: MMP_BlindnessDeafness(oC); break;
                    case 5: MMP_Sleep(oC); break;
                    case 6: MMP_Grease(oC); break;
                    case 7: MMP_CharmPerson(oC); break;
                    case 8: MMP_Daze(oC); break;;

                    }
                    return 1;
                }
            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,35.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}

int OtherThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Other Threats");
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) || (D > 3.0 && D < 6.0))
           {
               if(D > 3.0)
               {
                    switch(d4())
                    {
                    case 1: MMP_Slow(oC); break;
                    case 2: MMP_HoldPerson(oC); break;
                    case 3: MMP_StinkingCloud(oC); break;
                    default: CONJURER_SpecialAttack(oC);
                    }
                    return 1;
               }
               else if(D > 0.0 && !GetHasEffect(EFFECT_TYPE_FRIGHTENED))
               {
                    switch(d3())
                    {
                    case 1: MMP_HoldPerson(oC); break;
                    case 2: MMP_VampiricTouch(oC); break;
                    default: CONJURER_SpecialAttack(oC); break;
                    }
                    return 1;
                }
            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}
void Think()
{
    __TurnCombatRoundOn(TRUE);
    if(FighterThreat())
    {
        return;
    }
    if(MageThreat())
    {
        return;
    }
    if(ClericThreat())
    {
        return;
    }
    if(OtherThreat())
    {
        return;
    }
     object oTarget = FindNearestEnemy(OBJECT_SELF);
    if(GetDistanceToObject(oTarget) > 6.0) THEURGIST_SpecialAttack(oTarget);
    else return;
    __TurnCombatRoundOn(FALSE);
}


void main()
{

    Think();


}
