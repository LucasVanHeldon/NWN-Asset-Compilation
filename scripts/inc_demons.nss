#include "nw_i0_plot"
#include "nw_i0_spells"

#include "inc_ai"
#include "inc_magic"

int DEMON_UnholyBlight(object oTarget = OBJECT_INVALID)
{
    SendMessageToPC(GetFirstPC(),"Unholy Blight");

    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);


    int alignment = GetAlignmentGoodEvil(oTarget);
    if( alignment != ALIGNMENT_EVIL && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {

        int nHD = GetHitDice(OBJECT_SELF);
        if(nHD > 10) nHD = 10;
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        effect eDmg = EffectDamage(d8(nHD));
        effect eDaze = EffectDazed();
        effect eBeam = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_HAND);
        effect eLink = EffectLinkEffects(eVis,eDmg);
        effect eLink2 = EffectLinkEffects(eDaze,eLink);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0);
        if(!MySavingThrow(SAVING_THROW_WILL,oTarget,19))
        {
            ClearAllActions(TRUE);

            DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink2, oTarget, RoundsToSeconds(d4())));

            return TRUE;
        }
    }
    return FALSE;
}

int DEMON_ChaosHammer(object oTarget = OBJECT_INVALID)
{
    SendMessageToPC(GetFirstPC(),"Chaos Hammer");
    if(!GetIsObjectValid(oTarget))
        oTarget = FindWeakestEnemy(OBJECT_SELF);

    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    int nAlignment = GetAlignmentLawChaos(oTarget);
    if(nAlignment != ALIGNMENT_CHAOTIC && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        int cha = GetCharisma(oTarget);
        int nD20 = d20();
        if( (nD20+cha) < 19)
        {
            int nHD = GetHitDice(OBJECT_SELF);
            if(nHD > 10) nHD = 10;
            effect eHammer = EffectVisualEffect(VFX_IMP_HARM);
            effect eDmg = EffectDamage(d8(nHD));
            effect eLink = EffectLinkEffects(eDmg,eHammer);

            ClearAllActions(TRUE);
            ActionCastFakeSpellAtObject(SPELL_HAMMER_OF_THE_GODS, oTarget);
            DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
            return TRUE;
        }
    }
    return FALSE;
}

int DEMON_UnholyBlight2(object oTarget = OBJECT_INVALID)
{

    SendMessageToPC(GetFirstPC(),"Unholy Blight2");
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    int alignment = GetAlignmentGoodEvil(oTarget);
    if( alignment != ALIGNMENT_EVIL && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {

        int nHD = GetHitDice(OBJECT_SELF);
        if(nHD > 10) nHD = 10;
        effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
        effect eDmg = EffectDamage(d8(nHD));
        effect eDaze = EffectDazed();
        effect eLink = EffectLinkEffects(eVis,eDmg);
        effect eLink2 = EffectLinkEffects(eDaze,eLink);
        effect eBeam = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_HAND);

        ClearAllActions(TRUE);

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0);
        if(!MySavingThrow(SAVING_THROW_WILL,oTarget,19))
        {
            DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink2, oTarget, RoundsToSeconds(d4())));
        }
        return TRUE;
    }
    return FALSE;
}

int DEMON_ChaosHammer2(object oTarget)
{
    SendMessageToPC(GetFirstPC(),"Chaos Hammer2");
    int nAlignment = GetAlignmentLawChaos(oTarget);

    if(!GetIsObjectValid(oTarget))
         oTarget = PickEnemy(OBJECT_SELF);

    if(nAlignment != ALIGNMENT_CHAOTIC && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        int cha = GetCharisma(oTarget);
        int nD20 = d20();
        if( (nD20+cha) < 19)
        {
            int nHD = GetHitDice(OBJECT_SELF);
            if(nHD > 10) nHD = 10;

            effect eHammer = EffectVisualEffect(VFX_IMP_HARM);
            effect eDmg = EffectDamage(d8(nHD));
            effect eLink = EffectLinkEffects(eDmg,eHammer);
            effect eBeam = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_HAND);

            ClearAllActions(TRUE);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0);
            DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
            return TRUE;
        }

    }
    return FALSE;
}


