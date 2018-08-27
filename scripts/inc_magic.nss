int IsFighter(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_FIGHTER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_PALADIN ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_RANGER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_MONK ||
           // don't know, if should include this guy or not.
           GetClassByPosition(i,oTarget) == CLASS_TYPE_CLERIC)
            return TRUE;
    }
    return FALSE;
}

int IsMagicUser(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_SORCERER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_WIZARD)
            return TRUE;
    }
    return FALSE;
}

int IsCleric(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_CLERIC)
            return TRUE;
    }
    return FALSE;
}

// some classes which can cast spells are not counted atm
int IsSpellCaster(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_SORCERER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_WIZARD ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_CLERIC ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_DRUID)
            return TRUE;
    }
    return FALSE;
}

object FindNearestEnemyMagicUser(object oSelf=OBJECT_SELF,float fSize=30.0)
{
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    while(GetIsObjectValid(oNear))
    {
        if( GetIsEnemy(oNear) && CanSeeObject(oNear) && IsMagicUser(oNear) && !IsEnemyDead(oNear) ) return oNear;

        oNear = GetNextObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    }
    return OBJECT_INVALID;
}

object FindNearestEnemyCleric(object oSelf=OBJECT_SELF,float fSize=30.0)
{
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    while(GetIsObjectValid(oNear))
    {
        if( GetIsEnemy(oNear) && CanSeeObject(oNear)&& IsCleric(oNear) && !GetIsDead(oNear)) return oNear;

        oNear = GetNextObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    }
    return OBJECT_INVALID;
}

object FindNearestEnemySpellCaster(object oSelf=OBJECT_SELF, float fSize=30.0)
{
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    while(GetIsObjectValid(oNear))
    {
        if( GetIsEnemy(oNear) && CanSeeObject(oNear) && IsSpellCaster(oNear) && !IsEnemyDead(oNear)) return oNear;

        oNear = GetNextObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    }
    return OBJECT_INVALID;
}

object FindNearestRangedEnemy(object oSelf=OBJECT_SELF, float fSize=30.0f)
{
    object oNear = GetFirstObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    while(GetIsObjectValid(oNear))
    {
        if( GetIsEnemy(oNear) && CanSeeObject(oNear) &&
            GetWeaponRanged(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oNear)) &&
            !IsEnemyDead(oNear))

           return oNear;

        oNear = GetNextObjectInShape(SHAPE_SPHERE,fSize,GetLocation(oSelf));
    }
    return OBJECT_INVALID;
}

int NoPsychology(object oTarget)
{
    return !GetHasEffect(EFFECT_TYPE_DAZED,oTarget) &&
           !GetHasEffect(EFFECT_TYPE_SLEEP,oTarget) &&
           !GetHasEffect(EFFECT_TYPE_CHARMED,oTarget) &&
           !GetHasEffect(EFFECT_TYPE_DOMINATED,oTarget) &&
           !GetHasEffect(EFFECT_TYPE_PARALYZE,oTarget) &&
           !GetHasEffect(EFFECT_TYPE_STUNNED,oTarget);
}




void CastAt(object oTarget, int spell)
{
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(spell,oTarget);
    ActionWait(6.0);
}

void CastAtLocation(location loc, int spell)
{
    ClearAllActions(TRUE);
    ActionCastSpellAtLocation(spell,loc);
    ActionWait(6.0);
}

// will cast spell at a location halfway between caster and target
void CastBetween(int iSpell, object oTarget=OBJECT_INVALID)
{
    object oNear;

    if(oTarget==OBJECT_INVALID)
        oNear= FindNearestEnemy(OBJECT_SELF);
    else
        oNear = oTarget;

    float D = GetDistanceToObject(oNear);


    float P = D/2.0;
    vector vMy = GetPosition(OBJECT_SELF);
    vector vN  = GetPosition(oNear);
    // for whatever reason, I believe it should be: vMy - vN
    // but for some reason, it is facing the wrong way.
    vector vP  = VectorNormalize(vN - vMy);
    vector vL  = vMy + (P*vP);
    float  Facing = VectorToAngle(vP);

    ClearAllActions(TRUE);
    ActionCastSpellAtLocation( iSpell,
                        Location(GetArea(OBJECT_SELF),
                                 vL,
                                 Facing) );

}


// used for summoning (non-game functions)
void Summon(string resref, int num, location loc)
{
    int n = num;
    int i;

    for(i = 0; i < n; i++)
    {
        effect eSummon = EffectVisualEffect(VFX_IMP_UNSUMMON);
        object oSummon = CreateObject(OBJECT_TYPE_CREATURE,resref,loc);
        ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY,eSummon,loc,15.0);
    }
}




