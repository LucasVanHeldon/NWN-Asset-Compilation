void main()
{
 object oPC = GetPCSpeaker();
 ActionCastSpellAtObject(SPELL_BLINDNESS_AND_DEAFNESS, oPC, TRUE, TRUE);
  // Set the variables
    SetLocalInt(GetPCSpeaker(), "used_rock", 1);
}
