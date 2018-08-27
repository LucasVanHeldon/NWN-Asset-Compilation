
void MMP_MindBlast(object oTarget = OBJECT_INVALID);
void MMP_RayOfEnfeeblement(object oTarget = OBJECT_INVALID);

void MMP_MindBlast(object oTarget = OBJECT_INVALID)
{

    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Mind Blast");
    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_MINDBLAST,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_RayOfEnfeeblement(object oTarget = OBJECT_INVALID)
{

    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Ray of Enfeeblement");

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_RAY_OF_ENFEEBLEMENT,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazeCharm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_CHARM,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_AuraBlind(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);


    SendMessageToPC(oTarget,"Aura of Blinding");
    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_BLINDING,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraCold(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);
    oTarget=OBJECT_SELF;
    SendMessageToPC(oTarget,"Aura of Cold");

    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_COLD,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraElectricity(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Electricity");
    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_ELECTRICITY,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraFear(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Fear");
    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_FEAR,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraMenace(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Menace");
    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_MENACE,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraProtection(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Protection");
    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_PROTECTION,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraStun(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Stun");
    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_STUN,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraUnearthlyVisage(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Unearthly Visage");

    oTarget=OBJECT_SELF;
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_AURA_UNEARTHLY_VISAGE,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_AuraFire(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Aura of Fire");

    ClearAllActions(TRUE);
    oTarget=OBJECT_SELF;
    ActionCastSpellAtObject(SPELLABILITY_AURA_FIRE,oTarget,METAMAGIC_ANY,TRUE);
}



void MMP_BoltDrainCHA(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Boltdrain CHA");

        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_CHARISMA,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltDrainSTR(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Boltdrain STR");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_STRENGTH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltDrainDEX(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"BoltdrainDEX");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_DEXTERITY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltDrainWIS(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Boltdrain WIS");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_WISDOM,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltDrainINT(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Boltdrain INT");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_INTELLIGENCE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltDrainCON(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Boltdrain CON");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ABILITY_DRAIN_CONSTITUTION,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazeParalysis(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Gaze Parlysis");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_PARALYSIS,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazeConfusion(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Gaze of Confusion");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_CONFUSION,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazeDaze(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Gaze Dazing");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_DAZE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazeFear(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Gaze Fear");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_FEAR,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazeDomination(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Gaze Domination");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_DOMINATE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_SonicCone(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Sonic Cone");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_CONE_SONIC,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_PulseDrainCON(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Drain CON");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_CONSTITUTION,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDrainCHA(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Drain CHA");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_CHARISMA,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDrainDEX(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Drain DEX");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_DEXTERITY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDrainINT(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Drain CON");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_INTELLIGENCE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDrainSTR(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Drain STR");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_STRENGTH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDrainWIS(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Drain WIS");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_ABILITY_DRAIN_WISDOM,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_PulseDeath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {

        SendMessageToPC(oTarget,"Pulse Death");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_DEATH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDisease(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Disease");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_DISEASE,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_PulsePoison(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse Poison");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_POISON,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltAcid(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Acid Bolt");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_ACID,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltDisease(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Acid Bolt");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_BOLT_DISEASE,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_BoltPoison(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Acid Bolt");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_BOLT_POISON,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_BoltDeath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Acid Bolt");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_BOLT_DEATH,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_GustOfWind(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Gust of Wind");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_GUST_OF_WIND,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_ConeOfLightning(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Cone of Lightning");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_CONE_LIGHTNING,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_BallLightning(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Ball Lightning");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_BALL_LIGHTNING,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_ChainLightning(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Chain Lightning");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CHAIN_LIGHTNING,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_CallLightning(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Call Lightning");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(
    SPELL_CALL_LIGHTNING,
    oTarget,
    METAMAGIC_ANY,TRUE);
}

void MMP_LightningBolt(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Lightning");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_LIGHTNING_BOLT,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_PulseLightning(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Pulse Lightning");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_PULSE_LIGHTNING,oTarget,METAMAGIC_ANY,TRUE);
}



void MMP_WhirlWind(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Whirlwind");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_WHIRLWIND,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_CloudOfBewilderment(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Cloud of Bewilderment");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CLOUD_OF_BEWILDERMENT,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_CloudKill(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Cloud Kill");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CLOUDKILL,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_ElementalShield(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Elemental SHield");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_ELEMENTAL_SHIELD,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_ElementalSwarm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Elemental Swarm");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_ELEMENTAL_SWARM,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_Boom(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Boom!!");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_HORIZIKAULS_BOOM,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_IceStorm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Ice Storm");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_ICE_STORM,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_NatureBalance(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Nature's Balance");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_NATURES_BALANCE,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_Scare(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Scare");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_SCARE,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_Confusion(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Confusion");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CONFUSION,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_HoldPerson(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Hold Person");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_HOLD_PERSON,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_HoldMonster(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Hold Monster");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_HOLD_MONSTER,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_CharmPerson(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Charm Person");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CHARM_PERSON,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_CharmMonster(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Charm Monster");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CHARM_MONSTER,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_Daze(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Daze");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_DAZE,oTarget,METAMAGIC_ANY,TRUE);
}

int MMP_DominatePerson(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_DOMINATED);

    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DOMINATE_PERSON,oTarget,METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    return FALSE;
}

int MMP_DominateMonster(object oTarget = OBJECT_INVALID)
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



void MMP_DeafeningClang(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Deafening Clang");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_DEAFENING_CLANG,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_Displacement(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Confusion");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_DISPLACEMENT,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_EnergyDrain(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Energy Drain");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_ENERGY_DRAIN,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_Fear(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Fear");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_FEAR,oTarget,METAMAGIC_ANY,TRUE);
}



void MMP_FingerOfDeath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Finger of Death");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_FINGER_OF_DEATH,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_GhoulTouch(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Ghoul Touch");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CONFUSION,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_VampiricTouch(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Vampiric Touch");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_VAMPIRIC_TOUCH,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_PulseDrainLevel(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Pulse Level Drain");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_PULSE_LEVEL_DRAIN,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_PulseNegative(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Pulse Drain WIS");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_PULSE_NEGATIVE,oTarget,METAMAGIC_ANY,TRUE);
}



void MMP_CircleOfDeath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Circle of Death");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CIRCLE_OF_DEATH,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_CircleOfDoom(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Circle of Doom");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_CIRCLE_OF_DOOM,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_Dirge(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Dirge");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_DIRGE,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_DeathWard(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Death ward");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_DEATH_WARD,OBJECT_SELF,METAMAGIC_ANY,TRUE);
}

