//#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("The alcove to the south is thick with the smell of dead rats and long decayed corpses and the remains of each.", oPC);
    }
}
