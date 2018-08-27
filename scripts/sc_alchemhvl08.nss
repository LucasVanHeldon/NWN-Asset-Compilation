int StartingConditional()
{
    int iResult;
    int iGold = GetGold(GetPCSpeaker());

    iResult = (iGold >= 10000);
    return iResult;
}
