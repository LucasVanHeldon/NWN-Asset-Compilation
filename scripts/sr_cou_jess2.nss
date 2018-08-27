//#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();
    object oJess = GetObjectByTag("ShadowofJess");
    location lJess = GetLocation(oJess);
    int iJessState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q1_jess");

    if (!iTripped && GetIsPC(oPC) && iJessState == 5)
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("With the Shadow of Jess just ahead, the Potion of Banishment is quickly unstoppered.", oPC);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE), GetLocation(oJess));
        ActionWait(2.0);
        FloatingTextStringOnCreature("Noooooo!", oJess, FALSE);
        AddJournalQuestEntry("keep_q1_jess", 6, oPC);
        ActionWait(2.0);
        FloatingTextStringOnCreature("You see a blur of mist streak towards the north.", oPC);
        CreateObject(OBJECT_TYPE_ITEM, "CryptKey", lJess);
        DestroyObject(oJess);
        DestroyObject(GetObjectByTag("PotionBanishment"));
    }
}
