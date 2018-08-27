void main() {
    string strReagent = "DragonBlood";
    string strItemTag = "NW_IT_MSMLMISC17";
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + 1;
    SetLocalInt(oSelf, strReagent, nTotal);

    // Remove the item from the PC's inventory
    object oItem = GetItemPossessedBy(oPC, strItemTag);
    if (oItem == OBJECT_INVALID) oItem = GetItemPossessedBy(oPC, "VileofDragonBlood");
    DestroyObject(oItem);
}
