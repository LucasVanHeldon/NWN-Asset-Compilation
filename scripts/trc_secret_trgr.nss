////////////////////////////////////////////////////////////////////////////////////////////
// trc_secret_trgr
//
////////////////////////////////////////////////////////////////////////////////////////////
// Process:
// - Create a trigger marking off the area where the secret object can be detected. A single
//   generic trigger with this script and approach works for every kind of secret object.
//
// - Edit the properties of the trigger as follows:
//   - Give the trigger a unique tag
//   - On the "Scripts" tab, use "trc_secret_trgr" or whatever you want to name your script
//     for the "On Enter" event
//   - Put the difficulty check in the name of the trigger (first two characters); this can
//     be followed by other characters for trigger identification (e.g., "15 DC Secret Door
//     Trigger", "22 DC Invisible Couch Trigger"). Only the first two characters matter.
//   - Put the ResRef of the type of object to be created when detection occurs into the
//     "Key Tag" field on the "Advanced" tab of the trigger.  ResRef's can't have spaces
//     in the string and neither can the Key Tag field; that makes this an appropriate use.
//
// - Create a waypoint named "LOC_<tag of trigger>" and place it where you want the object
//   to appear. Note that some items (like the trap door) have their orientation reversed;
//   test to make sure the item appears with the desired orientation.
//
// - If you are creating a secret transport object like a door or portal, create a waypoint
//   named "DST_<tag of trigger>" and place it where you want the user to appear after use.
//   Associates will be transported with the PC.
//
// - Reset of the object is automatic in this system.  An unattended object for thirty seconds
//   will have to be re-detected.  If at any time during the thirty seconds the object is
//   re-visited, the reset time starts over.
//
// - You can get a reference to the revealed secret item by using "GetSecretObjectReference()".
////////////////////////////////////////////////////////////////////////////////////////////
// CONSTANTS
const int UNDETECTED = 0;
const int DETECTED   = 1;
const int ATTENDED   = 2;
////////////////////////////////////////////////////////////////////////////////////////////
// SetSecretObjectStatus
//
// Inputs:  int nStatus - Status for trigger to be set on local variable
//
// Purpose: Hides the local variable from the user.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void SetSecretObjectStatus(int nStatus, object oTrigger = OBJECT_SELF)
{
   SetLocalInt(oTrigger, "STATUS", nStatus);
}///////////////////////////////////////////////////////////////////////////////////////////
// IsDetected
//
// Inputs:  None
//
// Purpose: Reports on whether or not the object has been detected by referencing the status.
//
// Returns: BOOLEAN TRUE or FALSE
////////////////////////////////////////////////////////////////////////////////////////////
int IsDetected(object oTrigger = OBJECT_SELF)
{
   if (GetLocalInt(oTrigger, "STATUS") == UNDETECTED) return FALSE;
   return TRUE;
}///////////////////////////////////////////////////////////////////////////////////////////
// IsAttended
//
// Inputs:  None
//
// Purpose: Reports on whether or not a PC or Associate is in the trigger area for a detected
//           object.  If so, the object is ATTENDED. If not, it is only DETECTED.
//
// Returns: BOOLEAN TRUE or FALSE
////////////////////////////////////////////////////////////////////////////////////////////
int IsAttended(object oTrigger = OBJECT_SELF)
{
   object oInTrigger  = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
   if (GetIsObjectValid(oInTrigger) )
   {
      SetLocalInt(oTrigger, "STATUS", ATTENDED);
      return TRUE;
   }
   return FALSE;
}///////////////////////////////////////////////////////////////////////////////////////////
// ResetSecretObject
//
// Inputs:  None
//
// Purpose: Destroys the secret object and resets trigger variables.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void ResetSecretObject(object oTrigger = OBJECT_SELF)
{
   object oSecretObject = GetLocalObject(oTrigger, "OBJECT_REFERENCE");
   if (GetIsObjectValid(oSecretObject) ) DestroyObject(oSecretObject);
   // Mark it as not revealed
   DeleteLocalInt(oTrigger, "STATUS");
   DeleteLocalObject(oTrigger, "OBJECT_REFERENCE");
}///////////////////////////////////////////////////////////////////////////////////////////
// GetSecretObjectReference
//
// Inputs:  None
//
// Purpose: Hides a local variable that contains a reference to the revealed secret object.
//
// Returns: object reference
////////////////////////////////////////////////////////////////////////////////////////////
object GetSecretObjectReference(object oTrigger = OBJECT_SELF)
{
   return GetLocalObject(oTrigger, "OBJECT_REFERENCE");
}///////////////////////////////////////////////////////////////////////////////////////////
// DetectSecretObject
//
// Inputs:  object oSearcher (PC or Associate)
//
// Purpose: Uses SKILL_SEARCH, the PC's or Associate's "memory", race (if Elven), and active
//           search mode to determine whether or not a secret object is detected relative to
//           the set difficulty check.  If detection occurs, a local status variable on the
//           trigger is set.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void DetectSecretObject(object oSearcher, object oTrigger = OBJECT_SELF)
{
   if ( GetIsObjectValid(oSearcher) && GetIsObjectValid(oTrigger) )
   {
      int nDifficulty = StringToInt( GetSubString( GetName(oTrigger), 0, 2) );
      int nSkill      = GetSkillRank(SKILL_SEARCH, oSearcher);
      int nRace       = GetRacialType(oSearcher);
      int nMemory     = GetLocalInt(oSearcher, GetTag(oTrigger) );
      int nDieRoll;
      if ( GetDetectMode(oSearcher) == DETECT_MODE_ACTIVE || nRace == RACIAL_TYPE_ELF)
         nDieRoll = d20();
      else
         nDieRoll = d10();
      if ( (nSkill + nMemory + nDieRoll) >= nDifficulty) SetSecretObjectStatus(DETECTED);
   }
}///////////////////////////////////////////////////////////////////////////////////////////
// CreateSecretObject
//
// Inputs:  object oTrigger = OBJECT_SELF
//
// Purpose: Creates the secret object.  Sets the local object reference. Sets the tag to the
//          tag of the trigger.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void CreateSecretObject(object oTrigger = OBJECT_SELF)
{
   if ( GetIsObjectValid(oTrigger) )
   {
      string sResRef      = GetLockKeyTag(oTrigger);
      string sWaypointTag = "LOC_" + GetTag(oTrigger);
      object oWaypoint    = GetObjectByTag(sWaypointTag);
      if ( GetIsObjectValid(oWaypoint) )
      {
         location lLoc        = GetLocation(oWaypoint);
         object oSecretObject = CreateObject(OBJECT_TYPE_PLACEABLE, sResRef, lLoc, FALSE, GetTag(oTrigger) );
         SetLocalObject(oTrigger, "OBJECT_REFERENCE", oSecretObject);
      }
   }
}///////////////////////////////////////////////////////////////////////////////////////////
// ResetInThirtySeconds
//
// Inputs:  int nCounter
//
// Purpose: Recursive function checks every ten seconds to see if a PC or NPC is still in the
//           detection trigger area after the secret object has been revealed.  If at any
//           time during the ten seconds, a PC or NPC has entered the trigger area, the trigger
//           status will have been changed to ATTENDED.  This will restart the counter.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void ResetInThirtySeconds(int nCounter)
{
   nCounter++;
   if (IsAttended() ) nCounter = 0; // Reset the counter
   else // currently unattended; reduce the status to just detected (but not attended)
      SetSecretObjectStatus(DETECTED);
   if (nCounter == 3) ResetSecretObject();
   else DelayCommand(10.0, ResetInThirtySeconds(nCounter) );
}///////////////////////////////////////////////////////////////////////////////////////////
// SearchForObject
//
// Inputs:  object oSearcher
//
// Purpose: Recursive function checks every ten seconds to see if the secret object is found,
//           so long as the searcher is still in the area.  Searcher may be a PC or NPC.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void SearchForObject(object oSearcher)
{
   // See if the searcher is still in the trigger
   object oInTrigger  = GetFirstInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
   int    bInTrigger  = FALSE;
   while (GetIsObjectValid(oInTrigger) )
   {
      if (oInTrigger == oSearcher)
      {
         bInTrigger = TRUE;
         break;
      }
      else
         oInTrigger = GetNextInPersistentObject(OBJECT_SELF, OBJECT_TYPE_CREATURE);
   }
   if (bInTrigger)
   {
      DetectSecretObject(oSearcher);
      if (IsDetected() )
      {
         CreateSecretObject();
         if ( GetIsPC(oSearcher) )
         {
            AssignCommand(oSearcher, PlayVoiceChat(VOICE_CHAT_LOOKHERE));
            // Give the PC searcher bonus points for subsequent re-searches of this trigger tag
            SetLocalInt(oSearcher, GetTag(OBJECT_SELF), 10);
         }
         else if (GetIsObjectValid( GetMaster(oSearcher) ) )
         {
            AssignCommand(oSearcher, PlayVoiceChat(VOICE_CHAT_SEARCH));
            // Give the Associate and the master bonus points for subsequent re-searches of this
            //  trigger tag, but not as many as the PC could have received by himself
            SetLocalInt( oSearcher,            GetTag(OBJECT_SELF), 5);
            SetLocalInt( GetMaster(oSearcher), GetTag(OBJECT_SELF), 5);
         }
         SetSecretObjectStatus(ATTENDED);
         DelayCommand(10.0, ResetInThirtySeconds(0) );
      }
      else // If still in the area, no reason you cannot continue to search
         DelayCommand(10.0, SearchForObject(oSearcher) );
   }
}///////////////////////////////////////////////////////////////////////////////////////////
// main
//
// Fires from the triggers OnEnter event
////////////////////////////////////////////////////////////////////////////////////////////
void main()
{
   if ( IsDetected() ) SetSecretObjectStatus(ATTENDED);
   else SearchForObject( GetEnteringObject() );
}///////////////////////////////////////////////////////////////////////////////////////////