// cast at enemy that does not have effect
void CastAtWithoutEffect(int iEffect, int spell)
{
    object oDoom = FindNearestEnemyWithoutEffect(OBJECT_SELF,iEffect);
    if(!GetIsObjectValid(oDoom)) oDoom = FindNearestEnemy(OBJECT_SELF);
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(spell,oDoom);
    ActionWait(6.0);
}


void CastAtWeakest(int spell)
{
    object oDoom = FindWeakestEnemy(OBJECT_SELF);
    if(!GetIsObjectValid(oDoom)) oDoom = FindNearestEnemy(OBJECT_SELF);
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(spell,oDoom);
    ActionWait(6.0);

}

void CastAtStrongest(int spell)
{
    object oDoom = FindStrongestEnemy(OBJECT_SELF);
    if(!GetIsObjectValid(oDoom)) oDoom = FindNearestEnemy(OBJECT_SELF);
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(spell,oDoom);
    ActionWait(6.0);

}


void CastNegativeEnergyProtection(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_NEGATIVE_ENERGY_PROTECTION);
}

void CastProtectionFromElements(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_PROTECTION_FROM_ELEMENTS);
}

void CastProtectionFromGood(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_PROTECTION_FROM_GOOD);
}

void CastProtectionFromEvil(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_PROTECTION_FROM_EVIL);
}

void CastMagicCircleAgainstGood(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_MAGIC_CIRCLE_AGAINST_GOOD);
}

void CastMagicCircleAgainstLaw(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_MAGIC_CIRCLE_AGAINST_LAW);
}

void CastMagicCircleAgainstEvil(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_MAGIC_CIRCLE_AGAINST_EVIL);
}
void CastMagicCircleAgainstChaos(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_MAGIC_CIRCLE_AGAINST_CHAOS);
}


void CastPrayer(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_PRAYER);
}


void CastSanctuary(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_SANCTUARY);
}

void CastCureMinorWounds(object oWounded)
{
    CastAt(oWounded,SPELL_CURE_MINOR_WOUNDS);
}


void CastCureLightWounds(object oWounded)
{
    CastAt(oWounded,SPELL_CURE_LIGHT_WOUNDS);
}

void CastCureModerateWounds(object oWounded)
{
    CastAt(oWounded,SPELL_CURE_MODERATE_WOUNDS);
}

void CastCureSeriousWounds(object oWounded)
{
    CastAt(oWounded,SPELL_CURE_SERIOUS_WOUNDS);
}

void CastCureCriticalWounds(object oWounded)
{
    CastAt(oWounded,SPELL_CURE_CRITICAL_WOUNDS);
}

void CastHeal(object oWounded)
{
    CastAt(oWounded,SPELL_HEAL);
}


// 1st level cleric
void CastBane(object oDoom)
{
    CastAt(oDoom,SPELL_BANE);
}

void CastDoom(object oDoom)
{
    CastAt(oDoom,SPELL_DOOM);
}

void CastRemoveFear(object oWounded)
{
    CastAt(oWounded,SPELL_REMOVE_FEAR);
}

void CastRemoveBlindness(object oWounded)
{
    CastAt(oWounded,SPELL_REMOVE_BLINDNESS_AND_DEAFNESS);
}

void CastRemoveParalysis(object oWounded)
{
    CastAt(oWounded,SPELL_REMOVE_PARALYSIS);
}

void CastLesserDispel(object oWounded)
{
    CastAt(oWounded,SPELL_LESSER_DISPEL);
}

void CastLesserRestoration(object oWounded)
{
    CastAt(oWounded,SPELL_LESSER_RESTORATION);
}

void CastConfusion(object oWounded)
{
    CastAt(oWounded,SPELL_CONFUSION);
}

void CastDominatePerson(object oWounded)
{
    CastAt(oWounded,SPELL_DOMINATE_PERSON);
}

void CastStinkingCloud(object oTarget, int bBetween=FALSE)
{
    if(bBetween)
        CastBetween(SPELL_STINKING_CLOUD);
    else
        CastAt(oTarget,SPELL_STINKING_CLOUD);
}

void CastEntangle(object oTarget, int bLoc=FALSE)
{
    if(bLoc)
        CastAtLocation(GetLocation(oTarget),SPELL_ENTANGLE);
    else
        CastAt(oTarget,SPELL_ENTANGLE);
}

// 1st level wizard
void CastGrease(object oDoom)
{
    CastAtLocation(GetLocation(oDoom),SPELL_GREASE);
}


