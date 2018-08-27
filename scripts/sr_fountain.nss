#include "nw_i0_plot"
void main()
{
    int iFouledState = GetLocalInt(GetLastUsedBy(), "NW_JOURNAL_ENTRYFouledWaters");

    if (iFouledState < 4)
        SendMessageToPC(GetLastUsedBy(), "The waters to the fountain look discolored and a pungent smell comes from it.");
    else
        SendMessageToPC(GetLastUsedBy(), "The fountain bubbles with crisp, clean water.");
}
