void main()
{
    object oItem;
    if(!GetIsPC(GetEnteringObject())) return;
    oItem = CreateObject(OBJECT_TYPE_PLACEABLE,"pl_hiddendr004",GetLocation(GetWaypointByTag("WP_PLACABLE")));
    object oldItem=oItem;
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL,0,Random(9999));
    if(GetIsObjectValid(oItem)) DestroyObject(oldItem);
}
