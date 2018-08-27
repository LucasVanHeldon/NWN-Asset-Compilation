#include "nw_i0_tool"

int StartingConditional() {
    // Check if player has a vial of water
    if (CheckPartyForItem(GetPCSpeaker(), "cu_reag008")) return TRUE;
    if (CheckPartyForItem(GetPCSpeaker(), "cu_reag009")) return TRUE;
    return FALSE;
}
