void main()
{
  object oPC = GetPCSpeaker();
  effect eStat = EffectAbilityDecrease(ABILITY_CHARISMA, 1);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, eStat, oPC);
  // Set the variables
    SetLocalInt(GetPCSpeaker(), "used_rock", 1);
}
