#include "nw_i0_tool"

int StartingConditional() {
    // Check if player has a vial of water
    if (CheckPartyForItem(GetPCSpeaker(), "cu_reag021") || CheckPartyForItem(GetPCSpeaker(), "cu_food007")) return TRUE;
    return FALSE;
}
