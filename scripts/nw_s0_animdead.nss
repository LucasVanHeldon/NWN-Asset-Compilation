//::///////////////////////////////////////////////
//:: Animate Dead
//:: NW_S0_AnimDead.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Summons a powerful skeleton or zombie depending
    on caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 11, 2001
//:://////////////////////////////////////////////

void main()
{
    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = 48;
    //effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
    effect eSummon;
    //Metamagic extension if needed
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;  //Duration is +100%
    }
    //Summon the appropriate creature based on the summoner level
    if (nCasterLevel == 1)
    {
        //Skeleton
        eSummon = EffectSummonCreature("skeleton001",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel == 2)
    {
        //Zombie
        eSummon = EffectSummonCreature("zombie001",VFX_FNF_SUMMON_UNDEAD);
    }
    else if (nCasterLevel >= 3)
    {
        //Large Skeleton
        eSummon = EffectSummonCreature("sr_largeskeleton",VFX_FNF_SUMMON_UNDEAD);
    }
    else if ((nCasterLevel >= 6) && (nCasterLevel <= 9))
    {
        //Skeleton Warrior
        eSummon = EffectSummonCreature("NW_S_SKELWARR",VFX_FNF_SUMMON_UNDEAD);
    }
    else
    {
        //Skeleton Chieftain
        eSummon = EffectSummonCreature("NW_S_SKELCHIEF",VFX_FNF_SUMMON_UNDEAD);
    }
    //Apply the summon visual and summon the two undead.
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), HoursToSeconds(nDuration));
}


