#include "sr_swimming"

void main()
{
    object oPC = GetPCSpeaker();

    AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CHEST)));
    AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND)));
    AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND)));
    AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_HEAD)));
    AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_BOOTS)));
    AssignCommand(oPC, ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_CLOAK)));

    if (SwimCheck(oPC, 14, 2)) {
        location lSwimWP = GetLocation(GetObjectByTag("Landing_LLWP1"));
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(lSwimWP));
        SendMessageToPC(oPC, "You burst from the water with a big gasp for air and clamber to the safety of a ledge.");
    }
}
