//::///////////////////////////////////////////////
//:: Beholder main eye and eyestalk spells
//:: x2_inc_beholder
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    Include file for several beholder functions

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: August, 2003
//:://////////////////////////////////////////////
// Modified by Tony K for NWN2 2008-05-17
// Modified by Tony K for NWN1 2008-07-22


#include "x2_inc_behcommon"


const int BEHOLDER_EYE_SPELLID = 727;           // main eye spell id
const int BEHOLDER_TK_SPELLID = 777;            // telekinesis spell id
const int BEHOLDER_DISINTEGRATE_SPELLID = 787;
const int BEHOLDER_EXHAUSTION_SPELLID = 776;    // exhaustion spell id

const int BEHOLDER_RAY_DEATH            = 0x00000001;
const int BEHOLDER_RAY_TK_THRUST        = 0x00000002;
const int BEHOLDER_RAY_PETRI            = 0x00000004;
const int BEHOLDER_RAY_CHARM_PER        = 0x00000008;
const int BEHOLDER_RAY_SLOW             = 0x00000010;
const int BEHOLDER_RAY_WOUND            = 0x00000020;
const int BEHOLDER_RAY_FEAR             = 0x00000040;
// added beholder rays
const int BEHOLDER_RAY_CHARM_MON        = 0x00000080;
const int BEHOLDER_RAY_SLEEP            = 0x00000100;
const int BEHOLDER_RAY_DISINTEGRATE     = 0x00000200;
// gauth rays
const int BEHOLDER_RAY_DISPEL           = 0x00000400;
const int BEHOLDER_RAY_SCORCHING        = 0x00000800;
const int BEHOLDER_RAY_PARALYSIS        = 0x00001000;
const int BEHOLDER_RAY_EXHAUSTION       = 0x00002000;
// extra telekinesis
const int BEHOLDER_RAY_TK_THROW_ROCKS   = 0x00004000;
// eyeball
const int BEHOLDER_RAY_FROST            = 0x00008000;   // after use, must wait two rounds before next use of frost or daze
const int BEHOLDER_RAY_DAZE             = 0x00010000;   // after use, must wait two rounds before next use of frost or daze
const int BEHOLDER_RAY_CAUSE_FEAR       = 0x00020000;
// hive mother
const int BEHOLDER_RAY_CRITICAL_WOUND   = 0x00040000;

// user created rays
const int BEHOLDER_RAY_USER1            = 0x00400000;
const int BEHOLDER_RAY_USER2            = 0x00800000;
const int BEHOLDER_RAY_USER3            = 0x01000000;
const int BEHOLDER_RAY_USER4            = 0x02000000;
const int BEHOLDER_RAY_USER5            = 0x04000000;
const int BEHOLDER_RAY_USER6            = 0x08000000;
const int BEHOLDER_RAY_USER7            = 0x10000000;
const int BEHOLDER_RAY_USER8            = 0x20000000;
const int BEHOLDER_RAY_USER9            = 0x40000000;
const int BEHOLDER_RAY_USER10           = 0x80000000;


const int BEHOLDER_STANDARD_EYE_RAYS    = 0x000043ff;
const int GAUTH_STANDARD_EYE_RAYS       = 0x00003d20;
const int EYEBALL_STANDARD_EYE_RAYS     = 0x00038000;
const int HIVE_MOTHER_STANDARD_EYE_RAYS = 0x000443df;
const int BEHOLDER_MAGE_EYE_RAYS        = 0x00004227;

const int BEHOLDER_RAY_TK_ALL_TYPES     = 0x00004002;   // all telekinesis types or'ed together


const int BEHOLDER_MAIN_EYE_ANTI_MAGIC          = 0;
const int BEHOLDER_MAIN_EYE_NONE                = 1;
const int BEHOLDER_MAIN_EYE_STUN                = 2;
const int BEHOLDER_MAIN_EYE_ANTI_MAGIC_RANDOM   = 3;

const string BEHOLDER_MAIN_EYE_TYPE = "beholder_main_eye";
const string BEHOLDER_AI_ONE_RAY = "beholder_one_ray";


