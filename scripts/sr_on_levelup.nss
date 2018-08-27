#include "sr_i0_henchman"
#include "nw_i0_generic"
void main()
{
    int i,j;
    object oItem,oNew,oFam;

    object oPC = GetPCLevellingUp();
    if (GetIsObjectValid(oPC) == TRUE)
    {

      // Copy familiar/animal companion's inventory.
      for (j = 1; j <= 2; ++j) {
        if (j == 1) oFam = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
        if (j == 2) oFam = GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION,oPC);
        if (oFam != OBJECT_INVALID) {
          for(i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
              oItem = GetItemInSlot(i,oFam);
              if (oItem != OBJECT_INVALID)
                 switch (GetBaseItemType(oItem)) {
                  case BASE_ITEM_CREATUREITEM:
                  case BASE_ITEM_CBLUDGWEAPON:
                  case BASE_ITEM_CSLASHWEAPON:
                  case BASE_ITEM_CSLSHPRCWEAP:
                  case BASE_ITEM_CPIERCWEAPON: break;

                  default:
                    oNew = CreateItemOnObject(GetTag(oItem),oPC,GetNumStackedItems(oItem));
                    if (GetIdentified(oItem)) SetIdentified(oNew,TRUE);
                    break;
                 }
          }

          // Now go through the backpack.

          oItem = GetFirstItemInInventory(oFam);

          while (oItem != OBJECT_INVALID) {
              CreateItemOnObject(GetTag(oItem),oPC,GetNumStackedItems(oItem));
              oItem = GetNextItemInInventory(oFam);
          }
        }
      }

      object oHench = GetHenchman(oPC);
      if (GetIsObjectValid(oHench) == TRUE) {
        if (GetCanLevelUp(oPC, oHench) == TRUE) {
            SendMessageToPC(oPC, "Your henchman can level up, as well.");
            object oNew = DoLevelUp(oPC, oHench);
            if (GetIsObjectValid(oNew) == TRUE) {
                DelayCommand(1.0,AssignCommand(oNew, EquipAppropriateWeapons(oPC)));
            }
        }
      }
    }
}
