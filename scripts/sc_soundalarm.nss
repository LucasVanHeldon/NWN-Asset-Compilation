//:://////////////////////////////////////////////////////////////////
//:: Sound an alarm
//:: SC_SOUNDALARM
//:://////////////////////////////////////////////////////////////////
/*
Place this script in the "OnPerception" and "OnHeartbeat" events.
If the NPC perceives (sees) a PC, it will try to run towards a predefined waypoint (lAlarm), shout a warning and activate and encounter.
When the PC is perceived, the NPC sets the local variable "iSoundAlarm". The NPC will then say a string (string sShout), run towards a waypoint (lAlarm). When it gets within a certain range of the waypoint (fSoundDistance), it will shout another warning (sAlarm) and activate an encounter (oEncounter).
To use, add this script to the "onUserDefined" script. You also need a waypoint for where the alarm is to be sounded and an encounter. Change the tags or the code as you see fit. Make sure the "OnPerceived" and "OnHeartbeat" events are flagged on in the NPCs spawn script.
Possible uses for this script : Let a sentry alert other troops. The PCs have a chance to stop the NPC before it sounds the alarm, and thus avoids the encounter.
Please send any comments you might have :-)
*/
//:://////////////////////////////////////////////////////////////////
//:: Created By: Lars-Jacob Hove
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////////////////////////
void main()
{
    int nUser = GetUserDefinedEventNumber();
    if (nUser = 1002)
    {
        // Variables
        location lAlarm = GetLocation(GetObjectByTag("WP_Alarm"));  // Location of alarm-spot
        location lNpcLoc = GetLocation(OBJECT_SELF);                // Location of NPC
        int iSounded = GetLocalInt(OBJECT_SELF, "iSoundAlarm");     // Flag for checking if alarm is being sounded
        float fSoundDistance = 5.0f;                                // Distance for sounding alarm
        object oEncounter = GetObjectByTag("OrcAlarm");            // Encounter object
        string sAlarm = "Alarm! Alarm! Intruders!";                 // Alarm signal. Replace as fit.
        if (iSounded == 1) // Only do this if alarm is checked
        {
            ClearAllActions(); // Uncheck this if you want the NPC to always run towards the alarm.
            if (GetDistanceBetweenLocations(lAlarm, lNpcLoc) < fSoundDistance)
            {
                ActionSpeakString(sAlarm);
                SetEncounterActive(TRUE, oEncounter);
            }//if
        }//if
    }//if
    else if (nUser = 1002)
    {
        // Variables
        location lAlarm = GetLocation(GetObjectByTag("WP_Alarm"));  // Location of alarm-spot
        int iSounded = GetLocalInt(OBJECT_SELF, "iSoundAlarm");     // Flag for checking if alarm is being sounded
        string sShout = "Intruders spotted!";                       // Exclamation when spotting PC. Replace as fit.
        if (iSounded != 1)  // Do not sound alarm twice.
        {
            object oPerceived = GetLastPerceived();
            if ((GetLastPerceptionSeen()) && GetIsPC(oPerceived))
            {
                ActionSpeakString(sShout);
                ActionMoveToLocation(lAlarm, TRUE);
                SetLocalInt(OBJECT_SELF, "iSoundAlarm", 1);
            }
        }// if
    }//if
}//main
