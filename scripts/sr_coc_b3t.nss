//#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        object oWP1 = GetObjectByTag("sr_coc_b3wp1");

        FloatingTextStringOnCreature("This chamber is a mess of refuse, food scraps, and assorted garbage.  Unfortunately, it appears that you have also disturbed its small residents.", oPC);
        CreateObject(OBJECT_TYPE_CREATURE, "CarrionBat", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "CarrionBat", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "CarrionBat", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "CarrionBat", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "CarrionBat", GetLocation(oWP1));
    }
}
