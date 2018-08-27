// Book of Demons - Babau
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"


void CastSpores(object oTarget)
{

    int n = GetLocalInt(OBJECT_SELF,"nSpores");
    if(n < 3)
    {

        n = n + 1;
        SetLocalInt(OBJECT_SELF,"nSpores",1);
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_PULSE_SPORES,
                            oTarget,
                            METAMAGIC_ANY,
                            TRUE);
    }
}

void VROCK_Screech()
{

    if(GetLocalInt(OBJECT_SELF,"bScreech")==1)
    {
        return;
    }
    SetLocalInt(OBJECT_SELF,"bScreech",1);

    object oH = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    effect eStun = EffectStunned();
    ClearAllActions(TRUE);
    ActionCastSpellAtLocation(SPELLABILITY_HOWL_SONIC,GetLocation(OBJECT_SELF),METAMAGIC_ANY,TRUE);
    while(GetIsObjectValid(oH))
    {
        if(GetIsEnemy(oH))
        {
            if(!FortitudeSave(oH,22,SAVING_THROW_TYPE_SONIC))
            {
                DelayCommand(4.5,
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eStun,oH,RoundsToSeconds(d3()))
                    );
            }
        }
        oH = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
}


int ScoreSpores(object oTarget)
{
    float D = GetDistanceToObject(oTarget);
    int score = FloatToInt(D);
    return score;
}

void VROCK_Spores()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int minScore = 99999;
    object bestTarget = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && GetCurrentHitPoints(oTarget) > 0)
        {
            int score = ScoreTeleport(oTarget);
            if(score < minScore)
            {
                minScore = score;
                bestTarget = oTarget;
            }
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(bestTarget))
        CastSpores(bestTarget);
}


void SpecialAttack()
{
    switch(d4())
        {
        case 1:
            DEMON_CastDarkness();
            break;
        case 2:
            VROCK_Screech();
            break;
        case 3:
            DEMON_Teleport();
            break;
        case 4:
            VROCK_Spores();
            break;
        }
}

void VROCK_Gate()
{
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    string bp;
    int num;
    switch(d2())
    {
    case 1: bp = "dretch"; num=d10(2); break;
    case 2: bp = "vrock";  num = 1; break;
    }
    int i;
    for(i = 0; i < num; i++){
        object oD = CreateObject(OBJECT_TYPE_CREATURE,bp,GetLocation(OBJECT_SELF));
        SetLocalInt(oD,"bGated",1);
    }
    // summons can't gate
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
}


void main()
{
    object oSC = GetLastSpellCaster();
    if(GetLocalInt(OBJECT_SELF,"bGated") == 0 && GetCurrentHitPoints() < 20)
    {

        SetLocalInt(OBJECT_SELF,"bGated",1);

        ClearAllActions(TRUE);
        ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
        int chance = Random(100);
        if(chance < 35)
        {
            SendMessageToPC(GetFirstPC(),"Vrock gated demon successfully.");
            DelayCommand(3.0,AssignCommand(OBJECT_SELF,VROCK_Gate()));
        }
        else SendMessageToPC(GetFirstPC(),"Vrock Demongate failed");
    }
    else if(!GetLocalInt(OBJECT_SELF,"bHeroism"))
    {
        SetLocalInt(OBJECT_SELF,"bHeroism",1);
        effect eSave = EffectSavingThrowIncrease(SAVING_THROW_ALL,2);
        effect eAttack = EffectAttackIncrease(2);
        effect eSkills = EffectSkillIncrease(SKILL_ALL_SKILLS,2);
        effect eLink = EffectLinkEffects(eAttack,eSave);
        EffectLinkEffects(eSkills,eLink);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eLink,OBJECT_SELF);
    }
    else if(d6() < 3)
    {
        SpecialAttack();
    }
    else if( d6() < 3  && GetLastSpellHarmful() && GetIsEnemy(oSC))
    {
        switch(d2())
        {
        case 1:
            DEMON_Darkness(oSC);
            break;
        case 2:
            DEMON_TeleportAttack(oSC);
            break;
        }
    }
}
