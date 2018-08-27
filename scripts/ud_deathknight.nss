// Death Knight Template
#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_mmp"

void MMP_GazeDeath(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) &&
        GetIsEnemy(oTarget) &&
        (GetCurrentHitPoints(oTarget) > 0) )
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_DEATH,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void MMP_PowerWordKill(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) &&
        GetIsEnemy(oTarget) &&
        (GetCurrentHitPoints(oTarget) > 0) )
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_POWER_WORD_KILL,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void MMP_SlayLiving(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) &&
        GetIsEnemy(oTarget) &&
        (GetCurrentHitPoints(oTarget) > 0) )
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SLAY_LIVING,oTarget,METAMAGIC_ANY,TRUE);
    }
}

void DEATHKNIGHT_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    int nDie = Die(16);
    switch(nDie)
    {
    case 1: MMP_CircleOfDeath(oTarget); break;
    case 2: MMP_GazeDeath(oTarget); break;
    case 3: MMP_FingerOfDeath(OBJECT_SELF); break;
    case 4: MMP_CircleOfDoom(OBJECT_SELF); break;
    case 5: MMP_DeathArmor(OBJECT_SELF); break;
    case 6: MMP_PowerWordKill(oTarget); break;
    case 7: MMP_SlayLiving(oTarget); break;
    default: break;
    }
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    int nPowers = GetLocalInt(OBJECT_SELF,"nPowers");

    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1003:
        if(GetCurrentAction() == ACTION_CASTSPELL) break;
        DEATHKNIGHT_SpecialAttack();
        break;
    }
}
