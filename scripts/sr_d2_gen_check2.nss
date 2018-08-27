#include "NW_I0_GENERIC"

int StartingConditional()
{
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION)) {
        if(GetIsObjectValid(GetPCSpeaker())) {
            return TRUE;
        }
    }
    return FALSE;
}

