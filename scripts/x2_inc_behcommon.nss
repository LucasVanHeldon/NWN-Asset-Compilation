//::///////////////////////////////////////////////
//:: Beholder common functions
//:: x2_inc_behcommon
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Contains functions taken from the Companion and Monster AI

*/
//:://////////////////////////////////////////////
//:: Created By: Tony K
//:: Created On: May, 2008
//:://////////////////////////////////////////////

#include "x0_i0_spells"


// As MyPrintString, but to screen instead of log
void Jug_Debug2(string sString)
{
    SendMessageToPC(GetFactionLeader(GetFirstPC()), sString);
}


void SetObjectArray(object oSource, string sName, int iElem, object oElem)
{
    string sFull = sName+IntToString(iElem);
    SetLocalObject(oSource,sFull,oElem);
}


object GetObjectArray(object oSource, string sName, int iElem)
{
    string sFull = sName+IntToString(iElem);
    return GetLocalObject(oSource,sFull);
}


void SetIntArray(object oSource, string sName, int iElem, int iState)
{
    string sFull = sName+IntToString(iElem);
    SetLocalInt(oSource,sFull,iState);
}


int GetIntArray(object oSource, string sName, int iElem)
{
    string sFull = sName+IntToString(iElem);
    return GetLocalInt(oSource,sFull);
}


void SetFloatArray(object oSource, string sName, int iElem, float fVal)
{
    string sFull = sName+IntToString(iElem);
    SetLocalFloat(oSource,sFull,fVal);
}


float GetFloatArray(object oSource, string sName, int iElem)
{
    string sFull = sName+IntToString(iElem);
    return GetLocalFloat(oSource,sFull);
}


// returns TRUE if a humanoid
int GetIsHumanoid(int nRacial)
{
    return
        (nRacial == RACIAL_TYPE_DWARF) ||
        (nRacial == RACIAL_TYPE_ELF) ||
        (nRacial == RACIAL_TYPE_GNOME) ||
        (nRacial == RACIAL_TYPE_HUMANOID_GOBLINOID) ||
        (nRacial == RACIAL_TYPE_HALFLING) ||
        (nRacial == RACIAL_TYPE_HUMAN) ||
        (nRacial == RACIAL_TYPE_HALFELF) ||
        (nRacial == RACIAL_TYPE_HALFORC) ||
        (nRacial == RACIAL_TYPE_HUMANOID_MONSTROUS) ||
        (nRacial == RACIAL_TYPE_HUMANOID_ORC) ||
        (nRacial == RACIAL_TYPE_HUMANOID_REPTILIAN);
}


// check if target has a disabling effect
int GetIsDisabled(object oTarget)
{
    effect eCheck = GetFirstEffect(oTarget);
    while(GetIsEffectValid(eCheck))
    {
        switch (GetEffectType(eCheck))
        {
        case EFFECT_TYPE_PARALYZE:
        case EFFECT_TYPE_STUNNED:
        case EFFECT_TYPE_FRIGHTENED:
        case EFFECT_TYPE_SLEEP:
        case EFFECT_TYPE_DAZED:
        case EFFECT_TYPE_CONFUSED:
        case EFFECT_TYPE_TURNED:
        case EFFECT_TYPE_PETRIFY:
            return TRUE;
        }

        eCheck = GetNextEffect(oTarget);
    }
    return FALSE;
}


// This constant somewhat matches taking a henchmen hit dice and converting to CR rating
const float HENCH_HITDICE_TO_CR = 0.7;

const string sThreatRating = "HenchThreatRating";