// returns eyestalk caster level
int GetBeholderEyeStalkSpellCasterLevel()
{
    int returnValue = GetLocalInt(OBJECT_SELF, "beholder_spell_level");
    if (returnValue < 1)
    {
        returnValue = 13;
    }
    return returnValue;
}


// returns eyestalk DC, normally 10 + HD/2 + Cha modifier
int GetBeholderEyeStalkSpellDC()
{
    int returnValue = GetLocalInt(OBJECT_SELF, "beholder_spell_dc");
    if (returnValue < 1)
    {
        returnValue = 10 + GetHitDice(OBJECT_SELF) / 2 + GetAbilityModifier(ABILITY_CHARISMA);
    }
    else
    {
        // adjust for possible charisma bonus or penalty
        returnValue += GetAbilityModifier(ABILITY_CHARISMA) - GetAbilityScore(OBJECT_SELF, ABILITY_CHARISMA, TRUE) / 2 + 5;
    }
    return returnValue;
}


// return maximum number of eyestalk rays per quadrant
int GetBeholderMaxRaysPerQuadrant()
{
    int returnValue = GetLocalInt(OBJECT_SELF, "beholder_rays_per_quad");
    if (returnValue < 1)
    {
        returnValue = 3;
    }
    return returnValue;
}


// TRUE if beholder has agile tyrant feat (once extra ray in one quadrant)
int GetBeholderAgileTyrant()
{
    return GetLocalInt(OBJECT_SELF, "beholder_agile_tyrant");
}


// remove nRayToRemove from bitmask nCurRays, returns new bitmask
int RemoveEyebalRayType(int nCurRays, int nRayToRemove)
{
    int bitMask;
    if (nRayToRemove & BEHOLDER_RAY_TK_ALL_TYPES)
    {
        bitMask = ~BEHOLDER_RAY_TK_ALL_TYPES;
    }
    else
    {
        bitMask = ~nRayToRemove;
    }
    nCurRays &= bitMask;
    return nCurRays;
}


// applies beholder petrification effects
void DoBeholderPetrify(int nDuration, object oSource, object oTarget, int nSpellID)
{
    if(!GetIsReactionTypeFriendly(oTarget) && !GetIsDead(oTarget))
    {
        // * exit if creature is immune to petrification
        if (spellsIsImmuneToPetrification(oTarget) == TRUE)
        {
            return;
        }
        float fDifficulty = 0.0;
        int bIsPC = GetIsPC(oTarget);
        int bShowPopup = FALSE;

        // * calculate Duration based on difficulty settings
        int nGameDiff = GetGameDifficulty();
        switch (nGameDiff)
        {
            case GAME_DIFFICULTY_VERY_EASY:
            case GAME_DIFFICULTY_EASY:
            case GAME_DIFFICULTY_NORMAL:
                    fDifficulty = RoundsToSeconds(nDuration); // One Round per hit-die or caster level
                break;
            case GAME_DIFFICULTY_CORE_RULES:
            case GAME_DIFFICULTY_DIFFICULT:
                if (!GetPlotFlag(oTarget))
                {
                    bShowPopup = TRUE;
                }
            break;
        }

        effect ePetrify = EffectPetrify();
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
        effect eLink = EffectLinkEffects(eDur, ePetrify);


        /// * The duration is permanent against NPCs but only temporary against PCs
        if (bIsPC == TRUE)
        {
            if (bShowPopup == TRUE)
            {
                // * under hardcore rules or higher, this is an instant death
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
                DelayCommand(2.75, PopUpDeathGUIPanel(oTarget, FALSE , TRUE, 40579));
                // if in hardcore, treat the player as an NPC
                bIsPC = FALSE;
            }
            else
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDifficulty);
        }
        else
        {
            ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);
            // * Feb 11 2003 BK I don't think this is necessary anymore
            //if the target was an NPC - make him uncommandable until Stone to Flesh is cast
            //SetCommandable(FALSE, oTarget);

            // Feb 5 2004 - Jon
            // Added kick-henchman-out-of-party code from generic petrify script
            if (GetAssociateType(oTarget) == ASSOCIATE_TYPE_HENCHMAN)
            {
                FireHenchman(GetMaster(oTarget),oTarget);
            }
        }
        // April 2003: Clearing actions to kick them out of conversation when petrified
        AssignCommand(oTarget, ClearAllActions());
    }
}


