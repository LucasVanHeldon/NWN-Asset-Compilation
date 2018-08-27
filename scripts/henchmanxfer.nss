void main()
{
    object oNew;

    object oHench = GetLocalObject(OBJECT_SELF,"TransferTo");
    object oItem = GetFirstItemInInventory();

    while (GetIsObjectValid(oItem)) {
          oNew = CreateItemOnObject(GetTag(oItem),oHench,
                                    GetNumStackedItems(oItem));
          if (GetIdentified(oItem)) SetIdentified(oNew,TRUE);
          DestroyObject(oItem);
          oItem = GetNextItemInInventory();
    }
}
