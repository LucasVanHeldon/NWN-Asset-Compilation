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

    if (SwimCheck(oPC, 10, 1)) {
        location lSwimWP = GetLocation(GetObjectByTag("Landing_WP2"));
        AssignCommand(oPC, ActionJumpToLocation(lSwimWP));
    }
}