void DEMON_Blasphemy()
{
    int nBlasphemy = GetLocalInt(OBJECT_SELF,"nBlasphemy");
    if(nBlasphemy < 3)
    {
        object oHit = GetFirstObjectInShape(SHAPE_SPHERE,40.0,GetLocation(OBJECT_SELF));
        effect eVis = EffectVisualEffect(VFX_FNF_IMPLOSION);
        effect eDaze = EffectDazed();
        effect eWeakened = EffectAbilityDecrease(ABILITY_STRENGTH,d4()+2);
        effect eParalyzed = EffectParalyze();
        effect eDeath = EffectDeath();
        effect eLink;

        ClearAllActions(TRUE);
        ActionCastFakeSpellAtLocation(SPELL_POWER_WORD_KILL,GetLocation(OBJECT_SELF));

        nBlasphemy = nBlasphemy + 1;
        SetLocalInt(OBJECT_SELF,"nBlasphemy",nBlasphemy);

        while(GetIsObjectValid(oHit))
        {
            int nAlignment = GetAlignmentGoodEvil(oHit);
            if(nAlignment != ALIGNMENT_EVIL && GetIsEnemy(oHit) && GetCurrentHitPoints(oHit) > 0)
            {
                int nHD = GetHitDice(oHit);
                int nMyHD = GetHitDice(OBJECT_SELF);

                if(nHD > nMyHD)
                {
                    oHit = GetNextObjectInShape(SHAPE_SPHERE,40.0,GetLocation(OBJECT_SELF));
                    continue;
                }

                if(nHD == nMyHD)
                {
                     eLink = EffectLinkEffects(eVis,eDaze);
                     ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oHit,RoundsToSeconds(d3()));
                }
                if(nHD <= (nMyHD - 10) )
                {
                    eLink = EffectLinkEffects(eVis,eDeath);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oHit);
                }
                if(nHD <= (nMyHD - 1) )
                {
                    eLink = EffectLinkEffects(eVis,eWeakened);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oHit,RoundsToSeconds(d4(2)));
                }
                if(nHD <= (nMyHD - 5) )
                {
                    eLink = EffectLinkEffects(eVis,eParalyzed);
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oHit,IntToFloat(d10()*60));
                }
            }
            oHit = GetNextObjectInShape(SHAPE_SPHERE,40.0,GetLocation(OBJECT_SELF));
        }
    }
}

void DEMON_CharmPerson(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CHARMED);

    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        if(!GetHasEffect(EFFECT_TYPE_CHARMED,oTarget))
        {
            ClearAllActions(TRUE);
            ActionCastSpellAtObject(SPELL_CHARM_PERSON,oTarget,METAMAGIC_ANY,TRUE);
        }
    }
}

void DEMON_Confusion(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);

    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && !GetHasEffect(EFFECT_TYPE_CONFUSED,oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CONFUSION,oTarget,METAMAGIC_ANY,TRUE);
    }
}



object FindRangedEnemy(object oSelf = OBJECT_SELF)
{
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE,15.0,GetLocation(oSelf));
    while(GetIsObjectValid(oNear))
    {
        if( GetIsEnemy(oNear) && CanSeeObject(oNear) )
        {
            object oWeapon =  GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oNear);
            if(GetWeaponRanged(oWeapon)) return oNear;
        }
        oNear = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oSelf));
    }
    return OBJECT_INVALID;
}

