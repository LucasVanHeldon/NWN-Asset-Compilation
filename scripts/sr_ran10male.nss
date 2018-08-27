int StartingConditional()
{

    // Add the gender restrictions
    if(GetGender(GetPCSpeaker()) != GENDER_MALE)
        return FALSE;

    // Add the randomness
    if(Random(100) >= 10)
        return FALSE;

    return TRUE;
}
