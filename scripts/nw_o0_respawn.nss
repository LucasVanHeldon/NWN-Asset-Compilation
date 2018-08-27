#include "nw_i0_plot"

// * Applies an XP and GP penalty
// * to the player respawning
void ApplyPenalty(object oDead)
{
    int nXP = GetXP(oDead);
    int nPenalty = 500 * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin && nHD == 1)
    {
       nNewXP = nMin;
       ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectAbilityDecrease(ABILITY_CONSTITUTION,1),
            oDead);
    }
    SetXP(oDead, nNewXP);

    DelayCommand(4.0, FloatingTextStrRefOnCreature(58299, oDead, FALSE));
    DelayCommand(4.8, FloatingTextStrRefOnCreature(58300, oDead, FALSE));
}

void main()
{
  object oRespawner = GetLastRespawnButtonPresser();
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
  RemoveEffects(oRespawner);

  //* Go to Halls of Waiting
  string sDestTag =  "Halls_of_Waiting";
  string sArea = GetTag(GetArea(oRespawner));

  if (GetIsObjectValid(GetObjectByTag(sDestTag)))
  {
    if (sDestTag == "Halls_of_Waiting")
    {
      object oPriest = GetObjectByTag("NW_DEATH_CLERIC");
      //SetLocalInt(oPriest, "NW_L_SAYONELINER", 10);

      //AssignCommand(oPriest, DelayCommand(3.0,ActionStartConversation(oRespawner)));
      AssignCommand(oPriest, DelayCommand(2.1, PlayVoiceChat(VOICE_CHAT_TALKTOME, oPriest)));

      SetLocalLocation(oRespawner, "NW_L_I_DIED_HERE", GetLocation(GetLastRespawnButtonPresser()));
      SetLocalInt(oRespawner, "NW_L_I_DIED", 1);
      SetLocalObject(oPriest, "NW_L_LASTDIED", GetLastRespawnButtonPresser());
      // * April 2002: Moved penalty here, only when going back to the death temple
      ApplyPenalty(oRespawner);
    }
    object oSpawnPoint = GetObjectByTag(sDestTag);
    AssignCommand(oRespawner,JumpToLocation(GetLocation(oSpawnPoint)));
  }
  else
  {
    // * do nothing, just 'res where you are.
  }
}
