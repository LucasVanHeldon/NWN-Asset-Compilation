//::///////////////////////////////////////////////
//:: Beholder AI and Attack Include
//:: x2_inc_behai
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Include file for several beholder AI functions

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: August, 2003
//:://////////////////////////////////////////////
// Modified by Tony K for NWN2 2008-05-17
// Modified by Tony K for NWN1 2008-07-22


#include "x2_inc_beholder"


const int BEHOLDER_RAY_TYPES_STANDARD           = 0;
const int BEHOLDER_RAY_TYPES_GAUTH              = 1;
const int BEHOLDER_RAY_TYPES_STANDARD_MISSING14 = 2;
const int BEHOLDER_RAY_TYPES_SPECIFIED          = 3;
const int BEHOLDER_RAY_TYPES_EYEBALL            = 4;
const int BEHOLDER_RAY_TYPES_HIVE_MOTHER        = 5;
const int BEHOLDER_RAY_TYPES_BEHOLDER_MAGE      = 6;
// user created ray types
const int BEHOLDER_RAY_TYPES_USER1              = 20;
const int BEHOLDER_RAY_TYPES_USER2              = 21;
const int BEHOLDER_RAY_TYPES_USER3              = 22;

// internal AI local variables
const string BEHOLDER_THREAT_RATING = "BeholderThreatRating";
const string BEHOLDER_TOUCH_CHANCE = "BeholderTouchChance";
const string BEHOLDER_RAY_TARGET_QUAD = "BeholderRayQuad";
const string BEHOLDER_RAY_QUAD_COUNT = "BeholderRayQuadCount";
const string BEHOLDER_RAY_MESSAGE_SENT = "BeholderMessageSent";
const string BEHOLDER_EYE_IS_OPEN = "BeholderEyeOpen";
const string BEHOLDER_AI_ACTION_IN_ROUND_USED = "BeholderActionInRoundUsed";
const string BEHOLDER_AI_AGILE_TYRANT_USE = "BeholderAgileTyrantUse";

const int BEHOLDER_QUADRANT_FRONT   = 1;
const int BEHOLDER_QUADRANT_RIGHT   = 2;
const int BEHOLDER_QUADRANT_BACK    = 3;
const int BEHOLDER_QUADRANT_LEFT    = 4;

int gHenchRayTargetObjects;


// initializes list of targets into quadrants for the eyestalk rays
void InitRayTargets(object oTarget, int bFromSpellScript)
{
    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    vector vSelf = GetPosition(OBJECT_SELF);
    vector vTarget = GetPosition(oTarget);
    float fAngle1 = VectorToAngle(vTarget - vSelf);

    while (GetIsObjectValid(oCurTarget))
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " init ray target " + GetName(oTarget));
        float fCurThreatRating = GetRawThreatRating(oCurTarget);

        if (GetIsDisabled(oCurTarget))
        {
            fCurThreatRating *= 0.1;
        }
        SetLocalFloat(oCurTarget, BEHOLDER_THREAT_RATING, fCurThreatRating);
        if (bFromSpellScript && GetIsPC(oCurTarget))
        {
            SetLocalInt(oCurTarget, BEHOLDER_RAY_MESSAGE_SENT, TRUE);
        }
        else
        {
            DeleteLocalInt(oCurTarget, BEHOLDER_RAY_MESSAGE_SENT);
        }
        float fTouchChance;
        if (GetObjectSeen(oCurTarget))
        {
            int index;
            int hitCount;
            for (index = 0; index < 20; index++)
            {
                hitCount += TouchAttackRanged(oCurTarget, FALSE) ? 1 : 0;
            }
//          Jug_Debug(GetName(OBJECT_SELF) + " target " + GetName(oCurTarget) + " raw touch chance " + IntToString(hitCount));
            if (!hitCount)
            {
                fTouchChance = 0.05;
            }
            else if (hitCount == 20)
            {
                fTouchChance = 0.95;
            }
            else
            {
                fTouchChance = hitCount / 20.0;
            }
            vector vCurTarget = GetPositionFromLocation(GetLocation(oCurTarget));
            float fAngle2 = VectorToAngle(vCurTarget - vSelf);

            float fRelAngel = fAngle1 - fAngle2;
            if (fRelAngel < 0.0)
            {
                fAngle1 += 360.0;
            }
            int quadrant;
            if (fRelAngel > 315.0 || fRelAngel <= 45.0)
            {
                quadrant = BEHOLDER_QUADRANT_FRONT;
            }
            else if (fRelAngel <= 135.0)
            {
                quadrant = BEHOLDER_QUADRANT_RIGHT;
            }
            else if (fRelAngel <= 225.0)
            {
                quadrant = BEHOLDER_QUADRANT_BACK;
            }
            else
            {
                quadrant = BEHOLDER_QUADRANT_LEFT;
            }
            SetLocalInt(oCurTarget, BEHOLDER_RAY_TARGET_QUAD, quadrant);
//          Jug_Debug(GetName(oTarget) + " quadrant " + IntToString(quadrant));
        }
