//::///////////////////////////////////////////////////
//:: X0_O2_ANYLOW.NSS
//:: OnOpened/OnDeath script for a treasure container.
//:: Treasure type: Any, random selection from whatever is in base container
//:: Treasure level: TREASURE_TYPE_LOW
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 11/21/2002
//::///////////////////////////////////////////////////

//#include "x0_i0_treasure"
//#include "x2_inc_compon"

void main()
{

    object oPC = GetLastDisturbed();

    if (!GetIsPC(oPC)) return;

    int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

    if (DoOnce==TRUE) return;
    else
    {
        SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

        AdjustAlignment(oPC, ALIGNMENT_CHAOTIC, 3);
    }
}

