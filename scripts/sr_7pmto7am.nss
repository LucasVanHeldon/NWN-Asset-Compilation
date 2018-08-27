int StartingConditional()
{
    // Changed to shorter hours.  Now 10pm to 6am
    if(!(GetTimeHour() > 21  || GetTimeHour() < 6))
        return FALSE;

    return TRUE;
}