//      else
//      {
//          Jug_Debug("*****" + GetName(OBJECT_SELF) + " target " + GetName(oCurTarget) + " is not seen");
//      }
        SetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE, fTouchChance);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
    int curQuadCount;
    int nMaxRaysPerQuadrant = GetBeholderMaxRaysPerQuadrant();
    for (curQuadCount = 1; curQuadCount <= 4; curQuadCount++)
    {
        SetIntArray(OBJECT_SELF, BEHOLDER_RAY_QUAD_COUNT, curQuadCount, nMaxRaysPerQuadrant);
    }

    if (GetBeholderAgileTyrant())
    {
        SetLocalInt(OBJECT_SELF, BEHOLDER_AI_AGILE_TYRANT_USE, TRUE);
    }
}


// get death ray attack chances
void BeholderCheckDeathRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    float damageAmount = IntToFloat(11 + GetBeholderEyeStalkSpellCasterLevel());

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " check death ray for " + GetName(oCurTarget));
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_DEATH, OBJECT_SELF))
        {
            ratio *= CalculateDamageWeight(damageAmount, oCurTarget);
        }
        else
        {
            float saveChance = Getd20ChanceLimited(nSaveDC - GetFortitudeSavingThrow(oCurTarget));
            ratio *= saveChance /* * 1.0 */ +
                (1.0 - saveChance) * CalculateDamageWeight(damageAmount, oCurTarget);
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_DEATH, ratio);
//      Jug_Debug(GetName(OBJECT_SELF) + " ratio " + FloatToString(ratio));

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get telekinesis thrust chances
void BeholderCheckTKThrustRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_KNOCKDOWN, OBJECT_SELF) ||
            (GetAdjustedCreatureSize(oCurTarget) > CREATURE_SIZE_MEDIUM) ||
            GetIsDisabled(oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_TK_THRUST, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get telekinesis throw rock chances
void BeholderCheckTKThrowRocksRay()
{
    float damageAmount = 2.0 * GetBeholderEyeStalkSpellCasterLevel();
//  Jug_Debug(GetName(OBJECT_SELF) + " rock damage is " + FloatToString(damageAmount));

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = Getd20ChanceLimited(GetBaseAttackBonus(OBJECT_SELF) + GetAbilityModifier(ABILITY_CHARISMA) - GetAC(oCurTarget));
//      Jug_Debug(GetName(OBJECT_SELF) + " throw rock chance on " + GetName(oCurTarget) + " is " + FloatToString(ratio));
        ratio *= CalculateDamageWeight(damageAmount, oCurTarget);

        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_TK_THROW_ROCKS, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get petrification attack chances
void BeholderCheckPetriRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetHasEffect(EFFECT_TYPE_PETRIFY, oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= Getd20ChanceLimited(nSaveDC - GetFortitudeSavingThrow(oCurTarget));
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_PETRI, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get charm attack chances
void BeholderCheckCharmRay(int nRay)
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF) ||
             GetIsImmune(oCurTarget, IMMUNITY_TYPE_CHARM, OBJECT_SELF) || GetIsDisabled(oCurTarget) ||
             ((nRay == BEHOLDER_RAY_CHARM_PER) && !GetIsHumanoid(GetRacialType(oCurTarget))))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
            if (nRay == BEHOLDER_RAY_CHARM_PER)
            {
                ratio *= 0.31;
            }
            else
            {
                ratio *= 0.3;
            }
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, nRay, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get slow attack chances
void BeholderCheckSlowRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetHasEffect(EFFECT_TYPE_SLOW, oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= 0.3 * Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_SLOW, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get inflict wounds attack chances
void BeholderCheckWoundRay(int nRay)
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    float damageAmount = IntToFloat(GetBeholderEyeStalkSpellCasterLevel());
    if (nRay ==  BEHOLDER_RAY_WOUND)
    {
        if (damageAmount > 10.0)
        {
            damageAmount = 10.0;
        }
        damageAmount += 9.0;
    }
    else
    {
        if (damageAmount > 20.0)
        {
            damageAmount = 20.0;
        }
        damageAmount += 18.0;
    }

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " check wounds ray for " + GetName(oCurTarget));
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetRacialType(oCurTarget) == RACIAL_TYPE_UNDEAD)
        {
            ratio = 0.0;
        }
        else
        {
            float saveChance = Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
            ratio *= saveChance * CalculateDamageWeight(damageAmount, oCurTarget) +
                (1.0 - saveChance) * CalculateDamageWeight(damageAmount / 2.0, oCurTarget);
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, nRay, ratio);
//      Jug_Debug(GetName(OBJECT_SELF) + " ratio " + FloatToString(ratio));

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get fear attack chances
void BeholderCheckFearRay(int nRay)
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();
    int checkHitDice = nRay == BEHOLDER_RAY_CAUSE_FEAR;

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_FEAR, OBJECT_SELF) ||
            GetIsImmune(oCurTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF) ||
            GetIsDisabled(oCurTarget) ||
            (checkHitDice && (GetHitDice(oCurTarget) >= 5)))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= 0.95 * Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, nRay, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get sleep attack chances
void BeholderCheckSleepRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_SLEEP, OBJECT_SELF) ||
            GetIsImmune(oCurTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF) || GetIsDisabled(oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= 0.95 * Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_SLEEP, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get disintegrate attack chances
void BeholderCheckDisintegrateRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    float damageAmount = 3.5 * IntToFloat(GetBeholderEyeStalkSpellCasterLevel());

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " check disintegrate ray for " + GetName(oCurTarget));
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        float saveChance = Getd20ChanceLimited(nSaveDC - GetFortitudeSavingThrow(oCurTarget));
        ratio *= saveChance * CalculateDamageWeight(damageAmount, oCurTarget) +
            (1.0 - saveChance) * CalculateDamageWeight(18.0, oCurTarget);
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_DISINTEGRATE, ratio);
//      Jug_Debug(GetName(OBJECT_SELF) + " ratio " + FloatToString(ratio));

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get dispel attack chances
void BeholderCheckDispelRay()
{
    int casterLevel = GetBeholderEyeStalkSpellCasterLevel();
    if (casterLevel > 10)
    {
        casterLevel = 10;
    }
    giBestDispelCastingLevel = casterLevel;

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " check dispel ray for " + GetName(oCurTarget));
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);

        if (GetIsDisabled(oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= Jug_GetHasBeneficialEnhancement(oCurTarget).dispel;
        }

        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_DISPEL, ratio);
//      Jug_Debug(GetName(OBJECT_SELF) + " ratio " + FloatToString(ratio));

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get damage attack chances
void BeholderCheckDamageRay(int nRay)
{
    float damage;
    if (nRay == BEHOLDER_RAY_SCORCHING)
    {
        damage = 14.0;
    }
    else
    {
        damage = 2.0;
    }
    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " check damage ray for " + GetName(oCurTarget));
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        ratio *= CalculateDamageWeight(damage, oCurTarget);
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, nRay, ratio);
//      Jug_Debug(GetName(OBJECT_SELF) + " ratio " + FloatToString(ratio));

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get paralysis attack chances
void BeholderCheckParalysisRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC() - 4;

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_PARALYSIS, OBJECT_SELF) ||
            GetIsImmune(oCurTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF) ||
            GetIsDisabled(oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= 0.45 * Getd20ChanceLimited(nSaveDC - GetFortitudeSavingThrow(oCurTarget));
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_PARALYSIS, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get exhaust attack chances
void BeholderCheckExhaustionRay()
{
    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_ABILITY_DECREASE, OBJECT_SELF) ||
            GetHasSpellEffect(BEHOLDER_EXHAUSTION_SPELLID , oCurTarget) ||
            GetIsDisabled(oCurTarget))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= 0.35;
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_EXHAUSTION, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// get daze attack chances
void BeholderCheckDazeRay()
{
    int nSaveDC = GetBeholderEyeStalkSpellDC();

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        float ratio = GetLocalFloat(oCurTarget, BEHOLDER_TOUCH_CHANCE);
        if (GetIsImmune(oCurTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF) ||
             GetIsImmune(oCurTarget, IMMUNITY_TYPE_CHARM, OBJECT_SELF) || GetIsDisabled(oCurTarget) ||
             !GetIsHumanoid(GetRacialType(oCurTarget)) || (GetHitDice(oCurTarget) >= 5))
        {
            ratio = 0.0;
        }
        else
        {
            ratio *= Getd20ChanceLimited(nSaveDC - GetWillSavingThrow(oCurTarget));
            ratio *= 0.3;
        }
        SetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, BEHOLDER_RAY_DAZE, ratio);

        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
}


// BEHOLDER_RAY_USER add custom ray spell targeting here, copy the best matching ray and modify


const string sCustomStringName = "<CUSTOM0>";

