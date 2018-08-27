//::///////////////////////////////////////////////
//:: Default On Heartbeat
//:: NW_C2_DEFAULTE
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This will cause blocked creatures to open
    or smash down doors depending on int and
    str.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////

#include "hench_i0_generic"


void main()
{
    object oDoor = GetBlockingDoor();
    
//    Jug_Debug(GetName(OBJECT_SELF) + " is blocked by " + GetName(oDoor));
            
    if (GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) < 5)
    {
        return; // too stupid to follow (out of sight, out of mind)
        // TODO add wisdom check?
    }

    int iAggPursue = GetLocalInt(OBJECT_SELF,"ScoutMode") != 1;
    if (!iAggPursue)
    {
        if (GetPlotFlag(oDoor))
        {
            return;
        }
        if (GetIsTrapped(oDoor))
        {
            return;
        }
    }

    int nSel; 
    if (iAggPursue)
    {    
        nSel = 0xffff;
    }
    else
    {
        nSel = GetMonsterOptions(HENCH_MONAI_UNLOCK | HENCH_MONAI_OPEN);
    }
    if((HENCH_MONAI_OPEN & nSel) && GetIsDoorActionPossible(oDoor, DOOR_ACTION_OPEN) &&
        GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) >= 7 &&
        GetCreatureUseItems(OBJECT_SELF))
    {
        DoDoorAction(oDoor, DOOR_ACTION_OPEN);
        if (!iAggPursue)
        {
            SetLocalInt(OBJECT_SELF,"OpenedDoor", TRUE);
        }
    }
    else if ((HENCH_MONAI_UNLOCK & nSel) && GetIsDoorActionPossible(oDoor, DOOR_ACTION_UNLOCK))
    {
        DoDoorAction(oDoor, DOOR_ACTION_UNLOCK);
    }
    else if((HENCH_MONAI_UNLOCK & nSel) && GetIsDoorActionPossible(oDoor, DOOR_ACTION_BASH))
    {
        DoDoorAction(oDoor, DOOR_ACTION_BASH);
    }
}