// get threat rating of target, scale by hit dice
float GetRawThreatRating(object oTarget)
{
    int lastTestHitDice = GetLocalInt(oTarget, sThreatRating);
    int hitDice = GetHitDice(oTarget);
    float fThreat;
    if (GetHitDice(oTarget) == lastTestHitDice)
    {
        fThreat = GetLocalFloat(oTarget, sThreatRating);
    }
    else
    {
        fThreat = IntToFloat(GetHitDice(oTarget));
        fThreat = pow(1.5, fThreat * HENCH_HITDICE_TO_CR);
        int iAssocType = GetAssociateType(oTarget);
        if (iAssocType == ASSOCIATE_TYPE_FAMILIAR)
        {
            fThreat *= 0.1;
        }
        else if (iAssocType != ASSOCIATE_TYPE_NONE && iAssocType != ASSOCIATE_TYPE_HENCHMAN)
        {
            fThreat *= 0.8;
        }
        if ((GetLevelByClass(CLASS_TYPE_WIZARD, oTarget) >= 5) || (GetLevelByClass(CLASS_TYPE_SORCERER, oTarget) >= 6))
        {
            fThreat *= 1.3;
        }
        else if ((GetLevelByClass(CLASS_TYPE_DRAGON, oTarget) >= 11))
        {
            // dragons are extra tough
            fThreat *= 1.5;
        }
        if (fThreat < 0.001)
        {
            fThreat = 0.001;
        }
        SetLocalFloat(oTarget, sThreatRating, fThreat);
        SetLocalInt(oTarget, sThreatRating, hitDice);
    }
    return fThreat;
}


int gHenchSpellTargetObjects;

const string BEHOLDER_SPELL_TARGET_OBJECTS = "BeholderSpellTarget";


// gets list of possible targets that are seen or heard
void HenchInitSpellTargetObjects(object oIntruder)
{
    if (gHenchSpellTargetObjects != 0)
    {
        return;
    }

    int iMaxNumberToFind = GetAbilityScore(OBJECT_SELF, ABILITY_INTELLIGENCE) - 5;
    if (iMaxNumberToFind > 15)
    {
        iMaxNumberToFind = 15;
    }
    else if (iMaxNumberToFind < 2)
    {
        iMaxNumberToFind = 2;
    }
    int bIntruderFound = !GetIsObjectValid(oIntruder);;
    object oLastTarget = OBJECT_SELF;
    int iCurSeenIndex = 1;
    while (gHenchSpellTargetObjects <= iMaxNumberToFind)
    {
        object oCurSeen = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
            OBJECT_SELF, iCurSeenIndex++, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN,
            CREATURE_TYPE_IS_ALIVE, TRUE);
        if (!GetIsObjectValid(oCurSeen))
        {
            break;
        }
        SetLocalObject(oLastTarget, BEHOLDER_SPELL_TARGET_OBJECTS, oCurSeen);
//      Jug_Debug(GetName(OBJECT_SELF) + " adding seen target " + GetName(oCurSeen));
        oLastTarget = oCurSeen;
        gHenchSpellTargetObjects ++;
        if (oCurSeen == oIntruder)
        {
            bIntruderFound = TRUE;
        }
    }
    // limit the max number of heard targets to find
    iMaxNumberToFind /= 2;
    int iCurHeardIndex = 1;
    while ((gHenchSpellTargetObjects <= iMaxNumberToFind) && (iCurHeardIndex < 3))
    {
        object oCurHeard = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
            OBJECT_SELF, iCurHeardIndex++, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD_AND_NOT_SEEN,
            CREATURE_TYPE_IS_ALIVE, TRUE);
        if (!GetIsObjectValid(oCurHeard))
        {
            break;
        }
        if (LineOfSightObject(OBJECT_SELF, oCurHeard))
        {
            SetLocalObject(oLastTarget, BEHOLDER_SPELL_TARGET_OBJECTS, oCurHeard);
//          Jug_Debug(GetName(OBJECT_SELF) + " adding heard target " + GetName(oCurHeard));
            oLastTarget = oCurHeard;
            gHenchSpellTargetObjects ++;
            if (oCurHeard == oIntruder)
            {
                bIntruderFound = TRUE;
            }
        }
    }
    if (!bIntruderFound)
    {
        SetLocalObject(oLastTarget, BEHOLDER_SPELL_TARGET_OBJECTS, oIntruder);
//      Jug_Debug(GetName(OBJECT_SELF) + " adding intruder " + GetName(oIntruder));
        oLastTarget = oIntruder;
    }
    DeleteLocalObject(oLastTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
}


