void main()
{
    // Melissa2 runs to WP and scream
    object oMel = GetObjectByTag("melissa2");
    object oWP6 = GetObjectByTag("NP_WIGHT");
    AssignCommand( oMel, ActionMoveToObject(oWP6, TRUE));
    AssignCommand( oWP6, PlaySound("as_pl_screamf1"));

    // Create wight


    CreateObject(OBJECT_TYPE_CREATURE, "sr_wight", GetLocation(oWP6));

    // Destroy Wight_Conv_Trigger, and Melissa2, and set this trap off
    object oWightConv = GetObjectByTag("Wight_Conv_Trigger");

    object oWTrap = GetObjectByTag("Wight_Trap");
    DestroyObject(oWightConv, 2.0);
    DestroyObject(oMel, 2.0);

    SetTrapDisabled(oWTrap);

}
