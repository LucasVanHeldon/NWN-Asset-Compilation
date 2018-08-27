#include "NW_I0_PLOT"

void main()
{
    string sPC=GetName(GetPCSpeaker());
    object oMod = GetModule();
    int iHour = GetTimeHour() + 8;
    int iDay = GetCalendarDay();
    int iMonth=GetCalendarMonth();
    int iYear=GetCalendarYear();
    if (iHour>23) {
        iHour-=24;
        iDay++;
        if (iDay>28) {
            iDay=1;
            iMonth++;
        }
        if (iMonth>12) {
            iMonth=1;
            iYear++;
        }
        SetCalendar(iYear, iMonth, iDay);
    }
    SetTime(iHour, GetTimeMinute(), GetTimeSecond(), GetTimeMillisecond());

    if (d3()>1) {
        SetLocalInt(oMod, ("LastHourRest" + sPC), 0);
        SetLocalInt(oMod, ("LastDayRest" + sPC), 0);
        SetLocalInt(oMod, ("LastMonthRest" + sPC), 0);
        SetLocalInt(oMod, ("LastYearRest" + sPC), 0);
        AssignCommand(GetPCSpeaker(), ActionRest());
    } else
        SendMessageToPC(GetPCSpeaker(), "You rest but not well with all the activity around you.");
}

