//::///////////////////////////////////////////////
//:: Default: On Spell Cast At
//:: NW_C2_DEFAULTB
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This determines if the spell just cast at the
    target is harmful or not.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Dec 6, 2001
//:://////////////////////////////////////////////

#include "hench_i0_ai"


void main()
{
    object oCaster = GetLastSpellCaster();
    if(GetLastSpellHarmful())
    {
        SetCommandable(TRUE);

        if (!GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT"))
        { // set variables on target for mounted combat
            DeleteLocalInt(OBJECT_SELF,"bX3_LAST_ATTACK_PHYSICAL");
        } // set variables on target for mounted combat

        // ------------------------------------------------------------------
        // If I was hurt by someone in my own faction
        // Then clear any hostile feelings I have against them
        // After all, we're all just trying to do our job here
        // if we singe some eyebrow hair, oh well.
        // ------------------------------------------------------------------
        if (GetFactionEqual(oCaster, OBJECT_SELF))
        {
            ClearPersonalReputation(oCaster, OBJECT_SELF);
            // Send the user-defined event as appropriate
            if(GetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT))
            {
                SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_SPELL_CAST_AT));
            }
            return;
        }
        CheckRemoveStealth();
        if(!GetIsFighting(OBJECT_SELF))
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                HenchDetermineSpecialBehavior(oCaster);
            }
            else
            {
                HenchDetermineCombatRound(oCaster);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_SPELL_CAST_AT));
    }
}