// will put a grease spell at a location in between caster and
// enemy.
void CastGreaseBetween(object oTarget=OBJECT_INVALID)
{
    object oNear;

    if(oTarget==OBJECT_INVALID)
        oNear= FindNearestEnemy(OBJECT_SELF);
    else
        oNear = oTarget;

    float D = GetDistanceToObject(oNear);


    float P = D/2.0;
    vector vMy = GetPosition(OBJECT_SELF);
    vector vN  = GetPosition(oNear);
    // for whatever reason, I believe it should be: vMy - vN
    // but for some reason, it is facing the wrong way.
    vector vP  = VectorNormalize(vN - vMy);
    vector vL  = vMy + (P*vP);
    float  Facing = VectorToAngle(vP);

    ClearAllActions(TRUE);
    ActionCastSpellAtLocation( SPELL_GREASE,
                        Location(GetArea(OBJECT_SELF),
                                 vL,
                                 Facing) );

}


void CastDaze(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWithoutEffect(EFFECT_TYPE_DAZED,SPELL_DAZE);
    else
        CastAt(oTarget,SPELL_DAZE);
}

void CastNegativeEnergyRay(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_NEGATIVE_ENERGY_RAY);
    else
        CastAt(oTarget,SPELL_NEGATIVE_ENERGY_RAY);
}

void CastRayOfFrost(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_RAY_OF_FROST);
    else
        CastAt(oTarget,SPELL_RAY_OF_FROST);
}

void CastFlare(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_FLARE);
    else
        CastAt(oTarget,SPELL_FLARE);
}

void CastElectricJolt(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_ELECTRIC_JOLT);
    else
        CastAt(oTarget,SPELL_ELECTRIC_JOLT);
}

void CastAcidSplash(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_ACID_SPLASH);
    else
        CastAt(oTarget,SPELL_ACID_SPLASH);
}

void CastSleep(object oTarget=OBJECT_INVALID)
{

    if(oTarget == OBJECT_INVALID)
        CastAtWithoutEffect(EFFECT_TYPE_SLEEP,SPELL_SLEEP);
    else
        CastAt(oTarget,SPELL_SLEEP);
}

void CastColorSpray(object oTarget=OBJECT_INVALID)
{

    if(oTarget == OBJECT_INVALID)
        CastAt(FindNearestEnemy(OBJECT_SELF),SPELL_COLOR_SPRAY);
    else
        CastAt(oTarget,SPELL_COLOR_SPRAY);
}

void CastMagicMissile(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_MAGIC_MISSILE);
    else
        CastAt(oTarget,SPELL_MAGIC_MISSILE);
}

void CastIceDagger(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWeakest(SPELL_ICE_DAGGER);
    else
        CastAt(oTarget,SPELL_ICE_DAGGER);
}

// maximize effect of spell
void CastBurningHands(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAt(FindNearestEnemy(OBJECT_SELF),SPELL_BURNING_HANDS);
    else
        CastAt(oTarget,SPELL_BURNING_HANDS);
}

void CastScare(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAt(FindNearestEnemy(OBJECT_SELF),SPELL_SCARE);
    else
        CastAt(oTarget,SPELL_SCARE);
}

void CastGedleesElectricLoop(object oTarget)
{
    CastAt(oTarget,SPELL_GEDLEES_ELECTRIC_LOOP);
}

void CastInvisibility(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_INVISIBILITY);
}


void CastWeb(object oTarget, int useLoc=FALSE)
{
    if(useLoc==TRUE)
        CastAtLocation(GetLocation(oTarget),SPELL_WEB);
    else
       CastAt(oTarget,SPELL_WEB);
}

void CastRayOfEnfeeblement(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtStrongest(SPELL_RAY_OF_ENFEEBLEMENT);
    else
        CastAt(oTarget,SPELL_RAY_OF_ENFEEBLEMENT);
}

void CastBlindnessDeafness(object oTarget=OBJECT_INVALID)
{
    if(oTarget==OBJECT_INVALID)
        CastAtWithoutEffect(EFFECT_TYPE_BLINDNESS,SPELL_BLINDNESS_AND_DEAFNESS);
    else
        CastAt(oTarget,SPELL_BLINDNESS_AND_DEAFNESS);
}

void CastCloudOfBewilderment(object oTarget, int useLoc=FALSE)
{
    if(useLoc)
        CastAtLocation(GetLocation(oTarget),SPELL_CLOUD_OF_BEWILDERMENT);
    else
        CastAt(oTarget,SPELL_CLOUD_OF_BEWILDERMENT);
}

