int StartingConditional()

{
    int bCondition = GetLocalInt(OBJECT_SELF, "SR_TALKLEVEL") == 1;
    return bCondition;
}