int DEMON_TeleportAttack(object oTarget, object oSelf=OBJECT_SELF)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetDistanceToObject(oTarget) > 3.0)
    {
        if(d6() < 4)
        {
           object oTarget2 = FindStrongestEnemy(oSelf);
           if(GetIsObjectValid(oTarget2)) oTarget = oTarget2;
        }
        if(GetIsObjectValid(oTarget))
        {
            ClearAllActions(TRUE);
            AssignCommand(oSelf,JumpToLocation(GetLocation(oTarget)));
            return TRUE;
        }
    }
    return FALSE;
}

int DEMON_DarkenRanged()
{
    object oTarget = FindRangedEnemy();

    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget))
    {
        if(!GetHasEffect(EFFECT_TYPE_DARKNESS,oTarget))
        {
            ClearAllActions(TRUE);
            ActionCastSpellAtObject(SPELL_DARKNESS,oTarget,METAMAGIC_ANY,TRUE);
            return TRUE;
        }
    }
    return FALSE;
}

int DEMON_Darkness(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(!GetHasEffect(EFFECT_TYPE_DARKNESS,oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtLocation(SPELL_DARKNESS,GetLocation(oTarget),METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    else
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtLocation(SPELL_DARKNESS,GetLocation(OBJECT_SELF),METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    return FALSE;
}

object FindSpellCasterEnemy(object oSelf = OBJECT_SELF)
{
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE,15.0,GetLocation(oSelf));

    while(GetIsObjectValid(oNear))
    {
        if( GetIsEnemy(oNear) && CanSeeObject(oNear) )
        {
            if(GetCasterLevel(oNear) > 0) return oNear;
        }
        oNear = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oSelf));
    }
    return OBJECT_INVALID;
}


int DEMON_DispelSpellCaster(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindSpellCasterEnemy();

    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DISPEL_MAGIC,oTarget,METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    return FALSE;
}

void DEMON_DoTeleport()
{
    switch(d3())
    {
    case 1:
         SendMessageToPC(GetFirstPC(),"Teleport Strongest");
         DEMON_TeleportAttack(FindStrongestEnemy());
         break;
    case 2:
         SendMessageToPC(GetFirstPC(),"Teleport Spellcaster");
         DEMON_TeleportAttack(FindSpellCasterEnemy());
         break;
    case 3:
         SendMessageToPC(GetFirstPC(),"Teleport Ranged");
         DEMON_TeleportAttack(FindRangedEnemy());
         break;
    }
}

int ScoreDarken(object oTarget)
{

    int score = 0;
    if(IsMagicUser(oTarget)) score = score+4;
    if(IsRanged(oTarget)) score=score+5;
    if(IsFighter(oTarget)) score=score+3;
    if(IsCleric(oTarget)) score=score+4;
    return score;
}

void DEMON_CastDarkness()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int maxScore = 0;
    object bestTarget = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0 && !GetHasEffect(EFFECT_TYPE_DARKNESS,oTarget))
        {
            int score = ScoreDarken(oTarget);
            if(score > maxScore)
            {
                maxScore = score;
                bestTarget = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(bestTarget))
        DEMON_Darkness(bestTarget);
}

int ScoreTeleport(object oTarget)
{
    float D = GetDistanceToObject(oTarget);
    int score = FloatToInt(D);
    if(IsMagicUser(oTarget)) score = score+5;
    if(IsRanged(oTarget)) score=score+5;
    if(IsCleric(oTarget)) score=score+5;
    return score;
}


void DEMON_Teleport()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int maxScore = 0;
    object bestTarget = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0 )
        {
            int score = ScoreTeleport(oTarget);
            if(score > maxScore)
            {
                maxScore = score;
                bestTarget = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(bestTarget))
        DEMON_TeleportAttack(bestTarget);
}


int DEMON_DominateMonster(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_DOMINATED);

    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DOMINATE_MONSTER,oTarget,METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    return FALSE;
}

