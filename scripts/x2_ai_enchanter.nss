#include "inc_mmp"
#include "inc_prestigator"
#include "inc_evoker"
#include "inc_conjurer"
#include "inc_theurgist"
#include "inc_magician"



void ENCHANTER_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    __TurnCombatRoundOn(TRUE);

    switch(d8(2))
    {
    case 2: MMP_AnimateDead(oTarget); break;
    case 3: MMP_BallLightning(oTarget); break;
    case 4: MMP_BigbysInterposingHand(oTarget); break;
    case 5: MMP_Cloudkill(oTarget); break;
    case 6: MMP_ConeOfCold(oTarget); break;
    case 7: MMP_DominatePerson(oTarget); break;
    case 8: MMP_EnergyBuffer(OBJECT_SELF); break;
    case 9: MMP_Feeblemind(oTarget); break;
    case 10: MMP_FireBrand(oTarget); break;
    case 11: MMP_HoldMonster(oTarget); break;
    case 12: MMP_LesserMindBlank(oTarget); break;
    case 13: MMP_LesserSpellMantle(OBJECT_SELF); break;
    case 14: MMP_MestilsAcidSheath(OBJECT_SELF); break;
    case 15: MMP_MindFog(oTarget); break;
    default: MAGICIAN_SpecialAttack(oTarget); break;
    }

}

int FighterThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Fighter Threat");

    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && ( IsFighter(oC) || (D > 3.0 && D < 6.0)))
           {
               if(D > 3.0)
               {
                __TurnCombatRoundOn(TRUE);

                    switch(d20())
                    {
                    case 2: MMP_Slow(oC); break;
                    case 3: MMP_HoldPerson(oC); break;
                    case 4: MMP_StinkingCloud(oC); break;
                    case 5: MMP_Web(oC); break;
                    case 6: MMP_Darkness(oC); break;
                    case 7: MMP_BlindnessDeafness(oC); break;
                    case 8: MMP_Sleep(oC); break;
                    case 9: MMP_Grease(oC); break;
                    case 10: MMP_CharmPerson(oC); break;
                    case 11: MMP_Daze(oC); break;;
                    case 12: MMP_Fear(oC); break;
                    case 13: MMP_CharmMonster(oC); break;
                    case 14: MMP_Confusion(oC); break;
                    case 15: MMP_PhantasmalKiller(oC); break;
                    case 16: MMP_WallOfFire(oC); break;
                    default: MAGICIAN_SpecialAttack(oC); break;
                    }
                    __TurnCombatRoundOn(FALSE);

                    return 1;
               }
               else if(D > 0.0 )
               {
                    __TurnCombatRoundOn(TRUE);

                    switch(d20())
                    {
                    case 1: MMP_HoldPerson(oC); break;
                    case 2: MMP_VampiricTouch(oC); break;
                    case 3: MMP_Darkness(oC); break;
                    case 4: MMP_BlindnessDeafness(oC); break;
                    case 5: MMP_Sleep(oC); break;
                    case 6: MMP_Grease(oC); break;
                    case 7: MMP_CharmPerson(oC); break;
                    case 8: MMP_Daze(oC); break;;
                    case 9: MMP_Fear(oC); break;
                    case 10: MMP_Confusion(oC); break;
                    case 11: MMP_PhantasmalKiller(oC); break;
                    case 12: MMP_WallOfFire(oC); break;
                    default: MAGICIAN_SpecialAttack(oC); break;
                    }
                    __TurnCombatRoundOn(FALSE);

                    return 1;
                }

            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}



int MageThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Mage Threat");
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && IsMagicUser(oC) )
           {

                ENCHANTER_SpecialAttack(oC);


                return 1;
           }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}

int ClericThreat()
{

    object oC = GetFirstObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
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
               __TurnCombatRoundOn(TRUE);

                    switch(d20())
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
                    case 11: MMP_Fear(oC); break;
                    case 12: MMP_Confusion(oC); break;
                    case 13: MMP_PhantasmalKiller(oC); break;
                    case 14: MMP_WallOfFire(oC); break;
                    case 15: MMP_CharmMonster(oC); break;
                    default: ENCHANTER_SpecialAttack(oC);
                    }

                    return 1;
               }
               else if(D > 0.0 )
               {


                    switch(d10())
                    {
                    case 1: MMP_HoldPerson(oC); break;
                    case 2: MMP_VampiricTouch(oC); break;
                    case 3: MMP_Darkness(oC); break;
                    case 4: MMP_BlindnessDeafness(oC); break;
                    case 5: MMP_Sleep(oC); break;
                    case 6: MMP_Grease(oC); break;
                    case 7: MMP_CharmPerson(oC); break;
                    case 8: MMP_Daze(oC); break;;
                    default: MAGICIAN_SpecialAttack(oC); break;
                    }


                    return 1;
                }
            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,45.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}

int OtherThreat()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,50.0,GetLocation(OBJECT_SELF));
    SendMessageToPC(GetFirstPC(),"Other Threats");
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && !IsEnemyDead(oC))
        {
           float D = GetDistanceToObject(oC);

           if(IsActive(oC) && (D > 3.0 && D < 6.0))
           {
               if(D > 3.0)
               {
                    switch(d20())
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
                    case 11: MMP_Fear(oC); break;
                    case 12: MMP_Confusion(oC); break;
                    case 13: MMP_PhantasmalKiller(oC); break;
                    case 14: MMP_WallOfFire(oC); break;
                    case 15: MMP_CharmMonster(oC); break;
                    default: ENCHANTER_SpecialAttack(oC);
                    }
                    return 1;
               }
               else if(D > 0.0 && !GetHasEffect(EFFECT_TYPE_FRIGHTENED))
               {

                    switch(d20())
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
                    case 11: MMP_Fear(oC); break;
                    case 12: MMP_Confusion(oC); break;
                    case 13: MMP_PhantasmalKiller(oC); break;
                    case 14: MMP_WallOfFire(oC); break;
                    case 15: MMP_CharmMonster(oC); break;
                    default: ENCHANTER_SpecialAttack(oC);
                    }

                    return 1;
                }
            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,50.0,GetLocation(OBJECT_SELF));
    }
    return 0;
}
void Think()
{
     __TurnCombatRoundOn(TRUE);
    if(FighterThreat())
    {
        __TurnCombatRoundOn(FALSE);
        return;
    }
    if(MageThreat())
    {
        __TurnCombatRoundOn(FALSE);
        return;
    }
    if(ClericThreat())
    {
        __TurnCombatRoundOn(FALSE);
        return;
    }
    if(OtherThreat())
    {
        __TurnCombatRoundOn(FALSE);
        return;
    }
    object oTarget = FindNearestEnemy(OBJECT_SELF);
    if(GetDistanceToObject(oTarget) > 6.0) {
        __TurnCombatRoundOn(TRUE);
        ENCHANTER_SpecialAttack(oTarget);
        __TurnCombatRoundOn(FALSE);
    }
    else return;
}


void main()
{
       Think();
}
