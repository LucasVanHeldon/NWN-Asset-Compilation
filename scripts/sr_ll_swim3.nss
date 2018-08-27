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

    if (SwimCheck(oPC, 12, 2)) {
        location lSwimWP = GetLocation(GetObjectByTag("Landing_LLWP2"));
        AssignCommand(oPC,ClearAllActions());
        AssignCommand(oPC, ActionJumpToLocation(lSwimWP));
        SendMessageToPC(oPC, "You climb out of the water, dripping wet but safe.");
    }
}