// find the best ray to use against possible targets, the target priority is lowered based
// on the attack chance
int CheckRayToUse(int bUseAntiMagic, int nRaysToUseMask)
{
    int nBestRay;
    float fBestTargetWeight;
    object oBestTarget;

    int nCurRay = 1;
    int nCurRayMask = nRaysToUseMask;
    while (nCurRayMask)
    {
        if (nCurRayMask & 1)
        {
//          Jug_Debug(GetName(OBJECT_SELF) + " testing ray " + IntToHexString(nCurRay));
            object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
            while (GetIsObjectValid(oCurTarget))
            {
                int targetQuadrant = GetLocalInt(oCurTarget, BEHOLDER_RAY_TARGET_QUAD);
                // check quadrant limit
                if (!(bUseAntiMagic && (targetQuadrant == BEHOLDER_QUADRANT_FRONT) &&
                    (nCurRay != BEHOLDER_RAY_TK_THROW_ROCKS)) &&
                    GetIntArray(OBJECT_SELF, BEHOLDER_RAY_QUAD_COUNT, targetQuadrant) ||
                    GetLocalInt(OBJECT_SELF, BEHOLDER_AI_AGILE_TYRANT_USE))
                {
                    float fCurTargetWeight = GetFloatArray(oCurTarget, BEHOLDER_TOUCH_CHANCE, nCurRay);

//                  Jug_Debug(GetName(OBJECT_SELF) + " test target " + GetName(oCurTarget) + " weight " + FloatToString(fCurTargetWeight));

                    if (fCurTargetWeight > 0.0)
                    {
                        fCurTargetWeight *= GetLocalFloat(oCurTarget, BEHOLDER_THREAT_RATING);

                        if (fCurTargetWeight > fBestTargetWeight)
                        {
                            nBestRay = nCurRay;
                            fBestTargetWeight = fCurTargetWeight;
                            oBestTarget = oCurTarget;
                        }
                    }
                }
                oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
            }
        }

        nCurRayMask = nCurRayMask >> 1;
        nCurRay = nCurRay << 1;
    }

    if (fBestTargetWeight <= 0.0)
    {
        nRaysToUseMask = 0;
    }
    else
    {
        if (GetIsPC(oBestTarget) && !GetLocalInt(oBestTarget, BEHOLDER_RAY_MESSAGE_SENT))
        {
            string sLocalizedText = GetStringByStrRef(83839);
            int totalLen = GetStringLength(sLocalizedText);
            int customLen = GetStringLength(sCustomStringName);
            int startPosition = FindSubString(sLocalizedText, sCustomStringName);
            string sDisplayText = GetStringLeft(sLocalizedText, startPosition);
            sDisplayText += GetName(OBJECT_SELF);
            sDisplayText += GetStringRight(sLocalizedText, totalLen - customLen);
            SendMessageToPC(oBestTarget, "<cÚpÕ>" + sDisplayText + "</c>");
            SetLocalInt(oBestTarget, BEHOLDER_RAY_MESSAGE_SENT, TRUE);
        }

        BehDoFireBeam(nBestRay, oBestTarget);

        nRaysToUseMask = RemoveEyebalRayType(nRaysToUseMask, nBestRay);

        float fBestChance = 1.0 - GetFloatArray(oBestTarget, BEHOLDER_TOUCH_CHANCE, nBestRay);
        fBestChance *= GetLocalFloat(oBestTarget, BEHOLDER_THREAT_RATING);
        SetLocalFloat(oBestTarget, BEHOLDER_THREAT_RATING, fBestChance);

        int quadrant = GetLocalInt(oBestTarget, BEHOLDER_RAY_TARGET_QUAD);
        int raysLeftInQuadrant = GetIntArray(OBJECT_SELF, BEHOLDER_RAY_QUAD_COUNT, quadrant);
        if (!raysLeftInQuadrant)
        {
            // remove agile tyrant use (one extra ray in one quadrant)
            DeleteLocalInt(OBJECT_SELF, BEHOLDER_AI_AGILE_TYRANT_USE);
        }
        else
        {
            SetIntArray(OBJECT_SELF, BEHOLDER_RAY_QUAD_COUNT, quadrant, raysLeftInQuadrant - 1);
        }
    }
    return nRaysToUseMask;
}


