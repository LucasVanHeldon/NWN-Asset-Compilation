void main()
{
    object oPC = GetLastOpenedBy();
    int iBearState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q6_bear");

    if (iBearState < 2 && GetIsObjectValid(GetNearestObjectByTag("BeeManBear", oPC)))
        FloatingTextStringOnCreature("The bear growls dangerously at the door's opening.", oPC);
}
