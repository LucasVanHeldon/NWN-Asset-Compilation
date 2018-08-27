void main()
{
    int nPC = 0;
    object oPC = GetFirstPC();
    int nTotalHD = 0;

    while (GetIsObjectValid(oPC))
    {
        nPC++;
        nTotalHD += GetHitDice(oPC);
        oPC = GetNextPC();
    }


}
