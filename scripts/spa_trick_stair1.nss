//:://////////////////////////////////////////
//:: spa_trick_stair1
//:://////////////////////////////////////////
//:://////////////////////////////////////////
//:: Created By: Jazael  (Thanks A-Million!!!)
//:: Created On: 03/12/2003
//:://////////////////////////////////////////

//Create a door, and place this in the OnAreaTransition script handler.
//Set the doors Will Saving throw to the DC for the Wisdom check that is made.
void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget (OBJECT_SELF);
    float fDelay = 0.0;
    if (!GetLocalInt (OBJECT_SELF, "DO_ONCE"))
        {
            if (GetRacialType (oClicker) == RACIAL_TYPE_DWARF)
                {
                    int nOpenScore = d20() + GetAbilityModifier (ABILITY_WISDOM, oClicker) + 2;
                    if (nOpenScore >= GetWillSavingThrow (oTarget))
                        {
                            SpeakString ("You have noticed that the flagstones before the stairs are loose, but you cunningly disable the trap most likely designed to cause the stones to slip.");
                            oTarget = GetObjectByTag ("WP_Trick_Stairs2");
                        }

                    else
                        {
                            SpeakString ("You have noticed something odd about the stones before the stairs, but are unable to stop yourself in time from triggering a form of trap which causes the stairs to suddenly slant creating a slide.");
                            oTarget = GetObjectByTag ("WP_Trick_Stairs");
                        }
                }
            else
            {
            SpeakString ("As you proceed through the doorway you fail to notice the loose flagstones on the stairs, which slip, causing the stairs to slant. You slide down the rest of the stairway, landing well within the next room.");
            oTarget = GetObjectByTag ("WP_Trick_Stairs");
            }
            SetLocalInt (OBJECT_SELF, "DO_ONCE", TRUE);
            fDelay = 3.0f;

        }

    location lLoc = GetLocation (oTarget);
    DelayCommand (fDelay, AssignCommand (oClicker, JumpToLocation (lLoc)));
}
