// Pausanias's equip code
// Try to equip an item in the given slot, with feedback.

void trytoequip(object oItem, int iSlot, string sDescr)
{

    if (GetIdentified(oItem)) SpeakString("I'm equipping the "+GetName(oItem));
    else SpeakString("I'm equipping the "+sDescr);
    DelayCommand(0.1,ActionEquipItem(oItem,iSlot));
    DelayCommand(0.1,ActionEquipItem(oItem,iSlot));
    DelayCommand(0.1,ActionEquipItem(oItem,iSlot));

}

// Try to figure out what to do with an item.
void trytouse(object oItem)
{
    int iRing;
    switch (GetBaseItemType(oItem)) {

        case BASE_ITEM_ARMOR:
            trytoequip(oItem,INVENTORY_SLOT_CHEST,"piece of armor.");
            break;

        //case BASE_ITEM_LARGESHIELD:
        //case BASE_ITEM_SMALLSHIELD:
        //case BASE_ITEM_TOWERSHIELD:
        //    trytoequip(oItem,INVENTORY_SLOT_LEFTHAND,"shield.");
        //    break;

        case BASE_ITEM_CLOAK:
            trytoequip(oItem,INVENTORY_SLOT_CLOAK,"cloak.");
            break;

        case BASE_ITEM_BOOTS:
            trytoequip(oItem,INVENTORY_SLOT_BOOTS,"pair of boots.");
            break;

        case BASE_ITEM_BRACER:
        case BASE_ITEM_GLOVES:
            trytoequip(oItem,INVENTORY_SLOT_ARMS,"handwear.");
            break;

        case BASE_ITEM_HELMET:
            trytoequip(oItem,INVENTORY_SLOT_HEAD,"helmet.");
            break;

        case BASE_ITEM_BELT:
            trytoequip(oItem,INVENTORY_SLOT_BELT,"belt.");
            break;

        // Here we're actually trying to get the henchman to wear
        // two rings.
        case BASE_ITEM_RING: {

            if (GetLocalInt(OBJECT_SELF,"RightFree")) {
               trytoequip(oItem,INVENTORY_SLOT_RIGHTRING,"ring.");
               SetLocalInt(OBJECT_SELF,"RightFree",FALSE);
            }
            else if (GetLocalInt(OBJECT_SELF,"LeftFree")) {
               trytoequip(oItem,INVENTORY_SLOT_LEFTRING,"ring.");
               SetLocalInt(OBJECT_SELF,"LeftFree",FALSE);
            }
            else
               SpeakString("You've given me more than two rings to wear.");
         }
         break;

        case BASE_ITEM_AMULET:
            trytoequip(oItem,INVENTORY_SLOT_NECK,"amulet.");
            break;

        case BASE_ITEM_ARROW:
        //    trytoequip(oItem,INVENTORY_SLOT_ARROWS,"set of arrows ("+
        //               IntToString(GetNumStackedItems(oItem))+").");
        //    break;

        case BASE_ITEM_BULLET:
        //    trytoequip(oItem,INVENTORY_SLOT_BULLETS,"set of bullets ("+
        //               IntToString(GetNumStackedItems(oItem))+").");
        //    break;

        case BASE_ITEM_BOLT:
        //    trytoequip(oItem,INVENTORY_SLOT_BOLTS,"set of bolts ("+
        //               IntToString(GetNumStackedItems(oItem))+").");
        //    break;

        // THESE SHOULD BE EDITED SO THAT THE HENCHMAN DEALS WITH THEM
        // PROPERLY. FOR NOW THEY ARE IGNORED
        case BASE_ITEM_CREATUREITEM:
        case BASE_ITEM_GEM:
        case BASE_ITEM_KEY:
        case BASE_ITEM_MAGICROD:
        case BASE_ITEM_MAGICSTAFF:
        case BASE_ITEM_MAGICWAND:
        case BASE_ITEM_POTIONS:
        case BASE_ITEM_SPELLSCROLL:
        case BASE_ITEM_THIEVESTOOLS:
        case BASE_ITEM_TRAPKIT:
            break;

        case BASE_ITEM_TORCH:
            trytoequip(oItem,INVENTORY_SLOT_LEFTHAND,"torch.");
            break;

        default:
            break;

     }
}

void main() {
    // OK, now try to equip the NPC's items.
    ClearAllActions();

    SetLocalInt(OBJECT_SELF,"RightFree",
        !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTRING)));
    SetLocalInt(OBJECT_SELF,"LeftFree",
        !GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_LEFTRING)));

    object oItem = GetFirstItemInInventory(OBJECT_SELF);

    while (GetIsObjectValid(oItem)) {
        trytouse(oItem);
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }
}

