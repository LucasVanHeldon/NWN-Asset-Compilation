void main() {
    string strReagent = "FalconsFeather";
    string strItemTag = "cu_reag004";
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + 1;
    SetLocalInt(oSelf, strReagent, nTotal);

    // Remove the item from the PC's inventory
    object oItem = GetItemPossessedBy(oPC, strItemTag);
    DestroyObject(oItem);
}
