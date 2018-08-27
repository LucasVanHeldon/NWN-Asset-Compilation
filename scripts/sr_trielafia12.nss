//::///////////////////////////////////////////////
//:: FileName sr_trielafia12
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/11/2002 9:04:08 AM
//:://////////////////////////////////////////////
void main()
{

	// Remove items from the player's inventory
	object oItemToTake;
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SprigMistletoe");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
	oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "PollenMarshRose");
	if(GetIsObjectValid(oItemToTake) != 0)
		DestroyObject(oItemToTake);
}
