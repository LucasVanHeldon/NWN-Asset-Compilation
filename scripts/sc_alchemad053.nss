#include "nw_i0_tool"

void main() {
    string strReagent = "Garlic";
    string strItemTag = "NW_IT_MSMLMISC24";
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + 1;
    SetLocalInt(oSelf, strReagent, nTotal);

    // Remove the item from the PC's inventory
    object oItem;
    if (CheckPartyForItem(oPC, "NW_IT_MSMLMISC24")) oItem = GetItemPossessedBy(oPC, strItemTag);
    if (CheckPartyForItem(oPC, "cu_food001")) oItem = GetItemPossessedBy(oPC, "cu_food001");
    DestroyObject(oItem);
}
