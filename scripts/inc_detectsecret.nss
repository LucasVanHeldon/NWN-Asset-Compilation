

int nIsDwarf = 0;
int nClassIsRogue = 0;
int nRacialBonus = 0;
int nIsStone = 0;
int nDetectableYes = 0;

int DetectSecret(object oSecret= OBJECT_SELF)
{
    // get reset time, radius and DC of the secret object.
    float fResetTime = IntToFloat( GetFortitudeSavingThrow ( oSecret ) );
    float fSearchDist = IntToFloat( GetReflexSavingThrow ( oSecret ) );
    int nDiffaculty   = GetWillSavingThrow   ( oSecret );

    // what is the tag of this object used in setting the destination
    string sTag = GetTag(oSecret);

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
    int nDone = GetLocalInt( oSecret, "D_"+sTag);
    int nReset = GetLocalInt( oSecret, "Reset");
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
        float fDist = GetDistanceBetween( oSecret, oidNearestCreature );
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
            return TRUE;
       } // if skill search found
    } // if object is valid
    return FALSE;
}