int DEMON_Insanity(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastFakeSpellAtObject(SPELL_DOMINATE_MONSTER,oTarget);
        effect eConfus = EffectConfused();
        eConfus = ExtraordinaryEffect(eConfus);
        if(!WillSave(oTarget, 25, SAVING_THROW_TYPE_MIND_SPELLS))
        {
            DelayCommand(1.0,
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,eConfus,oTarget));
        }
        return TRUE;
    }
    return FALSE;
}

// it really should search for something to dispel
// but it is a lot of effort to go through all effects
// to determine them.
void DEMON_GreaterDispel(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,oTarget,METAMAGIC_ANY,TRUE);
}

int DEMON_PowerWordStun(object oTarget=OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_STUNNED);

    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DOMINATE_MONSTER,oTarget,METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    return FALSE;
}

int ScoreUnholyBlight(object oTarget)
{
    int alignment = GetAlignmentGoodEvil(oTarget);
    int score = 0;
    if(!GetIsEnemy(oTarget)) return 0;
    if(GetIsEnemy(oTarget)) score = score + 3;
    if(alignment != ALIGNMENT_EVIL) score = score + 10;
    if(alignment == ALIGNMENT_NEUTRAL) score = score + 1;
    if(GetCurrentHitPoints(oTarget) > 0)
        score = score + 1;
    if(GetCurrentHitPoints(oTarget) > 0 &&
        GetCurrentHitPoints(oTarget) < 20) score = score + 10;
    return score;
}

void DEMON_DoCastUnholyBlight(object oTarget)
{
    ClearAllActions(TRUE);
    effect eVis = EffectVisualEffect(VFX_IMP_DEATH);
    effect eDmg = EffectDamage(d8(5));
    effect eDaze = EffectDazed();
    effect eLink = EffectLinkEffects(eVis,eDmg);
    effect eLink2 = EffectLinkEffects(eDaze,eLink);
    effect eBeam = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_HAND);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0);
    if(!MySavingThrow(SAVING_THROW_WILL,oTarget,19))
    {
        DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink2, oTarget, RoundsToSeconds(d4())));
    }
}

void DEMON_CastUnholyBlight()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            int n = ScoreUnholyBlight(oTarget);
            if(n > score)
            {
                score = n;
                oBest = oTarget;
            }

        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest)&& GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        DEMON_DoCastUnholyBlight(oBest);
    }
}

int ScoreChaosHammer(object oTarget)
{
    int alignment = GetAlignmentGoodEvil(oTarget);
    int score = 0;
    if(!GetIsEnemy(oTarget)) return 0;
    if(GetIsEnemy(oTarget)) score = score + 3;
    if(alignment != ALIGNMENT_EVIL) score = score + 1;
    if(alignment != ALIGNMENT_CHAOTIC) score = score + 10;
    if(GetCurrentHitPoints(oTarget) > 0)
        score = score + 1;
    if(GetCurrentHitPoints(oTarget) > 0 &&
        GetCurrentHitPoints(oTarget) < 20) score = score + 10;
    return score;
}

void DEMON_DoCastChaosHammer(object oTarget)
{
    int cha = GetCharisma(oTarget);
    int nD20 = d20();
    if( (nD20+cha) < 19 )
    {
        effect eHammer = EffectVisualEffect(VFX_IMP_HARM);
        effect eDmg = EffectDamage(d8(5));
        effect eLink = EffectLinkEffects(eDmg,eHammer);
        effect eBeam = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_HAND);

        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eBeam,oTarget,2.0);
        DelayCommand(2.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,oTarget));
    }
}

void DEMON_CastChaosHammer()
{
    SendMessageToPC(GetFirstPC(),"Casting Chaos Hammer");
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            int n = ScoreChaosHammer(oTarget);
            if(n > score)
            {
                score = n;
                oBest = oTarget;
            }

        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest)  && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        DEMON_DoCastChaosHammer(oBest);
    }
}

