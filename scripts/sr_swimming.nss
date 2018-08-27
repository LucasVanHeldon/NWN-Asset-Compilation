// Swimming Code, Version 1.01 (by ShadeRaven)

// DC is passed.  This should be roughly the following:
//      Calm Water -   DC 10
//      Rough Water -  DC 15
//      Stormy Water - DC 20
// nChecks is the # of Checks (aka Distance) that should be made for a successful
//      swim to be returned.
// iCold defaults to FALSE, but if TRUE, Hypothermia damage is a possibility.
// iRough defaults to FALSE, with a 1 (or TRUE) being Normal Rough (d3 damage/round)
//      and a 2 being Rocky Rough (d6 damage/round).
// iDuress isn't used (yet) but will eventually reflect having to swim without preperation.
int SwimCheck(object oPC, int iDC, int nChecks, int iCold=FALSE, int iRough=FALSE, int iDuress=FALSE)
{
    // Character Strips off Equipment
    //   Note: Items should be destroyed if this is done under duress and the
    //         player had to strip equipment or drown.
    //   Alternative:  Give the player the option to remove items by slot and
    //         apply a penalty for each item the character doesn't strip.
    if (!iDuress) {
//        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST)));
//        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND)));
//        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)));
//        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD)));
//        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOOTS)));
//        AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CLOAK)));
    } else {
        // Future Code for Swimming under Duress
    }

    // Swimming Skill is Determined.
    //  a) Strength Modifier
    //  b) Barbarian, Druid, Ranger get their level added as skill ranks
    //  c) Bard, Fighter, Monk, Rogue get half their level as skill ranks
    //  d) Cleric, Sorcerer, and Wizard don't have Swim as a class skill so get 0 ranks
    //  e) Dwarves are -2 to Swimming (this is a RP racial bias - not a hardfast rule)
    int iSkill = GetAbilityModifier(ABILITY_STRENGTH, oPC);
    iSkill += GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC);
    iSkill += GetLevelByClass(CLASS_TYPE_BARD, oPC)/2;
    iSkill += GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    iSkill += GetLevelByClass(CLASS_TYPE_FIGHTER, oPC)/2;
    iSkill += GetLevelByClass(CLASS_TYPE_MONK, oPC)/2;
    iSkill += GetLevelByClass(CLASS_TYPE_RANGER, oPC);
    iSkill += GetLevelByClass(CLASS_TYPE_ROGUE, oPC)/2;
    if (GetRacialType(oPC) == RACIAL_TYPE_DWARF)
        iSkill -= 2;

    // Number of Round Drowning and Drowning DC
    int nDrowning = 0;
    int iDrownDC = 10;
    int iOrigDC = iDC;
    int iDam = 0;
    // Start the Checking Process
    int nTries = 0;
    while (nTries < nChecks) {
        // Rough Waters?  Take damage every round.
        int iRDam = d3();
        if (iRough==2)
            iRDam = d6();
        if (iRough>0) {
            SendMessageToPC(oPC, "You take rough water damage.");
            iDam+=iRDam;
        }

        int iResult = d20() + iSkill - iDC;
        // Success
        if (iResult >= 0) {
            nTries++;
            SendMessageToPC(oPC, "Successful swim of segment " + IntToString(nTries) + ".");
        // Failure
        } else if (iResult > -5) {
            SendMessageToPC(oPC, "Tred water in segment " + IntToString(nTries+1) + ".");
            if (iDC > iOrigDC)
                iDC = iOrigDC;
            nDrowning=0;
        } else {
            // Drowning
            /* MESSAGE removed because gets spammy
            SendMessageToPC(oPC, "Failed swim on length" + IntToString(nTries+1) +
                    " with a result of " + IntToString(iResult) + " versus DC: "+
                    IntToString(iDC) + " with a skill of " + IntToString(iSkill));
            */
              // The DC goes up by 1.
              iDC++;
              nDrowning++;
              // Hypothermia ??
              if (iCold)
                iDam+=d6();
              // Can hold breath for 2x Con Score
              if (nDrowning > GetAbilityScore(oPC, ABILITY_CONSTITUTION)*2) {
                  //Uh oh, time to make Con Checks
                  if ((d20()+GetAbilityModifier(ABILITY_CONSTITUTION, oPC)) < iDrownDC) {
                      // Drowned - R.I.P.
                        SendMessageToPC(oPC, "You drown within the depths of the water.");
                      int iHPs = GetCurrentHitPoints(oPC);
                      effect eDamage = EffectDamage(iHPs+10, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
                      ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
                      return FALSE;
                  } // glug
                  iDrownDC++;
              } // Made Con Check
        } // Bad Failure on Swim
    } // While loop
    // Succeeded.
    if (iDam>0) {
        effect eDamage = EffectDamage(iDam, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
    }
    return TRUE;
}
