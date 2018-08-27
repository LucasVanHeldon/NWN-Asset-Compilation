void PSYCHIC_MindBlast()
{
    int nHD = GetHitDice(OBJECT_SELF);
    object oC = GetFirstObjectInShape(SHAPE_CONE,15.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && GetCurrentHitPoints(oC) > 0)
        {
            if(!WillSave(oC,10+nHD+GetAbilityModifier(ABILITY_INTELLIGENCE)))
            {
                effect eDom = EffectDominated();
                effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,eDom),oC,RoundsToSeconds(d6()));
            }
        }
        oC = GetNextObjectInShape(SHAPE_CONE,15.0,GetLocation(OBJECT_SELF));
    }
}

void PSYCHIC_MindCrush(object oTarget = OBJECT_INVALID)
{
    int nHD = GetHitDice(OBJECT_SELF);
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,25.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC) && GetCurrentHitPoints(oC) > 0)
        {
            if(!WillSave(oC,10+nHD+GetAbilityModifier(ABILITY_INTELLIGENCE)))
            {
                effect eDom = EffectDominated();
                effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,eDom),oC,RoundsToSeconds(d6(2)));
            }
        }
        oC = GetNextObjectInShape(SHAPE_CONE,15.0,GetLocation(OBJECT_SELF));
    }
}

void PSYCHIC_Strength()
{
    int nAmt = d4();
    effect ePwr = EffectAbilityIncrease(ABILITY_STRENGTH,nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PSYCHIC_Dexterity()
{
    int nAmt = d4();
    effect ePwr = EffectAbilityIncrease(ABILITY_DEXTERITY,nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DOMINATED);
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));

}

void PSYCHIC_Constitution()
{
    int nAmt = d4();
    effect ePwr = EffectAbilityIncrease(ABILITY_CONSTITUTION,nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PSYCHIC_Will()
{
    int nAmt = d4();
    effect ePwr = EffectAbilityIncrease(ABILITY_WISDOM,nAmt);
    ePwr = EffectLinkEffects(EffectAbilityIncrease(ABILITY_INTELLIGENCE,nAmt),ePwr);
    ePwr = EffectLinkEffects(EffectAbilityIncrease(ABILITY_CHARISMA,nAmt),ePwr);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));

}

void PSYCHIC_Vulnerability(object oTarget = OBJECT_INVALID)
{
    int nAmt = d4();
    int nHD = GetHitDice(OBJECT_SELF);
    if(!GetIsObjectValid(oTarget)) oTarget = FindStrongestEnemy(OBJECT_SELF);

    effect ePwr = EffectACDecrease(nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_WISDOM)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}


void PSYCHIC_MindOverBody()
{
    int nAmt = d4();
    effect ePwr = EffectACIncrease(nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PSYCHIC_MindOverMatter()
{
    int nAmt = d4();
    effect ePwr = EffectDamageImmunityIncrease(DAMAGE_TYPE_BLUDGEONING,10);
    ePwr = EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_SLASHING,10),ePwr);
    ePwr = EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_PIERCING,10),ePwr);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_INTELLIGENCE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PSYCHIC_MindOverReality()
{
    int nAmt = d4();
    effect ePwr = EffectDamageImmunityIncrease(DAMAGE_TYPE_ACID,10);
    ePwr = EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_FIRE,10),ePwr);
    ePwr = EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,10),ePwr);
    ePwr = EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_SONIC,10),ePwr);
    ePwr = EffectLinkEffects(EffectDamageImmunityIncrease(DAMAGE_TYPE_ELECTRICAL,10),ePwr);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_INTELLIGENCE);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PSYCHIC_ReducePower(object oTarget = OBJECT_INVALID)
{
    int nAmt = d4();
    int nHD = GetHitDice(OBJECT_SELF);
    if(!GetIsObjectValid(oTarget)) oTarget = FindStrongestEnemy(OBJECT_SELF);

    effect ePwr = EffectAttackDecrease(nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_WISDOM)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}



void PSYCHIC_IncreasePower()
{
    int nAmt = d4();
    effect ePwr = EffectAttackIncrease(nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}


void PSYCHIC_Paralysis(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_DOMINATED);
    }
    int nHD = GetHitDice(OBJECT_SELF);


    effect ePwr = EffectParalyze();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Charm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CHARMED);
    }
    int nHD = GetHitDice(OBJECT_SELF);


    effect ePwr = EffectCharmed();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!WillSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Concealment()
{
    effect ePwr = EffectConcealment(50+10*GetAbilityModifier(ABILITY_INTELLIGENCE));
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );

    int nDur = d4()+GetAbilityModifier(ABILITY_INTELLIGENCE);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PYSCHIC_Enervation(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_DOMINATED);
    }

    int nHD = GetHitDice(OBJECT_SELF);
    effect ePwr = EffectDeath();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);

    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectLinkEffects(eVis,ePwr),OBJECT_SELF);
    }
}

