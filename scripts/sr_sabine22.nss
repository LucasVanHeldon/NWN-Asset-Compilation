//#include "nw_i0_tool"
#include "nw_i0_plot"

int StartingConditional()
{
    int iSabineState = GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYSabinesLoss");

    // Make sure the PC speaker has these items in their inventory
    if(!HasItem(GetPCSpeaker(), "simplegoldsilver") || iSabineState == 199)
        return FALSE;

    return TRUE;
}

