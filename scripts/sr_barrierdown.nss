#include "nw_i0_tool"

void main()
{
    object oPC = GetEnteringObject();
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(oPC, "scrollfreedomord");

    if (GetIsPC(oPC) && GetIsObjectValid(oItemToTake) != 0) {
        // SR's KotB plots:
        int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");

        if (iBarrierState <= 21) {
            FloatingTextStringOnCreature("Standing before the Barrier of Chaos, you take out the Scroll of Freedom of Order and recite it.", oPC);
            DestroyObject(oItemToTake);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
                EffectVisualEffect(VFX_DUR_FREEDOM_OF_MOVEMENT), GetLocation(oPC));
            AddJournalQuestEntry("coc_q2_barrier", 22, oPC);
            RewardPartyXP(250, oPC);
            DestroyObject(GetObjectByTag("BarrierF1"));
            DestroyObject(GetObjectByTag("BarrierF2"));
            DestroyObject(GetObjectByTag("BarrierF3"));
            DestroyObject(GetObjectByTag("BarrierF4"));
            DestroyObject(GetObjectByTag("BarrierJ1"));
            DestroyObject(GetObjectByTag("BarrierJ2"));
            DestroyObject(GetObjectByTag("BarrierJ3"));
            DestroyObject(GetObjectByTag("BarrierJ4"));
            DestroyObject(GetObjectByTag("BarrierK1"));
            DestroyObject(GetObjectByTag("BarrierK2"));
            DestroyObject(GetObjectByTag("BarrierK3"));
            DestroyObject(GetObjectByTag("BarrierK4"));
            FloatingTextStringOnCreature("The barrier is broken and entering the caves is now possible.", oPC);
        }
    }
}
