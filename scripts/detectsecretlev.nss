//::///////////////////////////////////////////////
//:: Secret Object invis object
//:: V 1.2
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This Invisable object will do a check and see
    if any pc comes within a radius of this object.
    If the PC has the search skill or is a elf then
    a search check will be made.
    It will create a secret object that will have its
    Destination set to a waypoint that has
    a tag of DST_<tag of this object>
    The radius is determined by the reflex saving
    throw of the invisible object
    The DC of the search stored by the willpower
    saving throw.

    Modifications by Esa Mayfield
    Made secret object reset x seconds after the search radius
    is clear of player characters completely.  As long as
    someone is standing in the search radius the object will be
    visible.  If you move out of radius x seconds later *poof!*
    it will have to be redetected.  Use Fortitude Saving Throw
    field in the Hidden "Object" Trigger properties to control
    the reset timer.

    Another modification is if the tag of this trigger starts with DST_ then
    the rest of the tag becomes the destination.  This makes it easier to use
    one of these placeable objects as both the trigger and the destination point
    so that you don't have to have a trigger and a waypoint on each side for
    2-way travel, just 2 triggers!  One called whatever_you_want and the other
    called DST_whatever_you_want.
*/
//:://////////////////////////////////////////////
//:: Created By: Robert Babiak
//:: Created On: June 25, 2002
//:: Modified By: Esa Mayfield, July 17, 2002
//:://////////////////////////////////////////////
int nIsDwarf = 0;
int nClassIsRogue = 0;
int nRacialBonus = 0;
int nIsStone = 0;
int nDetectableYes = 0;
void main()
{
    // get reset time, radius and DC of the secret object.
    float fResetTime = IntToFloat( GetFortitudeSavingThrow ( OBJECT_SELF ) );
    float fSearchDist = IntToFloat( GetReflexSavingThrow ( OBJECT_SELF ) );
    int nDiffaculty   = GetWillSavingThrow   ( OBJECT_SELF );
    // what is the tag of this object used in setting the destination
    string sTag = GetTag( OBJECT_SELF);
    // is it set in stone
    if (GetStringRight(sTag,6) == "_STONE")
    {
        nIsStone = 1;
    }
    else if (GetStringRight(sTag,6) != "_STONE")
    {
        nIsStone = 0;
    }
    // has it been found?
    int nDone = GetLocalInt( OBJECT_SELF, "D_"+sTag);
    int nReset = GetLocalInt( OBJECT_SELF, "Reset");
    int nBestSkill = -50;
    object oidBestSearcher = OBJECT_INVALID;
    int nCount = 1;
    // find the best searcher within the search radius.
    object oidNearestCreature = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    while ( ( nDone == 0                                   ) &&
            ( oidNearestCreature != OBJECT_INVALID         )
          )
    {
        // what is the distance of the PC to the trigger location
        float fDist = GetDistanceBetween( OBJECT_SELF, oidNearestCreature );
        // do the following should the nearest creature enter the search radius
        if ( fDist <= fSearchDist )
        {
            int nClassCount = 1;
            // determine if the nearest creature is a rogue
            while (nClassCount <= 3)
            {
                if (GetClassByPosition(nClassCount, oidNearestCreature) == CLASS_TYPE_ROGUE)
                {
                nClassIsRogue = 1;
                }
                nClassCount++;
            }

            // Dwarves get -2 to search checks (because the game let's them have
            // stone cunning on all the time whether it is stone or not.  If the hidden
            // object has stone flag then they get to keep the bonus.
            if ((nIsStone == 1                                         ) &&
                (GetRacialType(oidNearestCreature) == RACIAL_TYPE_DWARF)
               )
            {
                nRacialBonus = 0;
                nIsDwarf = 1;
            }
            else if ((nIsStone == 0                                         ) &&
                     (GetRacialType(oidNearestCreature) == RACIAL_TYPE_DWARF)
                    )
            {
                nRacialBonus = -2;
                nIsDwarf = 0;
            }
            // determine nearest creatures total skill modifier
            int nSkill = (nRacialBonus + GetSkillRank(SKILL_SEARCH, oidNearestCreature));
            if (nSkill > nBestSkill)
            {
                nBestSkill = nSkill;
                oidBestSearcher = oidNearestCreature;
            }
        }
        nCount = nCount +1;
        oidNearestCreature = GetNearestCreature( CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC,  OBJECT_SELF , nCount);
    }
    // only Rogues can detect if DC is greater than 20, unless the race is a dwarf and
    // the secret object is set in stone (or is made to appear like stone)
    // if any of those conditions are met detectable bit to 1 (true)
    if (( nDiffaculty <= 20 ) ||
        ( nClassIsRogue == 1) ||
        ( nIsDwarf == 1     )
       )
    {
        nDetectableYes = 1;
        // SendMessageToPC(oidBestSearcher, "Something is odd nearby!");
    }
    // if it hasn't been detected yet and the detectable bit is set to 1 (true)
    if ( ( nDone == 0                                   ) &&
         ( GetIsObjectValid( oidBestSearcher )          ) &&
         ( nDetectableYes == 1                          )
       )
    {
       int nMod = d20();
       // this is for diagnostic purposes
       // string sMod = IntToString(nMod);
       // string sBestSkill = IntToString(nBestSkill);
       // string sSkillTotal = IntToString(nBestSkill+nMod);
       // string sDiffaculty = IntToString(nDiffaculty);
       // SendMessageToPC(oidBestSearcher,"You rolled a "+sMod+" + "+sBestSkill+" = "+sSkillTotal+" vs. DC "+sDiffaculty);
       // did we find it.
       if ((nBestSkill +nMod > nDiffaculty))
       {
            location locLoc = GetLocation (OBJECT_SELF);
            object oidObject;
            // yes we found it, now create a secret object for us to use. it.
            oidObject = CreateObject( OBJECT_TYPE_PLACEABLE, "secretlever", locLoc, TRUE);
            SendMessageToPC(oidBestSearcher, "You have discovered a secret lever...");
            // get the faceing of the trigger and set it on the object.
            float fFace = GetFacing(OBJECT_SELF);
            AssignCommand (oidObject, SetFacing(fFace) );

            // the destination code has been modified so you do not need a separate
            // waypoint as a destination.  All you need are matching secret objects
            // one tagged whatever_you_want and the other tagged DST_whatever_you_want

            // the following checks to see if the trigger's tag has DST_ at the beginning
            // if it does it strips the DST_ and uses the remainder of the tag as the
            // destination waypoint
            if (GetSubString(sTag, 0, 4) == "DST_")
            {
                SetLocalString( oidObject, "Destination" , GetSubString(sTag, 4, 30));
            }
            // the following checks to see if the trigger's tag does not have DST_
            // at the beginning of it. if it doesn't then the destination becomes "DST_"+Tag
            if (GetSubString(sTag, 0, 4) != "DST_")
            {
                SetLocalString( oidObject, "Destination" , "DST_"+sTag );
            }
            // make this object as found.
            SetLocalInt(OBJECT_SELF, "D_"+sTag,1);
            SetPlotFlag(oidObject,1);
            SetLocalObject (OBJECT_SELF, "Object", oidObject);
       } // if skill search found
    } // if object is valid
    // here is where I took Roberts reset code and did my stuff to it
    // ok reset the object is destroyed, and the done flag is made 0 again
    if ( nDone == 1 )
    {
        // what is the distance of the PC to the object location
        float fDist = GetDistanceBetween( OBJECT_SELF, oidNearestCreature );
        // the following will only execute if no one is in the search radius
        if ( fDist > fSearchDist )
        {
            nDone = 0;
            SetLocalInt( OBJECT_SELF, "D_"+sTag, nDone);
            // since I removed the need for nReset I don't think this line is needed any more
            SetLocalInt( OBJECT_SELF, "Reset", nReset);
            object oidObject= GetLocalObject( OBJECT_SELF, "Object");
            if (oidObject != OBJECT_INVALID)
            {
                SetPlotFlag( oidObject,0);
                // destroy the object in fResetTime seconds
                DestroyObject( oidObject,fResetTime);
            }
        }
    }
}

