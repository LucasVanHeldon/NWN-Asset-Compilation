int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetArea(GetPCSpeaker()), "FreezeConvo") == 1))
        return FALSE;

    return TRUE;
}
