//::///////////////////////////////////////////////
//:: Resets Poor Room One for use again.
//:: pri_poor1done
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script calles the ClearRoom function found in
"_rsa_dmrest." For more information, please see
that script.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

#include "pri_doner_inc"

void main()
{
ClearRoom("RSA_Poor_1", "PoorAutoDoor");
}
