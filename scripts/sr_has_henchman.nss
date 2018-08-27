int StartingConditional()
{
    if (GetIsObjectValid(GetHenchman(GetPCSpeaker())))
        return FALSE;
    return TRUE;
}