// returns chance 0.0 to 1.0 for d20 roll
float Getd20Chance(int limit)
{
    limit += 21;
    if (limit >= 20)
    {
        return 1.0;
    }
    if (limit <= 0)
    {
        return 0.0;
    }
    return IntToFloat(limit) / 20.0;
}


// returns chance 0.0 to 1.0 for d20 roll 1, fail 20 success
float Getd20ChanceLimited(int limit)
{
    if (limit <= 1)
    {
        return 0.05;
    }
    if (limit >= 19)
    {
        return 0.95;
    }
    return IntToFloat(limit) / 20.0;
}


const int HENCH_BLEED_NEGHPS = -10;

// returns damage amount on target 0.0 (none) to 1.0 (lethal damage)
float CalculateDamageWeight(float damageAmount, object oTarget)
{
//Jug_Debug(GetName(oTarget) + " HP " + IntToString(GetCurrentHitPoints(oTarget)));
    int currentHitPoints = GetCurrentHitPoints(oTarget);
    if (currentHitPoints < 1)
    {
        // assume a bleed system is used (HENCH_BLEED_NEGHPS is a negative number)
        currentHitPoints -= HENCH_BLEED_NEGHPS;
        if (currentHitPoints < 1)
        {
            currentHitPoints = 1;
        }
    }
    damageAmount /= IntToFloat(currentHitPoints);
    if (damageAmount > 1.0)
    {
        damageAmount = 1.0;
    }
    return damageAmount;
}


struct sEnhancementLevel
{
    float breach;
    float dispel;
};

int giBestDispelCastingLevel;

// chance that dispel will work
float GetDispelChance(object oCreator)
{
    if (GetIsObjectValid(oCreator))
    {
        int nCasterLevel = GetCasterLevel(oCreator);    // this isn't always accurate (reset every spell)
        if (nCasterLevel <= 0)
        {
            nCasterLevel = GetHitDice(oCreator);
        }
        return Getd20Chance(giBestDispelCastingLevel - nCasterLevel - 11);
    }
    return Getd20Chance(giBestDispelCastingLevel - 21 /* 10 - 11 */);
}


const float fMaxEnhancementWeight = 0.5;

// Jugalator Script Additions
// Return 1 if target is enhanced with a beneficial
// spell that can be dispelled (= from a spell script), 2 if the
// effects can be breached, 0 otherwise.
// TK changed to not look for magical effects only
struct sEnhancementLevel Jug_GetHasBeneficialEnhancement(object oTarget)
{
    struct sEnhancementLevel result;
    effect eCheck = GetFirstEffect(oTarget);
    int lastSpellId = -1;
    int bCheckDispel = TRUE;