// check and fire all eyestalk rays
void CheckRays(int bUseAntiMagic)
{
    int rayTypes = GetLocalInt(OBJECT_SELF, "beholder_ray_types");

    int nRaysToUseMask;
    switch (rayTypes)
    {
        case BEHOLDER_RAY_TYPES_GAUTH:
            nRaysToUseMask = GAUTH_STANDARD_EYE_RAYS;
            break;
        case BEHOLDER_RAY_TYPES_STANDARD_MISSING14:
            nRaysToUseMask = BEHOLDER_STANDARD_EYE_RAYS;
            {
//              Jug_Debug(GetName(OBJECT_SELF) + " starting rays " + IntToHexString(nRaysToUseMask));
                int randomCount = d4();
                while ((randomCount > 0) && nRaysToUseMask)
                {
                    int eyeStalkToRemove = 1 << d10();
                    if (eyeStalkToRemove & nRaysToUseMask)
                    {
//                      Jug_Debug(GetName(OBJECT_SELF) + " removing ray " + IntToHexString(eyeStalkToRemove));
                        nRaysToUseMask = RemoveEyebalRayType(nRaysToUseMask, eyeStalkToRemove);
                        randomCount--;
                    }
                }
//              Jug_Debug(GetName(OBJECT_SELF) + " ending rays " + IntToHexString(nRaysToUseMask));
            }
            SetLocalInt(OBJECT_SELF, "beholder_ray_custom", nRaysToUseMask);
            SetLocalInt(OBJECT_SELF, "beholder_ray_types", BEHOLDER_RAY_TYPES_SPECIFIED);
            break;
        case BEHOLDER_RAY_TYPES_SPECIFIED:
            nRaysToUseMask = GetLocalInt(OBJECT_SELF, "beholder_ray_custom");
            break;
        case BEHOLDER_RAY_TYPES_EYEBALL:
            nRaysToUseMask = EYEBALL_STANDARD_EYE_RAYS;
            break;
        case BEHOLDER_RAY_TYPES_HIVE_MOTHER:
            nRaysToUseMask = HIVE_MOTHER_STANDARD_EYE_RAYS;
            break;
        case BEHOLDER_RAY_TYPES_BEHOLDER_MAGE:
            nRaysToUseMask = BEHOLDER_MAGE_EYE_RAYS;
            break;

        // BEHOLDER_RAY_TYPES_USER a custom set of ray types can be added here

        default:
            nRaysToUseMask = BEHOLDER_STANDARD_EYE_RAYS;
            break;
    }
//  Jug_Debug(GetName(OBJECT_SELF) + " in check rays types " + IntToHexString(nRaysToUseMask));

    nRaysToUseMask &= ~GetLocalInt(OBJECT_SELF, BEHOLDER_RAY_SUPPRESS);

//  Jug_Debug(GetName(OBJECT_SELF) + " in check rays types after suppress " + IntToHexString(nRaysToUseMask));

    if (nRaysToUseMask & BEHOLDER_RAY_DEATH)
    {
        BeholderCheckDeathRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_TK_THRUST)
    {
        BeholderCheckTKThrustRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_TK_THROW_ROCKS)
    {
        BeholderCheckTKThrowRocksRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_PETRI)
    {
        BeholderCheckPetriRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_CHARM_PER)
    {
        BeholderCheckCharmRay(BEHOLDER_RAY_CHARM_PER);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_CHARM_MON)
    {
        BeholderCheckCharmRay(BEHOLDER_RAY_CHARM_MON);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_SLOW)
    {
        BeholderCheckSlowRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_WOUND)
    {
        BeholderCheckWoundRay(BEHOLDER_RAY_WOUND);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_CRITICAL_WOUND)
    {
        BeholderCheckWoundRay(BEHOLDER_RAY_CRITICAL_WOUND);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_FEAR)
    {
        BeholderCheckFearRay(BEHOLDER_RAY_FEAR);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_CAUSE_FEAR)
    {
        BeholderCheckFearRay(BEHOLDER_RAY_CAUSE_FEAR);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_SLEEP)
    {
        BeholderCheckSleepRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_DISINTEGRATE)
    {
        BeholderCheckDisintegrateRay();
    }

    if (nRaysToUseMask & BEHOLDER_RAY_DISPEL)
    {
        BeholderCheckDispelRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_SCORCHING)
    {
        BeholderCheckDamageRay(BEHOLDER_RAY_SCORCHING);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_FROST)
    {
        BeholderCheckDamageRay(BEHOLDER_RAY_FROST);
    }
    if (nRaysToUseMask & BEHOLDER_RAY_PARALYSIS)
    {
        BeholderCheckParalysisRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_EXHAUSTION)
    {
        BeholderCheckExhaustionRay();
    }
    if (nRaysToUseMask & BEHOLDER_RAY_DAZE)
    {
        BeholderCheckDazeRay();
    }

    // BEHOLDER_RAY_USER add custom ray spell here

    int useAllRays = !GetLocalInt(OBJECT_SELF, BEHOLDER_AI_ONE_RAY);

    do
    {
        nRaysToUseMask = CheckRayToUse(bUseAntiMagic, nRaysToUseMask);
    } while (useAllRays && nRaysToUseMask);
}


const string sCreatureSaveResultStr = "BEHOLDER_CREATURE_SAVE";
const string sCreatureMagicUserStr = "BEHOLDER_CREATURE_MAGIC_USER_ONLY";