const string BEHOLDER_RAY_SUPPRESS = "BeholderRaySuppress";

// resets ray use
void TurnOffSuppress(int nRayMask)
{
    SetLocalInt(OBJECT_SELF, BEHOLDER_RAY_SUPPRESS, ~nRayMask & GetLocalInt(OBJECT_SELF, BEHOLDER_RAY_SUPPRESS));
}

// temporarily supresses use of given rays for nRounds time
void SuppressUseOfRays(int nRayMask, int nRounds)
{
//  int invertedMask = ~nRayMask;
    SetLocalInt(OBJECT_SELF, BEHOLDER_RAY_SUPPRESS, nRayMask | GetLocalInt(OBJECT_SELF, BEHOLDER_RAY_SUPPRESS));
    DelayCommand(6.0 * nRounds + 3.0, TurnOffSuppress(nRayMask));
}


// get location on ground that rocks can be thrown from for oTarget
location GetBeholderStartThrowRocksLocation(object oTarget)
{
    vector vSelf = GetPosition(OBJECT_SELF);
    vector vCurTarget = GetPosition(oTarget);
    float fAngle2 = VectorToAngle(vCurTarget - vSelf);
    float fAngleDifference = GetFacing(OBJECT_SELF) - VectorToAngle(vCurTarget - vSelf);
    location lRockThrowStart;
    // check if in front or back quadrant
    if (fabs(sin(fAngleDifference)) <= 0.5)
    {
        // check if behind
        if (cos(fAngleDifference) < 0.0)
        {
            switch (d2())
            {
                case 1:
                    lRockThrowStart = GetStepRightLocation(OBJECT_SELF);
                    break;
                default:
                    lRockThrowStart = GetStepLeftLocation(OBJECT_SELF);
                    break;
            }
        }
        else if (GetDistanceToObject(oTarget) < 7.5)
        {
            switch (d2())
            {
                case 1:
                    lRockThrowStart = GetFlankingRightLocation(OBJECT_SELF);
                    break;
                default:
                    lRockThrowStart = GetFlankingLeftLocation(OBJECT_SELF);
                    break;
            }
        }
        else
        {
            switch (d4())
            {
                case 1:
                    lRockThrowStart = GetFlankingRightLocation(OBJECT_SELF);
                    break;
                case 2:
                    lRockThrowStart = GetStepRightLocation(OBJECT_SELF);
                    break;
                case 3:
                    lRockThrowStart = GetFlankingLeftLocation(OBJECT_SELF);
                    break;
                default:
                    lRockThrowStart = GetStepLeftLocation(OBJECT_SELF);
                    break;
            }
        }
    }
    else
    {
        lRockThrowStart = GetBehindLocation(OBJECT_SELF);
    }

    return lRockThrowStart;
}



const int OVERRIDE_ATTACK_RESULT_DEFAULT          = 0;
const int OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL   = 1;
const int OVERRIDE_ATTACK_RESULT_PARRIED          = 2;
const int OVERRIDE_ATTACK_RESULT_CRITICAL_HIT     = 3;
const int OVERRIDE_ATTACK_RESULT_MISS             = 4;


