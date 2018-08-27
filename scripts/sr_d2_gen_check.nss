//::///////////////////////////////////////////////
//:: Generic Conversation Check
//:: NW_D2_gen_check
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Check to see whether the NPC has an initialized
    NPC is using SetSpecialConversationStart
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 7, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

int StartingConditional()
{
    if(!(GetTimeHour() > 7  && GetTimeHour() < 19))
        return FALSE;

    if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION))
    {
        if(!GetIsObjectValid(GetPCSpeaker()))
        {
            return TRUE;
        }
    }
    return FALSE;
}