// get the best antimagic target
object GetBestAntiMagicTarget(object oTarget)
{
    // reset flag on nearby creatures
    location testTargetLoc = GetLocation(OBJECT_SELF);
    object oTestTarget = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, testTargetLoc, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTestTarget))
    {
        SetLocalInt(oTestTarget, sCreatureSaveResultStr, -1);
        oTestTarget = GetNextObjectInShape(SHAPE_SPHERE, 25.0, testTargetLoc, FALSE, OBJECT_TYPE_CREATURE);
    }

    int bRequireTarget;
    if (GetDistanceToObject(oTarget) <= 5.0)
    {
        bRequireTarget = TRUE;
    }

    object oBestTarget = OBJECT_INVALID;
    int nBestMagicTarget = 0;

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        if (GetDistanceToObject(oCurTarget) > (bRequireTarget ? 5.0 : 25.0))
        {
            oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
            continue;
        }
        testTargetLoc = GetLocation(oCurTarget);
        int nAntiMagicCount;
        int nMageCount;

        oTestTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 25.0, testTargetLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTestTarget))
        {
            if (GetObjectType(oTestTarget) == OBJECT_TYPE_AREA_OF_EFFECT)
            {
                object oCreator = GetAreaOfEffectCreator(oTestTarget);
                if (GetObjectType(oCreator) == OBJECT_TYPE_CREATURE && GetIsEnemy(oCreator))
                {
                    nAntiMagicCount += 5;
                }
            }
            else
            {
                if (oTestTarget != OBJECT_SELF && !GetIsDead(oTestTarget))
                {
                    if (GetIsFriend(oTestTarget))
                    {
                        nAntiMagicCount = -1000;
                        break;
                    }
                    int nSaveResult = GetLocalInt(oTestTarget, sCreatureSaveResultStr);
                    int nMag;
                    if (nSaveResult == -1)
                    {
                        if ((oTestTarget != oTarget) && !GetObjectSeen(oTestTarget) && !GetObjectHeard(oTestTarget))
                        {
                            nSaveResult = 0;
                            nMag = 0;
                        }
                        // already antimagic or dead?
                        else if (!GetHasSpellEffect(BEHOLDER_EYE_SPELLID, oTestTarget) && !GetIsDead(oTestTarget))
                        {
                            nSaveResult = 0;
                            effect eCheck = GetFirstEffect(oTestTarget);
                            int bContinueLoop = TRUE;
                            while (bContinueLoop && GetIsEffectValid(eCheck))
                            {
                                int iSpell = GetEffectSpellId(eCheck);
                                if (iSpell != -1 && GetEffectSubType(eCheck) == SUBTYPE_MAGICAL)
                                {
                                    // Found an effect applied by a spell script - check the effect type
                                    // Ignore invisibility effects since that's a special case taken
                                    // care of elsewhere
                                    int iType = GetEffectType(eCheck);

                                    switch(iType)
                                    {
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
                                    case EFFECT_TYPE_DOMINATED:
                                        nSaveResult += 10;
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
                                        nSaveResult++;
                                        break;
                                    case EFFECT_TYPE_SLOW:
                                    // sometimes ignore slow
                                        if (d2() == 1)
                                        {
                                            break;
                                        }
                                    case EFFECT_TYPE_PARALYZE:
                                    case EFFECT_TYPE_STUNNED:
                                    case EFFECT_TYPE_FRIGHTENED:
                                    case EFFECT_TYPE_SLEEP:
                                    case EFFECT_TYPE_DAZED:
                                    case EFFECT_TYPE_CHARMED:
                                    case EFFECT_TYPE_CONFUSED:
                                    case EFFECT_TYPE_TURNED:
                                        // if disabled don't dispel
                                        nSaveResult = -1000;
                                        bContinueLoop = FALSE;
                                        break;
                                    case EFFECT_TYPE_PETRIFY:
                                    // ignore this target
                                        nSaveResult = 0;
                                        bContinueLoop = FALSE;
                                        break;
                                    }
                                }
                                eCheck = GetNextEffect(oTestTarget);
                            }
                            if (nSaveResult < 0)
                            {
                                nAntiMagicCount = -1000;
                                break;
                            }

                            nMag = GetLevelByClass(CLASS_TYPE_WIZARD, oTestTarget) + GetLevelByClass(CLASS_TYPE_SORCERER, oTestTarget) +
                                GetLevelByClass(CLASS_TYPE_BARD, oTestTarget) + GetLevelByClass(CLASS_TYPE_CLERIC, oTestTarget) +
                                GetLevelByClass(CLASS_TYPE_DRUID, oTestTarget);
                            if (nSaveResult > 0)
                            {
                                nSaveResult += nMag / 3;
                                nMag = 0;
                            }
                            else if (nMag > 3)
                            {
                                nSaveResult += nMag / 3;
                                nMag = 1;

                            }
                            else
                            {
                                nMag = 0;
                            }
                        }
                        else
                        {
                            nSaveResult = 0;
                            nMag = 0;
                        }
                        SetLocalInt(oTestTarget, sCreatureSaveResultStr, nSaveResult);
                        SetLocalInt(oTestTarget, sCreatureMagicUserStr, nMag);
                    }
                    else
                    {
                        nMag = GetLocalInt(oTestTarget, sCreatureMagicUserStr);
                    }
                    nAntiMagicCount += nSaveResult;
                    nMageCount += nMag;
                }
            }
            //Select the next target within the spell shape.
            oTestTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 25.0, testTargetLoc, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_AREA_OF_EFFECT);
        }
