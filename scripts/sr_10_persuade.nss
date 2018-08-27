#include "sr_i0_tools"

int StartingConditional()
{

    // Perform skill checks
    if(!(RollDC(10, SKILL_PERSUADE, GetPCSpeaker())))
        return FALSE;

    return TRUE;
}
