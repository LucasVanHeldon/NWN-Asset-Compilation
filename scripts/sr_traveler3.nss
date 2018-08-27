#include "nw_i0_plot"
int StartingConditional()
{

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "ArfluvanSilk"))
        return FALSE;

    return TRUE;
}
