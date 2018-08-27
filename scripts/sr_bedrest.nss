#include "NW_I0_PLOT"

void main()
{
    string sPC=GetName(GetPCSpeaker());
    object oMod = GetModule();
    SetLocalInt(oMod, ("LastHourRest" + sPC), 0);
    SetLocalInt(oMod, ("LastDayRest" + sPC), 0);
    SetLocalInt(oMod, ("LastMonthRest" + sPC), 0);
    SetLocalInt(oMod, ("LastYearRest" + sPC), 0);
    AssignCommand(GetPCSpeaker(), ActionRest());
}

