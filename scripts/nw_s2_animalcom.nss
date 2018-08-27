#include "sr_constants_inc"

void main()
{
  if (!ACON) {
    SummonAnimalCompanion();
  } else {
    // Number of Hours between Animal Companions.
    object oMod = GetModule();
    int iACPeriod = 12;
    string sPC = GetName(OBJECT_SELF);
    string sACText = sPC + " hasn't waited long enough to summon another companion.";
    string sWildText = sPC + " isn't in a Wilderness Setting.";
    string sWillText = "The animal companion resisted the call of " + sPC + ".";

    //First get the time last rested and the current time.
    int iLastHourAC = GetLocalInt(oMod, ("LastHourAC" + sPC));
    int iLastDayAC = GetLocalInt(oMod, ("LastDayAC" + sPC));
    int iLastYearAC = GetLocalInt(oMod, ("LastYearAC" + sPC));
    int iLastMonthAC = GetLocalInt(oMod, ("LastMonthAC" + sPC));
    int iHour = GetTimeHour();
    int iDay  = GetCalendarDay();
    int iYear = GetCalendarYear();
    int iMonth = GetCalendarMonth();
    int iHowLong = 0;

    if (iLastYearAC != iYear)
        iMonth = iMonth + 12;
    if (iLastMonthAC != iMonth)
        iDay = iDay + 28;
    if (iDay != iLastDayAC)
        iHour = iHour + 24 * (iDay - iLastDayAC);

    iHowLong = iHour - iLastHourAC;

    // Not waited long enough?
    if (iHowLong < iACPeriod || GetLocalInt(GetArea(OBJECT_SELF), "Wilderness") == 0)
    {
        AssignCommand(OBJECT_SELF, ClearAllActions());
        if (iHowLong < iACPeriod)
            FloatingTextStringOnCreature(sACText, OBJECT_SELF, FALSE);
        if (GetLocalInt(GetArea(OBJECT_SELF), "Wilderness") == 0)
            FloatingTextStringOnCreature(sWildText, OBJECT_SELF, FALSE);

    } else {
        SetLocalInt(oMod, ("LastHourAC" + sPC), GetTimeHour());
        SetLocalInt(oMod, ("LastDayAC" + sPC), GetCalendarDay());
        SetLocalInt(oMod, ("LastMonthAC" + sPC), GetCalendarMonth());
        SetLocalInt(oMod, ("LastYearAC" + sPC), GetCalendarYear());
        // The Will Save to resist the "Summons."
        //   - Base Will Save for Animals should = +1 per 3 levels
        //       (of Druid since the Druid Level = the AC's HD)
        int iHD = GetLevelByClass(CLASS_TYPE_DRUID);
        int iWillBonus = iHD/3;
        // The DC of Animal Friendship = 10 + 1 + Wis Mod
        int iDC = 10 + 1 + GetAbilityModifier(ABILITY_WISDOM);
        // Make Saving throw if Druid is over level 2.
        //   No save below level 3 because a Druid is supposed to get a free
        //   2 HD or less creature before then.
        if (d20()+iWillBonus >= iDC && iHD > 2) {
            FloatingTextStringOnCreature(sWillText, OBJECT_SELF, FALSE);
            // Give time back for next summon.  Making it half as long a wait.
            int iHour = GetTimeHour();
            iHour -= iACPeriod/2;
            if (iHour < 0) {
                SetLocalInt(oMod, ("LastHourAC" + sPC), iHour+24);
                SetLocalInt(oMod, ("LastDayAC" + sPC), GetCalendarDay()-1);
            } else {
                SetLocalInt(oMod, ("LastHourAC" + sPC), iHour);
            }
        } else {
            //Yep thats it
            SummonAnimalCompanion();
        }
    }
  } // Animal Companion On?
}
