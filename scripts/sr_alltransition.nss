void main()
{
  object oClicker = GetClickingObject();
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);

  AssignCommand(oClicker,JumpToLocation(lLoc));
  if (GetIsObjectValid(GetHenchman(oClicker)))
      AssignCommand(GetHenchman(oClicker),JumpToLocation(lLoc));
  if (GetIsObjectValid(GetHenchman(oClicker)))
      AssignCommand(GetHenchman(oClicker),JumpToLocation(lLoc));

}
