void main()
{
    object oPC = GetPCSpeaker();
    int PRICE = GetLocalInt(oPC,"SK_ALC_COST");

    int nGP = GetGold(oPC);
    if(nGP>=PRICE){
        TakeGoldFromCreature(PRICE, oPC, FALSE);
        object oWand = GetItemPossessedBy(oPC,"alchemytool");
        if(!GetIsObjectValid(oWand))
        {
            CreateItemOnObject("alchemytool",oPC);
        }
        ExecuteScript("sk_alc_upgrade",oPC);
    }
    else{
        SendMessageToPC(oPC,"You cannot afford to pay the fee.");
    }
}