int ScoreConfusion(object oTarget)
{
    int score = 0;
    if(!GetIsEnemy(oTarget)) return 0;
    if(GetCurrentHitPoints(oTarget) > 0) score = score + 1;
    if(GetIsEnemy(oTarget)) score = score + 5;
    if(!GetHasEffect(EFFECT_TYPE_CONFUSED,oTarget)) score = score + 10;
    if(IsMagicUser(oTarget)) score = score + 7;
    if(IsCleric(oTarget)) score = score + 9;
    if(IsFighter(oTarget) && GetDistanceToObject(oTarget) < 3.0) score = score + 5;
    if(IsRanged(oTarget)) score = score + 1;
    return score;
}

void DEMON_CastConfusion()
{

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreConfusion(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest)  && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CONFUSION,oBest,METAMAGIC_ANY,TRUE);
    }
}

int ScoreDispelMagic(object oTarget)
{
    int score = 0;
    if(IsMagicUser(oTarget)) score = score + 10;
    if(IsCleric(oTarget)) score = score + 10;
    effect eEff = GetFirstEffect(oTarget);

    if(!GetIsEnemy(oTarget)) return 0;

    while(GetIsEffectValid(eEff))
    {
         int nType = GetEffectType(eEff);
         switch(nType)
         {
         case EFFECT_TYPE_AC_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_ATTACK_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_CONCEALMENT: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_REDUCTION: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_RESISTANCE: score = score + 1; break;
         case EFFECT_TYPE_DISPELMAGICALL: score = score + 5; break;
         case EFFECT_TYPE_DISPELMAGICBEST: score = score + 5; break;
         case EFFECT_TYPE_ELEMENTALSHIELD: score = score + 1; break;
         case EFFECT_TYPE_ETHEREAL: score = score + 1; break;
         case EFFECT_TYPE_HASTE: score = score + 1; break;
         case EFFECT_TYPE_IMMUNITY: score = score + 1; break;
         case EFFECT_TYPE_IMPROVEDINVISIBILITY: score = score + 1; break;
         case EFFECT_TYPE_INVISIBILITY: score = score + 1; break;
         case EFFECT_TYPE_INVULNERABLE: score = score + 5; break;
         case EFFECT_TYPE_MOVEMENT_SPEED_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_POLYMORPH: score = score + 1; break;
         case EFFECT_TYPE_REGENERATE: score = score + 1; break;
         case EFFECT_TYPE_SANCTUARY: score = score + 2; break;
         case EFFECT_TYPE_SAVING_THROW_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_SEEINVISIBLE: score = score + 1; break;
         case EFFECT_TYPE_SPELL_IMMUNITY: score = score + 2; break;
         case EFFECT_TYPE_SPELL_RESISTANCE_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_SPELLLEVELABSORPTION: score = score + 4; break;
         case EFFECT_TYPE_TRUESEEING: score = score + 1; break;
         case EFFECT_TYPE_ULTRAVISION: score = score + 1; break;
        }
        eEff = GetNextEffect(oTarget);
    }
    return score;
}

void DEMON_CastDispelMagic()
{

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreDispelMagic(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest)  && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0 && oBest != OBJECT_SELF)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DISPEL_MAGIC,oBest,METAMAGIC_ANY,TRUE);
    }
}

void DEMON_CastGreaterDispel()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreDispelMagic(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest) && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0 && oBest != OBJECT_SELF)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,oBest,METAMAGIC_ANY,TRUE);
    }
}

int ScoreCharm(object oTarget)
{

    int score = 0;
    if(!GetHasEffect(EFFECT_TYPE_CHARMED,oTarget))
        score = score + 5;
    if(IsMagicUser(oTarget)) score = score+4;
    if(IsRanged(oTarget)) score=score+5;
    if(IsFighter(oTarget)) score=score+3;
    if(IsCleric(oTarget)) score=score+4;
    return score;
}

