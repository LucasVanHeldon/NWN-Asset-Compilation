// SkillCheck
//  Returns 0 on Failure
//  Returns 1 on Success

int SkillCheck(object oTarget, int iDC, int iSkill, int iTake20=FALSE)
{
    int iSkillScore = GetSkillRank(iSkill, oTarget);
    int iRoll = d20();

    if (iSkill == SKILL_LISTEN || iSkill == SKILL_SEARCH || iSkill == SKILL_SPOT)
        if (GetRacialType(oTarget) == RACIAL_TYPE_ELF
                || GetClassByPosition(1, oTarget) == CLASS_TYPE_ROGUE
                || GetClassByPosition(1, oTarget) == CLASS_TYPE_RANGER)
            iDC -= 5;
    if (iTake20)
        iRoll = 20;

    if ((iRoll + iSkillScore) >= iDC)
        return TRUE;

    return FALSE;
}

int RollDC(int DC, int nSkill, object oTarget)
{
    int nLevel = GetHitDice(OBJECT_SELF);
    int nTest = DC - Random(20) - 1;
    if (GetSkillRank(nSkill, oTarget) >= nTest)
    {
       return TRUE;
    }
       return FALSE;
}

int Take20DC(int DC, int nSkill, object oTarget)
{
    int nLevel = GetHitDice(OBJECT_SELF);
    int nTest = DC - 20;
    if (GetSkillRank(nSkill, oTarget) >= nTest)
    {
       return TRUE;
    }
       return FALSE;
}

