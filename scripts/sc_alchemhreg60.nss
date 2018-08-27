#include "nw_i0_tool"

int StartingConditional() {
    // Check if player has a vial of water
    if (CheckPartyForItem(GetPCSpeaker(), "NW_IT_MSMLMISC13")) return TRUE;
    return FALSE;
}
