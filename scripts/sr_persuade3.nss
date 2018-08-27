#include "nw_i0_tool"

int StartingConditional()
{

    if(GetSkillRank(SKILL_PERSUADE, GetPCSpeaker()) < 3)
        return FALSE;

    return TRUE;
}