// throw rocks using telekinesis, nRockWeight * 25 lb rock is thrown
void DoTKThrowRock(object oSource, object oTarget, int nRockWeight)
{
    int attackMods = GetBaseAttackBonus(OBJECT_SELF) + GetAbilityModifier(ABILITY_CHARISMA);
    int attackRoll = d20();
    int hitResult;
    if (attackRoll == 1)
    {
        hitResult = OVERRIDE_ATTACK_RESULT_MISS;
    }
    else if (attackRoll == 20)
    {
        hitResult = OVERRIDE_ATTACK_RESULT_CRITICAL_HIT;
    }
    else if ((attackRoll + attackMods) >= GetAC(oTarget))
    {
        hitResult = OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL;
    }
    else
    {
        hitResult = OVERRIDE_ATTACK_RESULT_MISS;
    }
    if (hitResult == OVERRIDE_ATTACK_RESULT_CRITICAL_HIT)
    {
        // check immunity and reroll attack
        if (GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT) ||
            ((d20() + attackMods) < GetAC(oTarget)))
        {
            // critical hit missed
            hitResult = OVERRIDE_ATTACK_RESULT_HIT_SUCCESSFUL;
        }
    }
//  Jug_Debug(GetName(OBJECT_SELF) + " throw rock result " + IntToString(hitResult) + " total is " + IntToString(nRockWeight));

    location lRockThrowStart = GetLocation(oSource);
    location lTargetLoc = GetLocation(oTarget);
    vector positionRandom = GetPositionFromLocation(lRockThrowStart);
    positionRandom.x += IntToFloat(Random(100)) / 1000 - 0.1;
    positionRandom.y += IntToFloat(Random(100)) / 1000 - 0.1;
    location lSourceLocRandom = Location(GetArea(oTarget),positionRandom,0.0f);

    AssignCommand( oSource,
                   ActionCastFakeSpellAtObject(SPELL_TRAP_SHURIKEN,
                                           oTarget,
                                           PROJECTILE_PATH_TYPE_HOMING));

//    SpawnItemProjectile(oSource, oTarget, lSourceLocRandom, lTargetLoc,
//        BASE_ITEM_SLING, PROJECTILE_PATH_TYPE_HOMING, hitResult, 0);
    if (hitResult != OVERRIDE_ATTACK_RESULT_MISS)
    {
        int damageAmount = d4(nRockWeight);
        if (hitResult == OVERRIDE_ATTACK_RESULT_CRITICAL_HIT)
        {
            damageAmount *= 2;
        }
        effect eBlunt = EffectDamage(damageAmount, DAMAGE_TYPE_BLUDGEONING);
        float fTravelTime = 1.5; //GetProjectileTravelTime(lSourceLocRandom, lTargetLoc, PROJECTILE_PATH_TYPE_HOMING);
        DelayCommand(fTravelTime, ApplyEffectToObject(DURATION_TYPE_INSTANT, eBlunt, oTarget) );
    }
}


// throw rocks using telekinesis, sizes nTotalWeight * 25 lb rocks
void DoTKThrowRocks(object oSource, object oTarget, int nTotalWeight)
{
    int nTotalWeight = GetBeholderEyeStalkSpellCasterLevel();
    int nCurRock = d4();
    while (nCurRock > 0)
    {
        int nCurRockWeight = nTotalWeight / nCurRock;

        float fDelay = GetRandomDelay(0.75, 1.25);
        DelayCommand(fDelay, DoTKThrowRock(oSource, oTarget, nCurRockWeight));

        nTotalWeight -= nCurRockWeight;
        nCurRock --;
    }
}


