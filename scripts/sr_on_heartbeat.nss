#include "nw_i0_generic"

void pcdying(object oPC)
{
  object oMod = GetModule();
  string sName = GetName(oPC);
  int iLastHPs = GetLocalInt(oMod, "LastHP"+sName);

  // Have Henchman that's not in combat?
  if (GetIsObjectValid(GetHenchman(oPC))) {
    if (!GetIsInCombat(GetHenchman(oPC))) {
        AssignCommand(GetHenchman(oPC), ActionMoveToObject(oPC, TRUE));
        SendMessageToPC(oPC, "Your henchman tries to tend to your wounds.");
        int iTend = 0;
        if (GetSkillRank(SKILL_HEAL, GetHenchman(oPC)) < 1 && d4() == 1)
            iTend = 1;
        else
            iTend = 1+(GetSkillRank(SKILL_HEAL, GetHenchman(oPC))/5);
        if (iTend > 0)
            ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(iTend), oPC);
    } // not in combat?
  } // Henchman?


  // Between 0 & -9 and not Bleeding
  if (GetCurrentHitPoints(oPC)<1 && GetCurrentHitPoints(oPC)>-10 && GetLocalInt(oPC, "iDying") == 0) {
    int oDieroll = d100();
    string sDieroll = IntToString(oDieroll);

    // Show healing roll for the stabilized.
    SendMessageToPC(oPC, "  Healing Roll: " + sDieroll);

    // +1 HP on a roll of 1 to 10 (d100)
    if (oDieroll <= 10) {
      effect eHeal = EffectHeal(1);
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oPC);
    } // oDieroll <= 10
  } // if not bleeding

  // check current hitpoints..if the pc has been healed then stop bleeding
  if (GetCurrentHitPoints(oPC) > iLastHPs && GetLocalInt(oPC, "iDying") == 1) {
    SetLocalInt(oPC, "iDying", 0);

    // display text string to all players in faction.
    string sCurrhp = IntToString(GetCurrentHitPoints(oPC));
    FloatingTextStringOnCreature(sName + " has been stabilized by Healing at "
          + sCurrhp + " HPs.", oPC, TRUE);
  } // Stabilized by healing

  // If bleeding
  if (GetLocalInt(oPC, "iDying") == 1 && GetCurrentHitPoints(oPC)<1) {
    int oDieroll = d100();
    string sDieroll = IntToString(oDieroll);

    // show stabilize roll results for each round
    SendMessageToPC(oPC, "  Stabilize Roll: " + sDieroll);

    if (oDieroll <=10) {
      SetLocalInt(oPC, "iDying", 0);

      // display text string to all players in faction.
      string sCurrhp = IntToString(GetCurrentHitPoints(oPC));
      FloatingTextStringOnCreature(sName + " has Self-Stabilized at " + sCurrhp + " HPs", oPC, TRUE);
    } // oDieRoll
  } // if bleeding

  if (GetLocalInt(oPC, "iDying") == 1) {
    // pc is still bleeding add one point of damage
    effect eDamage = EffectDamage(1, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    SetLocalInt(oMod,"LastHP"+sName, GetCurrentHitPoints(oPC));
    string sCurrhp = IntToString(GetCurrentHitPoints(oPC));

    // display text string to all players in faction until pc is dead.
    if (GetCurrentHitPoints(oPC) > -10)
      FloatingTextStringOnCreature(sName + " is Bleeding! HPs are currently at " + sCurrhp, oPC, TRUE);
  } // iDying == 1

  // Coup de Grace
  if (GetCurrentHitPoints(oPC)<1 && GetCurrentHitPoints(oPC)>-10) {
    int which = d100();
    switch (which) {
        case 1: PlayVoiceChat(VOICE_CHAT_PAIN1, oPC); break;
        case 2: PlayVoiceChat(VOICE_CHAT_PAIN2, oPC); break;
        case 3: PlayVoiceChat(VOICE_CHAT_PAIN3, oPC); break;
        case 4: PlayVoiceChat(VOICE_CHAT_HEALME, oPC); break;
        case 5: PlayVoiceChat(VOICE_CHAT_NEARDEATH, oPC); break;
        case 6: PlayVoiceChat(VOICE_CHAT_HELP, oPC); break;
    } // switch

    object oEnemy = GetNearestCreature(CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, oPC);

    if(!GetIsInCombat(oEnemy) && GetObjectSeen(oEnemy, oPC)
            && GetIsObjectValid(oEnemy) && GetReputation(oEnemy, oPC)<10) {
        FloatingTextStringOnCreature(GetName(oEnemy)+" has seen the dying "+ GetName(oPC), oPC);
        AssignCommand(oEnemy, ActionMoveToObject(oPC));
        FloatingTextStringOnCreature(GetName(oEnemy)+" is finishing off "+ GetName(oPC), oPC);
        effect eDamage = EffectDamage(10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    } // if oEnemy
  } // if HPs
} // PCDying

void main()
{
  // enumerate all PCs, check to make sure they are dying before executing functions
  object oMod = GetModule();
  object oPC = GetFirstPC();

  while (GetIsObjectValid(oPC)) {
    // only call user defined function if pc is dying then enumerate
    if (GetCurrentHitPoints(oPC)<1 && GetCurrentHitPoints(oPC)>-10)
      pcdying(oPC);

    string sName = GetName(oPC);
    SetLocalInt(oMod,"LastHP"+sName, GetCurrentHitPoints(oPC));

    oPC = GetNextPC();
  }
}
