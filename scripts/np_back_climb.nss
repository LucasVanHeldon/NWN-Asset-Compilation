   //CLIMBING BACK SCRIPT (sorry for the author, I had to modify it)

void main()
{
    object oPlayer = GetLastUsedBy();
    int nStrMod = GetAbilityModifier (ABILITY_STRENGTH, oPlayer);
    effect eDamage = EffectDamage (d10(1), DAMAGE_TYPE_BLUDGEONING);
    int nRoll = d20();
    object oWaypoint = GetWaypointByTag ("WP_Forest");
    location lWaypoint = GetLocation (oWaypoint);
    int nClimb = GetLocalInt( OBJECT_SELF, "ClimbRope");

    if ( (nRoll + nStrMod) >= 15)
    {

        AssignCommand (oPlayer, ActionJumpToObject (oWaypoint));
        ActionSpeakString ("You've managed to climb down the cliff", TALKVOLUME_TALK);


    }
    else
    if ( (nRoll + nStrMod) <= 14 && (nRoll + nStrMod) >= 11)
    {
        ActionSpeakString ("You can't seem to get a good hold to climb down the rock face.", TALKVOLUME_TALK);
        AssignCommand(oPlayer,ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 2.0));
    }
    else
    {
        ApplyEffectToObject (DURATION_TYPE_INSTANT, eDamage, oPlayer);
        PlaySound("as_pl_screamm1");
        ActionSpeakString ("You've fallen down the cliff and suffered injuries", TALKVOLUME_TALK);
        object oWaypoint = GetWaypointByTag ("NP_ClimbPoint");
        AssignCommand (oPlayer, ActionJumpToObject (oWaypoint));
        AssignCommand(oPlayer,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 2.0));
    }
    //Has the rope been created already?
    if( nClimb == 0 )
    {
     // No, ok, now create a secret object for us to use.
     CreateObject( OBJECT_TYPE_PLACEABLE, "climbingrope002", lWaypoint, TRUE);
     SetLocalInt(OBJECT_SELF, "nClimb", 1);
    }


}
