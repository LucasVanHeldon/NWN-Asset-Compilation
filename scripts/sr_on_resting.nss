#include "sr_i0_wandering"
#include "sr_constants_inc"
void main()
{
    object oMod = GetModule();
    object oPC = GetLastPCRested();
    int nCurrHP = GetCurrentHitPoints(oPC);
    string sPC = GetName(oPC);
    int iRestPeriod = 2 + FloatToInt((GetHitDice(oPC) * 0.5) - 0.25);
    if (!RESTON) iRestPeriod=0;

    if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
    {
        SetLocalInt(oMod,"StartRest" + sPC, nCurrHP);
        effect eSnore = EffectVisualEffect(VFX_IMP_SLEEP);
        string sRestText = GetName(oPC) + " hasn't waited long enough to rest.";

        //First get the time last rested and the current time.
        int iLastHourRest = GetLocalInt(oMod, ("LastHourRest" + sPC));
        int iLastDayRest = GetLocalInt(oMod, ("LastDayRest" + sPC));
        int iLastYearRest = GetLocalInt(oMod, ("LastYearRest" + sPC));
        int iLastMonthRest = GetLocalInt(oMod, ("LastMonthRest" + sPC));
        int iHour = GetTimeHour();
        int iDay  = GetCalendarDay();
        int iYear = GetCalendarYear();
        int iMonth = GetCalendarMonth();
        int iHowLong = 0;

        if (iLastYearRest != iYear)
            iMonth = iMonth + 12;
        if (iLastMonthRest != iMonth)
            iDay = iDay + 28;
        if (iDay != iLastDayRest)
            iHour = iHour + 24 * (iDay - iLastDayRest);

        iHowLong = iHour - iLastHourRest;

        if (iHowLong < iRestPeriod)
        {
            AssignCommand(oPC, ClearAllActions());
            string sRestText = GetName(oPC) + " has to wait another "  +
                IntToString(iRestPeriod - iHowLong) + " hours before they can rest again.";
            FloatingTextStringOnCreature(sRestText, oPC, FALSE);
        } else {
            SetCommandable(FALSE, oPC);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0);

            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0);
            DelayCommand(7.0, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSnore, oPC, 7.0));
//            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDazed(), oPC, 12.0);
            WandMonCheck(oPC);
        }
    }

    int nLastRestType = GetLastRestEventType();
    if (nLastRestType == REST_EVENTTYPE_REST_FINISHED || nLastRestType == REST_EVENTTYPE_REST_CANCELLED)
    {
        if(nLastRestType == REST_EVENTTYPE_REST_FINISHED)
        {
            int iHPGain = GetCurrentHitPoints(oPC) - nCurrHP;
            int nHD = GetHitDice(oPC) + GetSkillRank(SKILL_HEAL, oPC)
                + GetHasFeat(FEAT_SKILL_FOCUS_HEAL, oPC);
            if (GetAbilityModifier(ABILITY_WISDOM, oPC) > 0)
                nHD += GetAbilityModifier(ABILITY_WISDOM, oPC);

            int iAddHour = 0;
            if (iHPGain > nHD)
                iAddHour = (iHPGain - nHD)/5;

            SetLocalInt(oMod, ("LastHourRest" + sPC), GetTimeHour()+iAddHour);
            SetLocalInt(oMod, ("LastDayRest" + sPC), GetCalendarDay());
            SetLocalInt(oMod, ("LastMonthRest" + sPC), GetCalendarMonth());
            SetLocalInt(oMod, ("LastYearRest" + sPC), GetCalendarYear());

            SetCommandable(TRUE, oPC);

            int nSHP = GetLocalInt(oMod,("StartRest" + sPC));
            int nDam;
        }
    }
}
