int StartingConditional()
{
    // Changed to longer hours.  6am to 10pm
    if(!(GetTimeHour() > 5  && GetTimeHour() < 22))
        return FALSE;

    return TRUE;
}
