#include "sr_i0_wandering"

void main()
{
    object oPC = GetLastAttacker();
    string sPC = GetName(oPC);

    WandMonCheck(oPC, TRUE);
}
