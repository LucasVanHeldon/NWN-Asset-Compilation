void SendMsg(string msg)
{
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        SendMessageToPC(oPC,msg);
        oPC = GetNextPC();
    }
}

void main()
{
    object oItem = GetFirstItemInInventory(OBJECT_SELF);
    while(GetIsObjectValid(oItem))
    {
        if(GetTag(oItem) == "X1_WMGRENADE005")
        {
            SendMsg("Demonic altar destroyed");
            DestroyObject(OBJECT_SELF);
            break;
        }
        oItem = GetNextItemInInventory(OBJECT_SELF);
    }
}
