void main()
{
object oObject = OBJECT_SELF;
object oItem = GetFirstItemInInventory(oObject);
while(oItem != OBJECT_INVALID)
 {
 if(!GetIdentified(oItem))
     {
      SetIdentified(oItem, TRUE);
      oItem = GetNextItemInInventory(oObject);
     }
    oItem = GetNextItemInInventory(oObject);
   }
}