    while (GetIsEffectValid(eCheck))
    {
        int iType = GetEffectType(eCheck);
        if ((iType != EFFECT_TYPE_VISUALEFFECT) && (GetEffectSubType(eCheck) == SUBTYPE_MAGICAL))
        {
            if (bCheckDispel)
            {
                // Found an effect applied by a spell script - check the effect type
                switch(iType)
                {
                case EFFECT_TYPE_VISUALEFFECT:  // this effect is very common, don't check everything
                    break;
                case EFFECT_TYPE_REGENERATE:
                case EFFECT_TYPE_SANCTUARY:
                case EFFECT_TYPE_IMMUNITY:
                case EFFECT_TYPE_INVULNERABLE:
                case EFFECT_TYPE_HASTE:
                case EFFECT_TYPE_ELEMENTALSHIELD:
                case EFFECT_TYPE_SPELL_IMMUNITY:
                case EFFECT_TYPE_SPELLLEVELABSORPTION:
                case EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE:
                case EFFECT_TYPE_DAMAGE_INCREASE:
                case EFFECT_TYPE_DAMAGE_REDUCTION:
                case EFFECT_TYPE_DAMAGE_RESISTANCE:
                case EFFECT_TYPE_POLYMORPH:
                case EFFECT_TYPE_ETHEREAL:
                case EFFECT_TYPE_INVISIBILITY:
                    if (result.dispel < fMaxEnhancementWeight)
                    {
                        result.dispel += 0.5 * GetDispelChance(GetEffectCreator(eCheck));
                        if (result.dispel >= fMaxEnhancementWeight)
                        {
                            result.dispel = fMaxEnhancementWeight;
                            bCheckDispel = FALSE;
                        }
                    }
                    break;
                case EFFECT_TYPE_ABILITY_INCREASE:
                case EFFECT_TYPE_AC_INCREASE:
                case EFFECT_TYPE_ATTACK_INCREASE:
                case EFFECT_TYPE_CONCEALMENT:
                case EFFECT_TYPE_ENEMY_ATTACK_BONUS:
                case EFFECT_TYPE_MOVEMENT_SPEED_INCREASE:
                case EFFECT_TYPE_SAVING_THROW_INCREASE:
                case EFFECT_TYPE_SEEINVISIBLE:
                case EFFECT_TYPE_SKILL_INCREASE:
                case EFFECT_TYPE_SPELL_RESISTANCE_INCREASE:
                case EFFECT_TYPE_TEMPORARY_HITPOINTS:
                case EFFECT_TYPE_TRUESEEING:
                case EFFECT_TYPE_ULTRAVISION:
                    if (result.dispel < fMaxEnhancementWeight)
                    {
                        result.dispel += 0.1 * GetDispelChance(GetEffectCreator(eCheck));
                        if (result.dispel >= fMaxEnhancementWeight)
                        {
                            result.dispel = fMaxEnhancementWeight;
                            bCheckDispel = FALSE;
                        }
                    }
                    break;
/*              case EFFECT_TYPE_PARALYZE:
                case EFFECT_TYPE_STUNNED:
                case EFFECT_TYPE_FRIGHTENED:
                case EFFECT_TYPE_SLEEP:
                case EFFECT_TYPE_DAZED:
                case EFFECT_TYPE_CONFUSED:
                case EFFECT_TYPE_TURNED:
                case EFFECT_TYPE_PETRIFY:
                case EFFECT_TYPE_CUTSCENEIMMOBILIZE:
                case EFFECT_TYPE_MESMERIZE:
                    {
                        // if disabled don't dispel
                        struct sEnhancementLevel noResult;
                        return noResult;
                    } */
                }
            }
        }
        eCheck = GetNextEffect(oTarget);
    }

//  float targetWeight = GetThreatRating(oTarget);
//  result.breach *= targetWeight;
//  result.dispel *= targetWeight;

    if (bCheckDispel)
    {
            // check if target has summons
        object oSummon = GetAssociate(ASSOCIATE_TYPE_SUMMONED, oTarget);
        if (GetIsObjectValid(oSummon))
        {
        //    if (GetTag(oSummon) != "X2_S_DRGRED001" && GetTag(oSummon) != "X2_S_MUMMYWARR")
            {
                result.dispel += GetDispelChance(oTarget) * GetRawThreatRating(oSummon);
//              if (result.dispel >= fMaxEnhancementWeight * targetWeight)
//              {
//                  result.dispel = fMaxEnhancementWeight * targetWeight;
//              }
            }
        }
    }
    return result;
}


// gets creature size adjusted for enlarge effects
int GetAdjustedCreatureSize(object oTarget)
{
    int nSize = GetCreatureSize(oTarget);
    return nSize;
}


const int SAVING_THROW_CHECK_FAILED           = 0;
const int SAVING_THROW_CHECK_SUCCEEDED        = 1;
const int SAVING_THROW_CHECK_IMMUNE           = 2;


const int TOUCH_ATTACK_RESULT_MISS       = 0;
const int TOUCH_ATTACK_RESULT_HIT        = 1;
const int TOUCH_ATTACK_RESULT_CRITICAL   = 2;
