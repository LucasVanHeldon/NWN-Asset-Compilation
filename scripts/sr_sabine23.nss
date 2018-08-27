#include "nw_i0_plot"

int StartingConditional()
{
    int iSabineState = GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYSabinesLoss");

    if (iSabineState == 2 || iSabineState == 1)
        return TRUE;
    return FALSE;
}
