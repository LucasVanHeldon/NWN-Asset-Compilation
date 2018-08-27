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
#include "ai_inc"

void RangeAttack(object oTarget)
{
    ClearAllActions(TRUE);
    if(d6() < 4) oTarget=FindWeakestEnemy(OBJECT_SELF);
    AssignCommand(OBJECT_SELF,ActionEquipMostDamagingRanged(oTarget));
    DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionAttack(oTarget)));
}

void MeleeAttack(object oTarget)
{
    ClearAllActions(TRUE);
    if(d6() < 4) oTarget=FindWeakestEnemy(OBJECT_SELF);
    AssignCommand(OBJECT_SELF,ActionEquipMostDamagingMelee(oTarget,TRUE));
    DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionAttack(oTarget)));
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here

    object oPercep=OBJECT_INVALID;
    object oNear = FindNearestEnemy(OBJECT_SELF);
    if( !GetIsObjectValid(oNear) ) oPercep = oNear;
    if(d6() < 4) oPercep=FindWeakestEnemy(OBJECT_SELF);

    if(!GetIsObjectValid(oPercep)) return;
    oNear = oPercep;
    float D = GetDistanceToObject(oNear);



    switch(nCalledBy)
    {
    case 1002:
        ClearAllActions(TRUE);
        if(D > 3.0) RangeAttack(oNear);
        else MeleeAttack(oNear);
        break;
    }
}
