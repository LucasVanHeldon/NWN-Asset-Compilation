int StartingConditional()
{
    int iResult;
    int iGold = GetGold(GetPCSpeaker());

    iResult = (iGold >= 1000);
    return iResult;
}
