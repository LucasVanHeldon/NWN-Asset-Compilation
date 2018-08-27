int StartingConditional()
{
    int iResult;
    int iGold = GetGold(GetPCSpeaker());

    iResult = (iGold >= 5000);
    return iResult;
}