void DEMON_CastCharmPerson()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int maxScore = 0;
    object bestTarget = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0 && !GetHasEffect(EFFECT_TYPE_DARKNESS,oTarget))
        {
            int score = ScoreDarken(oTarget);
            if(score > maxScore)
            {
                maxScore = score;
                bestTarget = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(bestTarget))
        DEMON_CharmPerson(bestTarget);
}

int ScoreHoldPerson(object oTarget)
{
    int score = 0;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(!GetHasEffect(EFFECT_TYPE_PARALYZE,oTarget)) score = score + 1;
    if(GetDistanceToObject(oTarget) < 3.0) score = score + 1;
    if(FindStrongestEnemy(OBJECT_SELF) == oTarget) score = score + 1;
    return score;
}

void DEMON_CastHoldPerson()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreHoldPerson(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_HOLD_PERSON,oBest,METAMAGIC_ANY,TRUE);
    }
}

int ScoreFeebleMind(object oTarget)
{
    int score = 10;
    if(GetDistanceToObject(oTarget) > 3.0) score = score + 1;
    if(IsMagicUser(oTarget)) score = score + 1;
    return score;
}

void DEMON_CastFeebleMind()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    SendMessageToPC(GetFirstPC(),"Feeble Mind");
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            int n = ScoreFeebleMind(oTarget);
            if(n > score)
            {
                score = n;
                oBest = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FEEBLEMIND,oBest,METAMAGIC_ANY,TRUE);
    }
}

int ScoreCallLightning(object oTarget)
{
    int score = 10;
    int nHP = GetCurrentHitPoints(oTarget);
    if(nHP > 0) score = score + 1;
    if(nHP > 0 && nHP < 20) score = score + 1;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(GetDistanceToObject(oTarget) > 3.0) score = score + 1;
    return score;
}



void DEMON_CastCallLightning()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 15;
    object oBest = OBJECT_INVALID;

    SendMessageToPC(GetFirstPC(),"Call Lightning");
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            int n = ScoreCallLightning(oTarget);
            if(n > score)
            {
                score = n;
                oBest = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CALL_LIGHTNING,oBest,METAMAGIC_ANY,TRUE);
    }
}


int ScoreSlow(object oTarget)
{
    int score = 0;
    if(GetDistanceToObject(oTarget) > 3.0) score = score + 1;
    if(!GetHasEffect(EFFECT_TYPE_SLOW,oTarget)) score = score + 1;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(IsFighter(oTarget)) score = score + 1;
    if(IsCleric(oTarget)) score = score + 1;
    return score;
}

void DEMON_CastSlow()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    SendMessageToPC(GetFirstPC(),"Slow");
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            int n = ScoreSlow(oTarget);
            if(n > score)
            {
                score = n;
                oBest = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SLOW,oBest,METAMAGIC_ANY,TRUE);
    }
}

void SmiteImplode(object oSelf)
{
    effect eVis = EffectVisualEffect(VFX_FNF_IMPLOSION);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oSelf,2.0);
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oSelf));
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            effect eDaze = EffectDazed();
            eDaze = ExtraordinaryEffect(eDaze);
            if(!WillSave(oTarget,22,SAVING_THROW_TYPE_MIND_SPELLS))
            {
                effect eVis2 = EffectVisualEffect(VFX_IMP_DAZED_S);
                eDaze = EffectLinkEffects(eVis2,eDaze);
                float time = RoundsToSeconds(d10());
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDaze,oTarget,time);

            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(oSelf));
    }
}

int ScoreSmite(object oTarget)
{
    int score = 20;
    int nHP = GetCurrentHitPoints(oTarget);
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(nHP > 0) score = score + 1;
    if(nHP > 0 && nHP < 20) score = score + 1;
    if(GetDistanceToObject(oTarget) < 20.0) score = score + 1;
    if(GetDistanceToObject(oTarget) < 10.0) score = score + 1;

    return score;
}

