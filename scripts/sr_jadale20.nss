int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetArea(GetPCSpeaker()), "FreezeConvo") == 2))
        return FALSE;

    return TRUE;
}
