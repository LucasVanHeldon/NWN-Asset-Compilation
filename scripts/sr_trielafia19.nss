//#include "nw_i0_tool"
#include "nw_i0_plot"

int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "bottlefoulsewer"))
        return FALSE;

    return TRUE;
}
