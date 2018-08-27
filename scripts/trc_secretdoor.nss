////////////////////////////////////////////////////////////////////////////////////////////
// trc_trapdoor
//
// Description - Allows use of trapdoors. Based on BioWare nw_o2_trapdoor.
//
// Depending on the state of the trapdoor (open, closed, locked), players will have to
// click on the trap door placeable multiple times.
//
// Place this script in the OnUsed event for the trapdoor placeable.
//
// If you want to make things interesting, add some script in which you generate another die roll (e.g.,
// d10) and, if the value is equal to "1" (e.g., 10% chance), spawn in a hostile guard, the local
// constable (with a "you go to jail" script), the building owner (who then shouts for guards), or
// whatever, so there's a risk for the PC to click on the trapdoor all day long until it finally opens.
//
// Alternatively, you can use a local variable (stored on the PC for a multi-player module; stored on the
// trapdoor for a single player module) that counts the number of times the PC attempts to pick the lock
// and after exceeding some value (you could use one of the other saving throw values, for instance, if
// you want to make this a generic capability), "jams the lock" permanently (that is, disables any
// further attempts to open it) with a SendMessageToPC() call to tell the PC that the lock is now jammed.
//
// Created By: T.R.Clark
// Created On: 03/15/02
// Last update On: 12/06/03
////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////
// SendCreature
//
// Inputs:  object oCreature, object oDest
//
// Purpose: Used by various functions in loops to transport associates to a jump location
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void SendCreature(object oCreature, object oDest)
{
   if (GetIsObjectValid(oCreature) )
   {
      AssignCommand(oCreature, ClearAllActions() );
      AssignCommand(oCreature, ActionJumpToObject(oDest, FALSE) );
   }
}///////////////////////////////////////////////////////////////////////////////////////////
// SendAssociates
//
// Inputs:  object oPC, object oDest
//
// Purpose: Insures assoicates jump with a PC.
//
// Returns: void
////////////////////////////////////////////////////////////////////////////////////////////
void SendAssociates(object oPC, object oDest)
{
   object oAnimal    = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC);
   object oDominated = GetAssociate(ASSOCIATE_TYPE_DOMINATED,       oPC);
   object oFamiliar  = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,        oPC);
   object oHenchman  = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,        oPC);
   object oSummoned  = GetAssociate(ASSOCIATE_TYPE_SUMMONED,        oPC);
   int    nNth       = 2;
   SendCreature(oAnimal,    oDest);
   SendCreature(oDominated, oDest);
   SendCreature(oFamiliar,  oDest);
   SendCreature(oSummoned,  oDest);
   while (GetIsObjectValid(oHenchman) ) // Accommodate potential for multiple henchmen
   {
      SendCreature(oHenchman, oDest);
      oHenchman = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC, nNth++);
   }
}///////////////////////////////////////////////////////////////////////////////////////////
void main()
{
   object oPC = GetLastUsedBy();
   // Allow for traps and locks
   if ( GetIsTrapped(OBJECT_SELF) ) return; // Must remove trap first
   if (GetLocked(OBJECT_SELF) )
   {
      // See if we have the key and unlock if so
      string sKey = GetTrapKeyTag(OBJECT_SELF);
      object oKey = GetItemPossessedBy(oPC, sKey);
      if (GetIsObjectValid(oKey) )
      {
         AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID) );
         DelayCommand(0.1, PlaySound("as_dr_locked2") );
         SendMessageToPC(oPC, GetStringByStrRef(7945) );
         SetLocked(OBJECT_SELF, FALSE);
      }
      else
      {
         int nDC    = GetLockUnlockDC(OBJECT_SELF);
         int nSkill = GetSkillRank(SKILL_OPEN_LOCK, oPC);
         int nRoll  = d20();
         // Print '*locked*' message and play sound
         DelayCommand(0.1, PlaySound("as_dr_locked2") );
         FloatingTextStringOnCreature("*" + GetStringByStrRef(8307) + "*", oPC);
         SendMessageToPC(oPC, GetStringByStrRef(8296) );
         AssignCommand(oPC, ActionSpeakString("I don't have the key.") );
         AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID) );
         if ( (nRoll + nSkill) >= nDC)
         {
            SetLocked(OBJECT_SELF, FALSE);
            AssignCommand(oPC, ActionSpeakString("Got it...") );
         }
         else
            AssignCommand(oPC, ActionSpeakString("It didn't open it...") );
      }
   }
   else // Handle opening/closing the trapdoor
   {
      if ( GetIsOpen(OBJECT_SELF) ) // It's open -- go through and then close
      {
         // Get the destination waypoint
         string sTag  = GetTag(OBJECT_SELF);
         string sDest = "DST_" + sTag;
         object oDest = GetNearestObjectByTag(sDest); // First check for destinations in same area
         if (!GetIsObjectValid(oDest) ) oDest = GetObjectByTag(sDest); // Assume not in same area
         if (GetIsObjectValid(oDest) )
         {
            if (GetArea(oPC) == GetArea(oDest) )// If in the same area, fade out and back
            {
               FadeToBlack(oPC, FADE_SPEED_FAST);
               DelayCommand(0.5, FadeFromBlack(oPC, FADE_SPEED_FAST) );
            }
            AssignCommand(oPC, ActionJumpToObject(oDest, FALSE) );
            SendAssociates(oPC, oDest);
         }
         DelayCommand(10.0, ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE) );
      }
      else // Open the trapdoor
      {
         // Play animation of user opening it
         AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID) );
         DelayCommand(1.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN) );
      }
   }
}

