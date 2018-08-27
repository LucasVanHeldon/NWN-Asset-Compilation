#include "nw_i0_plot"

void CreateStackedItem(string strItemTag, object oPC, int iStackSize) {
       CreateItemOnObject(strItemTag, oPC, iStackSize);
}

void main() {
    string strReagent = "Ruby";
    string strItemTag = "NW_IT_GEM006";
    object oSelf = OBJECT_SELF;
    object oPC = GetPCSpeaker();
    int nTotal;

    // Get the variable from the Alchem kit
    nTotal = (GetLocalInt(oSelf, strReagent)) + 1;
    SetLocalInt(oSelf, strReagent, nTotal);

    // Remove the item from the PC's inventory
    object oItem = GetItemPossessedBy(oPC, strItemTag);
    int iStack = GetNumStackedItems(oItem);
    DestroyObject(oItem);   // Takes entire stack
    AssignCommand(oSelf, DelayCommand(1.0, CreateStackedItem(strItemTag, oPC, (iStack - 1))));
}
