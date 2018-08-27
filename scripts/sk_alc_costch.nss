int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int PRICE = GetLocalInt(oPC,"SK_ALC_COST");

    int nGP = GetGold(oPC);
    return nGP>=PRICE;
}
