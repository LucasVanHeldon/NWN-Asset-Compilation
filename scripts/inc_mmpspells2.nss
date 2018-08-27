

void MMP_MelfsAcidArrow(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Melf's Acid Arrow");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_MELFS_ACID_ARROW,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_MestilsAcidBreath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Mestil's Acid Breath");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_MESTILS_ACID_BREATH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_MestilsAcidSheath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Mestil's Acid Sheath");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_MESTILS_ACID_SHEATH,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_Flare(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindWeakestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Flare");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FLARE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ElectricJolt(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindWeakestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Electric Jolt");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ELECTRIC_JOLT,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ColorSpray(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Color Spray");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_COLOR_SPRAY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_RayOfFrost(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindWeakestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Ray of Frost");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_RAY_OF_FROST,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Grease(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Grease");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_GREASE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_IceDagger(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Ice Dagger");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ICE_DAGGER,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_MagicMissile(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Magic Missile");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_MAGIC_MISSILE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_NegativeEnergyRay(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Negative Energy Ray");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_NEGATIVE_ENERGY_RAY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Sleep(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Sleep");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SLEEP,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BalagornsIronHorn(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Balagorn's Iron Horn");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BALAGARNSIRONHORN,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BlindnessDeafness(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Blindness and Deafness");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_GedleesElectricLoop(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Blindness and Deafness");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_GEDLEES_ELECTRIC_LOOP,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Darkness(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Darkness");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DARKNESS,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_TashasHideousLaughter(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Tasha's Hideous Laughter");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_TASHAS_HIDEOUS_LAUGHTER,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Web(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Web");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_WEB,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_FlameArrow(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Flame Arrow");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FLAME_ARROW,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_NegativeEnergyBurst(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Negative Energy Burst");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_NEGATIVE_ENERGY_BURST,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_StinkingCloud(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Stinking Cloud");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_STINKING_CLOUD,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_Contagion(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(
                        OBJECT_SELF,
                        EFFECT_TYPE_DISEASE
                        );

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CONTAGION,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_CreepingDoom(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CREEPING_DOOM,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ImprovedInvisibility(object oTarget = OBJECT_INVALID)
{
    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_IMPROVED_INVISIBILITY,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Haste(object oTarget = OBJECT_INVALID)
{
    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_HASTE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_ConeOfColdSA(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_CONE_COLD,oTarget,METAMAGIC_ANY,TRUE);
    }
}
void MMP_SeeInvisibility(object oTarget = OBJECT_INVALID)
{
    if(GetIsObjectValid(oTarget))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SEE_INVISIBILITY,oTarget,METAMAGIC_ANY,TRUE);
    }
}




void MMP_Bane(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Bane");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BANE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Doom(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Doom");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DOOM,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_BestowCurse(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Bestow Curse");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BESTOW_CURSE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_BladeBarrier(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Blade Barrier");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BLADE_BARRIER,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_FeebleMind(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Feeble Mind");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FEEBLEMIND,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Harm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Harm");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_HARM,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Poison(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Poison");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_POISON,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_SummonIX(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"SummonIX");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SUMMON_CREATURE_IX,oTarget,METAMAGIC_ANY,TRUE);
    }
}



void MMP_Invisibility(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_INVISIBILITY,oTarget,METAMAGIC_ANY,TRUE);
}


void MMP_DancingLights()
{
    int n = d4();
    int i;
    SetLocalInt(OBJECT_SELF,"bDancingLights",1);
    ClearAllActions(TRUE);
    for(i = 0; i < n; i++)
        CreateObject(OBJECT_TYPE_CREATURE,"mmp_dancinglight",GetLocation(OBJECT_SELF));
}


void MMP_Enervation(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Enervation");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ENERVATION,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_EvardsBlackTentacles(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Evard's Black Tentacles");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_EVARDS_BLACK_TENTACLES,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_IsaacsLesserMissileStorm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Issac's Lesser Missile Storm");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ISAACS_LESSER_MISSILE_STORM,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_LesserSpellBreach(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Lesser Spell Breach");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LESSER_SPELL_BREACH,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_LesserDispel(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Lesser Dispel");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LESSER_DISPEL,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_DispelMagic(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Dispel Magic");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DISPEL_MAGIC,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_GreaterDispelling(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Greater Dispel Magic");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_PhantasmalKiller(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Phantasmal Killer");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_PHANTASMAL_KILLER,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_AnimateDead(object oTarget = OBJECT_INVALID)
{
    ClearAllActions(TRUE);
    ActionCastSpellAtLocation(SPELL_ANIMATE_DEAD,GetLocation(oTarget),METAMAGIC_ANY,TRUE);
}

void MMP_BigbysInterposingHand(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Bigbys Interposing Hand");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BIGBYS_INTERPOSING_HAND,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Cloudkill(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Cloudkill");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CLOUDKILL,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Dismissal(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        SendMessageToPC(oTarget,"Dismissal");
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DISMISSAL,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_EnergyBuffer(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_ENERGY_BUFFER,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_Feeblemind(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FEEBLEMIND,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_FireBrand(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FIREBRAND,oTarget,METAMAGIC_ANY,TRUE);
    }
}

/* this is a group of spells
void MMP_GreaterShadowConjuration(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_GREATER_SHADOW_CONJURATION,oTarget,METAMAGIC_ANY,TRUE);
    }
}
*/


void MMP_LesserMindBlank(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LESSER_MIND_BLANK,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_LesserPlanarBinding(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_PLANAR_BINDING,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_LesserSpellMantle(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LESSER_SPELL_MANTLE,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_MindFog(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_MIND_FOG,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_SummonCreatureV(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) && GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SUMMON_CREATURE_V,oTarget,METAMAGIC_ANY,TRUE);
    }
}

