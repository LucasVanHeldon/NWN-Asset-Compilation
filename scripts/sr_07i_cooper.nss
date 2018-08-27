//::///////////////////////////////////////////////
//:: FileName sr_07i_cooper
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/12/2002 8:25:04 PM
//:://////////////////////////////////////////////
void main()
{

	// Either open the store with that tag or let the user know that no store exists.
	object oStore = GetNearestObjectByTag("07i_cooper");
	if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
		OpenStore(oStore, GetPCSpeaker());
	else
		ActionSpeakStringByStrRef(53090, TALKVOLUME_TALK);
}
