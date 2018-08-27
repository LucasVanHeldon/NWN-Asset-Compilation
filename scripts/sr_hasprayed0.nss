int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "Prayed") == 0))
        return FALSE;

    return TRUE;
}
