#include "nw_i0_tool"

int StartingConditional() {
    // Check if player has a vial of water
    if (!CheckPartyForItem(GetPCSpeaker(), "EmptyVile") && !CheckPartyForItem(GetPCSpeaker(), "EmptyBottle")) return TRUE;
    return FALSE;
}
