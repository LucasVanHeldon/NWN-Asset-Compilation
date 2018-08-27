int StartingConditional()
{
    int bCondition = GetLocalInt(GetPCSpeaker(),"SR_TALKLEVEL") == 0;

    return bCondition;
}
