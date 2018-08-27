//::///////////////////////////////////////////////
//:: FileName at_take_map
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/27/2003 1:19:18 AM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    object oItem = GetObjectByTag("SlaversMap");
    object oPossessor = GetItemPossessor(oItem); //Find Person who has oItem
    oItemToTake = GetItemPossessedBy(oPossessor, "SlaversMap");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
