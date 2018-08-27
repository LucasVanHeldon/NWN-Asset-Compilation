void main()
{
 object oPC = GetPCSpeaker();
 ActionCastSpellAtObject(SPELL_BESTOW_CURSE, oPC, TRUE, TRUE);
 // Set the variables
    SetLocalInt(GetPCSpeaker(), "used_rock", 1);
}
