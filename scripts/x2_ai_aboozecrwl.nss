#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "x0_i0_spawncond"
#include "x3_inc_skin"
#include "inc_ai"
#include "inc_magic"
#include "inc_mmpspells"
#include "inc_mmpspells2"
#include "inc_mmpcast"


void MMPABBOOZE_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    int nHD = GetHitDice(OBJECT_SELF);

    if(GetLocalInt(OBJECT_SELF,"bMindBlast") && nHD > 6)
        if(d6() < 3)
        {
            MMP_MindBlast(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bCharmGaze") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraBlind") && nHD > 7)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_BLINDING))
        {
            MMP_AuraBlind(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraCold") && nHD > 8)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_COLD))
        {
            MMP_AuraCold(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraElectricity") && nHD > 8)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_ELECTRICITY))
        {
            MMP_AuraElectricity(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraFire") && nHD > 8)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_FIRE))
        {
            MMP_AuraFire(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraFear") && nHD > 6)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_FEAR))
        {
            MMP_AuraFear(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraMenace") && nHD > 9)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_MENACE))
        {
            MMP_AuraMenace(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bAuraProtection") && nHD > 7)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_PROTECTION))
        {
            MMP_AuraProtection(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraStun") && nHD > 6)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_STUN))
        {
            MMP_AuraStun(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraUnearthlyVisage") && nHD > 20)
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


    if(GetLocalInt(OBJECT_SELF,"bSonicCone")&& nHD > 6)
        if(d6() < 3)
        {
            MMP_SonicCone(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bGazeCharm") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }

     if(GetLocalInt(OBJECT_SELF,"bGazeConfuse") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeConfusion(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeDaze")&& nHD > 4)
        if(d6() < 3)
        {
            MMP_GazeDaze(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeFear")&& nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeFear(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeDominate")&& nHD > 10)
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

    if(GetLocalInt(OBJECT_SELF,"bPDCHA")  && nHD > 5)
        if(d6() < 3)
        {
            MMP_PulseDrainCHA(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDINT") && nHD > 5)
        if(d6() < 3)
        {
            MMP_PulseDrainINT(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDWIS") && nHD > 5)
        if(d6() < 3)
        {
            MMP_PulseDrainWIS(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDDEX") && nHD > 5)
        if(d6() < 3)
        {
            MMP_PulseDrainDEX(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDCON") && nHD > 5)
        if(d6() < 3)
        {
            MMP_PulseDrainCON(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPDSTR") && nHD > 5)
        if(d6() < 3)
        {
            MMP_PulseDrainSTR(oTarget);
            return;
        }



    if(GetLocalInt(OBJECT_SELF,"bHoldPerson") && nHD > 3)
        if(d6() < 3)
        {
            MMP_HoldPerson(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bHoldMonster") && nHD > 5)
        if(d6() < 3)
        {
            MMP_HoldMonster(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bCharmPerson"))
        if(d6() < 3)
        {
            MMP_CharmPerson(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bCharmMonster") && nHD > 3)
        if(d6() < 3)
        {
            MMP_CharmMonster(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bDominatePerson") && nHD > 7)
        if(d6() < 3)
        {
            MMP_DominatePerson(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bDominateMonster") && nHD > 11)
        if(d6() < 3)
        {
            MMP_DominateMonster(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoom") && nHD > 3)
        if(d6() < 3)
        {
            MMP_Boom(oTarget);
            return;
        }


     if(GetLocalInt(OBJECT_SELF,"bConfusion") && nHD > 7)
        if(d6() < 3)
        {
            MMP_Confusion(oTarget);
            return;
        }

     if(GetLocalInt(OBJECT_SELF,"bScare"))
        if(d6() < 3)
        {
            MMP_Scare(oTarget);
            return;
        }

      if(GetLocalInt(OBJECT_SELF,"bDaze"))
        if(d6() < 3)
        {
            MMP_Daze(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bInsanity") && nHD > 15)
        if(d6() < 3)
        {
            MMP_Insanity(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bDeafeningClang") && nHD > 3)
        if(d6() < 3)
        {
            MMP_DeafeningClang(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bDisplacement") && nHD > 6)
        if(d6() < 3)
        {
            MMP_Displacement(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bEnergyDrain") && nHD > 3)
        if(d6() < 3)
        {
            MMP_EnergyDrain(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bFear") && nHD > 7)
        if(d6() < 3)
        {
            MMP_Fear(oTarget);
            return;
        }

   if(GetLocalInt(OBJECT_SELF,"bFingerOfDeath") && nHD > 12)
        if(d6() < 3)
        {
            MMP_FingerOfDeath(oTarget);
            return;
        }

   if(GetLocalInt(OBJECT_SELF,"bGhoulTouch") && nHD > 3)
        if(d6() < 3)
        {
            MMP_EnergyDrain(oTarget);
            return;
        }


   if(GetLocalInt(OBJECT_SELF,"bVampiricTouch") && nHD > 7)
        if(d6() < 3)
        {
            MMP_VampiricTouch(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bMindBlast") && nHD > 8)
        if(d6() < 3)
        {
            MMP_MindBlast(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bCharmGaze") && nHD > 7)
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraBlind") && nHD > 6)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_BLINDING))
        {
            MMP_AuraBlind(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraCold") && nHD > 7)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_COLD))
        {
            MMP_AuraCold(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraElectricity")&& nHD > 7)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_ELECTRICITY))
        {
            MMP_AuraElectricity(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraFire") && nHD > 7)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_FIRE))
        {
            MMP_AuraFire(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraFear")&& nHD > 7)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_FEAR))
        {
            MMP_AuraFear(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraMenace") && nHD > 10)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_MENACE))
        {
            MMP_AuraMenace(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bAuraProtection")&& nHD > 6)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_PROTECTION))
        {
            MMP_AuraProtection(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraStun") && nHD > 6)
        if(d6() < 3 && !GetHasSpell(SPELLABILITY_AURA_STUN))
        {
            MMP_AuraStun(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bAuraUnearthlyVisage")&& nHD > 20)
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


    if(GetLocalInt(OBJECT_SELF,"bSonicCone")&& nHD > 6)
        if(d6() < 3)
        {
            MMP_SonicCone(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bGazeCharm") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }

     if(GetLocalInt(OBJECT_SELF,"bGazeConfuse") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeConfusion(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeDaze") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeDaze(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeFear") && nHD > 6)
        if(d6() < 3)
        {
            MMP_GazeFear(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bGazeDominate")&& nHD > 12)
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

    if(GetLocalInt(OBJECT_SELF,"bBoltAcid"))
        if(d6() < 3)
        {
            MMP_BoltAcid(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoltDisease"))
        if(d6() < 3)
        {
            MMP_BoltDisease(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bBoltPoison"))
        if(d6() < 3)
        {
            MMP_BoltPoison(oTarget);
            return;
        }


    if(GetLocalInt(OBJECT_SELF,"bBoltDeath")&& nHD > 10)
        if(d6() < 3)
        {
            MMP_BoltDeath(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bPulseDisease"))
        if(d6() < 3)
        {
            MMP_PulseDisease(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPulseDeath")&& nHD > 12)
        if(d6() < 3)
        {
            MMP_PulseDeath(oTarget);
            return;
        }
    if(GetLocalInt(OBJECT_SELF,"bPulsePoison"))
        if(d6() < 3)
        {
            MMP_PulsePoison(oTarget);
            return;
        }
}




void main()
{
    if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        MMPABBOOZE_SpecialAttack();
          __TurnCombatRoundOn(FALSE);
    }
    else
    {
        object oEnemy = bkAcquireTarget();
        if (GetIsObjectValid(oEnemy))
        {
            object oSelf = OBJECT_SELF;
            int i;
            int time = d6(2);
            for(i = 0; i < 8; i++)
            {
                float D = GetDistanceToObject(oEnemy);
                if(D > 0.0 && D < 2.5)
                {

                    if(TouchAttackMelee(oEnemy,TRUE))
                    {
                        if(!FortitudeSave(oEnemy,13,SAVING_THROW_TYPE_POISON))
                        {
                            effect ePar = EffectParalyze();
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePar,oEnemy,RoundsToSeconds(time));
                            effect eVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oEnemy,RoundsToSeconds(time));
                            oEnemy = PickEnemy(OBJECT_SELF);
                        }
                    }
                }

            }
        }
    }
}
