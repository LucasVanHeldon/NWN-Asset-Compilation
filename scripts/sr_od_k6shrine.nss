#include "nw_i0_tool"

void main()
{
    object oPC = GetLastAttacker();
    int iShrineState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q5_shrine");

    if (iShrineState < 99)
    {
        PlaySound("as_cv_belltower3");
        AddJournalQuestEntry("coc_q5_shrine", 2, oPC);
        FloatingTextStringOnCreature("You get a feeling of great relief for having destroyed the altar.",
                oPC);
        SetLocalInt(GetArea(oPC), "Shrine", 99);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_IMP_AURA_HOLY), GetLocation(OBJECT_SELF));
        RewardPartyXP(250, oPC);
        DestroyObject(GetObjectByTag("BlackMoonSparks"));
    }

}
