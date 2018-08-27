void CreateStackedItem(string strItemTag, object oPC, int iStackSize) {
       CreateItemOnObject(strItemTag, oPC, iStackSize);
}

void main() {
    string strReagent = "VialofWater";
    string strItemTag = "cu_reag021";
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + 1;
    SetLocalInt(oSelf, strReagent, nTotal);

    // Remove the item from the PC's inventory
    object oItem = GetItemPossessedBy(oPC, strItemTag);
    if (!GetIsObjectValid(oItem)) { // Must have 'Water' food item (potion) not a 'Vial of Water'
        oItem = GetItemPossessedBy(oPC, "cu_food007");
        int iStack = GetNumStackedItems(oItem);
        AssignCommand(oSelf, DelayCommand(1.0, CreateStackedItem("cu_food007", oPC, (iStack - 1))));
    }
    DestroyObject(oItem);
}
