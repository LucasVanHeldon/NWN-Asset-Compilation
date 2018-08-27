#include "nw_i0_tool"

int StartingConditional() {
    // Check if player has a vial of water
    if ( (CheckPartyForItem(GetPCSpeaker(), "NW_IT_MSMLMISC24")) || (CheckPartyForItem(GetPCSpeaker(), "cu_food001"))) return TRUE;
    return FALSE;
}