//      Jug_Debug(GetName(OBJECT_SELF) + " mage count " + IntToString(nMageCount) + " total " + IntToString(gHenchSpellTargetObjects));
        if ((nAntiMagicCount > nBestMagicTarget) && (nMageCount < gHenchSpellTargetObjects))
        {
            nBestMagicTarget = nAntiMagicCount;
            oBestTarget = oCurTarget;
        }
        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
    // ignore minor magic sometimes
    if (nBestMagicTarget <= d4(2))
    {
        oBestTarget = OBJECT_INVALID;
    }
    return oBestTarget;
}


// get the best stun target
object GetBestStunTarget(object oTarget)
{
    // reset flag on nearby creatures
    location testTargetLoc = GetLocation(OBJECT_SELF);
    object oTestTarget = GetFirstObjectInShape(SHAPE_SPHERE, 25.0, testTargetLoc, FALSE, OBJECT_TYPE_CREATURE);
    while (GetIsObjectValid(oTestTarget))
    {
        SetLocalInt(oTestTarget, sCreatureSaveResultStr, -1);
        oTestTarget = GetNextObjectInShape(SHAPE_SPHERE, 25.0, testTargetLoc, FALSE, OBJECT_TYPE_CREATURE);
    }

    int bRequireTarget;
    if (GetDistanceToObject(oTarget) <= 5.0)
    {
        bRequireTarget = TRUE;
    }

    object oBestTarget = OBJECT_INVALID;
    int nBestStunCount;

    object oCurTarget = GetLocalObject(OBJECT_SELF, BEHOLDER_SPELL_TARGET_OBJECTS);
    while (GetIsObjectValid(oCurTarget))
    {
        if (GetDistanceToObject(oCurTarget) > (bRequireTarget ? 5.0 : 25.0))
        {
            oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
            continue;
        }
        testTargetLoc = GetLocation(oCurTarget);
        int nStunCount;

        oTestTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 25.0, testTargetLoc, TRUE, OBJECT_TYPE_CREATURE);
        //Cycle through the targets within the spell shape until an invalid object is captured.
        while (GetIsObjectValid(oTestTarget))
        {
            if (oTestTarget != OBJECT_SELF && !GetIsDead(oTestTarget))
            {
                if (GetIsFriend(oTestTarget))
                {
                    nStunCount = -1000;
                    break;
                }
                int nSaveResult = GetLocalInt(oTestTarget, sCreatureSaveResultStr);
                if (nSaveResult == -1)
                {
                    if ((oTestTarget != oTarget) && !GetObjectSeen(oTestTarget) && !GetObjectHeard(oTestTarget))
                    {
                        nSaveResult = 0;
                    }
                    else if (!GetIsDisabled(oTestTarget) && !GetIsDead(oTestTarget) &&
                        !GetIsImmune(oTestTarget, IMMUNITY_TYPE_MIND_SPELLS, OBJECT_SELF) &&
                        !GetIsImmune(oTestTarget, IMMUNITY_TYPE_STUN, OBJECT_SELF))
                    {
                        nSaveResult = 1;
                    }
                    else
                    {
                        nSaveResult = 0;
                    }
                    SetLocalInt(oTestTarget, sCreatureSaveResultStr, nSaveResult);
                }
                nStunCount += nSaveResult;
            }
            //Select the next target within the spell shape.
            oTestTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 25.0, testTargetLoc, TRUE, OBJECT_TYPE_CREATURE);
        }
//      Jug_Debug(GetName(OBJECT_SELF) + " stun total " + IntToString(nStunCount));
        if (nStunCount > nBestStunCount)
        {
            nBestStunCount = nStunCount;
            oBestTarget = oCurTarget;
        }
        oCurTarget = GetLocalObject(oCurTarget, BEHOLDER_SPELL_TARGET_OBJECTS);
    }
    if (nBestStunCount <= 0)
    {
        oBestTarget = OBJECT_INVALID;
    }
//  Jug_Debug(GetName(OBJECT_SELF) + " stun  " + GetName(oBestTarget));
    return oBestTarget;
}


