#include "nw_i0_tool"

int StartingConditional()
{

    // Perform skill checks
    if(!(AutoDC(DC_MEDIUM, SKILL_LORE, GetPCSpeaker())))
        return FALSE;

    return TRUE;
}