void MMP_DeathArmor(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    SendMessageToPC(oTarget,"Death ward");
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_DEATH_ARMOR,OBJECT_SELF,METAMAGIC_ANY,TRUE);
}


int MMP_Insanity(object oTarget = OBJECT_INVALID)
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



void MMP_BoltCold(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Freezing Bolt");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_COLD,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ConeOfAcid(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Cone of Acid");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_CONE_ACID,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseCold(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Freezing Pulse");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_COLD,oTarget,METAMAGIC_ANY,TRUE);
    }
}




void MMP_TouchPetrify(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_TOUCH_PETRIFY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltKnockdown(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_KNOCKDOWN,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_BoltStun(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_STUN,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_BreathPetrify(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BREATH_PETRIFY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Earthquake(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_EARTHQUAKE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GazePetrify(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_PETRIFY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Slow(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SLOW,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Bombardment(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BOMBARDMENT,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_FleshToStone(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FLESH_TO_STONE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_HorridWilting(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_PETRIFY);

    if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_HORRID_WILTING,oTarget,METAMAGIC_ANY,TRUE);
    }
}




void MMP_WallOfFire(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Wall of Fire");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_WALL_OF_FIRE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_DelayedBlastFireball(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Delayed blast Fireball");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DELAYED_BLAST_FIREBALL,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Fireball(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Fireball");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FIREBALL,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_IncendiaryCloud(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Incendiary Cloud");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_INCENDIARY_CLOUD,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_FireStorm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Fire Storm");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FIRE_STORM,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Flamestrike(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Flamestrike");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FLAME_STRIKE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Inferno(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Inferno");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_INFERNO,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_Firebrand(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Firebrand");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FIREBRAND,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseFire(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse, Fire");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_FIRE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ConeOfFire(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Flamestrike");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_CONE_FIRE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BoltFire(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Fire Bolt");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_BOLT_FIRE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Combust(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Combust");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_COMBUST,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BurningHands(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Burning Hands");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BURNING_HANDS,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_AcidFog(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Acid Fog");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ACID_FOG,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_AcidSplash(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Acid Splash");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ACID_SPLASH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Drown(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Acid Fog");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DROWN,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ConeOfCold(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Cone of Cold");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_CONE_COLD,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_MephitSaltBreath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Mephit Salt Breath");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_MEPHIT_SALT_BREATH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_MephitSteamBreath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Mephit Steam Breath");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_MEPHIT_STEAM_BREATH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PulseDrown(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Pulse, Drown");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_DROWN,oTarget,METAMAGIC_ANY,TRUE);
    }
}


