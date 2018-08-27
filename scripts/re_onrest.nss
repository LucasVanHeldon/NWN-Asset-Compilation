//::///////////////////////////////////////////////
//:: FileName re_onrest.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
If placed in the module OnPlayerRest handler, this
script will generate a chance of a random encounter
whenever a player rests.  All of the parameters of
this encounter are determined by the Random Encouter
Properties placed on the Area object in which the
player is resting, as set by the SetRndEncProperties()
function.  If no properties are set on the Area Object
then the Module Object will be used.  If none are set
on the Module Object, the module object will be set
with defaults and they will be used.

To make an area safe for resting encounters use 0
for the iChanceOnRest Property of the
SetRndEncProperties() function.
*/
//:://////////////////////////////////////////////
//:: Created By: Ray Miller
//:: Created On: 1/6/03
//:://////////////////////////////////////////////
#include "re_rndenc"
int GetTotalLevels(object oPC = OBJECT_SELF)
{
int iLevel = GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC) + GetLevelByPosition(3, oPC);
return iLevel;
}

void main()
{
//////////////////////////////////////////////////
//This should be set to the number of seconds that
//players have to wait between rests.
int iRestPeriod = 480
;/////////////////////////////////////////////////
//Set this to false to disable the darkness effect
//when a PC rests.
int iDark = TRUE
;/////////////////////////////////////////////////

object oPC = GetLastPCRested();
object oArea = GetArea(oPC);
struct RndEncProperties strProps = GetRndEncProperties(oArea);
if(!strProps.bInitialized) strProps = GetRndEncProperties(GetModule());
if(!strProps.bInitialized)
    {
    SetRndEncProperties(GetModule());
    strProps = GetRndEncProperties(GetModule());
    }
if(GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
    int iTimeSinceRest = GetTimeInSeconds() - GetLocalInt(oPC, "re_iLastRestTime");
    if(iTimeSinceRest < iRestPeriod)
        {
        int iMph;
        if(!GetLocalInt(GetModule(), "re_iMph")) iMph = 2;
        else iMph = GetLocalInt(GetModule(), "re_iMph");
        int iTimeLeft = iRestPeriod - iTimeSinceRest;
        int iInGameHours = iTimeLeft / 120;
        int iInGameMinutes = (iTimeLeft - (iInGameHours * 120)) / iMph;
        SendMessageToPC(oPC, "You may not rest for another " + IntToString(iInGameHours) + " hours " + IntToString(iInGameMinutes) + " minutes of game time.");
        AssignCommand(oPC, ClearAllActions());
        }
    else
        {
        SetLocalInt(oPC, "re_resting", TRUE);
        SetLocalInt(oPC, "re_iLastRestTime", GetTimeInSeconds());

        //Apply visual effects to resting PC
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_SLEEP), oPC);
        if(iDark) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectBlindness(), oPC, 7.0 + IntToFloat(GetTotalLevels(oPC)) / 2.5);

        float fDelay = IntToFloat(Random(8 + FloatToInt(IntToFloat(GetTotalLevels(oPC)) / 2.5))+1);
        DelayCommand(fDelay, ExecuteScript("re_or", oPC));
        }
    }
else
    {
    DeleteLocalInt(oPC, "re_resting");
    effect eEffect = GetFirstEffect(oPC);
    while(GetIsEffectValid(eEffect))
        {
        if(GetEffectType(eEffect) == EFFECT_TYPE_BLINDNESS && GetEffectCreator(eEffect) == GetModule()) RemoveEffect(oPC, eEffect);
        if(GetEffectType(eEffect) == VFX_IMP_SLEEP && GetEffectCreator(eEffect) == GetModule()) RemoveEffect(oPC, eEffect);
        eEffect = GetNextEffect(oPC);
        }
    }
}