// run AI for all eyestalk ray attacks
void RunBeholderSmallEyeAttacks(object oTarget, int bFromSpellScript, int bAntiMagicUsed)
{
    // if in antimagic or blind, can't use eye ray attacks
    if (GetHasEffect(EFFECT_TYPE_SPELL_FAILURE) || GetHasEffect(EFFECT_TYPE_BLINDNESS))
    {
        return;
    }

    // find targets - up to three eyes can be used in a quadrant
    InitRayTargets(oTarget, bFromSpellScript);

    CheckRays(bAntiMagicUsed);
}


// checks main eye and eyestalk AI for what to do
// returns antimagic or stun target if any
object RunBeholderEyeAttacks(object oTarget, int bFromSpellScript)
{
//  Jug_Debug(GetName(OBJECT_SELF) + " run beholder attack spell");

    // Only if we are beholders and not beholder mages
    int nMainEyeAttack = GetLocalInt(OBJECT_SELF, BEHOLDER_MAIN_EYE_TYPE);
    if (nMainEyeAttack ==  BEHOLDER_MAIN_EYE_ANTI_MAGIC_RANDOM)
    {
        nMainEyeAttack = (d3() == 1) ? BEHOLDER_MAIN_EYE_ANTI_MAGIC : BEHOLDER_MAIN_EYE_NONE;
        SetLocalInt(OBJECT_SELF, BEHOLDER_MAIN_EYE_TYPE, nMainEyeAttack);
    }

    DeleteLocalInt(OBJECT_SELF, BEHOLDER_EYE_IS_OPEN);
    DeleteLocalInt(OBJECT_SELF, BEHOLDER_AI_ACTION_IN_ROUND_USED);

    // need that to make them not drop out of combat
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 736));

    HenchInitSpellTargetObjects(oTarget);

    // first determine where anti magic eye should be used (if at all)
    int bUseMainEye;
    if (nMainEyeAttack == BEHOLDER_MAIN_EYE_ANTI_MAGIC)
    {
        object oTestTarget = GetBestAntiMagicTarget(oTarget);
        bUseMainEye = GetIsObjectValid(oTestTarget);
        if (bUseMainEye)
        {
            oTarget = oTestTarget;
        }
    }
    else if (nMainEyeAttack == BEHOLDER_MAIN_EYE_STUN)
    {
        object oTestTarget = GetBestStunTarget(oTarget);
        bUseMainEye = GetIsObjectValid(oTestTarget);
        if (bUseMainEye)
        {
            oTarget = oTestTarget;
            SetLocalInt(OBJECT_SELF, BEHOLDER_AI_ACTION_IN_ROUND_USED, TRUE);
        }
    }

    DelayCommand(0.01, RunBeholderSmallEyeAttacks(oTarget, bFromSpellScript,
        bUseMainEye && (nMainEyeAttack == BEHOLDER_MAIN_EYE_ANTI_MAGIC)));

//  Jug_Debug(GetName(OBJECT_SELF) + " use main eye " + IntToString(bUseMainEye));

    // Only if we are beholders and not beholder mages
    if (bUseMainEye)
    {
//      Jug_Debug(GetName(OBJECT_SELF) + " use anti magic on " + GetName(oTarget));
        SetLocalInt(OBJECT_SELF, BEHOLDER_EYE_IS_OPEN, TRUE);
        OpenAntiMagicEye(oTarget);
        return oTarget;
    }
    return OBJECT_INVALID;
}


const string beholderCombatRoundStr = "BeholderCombatRound";
const string beholderLastCombatTime = "BeholderLastCombatRound";

// test if a new combat round has started
// since eyestalk attacks are free actions, this allows their use even if moving
int CheckIfNewCombatRound()
{
    int combatRoundCount = GetLocalInt(OBJECT_SELF, beholderCombatRoundStr);
    int combatRoundIncremented;

    int currentTimeSec = GetTimeSecond();

    if (combatRoundCount == 0)
    {
        combatRoundCount ++;
        SetLocalInt(OBJECT_SELF, beholderLastCombatTime, currentTimeSec);
        SetLocalInt(OBJECT_SELF, beholderCombatRoundStr, combatRoundCount);
        combatRoundIncremented = TRUE;
    }
    else
    {
        int lastCombatTime = GetLocalInt(OBJECT_SELF, beholderLastCombatTime);
        int lastCombatTimeDiff = currentTimeSec + 1 - lastCombatTime;
        if (lastCombatTimeDiff < 0)
        {
            lastCombatTimeDiff += 60;
        }
        if (lastCombatTimeDiff > 5)
        {
//          Jug_Debug(GetName(OBJECT_SELF) + " setting combat round count value " + IntToString(lastCombatTimeDiff));
            combatRoundCount ++;
            combatRoundIncremented = TRUE;
            SetLocalInt(OBJECT_SELF, beholderCombatRoundStr, combatRoundCount);
            SetLocalInt(OBJECT_SELF, beholderLastCombatTime, currentTimeSec);
        }
    }

    return combatRoundIncremented;
}