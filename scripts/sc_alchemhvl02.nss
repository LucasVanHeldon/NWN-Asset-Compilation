int StartingConditional()
{
    int iResult;
    int iGold = GetGold(GetPCSpeaker());

    iResult = (iGold >= 100);
    return iResult;
}