// do beholder ray attack, both beam and effects of ray are done
void DoBeholderRayAttack(int nRay, object oTarget, int bCritical)
{
    int     nSave, bSave;
    int     nSaveDC = GetBeholderEyeStalkSpellDC();
    int     nDamage;
    effect  e1, eLink, eVis, eDur /*, eBeam */;

    // BEHOLDER_RAY_USER add custom ray save types
    switch (nRay)
    {
        case BEHOLDER_RAY_DEATH:
        case BEHOLDER_RAY_PETRI:
        case BEHOLDER_RAY_DISINTEGRATE:
        case BEHOLDER_RAY_PARALYSIS:
            nSave = SAVING_THROW_FORT;
            break;

        case BEHOLDER_RAY_DISPEL:
        case BEHOLDER_RAY_SCORCHING:
        case BEHOLDER_RAY_EXHAUSTION:
        case BEHOLDER_RAY_TK_THROW_ROCKS:
        case BEHOLDER_RAY_FROST:
            nSave = -1; // no save
            break;

        default:
            nSave = SAVING_THROW_WILL;
            break;
    }

    if ((nRay == BEHOLDER_RAY_CHARM_PER) && !GetIsHumanoid(GetRacialType(oTarget)))
    {
        bSave = SAVING_THROW_CHECK_IMMUNE;
    }
    else if ((nRay == BEHOLDER_RAY_DAZE) && (!GetIsHumanoid(GetRacialType(oTarget)) || (GetHitDice(oTarget) >= 5)))
    {
        bSave = SAVING_THROW_CHECK_IMMUNE;
    }
    else if ((nRay == BEHOLDER_RAY_TK_THRUST) && (GetAdjustedCreatureSize(oTarget) > CREATURE_SIZE_MEDIUM))
    {
        // can't move more than 325 pounds
        bSave = SAVING_THROW_CHECK_IMMUNE;
    }
    else if ((nRay == BEHOLDER_RAY_CAUSE_FEAR) && (GetHitDice(oTarget) >= 5))
    {
        bSave = SAVING_THROW_CHECK_IMMUNE;
    }
    else
    {
        if (nSave == SAVING_THROW_WILL)
        {
            bSave = WillSave(oTarget, nSaveDC, SAVING_THROW_TYPE_NONE);
        }
        else if (nSave == SAVING_THROW_FORT)
        {
            bSave = FortitudeSave(oTarget, nSaveDC, SAVING_THROW_TYPE_NONE);
        }
    }

    switch (nRay)
    {
        case BEHOLDER_RAY_DEATH:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectDeath(TRUE);
                eVis = EffectVisualEffect(VFX_IMP_DEATH);
                eLink = EffectLinkEffects(e1,eVis);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
            }
            else
            {
                nDamage = d6(3) + GetBeholderEyeStalkSpellCasterLevel();
                if (bCritical)
                {
                    nDamage *= 2;
                }
                e1 = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
                eVis = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
                eLink = EffectLinkEffects(e1,eVis);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget);
            }
            break;

        case BEHOLDER_RAY_TK_THRUST:
            // no matching spell
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectKnockdown();
                eVis = EffectVisualEffect(VFX_IMP_STUN);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,6.0f);
            }
            break;

        // Petrify for one round per SaveDC
        case BEHOLDER_RAY_PETRI:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                DoBeholderPetrify(nSaveDC,OBJECT_SELF, oTarget, SPELL_FLESH_TO_STONE);
            }
            break;

        case BEHOLDER_RAY_CHARM_MON:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectCharmed();
                eVis = EffectVisualEffect(VFX_IMP_CHARM);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,24.0f);
            }
            break;

        case BEHOLDER_RAY_SLOW:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectSlow();
                eVis = EffectVisualEffect(VFX_IMP_SLOW);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,RoundsToSeconds(6));
            }
            break;

        case BEHOLDER_RAY_WOUND:
        case BEHOLDER_RAY_CRITICAL_WOUND:
            nDamage = GetBeholderEyeStalkSpellCasterLevel();
            if (nRay == BEHOLDER_RAY_WOUND)
            {
                if (nDamage > 10)
                {
                    nDamage = 10;
                }
                nDamage += d8(2);
            }
            else
            {
                if (nDamage > 20)
                {
                    nDamage = 20;
                }
                nDamage += d8(4);
            }
            if (bCritical)
            {
                nDamage *= 2;
            }
            if (bSave != SAVING_THROW_CHECK_FAILED)
            {
                // cause serious - save is 1/2
                nDamage /= 2;
            }
            e1 = EffectDamage(nDamage, DAMAGE_TYPE_NEGATIVE);
            eVis = EffectVisualEffect(VFX_COM_BLOOD_REG_RED);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oTarget);
            break;

        case BEHOLDER_RAY_FEAR:
        case BEHOLDER_RAY_CAUSE_FEAR:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectFrightened();
                eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
                eDur = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
                e1 = EffectLinkEffects(eDur,e1);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,RoundsToSeconds(1+d4()));
            }
            break;

        case BEHOLDER_RAY_CHARM_PER:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectCharmed();
                eVis = EffectVisualEffect(VFX_IMP_CHARM);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,e1,oTarget,24.0f);
            }
            break;

        case BEHOLDER_RAY_SLEEP:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                e1 = EffectSleep();
                eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                eDur = EffectLinkEffects(eDur, EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE));
                eVis = EffectVisualEffect(VFX_IMP_SLEEP);
                eDur = EffectLinkEffects(eVis, eDur);

                //ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oLowest);
                if (GetIsImmune(oTarget, IMMUNITY_TYPE_SLEEP, OBJECT_SELF) == FALSE)
                {
                    e1 = EffectLinkEffects(e1, eDur);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e1, oTarget, RoundsToSeconds(1+d4()));
                }
                else
                // * even though I am immune apply just the sleep effect for the immunity message
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, e1, oTarget, RoundsToSeconds(1+d4()));
                }
            }
            break;

        case BEHOLDER_RAY_DISINTEGRATE:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                string nName = GetName(oTarget);
                if (nName == "Mordenkainen's Sword")
                {
                    effect eKill = EffectDamage(GetCurrentHitPoints(oTarget) + 1,DAMAGE_TYPE_MAGICAL,DAMAGE_POWER_NORMAL);
                    eVis = EffectVisualEffect(VFX_IMP_DEATH);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eKill, oTarget);
                    break; // out of case
                }
                nDamage = d6(GetBeholderEyeStalkSpellCasterLevel());
            }
            else
            {
                nDamage = d6(5);
            }
            if (bCritical)
            {
                nDamage *= 2;
            }
            {
                e1 = EffectDamage(nDamage, DAMAGE_TYPE_MAGICAL);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, e1, oTarget);
                if (GetCurrentHitPoints(oTarget) <= 0)
                {
                    // If they are at or below 0 hit points, disintegrate them!
                    eVis = EffectVisualEffect(VFX_IMP_DEATH);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                }
            }
            break;

        case BEHOLDER_RAY_DISPEL:
            {
                eVis = EffectVisualEffect(VFX_IMP_BREACH);
                effect eImpact = EffectVisualEffect(VFX_FNF_DISPEL);
                int nCasterLevel = GetBeholderEyeStalkSpellCasterLevel();
                //--------------------------------------------------------------------------
                // Dispel Magic is capped at caster level 10
                //--------------------------------------------------------------------------
                if (nCasterLevel > 10)
                {
                    nCasterLevel = 10;
                }
//              Jug_Debug(GetName(OBJECT_SELF) + " doing dispel " + IntToString(nCasterLevel));
//                spellsDispelMagic(oTarget, nCasterLevel, eVis, eImpact);

                e1 = EffectDispelMagicAll(nCasterLevel);
 //               ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, e1, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);
            }
            break;

        case BEHOLDER_RAY_SCORCHING:
            nDamage = d6(4);
            if (bCritical)
            {
                nDamage *= 2;
            }
            e1 = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oTarget);
            break;

        case BEHOLDER_RAY_PARALYSIS:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                int nDuration = GetBeholderEyeStalkSpellCasterLevel();
                nDuration = GetScaledDuration(nDuration, oTarget);
                e1 = EffectParalyze();
                eVis = EffectVisualEffect(82);
                eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
                effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);

                eLink = EffectLinkEffects(eDur2, eDur);
                eLink = EffectLinkEffects(eLink, e1);
                eLink = EffectLinkEffects(eLink, eVis);
                eLink = EffectLinkEffects(eLink, eDur3);

                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            }
            break;

        case BEHOLDER_RAY_EXHAUSTION:
            if (bSave == SAVING_THROW_CHECK_FAILED && !GetHasSpellEffect(BEHOLDER_EXHAUSTION_SPELLID , oTarget))
            {
                effect eStrPenalty = EffectAbilityDecrease(ABILITY_STRENGTH, 6);
                effect eDexPenalty = EffectAbilityDecrease(ABILITY_DEXTERITY, 6);
                effect eMovePenalty = EffectMovementSpeedDecrease(50);  // 50% decrease

                eLink = EffectLinkEffects (eStrPenalty, eDexPenalty);
                eLink = EffectLinkEffects(eLink, eMovePenalty);
                eLink = ExtraordinaryEffect(eLink);

                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,TurnsToSeconds(GetBeholderEyeStalkSpellCasterLevel()));
            }
            break;

        case BEHOLDER_RAY_FROST:
            nDamage = d3();
            if (bCritical)
            {
                nDamage *= 2;
            }
            e1 = EffectDamage(nDamage, DAMAGE_TYPE_COLD);
            eVis = EffectVisualEffect(VFX_IMP_FROST_S);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,e1,oTarget);
            // eyeball can't use daze or frost for next 2 rounds
            SuppressUseOfRays(BEHOLDER_RAY_FROST | BEHOLDER_RAY_DAZE, 2);
            break;

        case BEHOLDER_RAY_DAZE:
            if (bSave == SAVING_THROW_CHECK_FAILED)
            {
                effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_NEGATIVE);
                e1 = EffectDazed();
                effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);

                eLink = EffectLinkEffects(eMind, e1);
                eLink = EffectLinkEffects(eLink, eDur);

                eVis = EffectVisualEffect(VFX_IMP_DAZED_S);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oTarget,6.0f);
            }
            // eyeball can't use daze or frost for next 2 rounds
            SuppressUseOfRays(BEHOLDER_RAY_FROST | BEHOLDER_RAY_DAZE, 2);
            break;

        // BEHOLDER_RAY_USER add custom ray effects here
    }
}


