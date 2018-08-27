#include "x0_i0_spawncond"
#include "inc_demons"
#include "inc_mmp"


void MMPABB_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    if(GetLocalInt(OBJECT_SELF,"bMindBlast"))
        if(d6() < 3)
        {
            MMP_MindBlast(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bCharmGaze"))
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraBlind"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_BLINDING))
        {
            MMP_AuraBlind(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraCold"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_COLD))
        {
            MMP_AuraCold(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraElectricity"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_ELECTRICITY))
        {
            MMP_AuraElectricity(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraFire"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_FIRE))
        {
            MMP_AuraFire(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraFear"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_FEAR))
        {
            MMP_AuraFear(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraMenace"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_MENACE))
        {
            MMP_AuraMenace(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bAuraProtection"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_PROTECTION))
        {
            MMP_AuraProtection(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraStun"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_STUN))
        {
            MMP_AuraStun(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraUnearthlyVisage"))
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_UNEARTHLY_VISAGE))
        {
            MMP_AuraUnearthlyVisage(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoltCHA"))
        if(d6() < 3)
        {
            MMP_BoltDrainCHA(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bBoltINT"))
        if(d6() < 3)
        {
            MMP_BoltDrainINT(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bBoltWIS"))
        if(d6() < 3)
        {
            MMP_BoltDrainWIS(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoltSTR"))
        if(d6() < 3)
        {
            MMP_BoltDrainSTR(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoltDEX"))
        if(d6() < 3)
        {
            MMP_BoltDrainDEX(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoltCON"))
        if(d6() < 3)
        {
            MMP_BoltDrainCON(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bSonicCone"))
        if(d6() < 3)
        {
            MMP_SonicCone(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bGazeCharm"))
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }

     if(GetLocalInt(OBJECT_SELF,"bGazeConfuse"))
        if(d6() < 3)
        {
            MMP_GazeConfusion(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeDaze"))
        if(d6() < 3)
        {
            MMP_GazeDaze(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeFear"))
        if(d6() < 3)
        {
            MMP_GazeFear(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeDominate"))
        if(d6() < 3)
        {
            MMP_GazeDomination(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bRayOfEnfeeble"))
        if(d6() < 3)
        {
            MMP_RayOfEnfeeblement(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bPDCHA"))
        if(d6() < 3)
        {
            MMP_PulseDrainCHA(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDINT"))
        if(d6() < 3)
        {
            MMP_PulseDrainINT(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDWIS"))
        if(d6() < 3)
        {
            MMP_PulseDrainWIS(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDDEX"))
        if(d6() < 3)
        {
            MMP_PulseDrainDEX(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDCON"))
        if(d6() < 3)
        {
            MMP_PulseDrainCON(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDSTR"))
        if(d6() < 3)
        {
            MMP_PulseDrainSTR(oTarget);
            return;
        }





    DetermineCombatRound();
}




void GRAYSLAAD_Summon()
{

    string bp;
    int num;
    int nChance = 0;
    switch(d3())
    {
    case 1: bp = "NW_SLAADRED"; num = d2(); nChance=40; break;
    case 2: bp = "NW_SLAADBLUE"; num = 1; nChance = 40; break;
    case 3: bp = "NW_SLAADGRAY"; num = 1; nChance = 20;
    }
    int nGated = GetLocalInt(OBJECT_SELF,"nGated");
    if(nGated < 2)
    {
        SetLocalInt(OBJECT_SELF,"nGated",nGated+1);
        ClearAllActions(TRUE);
        ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
        int chance = Random(100);
        if(chance < nChance)
        {
            int i;
            for(i = 0; i < num; i++)
                EffectSummonCreature(bp,VFX_FNF_SUMMON_MONSTER_1,1.0);
        }
    }
}


void DEMONIC_SpecialAttack()
{
    int nDarkness = GetLocalInt(OBJECT_SELF,"nDarkness");
    int nDispel = GetLocalInt(OBJECT_SELF,"nDispel");
    int nUnholyBlight = GetLocalInt(OBJECT_SELF,"nUnholyBlight");
    int nChaosHammer = GetLocalInt(OBJECT_SELF,"nChaosHammer");
    int nBlasphemy = GetLocalInt(OBJECT_SELF,"nBlasphemy");
    int nDominate = GetLocalInt(OBJECT_SELF,"nDominate");
    int nInsanity = GetLocalInt(OBJECT_SELF,"nInsanity");
    int nPowerWord = GetLocalInt(OBJECT_SELF,"nPowerWord");

    switch(Random(13)+1)
    {
    case 1:

        if(nDarkness < GetHitDice(OBJECT_SELF))
        {
            SendMessageToPC(GetFirstPC(),"Darkness");
            SetLocalInt(OBJECT_SELF,"nDarkness",nDarkness+1);
            DEMON_CastDarkness();

        }
        break;
    case 2:
        if(nDarkness < GetHitDice(OBJECT_SELF))
        {
            SendMessageToPC(GetFirstPC(),"Dispel Magic");
            SetLocalInt(OBJECT_SELF,"nDarkness",nDispel+1);
            DEMON_DispelSpellCaster();
        }
        break;
    case 3:
        DEMON_Teleport();
        break;
    case 4:
        if(nUnholyBlight < (GetHitDice(OBJECT_SELF)/2+1))
        {
            SendMessageToPC(GetFirstPC(),"Unholy Blight");
            SetLocalInt(OBJECT_SELF,"nUnholyBlight",nUnholyBlight+1);
            DEMON_CastUnholyBlight();
        }
        break;
    case 5:
        SendMessageToPC(GetFirstPC(),"Mirror Image");
        DEMON_Blink();
        break;
    case 6:
        if(nUnholyBlight < (GetHitDice(OBJECT_SELF)/2+1))
        {
            SendMessageToPC(GetFirstPC(),"Chaos Hammer");
            SetLocalInt(OBJECT_SELF,"nChaosHammer",nChaosHammer+1);
            DEMON_CastChaosHammer();
        }
        break;
    case 7:
        if(nBlasphemy < 1)
        {
            SendMessageToPC(GetFirstPC(),"Blasphemy");
            SetLocalInt(OBJECT_SELF,"nBlasphemy",1);
            DEMON_Blasphemy();
        }
        break;
    case 8:
        SendMessageToPC(GetFirstPC(),"Charm Person");
        DEMON_CharmPerson();
        break;
    case 9:
        SendMessageToPC(GetFirstPC(),"Confusion");
        DEMON_CastConfusion();
        break;
    case 10:
        if(nDominate < GetHitDice(OBJECT_SELF)/2+1)
        {
            SendMessageToPC(GetFirstPC(),"Dominate");
            SetLocalInt(OBJECT_SELF,"nDominate",nDominate+1);
            DEMON_DominateMonster();
        }
        break;
    case 11:
        if(nInsanity < 1)
        {
            SendMessageToPC(GetFirstPC(),"Insanity");
            SetLocalInt(OBJECT_SELF,"nInsanity",1);
            DEMON_Insanity();
        }
        break;
    case 12:
        if(nPowerWord < 1)
        {
            SendMessageToPC(GetFirstPC(),"Power Word: Stun");
            SetLocalInt(OBJECT_SELF,"nPowerWord",1);
            DEMON_PowerWordStun();
        }
        break;
    case 13:
    default:
        SendMessageToPC(GetFirstPC(),"Dominate");
        DEMON_CastDispelMagic();
        break;


    }
}



void SpecialAttack()
{
    // don't let it interrupt this is fickle
    if(GetCurrentAction(OBJECT_SELF) == ACTION_CASTSPELL) return;
    switch(d12())
    {
    case 1:
        DEMON_CastLightningBolt();
        break;
    case 2:
        DEMON_AnimateObjects();
        break;
    case 3:
        DEMON_ChaosHammer();
        break;
    case 4:
        DEMON_CastDarkness();
        break;
    case 5:
        DEMON_CastDispelMagic();
        break;
    case 6:
        GRAYSLAAD_Summon();
        break;
    case 7:
        DEMONIC_SpecialAttack();
        break;
    case 8:
        DEMON_CastCauseBlindness();
        break;
    default:
        MMPABB_SpecialAttack();
    }
}



void main()
{
    if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        SpecialAttack();
        __TurnCombatRoundOn(FALSE);
    }
}