void PSYCHIC_Confusion(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);


    effect ePwr = EffectConfused();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!WillSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_WISDOM)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Cripple(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);


    effect ePwr = EffectCurse(d4(),d4(),d4(),d4(),d4(),d4());
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!WillSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_WISDOM)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_EgoWhip(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectDamage(d6(nAmt));
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Shield()
{
   int nAmt = d4();
    effect ePwr = EffectDamageShield(d4()+GetAbilityModifier(ABILITY_INTELLIGENCE),d4()+GetAbilityModifier(ABILITY_CHARISMA),DAMAGE_TYPE_SONIC);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}


void PSYCHIC_Daze(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectDazed();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!WillSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Deafness(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectDeaf();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Contagion(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectDisease(d20());
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}


void PSYCHIC_Adhesive(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectEntangle();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}


void PSYCHIC_Frighten(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectFrightened();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}


void PSYCHIC_Haste()
{
    effect ePwr = EffectHaste();
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}


void PSYCHIC_Speed()
{
    effect ePwr = EffectMovementSpeedIncrease(10);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}

void PSYCHIC_Entomb(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectPetrify();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}

void PSYCHIC_Enervation(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectDeath();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}


void PSYCHIC_Regeneration()
{
    int nAmt = GetAbilityModifier(ABILITY_INTELLIGENCE)+1;
    effect ePwr = EffectRegenerate(nAmt,1.0);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}


void PSYCHIC_BeatTheOdds()
{
    int nAmt = GetAbilityModifier(ABILITY_INTELLIGENCE)+1;
    effect ePwr = EffectSavingThrowIncrease(SAVING_THROW_ALL,nAmt);
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}


void PSYCHIC_DetectInvisibility()
{
    int nAmt = GetAbilityModifier(ABILITY_INTELLIGENCE)+1;
    effect ePwr = EffectSeeInvisible();
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
}


void PSYCHIC_Silence(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
    {
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_CONFUSED);
    }
    int nHD = GetHitDice(OBJECT_SELF);
    int nAmt = nHD;
    if(nAmt > 10) nAmt = 10;
    effect ePwr = EffectSilence();
    effect eVis = EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_POSITIVE );
    eVis = EffectLinkEffects(eVis2,eVis);
    if(!FortitudeSave(oTarget,10+nHD+GetAbilityModifier(ABILITY_CHARISMA)))
    {
        int nDur = d4()+GetAbilityModifier(ABILITY_CHARISMA);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectLinkEffects(eVis,ePwr),OBJECT_SELF,RoundsToSeconds(nDur));
    }
}


int PSYCHIC_SpecialAttack(int nPoints)
{
   if(nPoints > 9 && d6() < 3)
    {
        PSYCHIC_Enervation();
        return 10;
    }

   if(nPoints > 9 && d6() < 3)
    {
        PSYCHIC_Entomb();
        return 10;
    }

    if(nPoints > 9  && d6() < 3)
    {
        PSYCHIC_MindCrush();
        return 10;
    }
    if(nPoints > 8 && d6() < 3)
    {
        PSYCHIC_EgoWhip();
        return 9;
    }
    if(nPoints > 7 && d6() < 3)
    {
        PSYCHIC_Regeneration();
        return 8;
    }

   if(nPoints > 6 && d6() < 3)
    {
        PSYCHIC_Shield();
        return 7;
    }

   if(nPoints > 6 && d6() < 3)
    {
        PSYCHIC_Cripple();
        return 7;
    }

   if(nPoints > 6 && d6() < 3)
    {
        PSYCHIC_Contagion();
        return 7;
    }

   if(nPoints > 6 && d6() < 3)
    {
        PSYCHIC_Confusion();
        return 7;
    }

   if(nPoints > 5 && d6() < 3)
    {
        PSYCHIC_Concealment();
        return 6;
    }

   if(nPoints > 5 && d6() < 3)
    {
        PSYCHIC_Paralysis();
        return 6;
    }

   if(nPoints > 4 && d6() < 3)
    {
        PSYCHIC_Deafness();
        return 5;
    }

   if(nPoints > 4 && d6() < 3)
    {
        PSYCHIC_Adhesive();
        return 5;
    }

   if(nPoints > 4 && d6() < 3)
    {
        PSYCHIC_Will();
        return 5;
    }
   if(nPoints > 4 && d6() < 3)
    {
        PSYCHIC_MindOverMatter();
        return 5;
    }
   if(nPoints > 4 && d6() < 3)
    {
        PSYCHIC_MindOverReality();
        return 5;
    }
  if(nPoints > 4 && d6() < 3)
   {
        PSYCHIC_MindOverBody();
        return 5;
   }
   if(nPoints > 3 && d6() < 3)
   {
        PSYCHIC_Silence();
        return 4;
   }
    if(nPoints > 3 && d6() < 3)
    {
        PSYCHIC_MindBlast();
        return 2;
    }

   if(nPoints > 2 && d6() < 3)
   {
        PSYCHIC_BeatTheOdds();
        return 3;
   }

   if(nPoints > 2 && d6() < 3)
   {
        PSYCHIC_Vulnerability();
        return 3;
   }
   if(nPoints > 2 && d6() < 3)
   {
        PSYCHIC_ReducePower();
        return 3;
   }
   if(nPoints > 2 && d6() < 3)
   {
        PSYCHIC_IncreasePower();
        return 3;
   }

   if(nPoints > 1 && d6() < 3)
    {
        PSYCHIC_Strength();
        return 2;
    }
   if(nPoints > 1 && d6() < 3)
    {
        PSYCHIC_Dexterity();
        return 2;
    }
   if(nPoints > 1 && d6() < 3)
    {
        PSYCHIC_Constitution();
        return 2;
    }
    if(nPoints > 0 && d6() < 3)
    {
        PSYCHIC_Charm();
        return 1;
    }
    if(nPoints > 0 && d6() < 3)
    {
        PSYCHIC_Daze();
        return 1;
    }
    if(nPoints > 0 && d6() < 3)
    {
        PSYCHIC_Haste();
        return 1;
    }
     if(nPoints > 0 && d6() < 3)
    {
        PSYCHIC_Speed();
        return 1;
    }
    if(nPoints > 0 && d6() < 3)
    {
        PSYCHIC_DetectInvisibility();
        return 1;
    }

    return 0;
}