void DEMON_Smite(object oTarget)
{
    int nSmite = GetLocalInt(OBJECT_SELF,"nSmite");
    if(nSmite < 3)
    {
        effect eVis = EffectVisualEffect(VFX_FNF_DECK);
        ClearAllActions(TRUE);
        ActionCastFakeSpellAtLocation(SPELL_DIVINE_MIGHT,GetLocation(OBJECT_SELF));

        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis,OBJECT_SELF);
        nSmite = nSmite + 1;
        SetLocalInt(OBJECT_SELF,"nSmite",nSmite);

        if(!WillSave(oTarget,22,SAVING_THROW_TYPE_EVIL))
        {
            DelayCommand(2.0,SmiteImplode(OBJECT_SELF));
        }
    }
}

void DEMON_CastSmite()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    SendMessageToPC(GetFirstPC(),"Smite");
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget))
        {
            int n = ScoreSmite(oTarget);
            if(n > score)
            {
                score = n;
                oBest = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        DEMON_Smite(oBest);
    }
}

int ScoreLightningBolt(object oTarget)
{
    int score = 0;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(GetDistanceToObject(oTarget) < 3.0) score = score + 1;
    int nHP = GetCurrentHitPoints(oTarget);
    if(nHP > 0 && nHP < 20) score = score + 2;
    if(nHP > 0) score = score + 1;
    score = score + GetTotalEnemiesInSphere(GetLocation(oTarget),5.0);
    return score;
}

void DEMON_CastLightningBolt()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreLightningBolt(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LIGHTNING_BOLT,oBest,METAMAGIC_ANY,TRUE);
    }
}

int ScoreBlindness(object oTarget)
{
    int score = 0;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(!GetHasEffect(EFFECT_TYPE_BLINDNESS,oTarget)) score = score + 1;
    if(GetDistanceToObject(oTarget) < 3.0) score = score + 1;
    if(IsFighter(oTarget)) score = score + 2;
    if(IsCleric(oTarget)) score = score + 1;

    return score;
}

void DEMON_CastCauseBlindness()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreBlindness(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS,oBest,METAMAGIC_ANY,TRUE);
    }
}


void DEMON_AnimateObjects()
{
    int nNum = d4();
    int i;
    for(i = 0; i < 4; i++)
    {
        string bp = "ZEP_ANIMTOME1";
        switch(d10())
        {
        case 1: bp = "ZEP_ANIMTABLE"; break;
        case 2: bp = "ZEP_ANIMTOME1"; break;
        case 3: bp = "ZEP_ANIMTOME2"; break;
        case 4: bp = "ZEP_ANIMTOME3"; break;
        case 5: bp = "ZEP_ANIMTOME4"; break;
        case 6: bp = "ZEP_ANIMTOME5"; break;
        case 7: bp = "ZEP_ANIMTOME6"; break;
        case 8: bp = "ZEP_ANIMWHEEL"; break;
        case 9:
        default:
            bp = "ZEP_ANIMCHEST";
        }
        EffectSummonCreature(bp,VFX_FNF_SUMMON_MONSTER_1,1.0);
    }
}

void DoBlink(object oSelf)
{
    int nBlink = GetLocalInt(OBJECT_SELF,"nBlink");
    if(nBlink < 10)
    {
        SetLocalInt(OBJECT_SELF,"nBlink",nBlink+1);
        vector upos = GetPosition(oSelf);
        vector new;
        float x = IntToFloat(Random(15));
        if(d6() < 4) x = x * -1.0;
        float y = IntToFloat(Random(15));
        if(d6() < 4) y = y * -1.0;

        new.x = upos.x +  x;
        new.y = upos.y + y;
        new.z = upos.z;

        location lLoc = Location(GetArea(oSelf),new,GetFacing(oSelf));
        ClearAllActions(TRUE);
        AssignCommand(oSelf,JumpToLocation(lLoc));
        DelayCommand(1.0,DoBlink(oSelf));
    }
}

void DEMON_Blink()
{
    DoBlink(OBJECT_SELF);
}