void CastGhoulTouch(object oTarget)
{
    CastAt(oTarget,SPELL_GHOUL_TOUCH);
}

void CastGhostlyVisage(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_GHOSTLY_VISAGE);
}

void CastVampiricTouch(object oTarget)
{
    CastAt(oTarget,SPELL_VAMPIRIC_TOUCH);
}

void CastFear(object oTarget)
{
    CastAt(oTarget,SPELL_FEAR);
}

void CastLightningBolt(object oTarget=OBJECT_INVALID)
{
    if(oTarget == OBJECT_INVALID)
        CastAtWeakest(SPELL_LIGHTNING_BOLT);
    else
        CastAt(oTarget,SPELL_LIGHTNING_BOLT);
}

void CastSilence(object oTarget)
{
    CastAt(oTarget,SPELL_SILENCE);
}

void CastDarkness(object oTarget)
{
    CastAtLocation(GetLocation(oTarget),SPELL_DARKNESS);
}

void CastHoldPerson(object oTarget)
{
    CastAt(oTarget,SPELL_HOLD_PERSON);
}

void CastBullsStrength(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_BULLS_STRENGTH);
}

void CastInflictLightWounds(object oTarget)
{
    CastAt(oTarget,SPELL_INFLICT_LIGHT_WOUNDS);
}


void CastRemoveCurse(object oTarget)
{
    CastAt(oTarget,SPELL_REMOVE_CURSE);
}

void CastRemoveDisease(object oTarget)
{
    CastAt(oTarget,SPELL_REMOVE_DISEASE);
}

void CastNeutralizePoison(object oTarget)
{
    CastAt(oTarget,SPELL_NEUTRALIZE_POISON);
}

void CastStoneToFlesh(object oTarget)
{
    CastAt(oTarget,SPELL_STONE_TO_FLESH);
}

void CastLesserDispelMagic(object oTarget)
{
    CastAt(oTarget,SPELL_LESSER_DISPEL);
}

void CastDispelMagic(object oTarget)
{
    CastAt(oTarget,SPELL_DISPEL_MAGIC);
}

void CastMordenkainensDisjunction(object oTarget)
{
    CastAt(oTarget,SPELL_MORDENKAINENS_DISJUNCTION);
}

void CastRestoration(object oTarget)
{
    CastAt(oTarget,SPELL_RESTORATION);
}

void CastClarity(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_CLARITY);
}

void CastTrueStrike(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_TRUE_STRIKE);
}

void CastMageArmor(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_MAGE_ARMOR);
}

// this is actually an odd one because if you have it cast it on itself
// it  must be holding the weapon however in order to cast it, it
// has to put it down first.
void CastFlameWeapon(object oItem)
{
    CastAt(oItem,SPELL_FLAME_WEAPON);
}

void CastEntropicShield(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_ENTROPIC_SHIELD);
}

void CastMagicWeapon(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_MAGIC_WEAPON);
}

void CastShieldOfFaith(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_SHIELD_OF_FAITH);
}

void CastShield(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_SHIELD);
}

void CastEndurance(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_ENDURANCE);
}

void CastEndureElements(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_ENDURE_ELEMENTS);
}

void CastBless(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_BLESS);
}

void CastAid(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_AID);
}

void CastDarkvision(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_DARKVISION);
}

void CastDivineFavor(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_DIVINE_FAVOR);
}

void CastResistElements(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_RESIST_ELEMENTS);
}

void CastResistance(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_RESISTANCE);
}

void CastVirtue(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_VIRTUE);
}

void CastSearingLight(object oTarget)
{
    CastAt(oTarget,SPELL_SEARING_LIGHT);
}

void CastSoundBurst(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_SOUND_BURST);
}

void CastBestowCurse(object oTarget)
{
    CastAt(oTarget,SPELL_BESTOW_CURSE);
}

void CastSummonCreatureI()
{
    CastAtLocation(GetLocation(OBJECT_SELF),SPELL_SUMMON_CREATURE_I);
}

void CastShelgarnsPersistentBlade(object oTarget=OBJECT_SELF)
{
    CastAt(oTarget,SPELL_SHELGARNS_PERSISTENT_BLADE);
}

void CastIronGuts(object oTarget)
{
    CastAt(oTarget,SPELL_IRONGUTS);
}

void CastHorzikulsBoom(object oTarget)
{
    CastAt(oTarget,SPELL_HORIZIKAULS_BOOM);
}
void CastCharmPerson(object oTarget)
{
    CastAt(oTarget,SPELL_CHARM_PERSON);
}







