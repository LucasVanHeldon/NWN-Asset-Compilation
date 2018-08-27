//::///////////////////////////////////////////////
//:: Summon Creature Series
//:: NW_S0_Summon
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Carries out the summoning of the appropriate
    creature for the Summon Monster Series of spells
    1 to 9
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 8, 2002
//:://////////////////////////////////////////////
#include "sr_constants_inc"

effect SetSummonEffect(int nSpellID);

void main()
{
    //Declare major variables
    int nSpellID = GetSpellId();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    nDuration = 24;
    if(nDuration == 1)
        nDuration = 2;
    // Duration override.
    if (SUMMON)
        nDuration = (GetCasterLevel(OBJECT_SELF))+3;

    effect eSummon = SetSummonEffect(nSpellID);

    //Make metamagic check for extend
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Apply the VFX impact and summon effect

    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration));
}


effect SetSummonEffect(int nSpellID)
{
    int nFNF_Effect;
    int nRoll = d3();
    string sSummon;
    if(GetHasFeat(FEAT_ANIMAL_DOMAIN_POWER)) //WITH THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
    }
    else  //WITOUT THE ANIMAL DOMAIN
    {
        if(nSpellID == SPELL_SUMMON_CREATURE_I)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_badgerdire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_II)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_BOARDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_III)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_1;
            sSummon = "NW_S_WOLFDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IV)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_SPIDDIRE";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_V)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_beardire";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VI)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_2;
            sSummon = "NW_S_diretiger";
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRHUGE";
                break;

                case 2:
                    sSummon = "NW_S_WATERHUGE";
                break;

                case 3:
                    sSummon = "NW_S_FIREHUGE";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_VIII)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRGREAT";
                break;

                case 2:
                    sSummon = "NW_S_WATERGREAT";
                break;

                case 3:
                    sSummon = "NW_S_FIREGREAT";
                break;
            }
        }
        else if(nSpellID == SPELL_SUMMON_CREATURE_IX)
        {
            nFNF_Effect = VFX_FNF_SUMMON_MONSTER_3;
            switch (nRoll)
            {
                case 1:
                    sSummon = "NW_S_AIRELDER";
                break;

                case 2:
                    sSummon = "NW_S_WATERELDER";
                break;

                case 3:
                    sSummon = "NW_S_FIREELDER";
                break;
            }
        }
    }
    //effect eVis = EffectVisualEffect(nFNF_Effect);
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    effect eSummonedMonster = EffectSummonCreature(sSummon, nFNF_Effect);
    return eSummonedMonster;
}

