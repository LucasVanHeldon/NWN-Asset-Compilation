// Book of Demons - Babau
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"
#include "inc_mmp"

void ABERRATION_SpecialAttack(object oTarget = OBJECT_INVALID)
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

}


void SpecialAttack()
{
    switch(d6())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Insanity");
        DEMON_Insanity();
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Greater Dispel");
        DEMON_GreaterDispel();
        break;
    case 3:
        SendMessageToPC(GetFirstPC(),"Dominate");
        DEMON_DominateMonster();
        break;
    case 4:
        DEMON_Teleport();
        break;
    case 5:
        SendMessageToPC(GetFirstPC(),"Blasphemy");
        DEMON_Blasphemy();
        break;
    case 6:
        ABERRATION_SpecialAttack();
    }
}

void SpellCast(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    switch(d6())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Insanity");
        DEMON_Insanity(oTarget);
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Power Word: Stun");
        DEMON_PowerWordStun(oTarget);
        break;
    case 3:
        SendMessageToPC(GetFirstPC(),"Dominate");
        DEMON_DominateMonster(oTarget);
        break;
    case 4:
        DEMON_Teleport();
        break;
    case 5:
        SendMessageToPC(GetFirstPC(),"Blasphemy");
        DEMON_Blasphemy();
        break;
    case 6:
        SendMessageToPC(GetFirstPC(),"Greater Dispel");
        DEMON_GreaterDispel(oTarget);
        break;
    }
}


void Gate(string bp, int num)
{
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    int i;
    for(i = 0; i < num; i++)
    {
        object oD = CreateObject(OBJECT_TYPE_CREATURE,bp,GetLocation(OBJECT_SELF));
        // summons can't gate
        SetLocalInt(oD,"bGated",1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
    }
}

void GateDemons()
{
    Gate("dretch",d10(4));
    Gate("hezrou",d4());
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();
    int nState = GetLocalInt(OBJECT_SELF,"nState");

    switch(nCalledBy)
    {
    case 1002:
        switch(nState)
        {
        case 0:
            GateDemons();
            break;
        default:
            DetermineCombatRound();
        }
        nState = nState + 1;
        SetLocalInt(OBJECT_SELF,"nState",nState);
        break;

    case 1003:
        if(d6() < 3)
        {
            SpecialAttack();
        }
        break;
    case 1006:
        if(d6() < 3)
        {
            SpecialAttack();
        }
        break;
    case 1011:

        object oSC = GetLastSpellCaster();
        if( d6() < 4 && GetLastSpellHarmful())
        {
            DEMON_GreaterDispel(oSC);
        }
        break;
    }
}
