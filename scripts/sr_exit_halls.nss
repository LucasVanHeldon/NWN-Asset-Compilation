void main()
{
    int iGold = GetLocalInt(GetExitingObject(), "HallsGold");

    if (iGold < GetGold(GetExitingObject())) {
        int iDiff = GetGold(GetExitingObject()) - iGold;
        TakeGoldFromCreature(iDiff, GetExitingObject(), TRUE);
    }
}
