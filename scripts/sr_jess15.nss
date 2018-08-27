#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    object oPC = GetFirstFactionMember(GetPCSpeaker(), TRUE);
    while (GetIsObjectValid(oPC)) {
        AdjustAlignment(oPC, ALIGNMENT_GOOD, 5);
        oPC = GetNextFactionMember(GetPCSpeaker(), TRUE);
    }
}
