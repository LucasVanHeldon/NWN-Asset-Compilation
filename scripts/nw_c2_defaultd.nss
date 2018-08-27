#include "NW_I0_GENERIC"
#include "sr_constants_inc"
//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
void main()
{
// enter desired behaviour here
    int iEvent = GetUserDefinedEventNumber();

    switch (iEvent) {
      //OnPercieved
      case 1002:
        SpeakOneLinerConversation();
      break;

      case 1007: // Death Event - includes new XP chart.
        int BONUSXP=0;
        float fCR = GetChallengeRating(OBJECT_SELF);
        int nMonsterXP;

        // Get number of party members, and average Party Level
        int nPartyMembers;
        int nHenchmen;
        int nPartyLevelSum;
        float fAvgPartyLevel;
        object oKiller = GetLastKiller();

        object oPC = GetFirstFactionMember(oKiller);
        object oKilledArea = GetArea(OBJECT_SELF);
        while(GetIsObjectValid(oPC)) {
            if (oKilledArea == GetArea(oPC)) {
                nPartyMembers++;
                nPartyLevelSum += GetCharacterLevel(oPC);
                if (GetIsObjectValid(GetHenchman(oPC)))
                    nHenchmen++;
                if (!(GetAnimalCompanionName(oPC)==""))
                    nHenchmen++;
            } // if
            oPC = GetNextFactionMember(oKiller, TRUE);
        } // while

        PrintString("=== DEATH EVENT ===");
        PrintString("Killer: " + GetName(oKiller));
        PrintString("Area: " + GetTag(oKilledArea));
        PrintString("# in Area: " + IntToString(nPartyMembers));

        if (nPartyMembers == 0) return;

        fAvgPartyLevel = IntToFloat(nPartyLevelSum) / IntToFloat(nPartyMembers);

        // Bring partylevel up to 3 if less than 3
        if (FloatToInt(fAvgPartyLevel) < 3) fAvgPartyLevel = 3.0;

        // Get the base Monster XP
        if ((FloatToInt(fAvgPartyLevel) <= 6) && (fCR < 1.5))
            nMonsterXP = BASEXP;
        else {
            nMonsterXP = BASEXP * FloatToInt(fAvgPartyLevel);
            int nDiff = FloatToInt(((fCR < 1.0) ? 1.0 : fCR) - fAvgPartyLevel);
            switch (nDiff) {
              case -7:
                nMonsterXP /= 12; break;
              case -6:
                nMonsterXP /= 8; break;
              case -5:
                nMonsterXP = nMonsterXP * 3 / 16; break;
              case -4:
                nMonsterXP /= 4; break;
              case -3:
                nMonsterXP /= 3; break;
              case -2:
                nMonsterXP /= 2; break;
              case -1:
                nMonsterXP = nMonsterXP * 2 / 3; break;
              case 0:
                break;
              case 1:
                nMonsterXP = nMonsterXP * 3 / 2; break;
              case 2:
                nMonsterXP *= 2; break;
              case 3:
                nMonsterXP *= 3; break;
              case 4:
                nMonsterXP *= 4; break;
              case 5:
                nMonsterXP *= 6; break;
              case 6:
                nMonsterXP *= 8; break;
              case 7:
                nMonsterXP *= 12; break;
              default:
                nMonsterXP = 0;
            } // switch
        } // if ((FloatToInt(fAvgPartyLevel) < 6) && (fCR < 1.5)) {...} else {

        // Calculations for CR < 1
        if (fCR < 0.76 && nMonsterXP) {
            if (fCR <= 0.11)
                nMonsterXP = nMonsterXP / 10;
            else if (fCR <= 0.13)
                nMonsterXP = nMonsterXP / 8;
            else if (fCR <= 0.18)
                nMonsterXP = nMonsterXP / 6;
            else if (fCR <= 0.28)
                nMonsterXP = nMonsterXP / 4;
            else if (fCR <= 0.4)
                nMonsterXP = nMonsterXP / 3;
            else if (fCR <= 0.76)
                nMonsterXP = nMonsterXP /2;
            // Only the CR vs Avg Level table could set nMonsterXP to 0... to fix any
            // round downs that result in 0:

            if (nMonsterXP == 0) nMonsterXP = 1;
        }  // CR < 1

        nMonsterXP += BONUSXP;

        PrintString("nMonsterXP: " + IntToString(nMonsterXP));
        PrintString("nHenchmen : " + IntToString(nHenchmen));
        if (nHenchmen > 0) {
            float fMonsterXP = IntToFloat(nMonsterXP * nPartyMembers) / (IntToFloat(nPartyMembers) + IntToFloat(nHenchmen)*0.5);
            nMonsterXP = FloatToInt(fMonsterXP);
            PrintString("nMonsterXP with Henchmen: " + IntToString(nMonsterXP));
        } // nHenchmen > 0

        int nCharXP = nMonsterXP / nPartyMembers;
        PrintString("nCharXP : " + IntToString(nCharXP));
        float fCharXP2 = IntToFloat(nMonsterXP / nPartyMembers) * 0.7;
        int nCharXP2 = FloatToInt(fCharXP2);
        PrintString("nCharXP2: " + IntToString(nCharXP2));
        float fCharXP3 = IntToFloat(nMonsterXP / nPartyMembers) * 0.6;
        int nCharXP3 = FloatToInt(fCharXP3);
        PrintString("nCharXP3: " + IntToString(nCharXP3));
        PrintString("=== End Death Event ===");

        oPC = GetFirstFactionMember(oKiller);
        while(GetIsObjectValid(oPC)) {
            if (oKilledArea == GetArea(oPC)) {
                if (GetSubRace(oPC) == "Gray Dwarf" || GetSubRace(oPC) == "Drow Elf") {
                    GiveXPToCreature(oPC, nCharXP2);
                } else if (GetSubRace(oPC) == "Deep Gnome") {
                    GiveXPToCreature(oPC, nCharXP3);
                } else {
                    GiveXPToCreature(oPC, nCharXP);
                }  // Gray or Drow

                // Alignment Adjustment System (Good/Evil)
                if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD) {
                    if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD)
                        AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
                    if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL && d100() == 1)
                        AdjustAlignment(oPC, ALIGNMENT_GOOD, 1);
                } else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL) {
                    if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD && d100() == 1)
                        AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
                    if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL && d20() == 1)
                        AdjustAlignment(oPC, ALIGNMENT_GOOD, 1);
                } else {
                    if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_GOOD)
                        AdjustAlignment(oPC, ALIGNMENT_EVIL, 1);
                    if (GetAlignmentGoodEvil(OBJECT_SELF) == ALIGNMENT_EVIL && d100() == 1)
                        AdjustAlignment(oPC, ALIGNMENT_GOOD, 1);
                }
            } // killed area

            oPC = GetNextFactionMember(oKiller, TRUE);
        } // while oPC

        return;
    } // Event 1007
}