// open antimagic eye at target
void OpenAntiMagicEye (object oTarget)
{
    ClearAllActions();

    int bInstant = GetLocalInt(OBJECT_SELF, BEHOLDER_MAIN_EYE_TYPE) != BEHOLDER_MAIN_EYE_STUN;
    int nSpell = bInstant ? BEHOLDER_EYE_SPELLID : SPELLABILITY_GAZE_STUNNED;
    if (GetObjectSeen(oTarget))
    {
        ActionCastSpellAtObject(nSpell , oTarget, METAMAGIC_ANY, TRUE, 0, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
    }
    else
    {
        ActionCastSpellAtLocation(nSpell, GetLocation(oTarget), METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_DEFAULT, bInstant);
    }
}


// being a badass beholder, we close our antimagic eye only to attack with our eye rays
// and then reopen it...
void CloseAntiMagicEye(object oTarget)
{
    RemoveSpellEffects(BEHOLDER_EYE_SPELLID, OBJECT_SELF, oTarget);
}


const float BEHOLDER_BEAM_EFFECT_TIME = 0.33;

void DoBeamEffect(int nRay, object oTarget, int bMiss)
{
    effect  eBeam;

    switch (nRay)
    {
        case BEHOLDER_RAY_DEATH:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FINGER_OF_DEATH, TRUE));
            eBeam = EffectBeam(VFX_BEAM_BLACK, OBJECT_SELF, BODY_NODE_MONSTER_0, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_TK_THRUST:
            // no matching spell
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, BEHOLDER_TK_SPELLID, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_ODD, OBJECT_SELF, BODY_NODE_MONSTER_1, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_TK_THROW_ROCKS:
        {
            location lRockThrowTest = GetBeholderStartThrowRocksLocation(oTarget);
            object oIpoint = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_weathmark", lRockThrowTest);
            location lRockThrowStart = GetLocation(oIpoint);

            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, BEHOLDER_TK_SPELLID, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_ODD, OBJECT_SELF, BODY_NODE_MONSTER_1, FALSE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oIpoint, 1.0 /*BEHOLDER_BEAM_EFFECT_TIME*/);

            DestroyObject(oIpoint, 1.0);

            DoTKThrowRocks(oIpoint, oTarget, GetBeholderEyeStalkSpellCasterLevel());

            break;
        }

        // Petrify for one round per SaveDC
        case BEHOLDER_RAY_PETRI:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FLESH_TO_STONE, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_HOLY, OBJECT_SELF, BODY_NODE_MONSTER_2, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_CHARM_MON:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHARM_MONSTER, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_MONSTER_3, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_SLOW:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLOW, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_COLD, OBJECT_SELF, BODY_NODE_MONSTER_4, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_WOUND:
        case BEHOLDER_RAY_CRITICAL_WOUND:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INFLICT_MODERATE_WOUNDS, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_EVIL, OBJECT_SELF, BODY_NODE_MONSTER_3, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_FEAR:
        case BEHOLDER_RAY_CAUSE_FEAR:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_FEAR, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_MONSTER_0, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_CHARM_PER:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CHARM_PERSON, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_MONSTER_4, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_SLEEP:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SLEEP, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_MONSTER_1, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_DISINTEGRATE:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, BEHOLDER_DISINTEGRATE_SPELLID, TRUE));
            eBeam = EffectBeam(VFX_BEAM_DISINTEGRATE, OBJECT_SELF, BODY_NODE_MONSTER_0, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eBeam, oTarget, BEHOLDER_BEAM_EFFECT_TIME);
            break;

        case BEHOLDER_RAY_DISPEL:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DISPEL_MAGIC, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_ODD, OBJECT_SELF, BODY_NODE_MONSTER_0, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            break;

        case BEHOLDER_RAY_SCORCHING:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 1056, TRUE));
            eBeam = EffectBeam(VFX_BEAM_FIRE, OBJECT_SELF, BODY_NODE_MONSTER_2, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            break;

        case BEHOLDER_RAY_PARALYSIS:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_PERSON, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_MONSTER_4, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            break;

        case BEHOLDER_RAY_EXHAUSTION:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, BEHOLDER_EXHAUSTION_SPELLID, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_EVIL, OBJECT_SELF, BODY_NODE_MONSTER_4, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            break;

         case BEHOLDER_RAY_FROST:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAY_OF_FROST, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_COLD, OBJECT_SELF, BODY_NODE_MONSTER_1, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            break;

        case BEHOLDER_RAY_DAZE:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DAZE, TRUE));
            eBeam = EffectBeam(VFX_BEAM_SILENT_MIND, OBJECT_SELF, BODY_NODE_MONSTER_2, bMiss);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,1.0);
            break;
        // BEHOLDER_RAY_USER add custom ray effects here
    }
}


