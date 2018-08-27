#include "x0_i0_spawncond"
#include "ai_inc"

void MMP_MindBlast(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_MINDBLAST,oTarget,METAMAGIC_ANY,TRUE);
}

void MMP_GazeCharm(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindStrongestEnemy(OBJECT_SELF);

    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELLABILITY_GAZE_CHARM,oTarget,METAMAGIC_ANY,TRUE);
}

void MMPABB_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    if(GetLocalInt(OBJECT_SELF,"bMindBlast"))
        if(d6() < 3)
        {
            MMP_MindBlast(oTarget);
            return;
        }

    if(GetLocalInt(OBJECT_SELF,"bCharmGaze"))
        if(d6() < 3)
        {
            MMP_GazeCharm(oTarget);
            return;
        }
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1002:
     {
        int n = d4();
        int i;
        if(!GetLocalInt(OBJECT_SELF,"bDancingLights"))
        {
            SetLocalInt(OBJECT_SELF,"bDancingLights",1);
            ClearAllActions(TRUE);
            for(i = 0; i < n; i++)
                CreateObject(OBJECT_TYPE_CREATURE,"mmp_dancinglight",GetLocation(OBJECT_SELF));
        }
        DetermineCombatRound();
        break;
     }
    case 1003:
        MMPABB_SpecialAttack();
        break;
    }

}
