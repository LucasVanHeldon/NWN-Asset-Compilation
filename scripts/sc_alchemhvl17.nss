#include "nw_i0_tool"

int StartingConditional()
{
    int iResult;

    iResult = CheckPartyForItem(GetPCSpeaker(), "NW_IT_GEM001");
    return iResult;
}
