#include "nw_i0_tool"

int StartingConditional()
{

    if(GetSkillRank(SKILL_PERSUADE, GetPCSpeaker()) < 7)
        return FALSE;

    return TRUE;
}
