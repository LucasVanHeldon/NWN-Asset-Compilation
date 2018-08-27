#include "nw_i0_plot"

int StartingConditional()
{
    int iFouledState = GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYFouledWaters");

    if (iFouledState > 3)
        return TRUE;
    return FALSE;
}
