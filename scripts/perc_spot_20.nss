void main()
{
int iSkill = SKILL_SPOT; // Skill
int iGoal = 20; // Skill Integer Goal
object oPercep = GetNearestObjectByTag("Percep");
int iListen = GetSkillRank(iSkill, oPercep);
if(iListen >iGoal)
{
int iDiff = iListen - iGoal;
  int iGoal = iListen - iDiff;
    effect eListen = EffectSkillDecrease(iSkill, iGoal);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eListen, oPercep);
    SetCustomToken(105, IntToString(iGoal));
     }
     if(iListen <iGoal)
       {
       int iDiff = iGoal - iListen;
       int iGoal = iListen + iDiff;
        effect eListen = EffectSkillIncrease(iSkill, iGoal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eListen, oPercep);
        SetCustomToken(105, IntToString(iGoal));
        }
}
