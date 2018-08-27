int StartingConditional()
{
    if (GetLocalInt(GetModule(), "prisoner_free") == 0)
        return TRUE;
    return FALSE;
}
