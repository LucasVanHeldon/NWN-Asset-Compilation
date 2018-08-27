#include "nw_i0_tool"

int StartingConditional()
{

    if(!(AutoDC(DC_EASY, SKILL_PERSUADE, GetPCSpeaker())))
        return FALSE;

    return TRUE;
}
