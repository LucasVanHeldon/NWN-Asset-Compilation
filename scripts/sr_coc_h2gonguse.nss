void main()
{
    PlaySound("as_cv_gongring3");
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");

    if (!iTripped) {
        SetLocalInt(OBJECT_SELF, "Tripped", TRUE);
        object oWP1 = GetObjectByTag("Bugbear_H2WP1");
        object oWP2 = GetObjectByTag("Bugbear_H2WP2");
        object oWP3 = GetObjectByTag("Bugbear_H2WP3");
        object oWP4 = GetObjectByTag("Bugbear_H2WP4");

        CreateObject(OBJECT_TYPE_CREATURE, "MoonBugbear1", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "MoonBugbear2", GetLocation(oWP2));
        CreateObject(OBJECT_TYPE_CREATURE, "MoonBugbear1", GetLocation(oWP3));
        CreateObject(OBJECT_TYPE_CREATURE, "MoonBugbear2", GetLocation(oWP4));
    }

    object oPC = GetFirstPC();
    object oBugbear = GetObjectByTag("MoonBugbear1");
    // Set the faction to hate the player, then attack the player
    while (GetIsObjectValid(oPC)) {
        AdjustReputation(oPC, oBugbear, -100);
        AdjustReputation(oBugbear, oPC, -100);
        oPC = GetNextPC();
    }
}
