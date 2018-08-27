//::///////////////////////////////////////////////
//:: FileName re_onload.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
This is the default OnLoad script for the BESIE
Random Encounter system.  This script is really just
a template.  The OnLoad handler is the best place
to set the random encounter properties for the areas
of your module.
*/
//:://////////////////////////////////////////////
//:: Created By: Ray Miller
//:: Created On: 5/17/03
//:://////////////////////////////////////////////
#include"re_rndenc"
void main()
{
//Notice that everything here matches the default settings of the SetRndEncProperties function except
//the iChanceOnRest parameter, which is set to 0.  The purpose of this statement is to make every area
//of this module, that is not explicitley set, safe for resting.
SetRndEncProperties(GetModule(), 4, TRUE, "re_ceghimpubt0", 180, 2, 4, FALSE, 0);


//This sets the chance of a resting encounter in the area to 20 percent.  Remember that when players
//are resting it is because they are wounded and/or are low on resources.  It is important not to set
//the random encounter difficulty too high, especially in areas that are not safe for resting.
// Repeat the following function call for each area that needs specific properties set.
//SetRndEncProperties(GetObjectByTag("<Area tag goes here>"), 4, TRUE, "re_ceghimpubt0", 180, 2, 4, FALSE, 20);
}
