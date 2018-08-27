int StartingConditional()
{
    int iResult;
    int iGold = GetGold(GetPCSpeaker());

    iResult = (iGold >= 2000);
    return iResult;
}
