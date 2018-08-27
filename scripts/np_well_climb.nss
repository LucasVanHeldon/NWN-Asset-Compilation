   //CLIMBING BACK SCRIPT (sorry for the author, I had to modify it)

void main()
{
    object oPlayer = GetLastOpenedBy();
    int nStrMod = GetAbilityModifier (ABILITY_STRENGTH, oPlayer);
    effect eDamage = EffectDamage (d3(1), DAMAGE_TYPE_BLUDGEONING);
    int nRoll = d20();
    object oWaypoint = GetWaypointByTag ("WP_ClimbPoint");
    location lWaypoint = GetLocation (oWaypoint);
    int nDone = GetLocalInt( OBJECT_SELF, "FoundRope");

    if ( (nRoll + nStrMod) >= 15)
    {

        AssignCommand (oPlayer, ActionJumpToObject (oWaypoint));
        ActionSpeakString ("You've managed to climb down the well", TALKVOLUME_TALK);


    }
    else
    if ( (nRoll + nStrMod) <= 14 && (nRoll + nStrMod) >= 11)
    {
        ActionSpeakString ("You can't seem to get a good hold to climb down the well", TALKVOLUME_TALK);
        AssignCommand(oPlayer,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
    }
    else
    {
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDamage, oPlayer);
        PlaySound("as_pl_screamm1");
        ActionSpeakString ("You've fallen down the well and suffered injuries", TALKVOLUME_TALK);
        object oWaypoint = GetWaypointByTag ("WP_ClimbPoint");
        AssignCommand (oPlayer, ActionJumpToObject (oWaypoint));
        AssignCommand(oPlayer,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 2.0));
    }
    //Has the rope been created already?
    if( nDone == 0 )
    {
     // No, ok, now create a secret object for us to use.
     CreateObject( OBJECT_TYPE_PLACEABLE, "climbingrope001", lWaypoint, TRUE);
     SetLocalInt(OBJECT_SELF, "nDone", 1);
    }


}
