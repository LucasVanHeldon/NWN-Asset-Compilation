//::///////////////////////////////////////////////
//:: FileName at_010
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/28/2004 9:23:31 PM
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "WolfSkin");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SilkGland");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "GoblinHead");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
