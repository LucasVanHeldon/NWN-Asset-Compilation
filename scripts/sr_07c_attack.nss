//::///////////////////////////////////////////////
//:: FileName sr_attack
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/19/2002 6:28:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_generic"

void main()
{
    object oPC = GetLastAttacker();

    SetPCDislike(oPC,GetObjectByTag("Dubricus"));
    SetPCDislike(oPC,GetObjectByTag("Flinytia"));
}
