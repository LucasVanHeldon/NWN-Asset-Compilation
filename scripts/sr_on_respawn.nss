#include "nw_i0_plot"
#include "sr_constants_inc"

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
//    int nPenalty = 500 * GetHitDice(oDead);
    int nPenalty = DEATHXP * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin && nHD == 1)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);

    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
//    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}

void main()
{
  object oRespawner = GetLastRespawnButtonPresser();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
  RemoveEffects(oRespawner);

  SetLocalInt(oRespawner, "iDying", 0);

  string sPC = GetName(GetLastRespawnButtonPresser());
  object oMod = GetModule();
  SetLocalInt(oMod, ("LastHourRest" + sPC), 0);
  SetLocalInt(oMod, ("LastDayRest" + sPC), 0);
  SetLocalInt(oMod, ("LastMonthRest" + sPC), 0);
  SetLocalInt(oMod, ("LastYearRest" + sPC), 0);

  //* Go to Halls of Waiting
  string sDestTag =  "RESPAWNPOINT";
  string sArea = GetTag(GetArea(oRespawner));

  if (GetIsObjectValid(GetObjectByTag(sDestTag)))
  {
    if (sDestTag == "RESPAWNPOINT")
    {
      object oPriest = GetObjectByTag("HallsGuardian");
      //SetLocalInt(oPriest, "NW_L_SAYONELINER", 10);

      //AssignCommand(oPriest, DelayCommand(3.0,ActionStartConversation(oRespawner)));
//      AssignCommand(oPriest, DelayCommand(2.1, PlayVoiceChat(VOICE_CHAT_TALKTOME, oPriest)));

      SetLocalLocation(oRespawner, "NW_L_I_DIED_HERE", GetLocation(GetLastRespawnButtonPresser()));
      SetLocalInt(oRespawner, "NW_L_I_DIED", 1);
      SetLocalObject(oPriest, "NW_L_LASTDIED", GetLastRespawnButtonPresser());
      // * April 2002: Moved penalty here, only when going back to the death temple
      ApplyPenalty(oRespawner);

      if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, GetLastRespawnButtonPresser()) < 11)
            SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 11, GetLastRespawnButtonPresser());
      if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, GetLastRespawnButtonPresser()) < 25)
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 25, GetLastRespawnButtonPresser());
      AdjustFactionReputation(GetLastRespawnButtonPresser(), oPriest, 100);

    }
    object oSpawnPoint = GetObjectByTag(sDestTag);
    AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
  }
  else
  {
    // * do nothing, just 'res where you are.
  }
}
