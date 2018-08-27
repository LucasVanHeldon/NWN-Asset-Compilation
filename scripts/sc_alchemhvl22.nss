#include "nw_i0_tool"

int StartingConditional()
{
    int iResult;

    iResult = CheckPartyForItem(GetPCSpeaker(), "NW_IT_GEM010");
    return iResult;
}