// try to fire beam at target, checks for ranged touch hit or miss
void DelayedBehFireBeam(int nRay, object oTarget)
{
    if (!GetIsDead(OBJECT_SELF) && !GetIsDisabled(OBJECT_SELF))
    {
        int bHit;
        if (nRay == BEHOLDER_RAY_TK_THROW_ROCKS)
        {
            // no touch attack needed
            bHit = TOUCH_ATTACK_RESULT_HIT;
        }
        else
        {
            bHit = TouchAttackRanged(oTarget, FALSE);
        }

        DoBeamEffect(nRay, oTarget, bHit == TOUCH_ATTACK_RESULT_MISS);

        if (bHit != TOUCH_ATTACK_RESULT_MISS)
        {
//            Jug_Debug(GetName(OBJECT_SELF) + " hit ray " + IntToHexString(nRay) + " on " + GetName(oTarget));
            DelayCommand(0.15, DoBeholderRayAttack(nRay, oTarget, (bHit == TOUCH_ATTACK_RESULT_CRITICAL) &&
                !GetIsImmune(oTarget, IMMUNITY_TYPE_CRITICAL_HIT)));
        }
    }
}



float fCurRayDelay;

// fire beam at target, delay is done so all eyestalk rays don't fire at once
void BehDoFireBeam(int nRay, object oTarget)
{
//    Jug_Debug(GetName(OBJECT_SELF) + " fire ray " + IntToHexString(nRay) + " on " + GetName(oTarget));
    DelayCommand(fCurRayDelay, DelayedBehFireBeam(nRay, oTarget));
    fCurRayDelay += 0.35;
}