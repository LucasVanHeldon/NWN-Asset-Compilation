#include "NW_I0_GENERIC"

void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "grufftalk", 3);
    AdjustReputation(GetPCSpeaker(), OBJECT_SELF, -100);
    DetermineCombatRound();
}
