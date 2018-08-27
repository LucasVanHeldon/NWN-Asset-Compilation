//#include "nw_i0_tool"
//#include "sr_i0_tools"

void main()
{
    object oPC = GetEnteringObject();
    int iShrineState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q5_shrine");

    if (GetIsPC(oPC) && iShrineState == 0)
    {
        PlaySound("as_pl_evilchantm");
        AddJournalQuestEntry("coc_q5_shrine", 1, oPC);
        FloatingTextStringOnCreature("You sense a strong pulsing evil coming from the altar to the south.",
                oPC);
        SetLocalInt(GetArea(oPC), "Shrine", 1);
        ActionCastSpellAtObject(SPELL_DARKNESS, oPC, METAMAGIC_NONE, TRUE);
        ActionCastSpellAtObject(SPELL_NEGATIVE_ENERGY_BURST, oPC, METAMAGIC_NONE, TRUE);
    }
}
