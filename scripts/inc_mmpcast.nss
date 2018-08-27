int MMPC_ScoreDispelMagic(object oTarget)
{
    int score = 0;
    if(IsMagicUser(oTarget)) score = score + 10;
    if(IsCleric(oTarget)) score = score + 10;
    effect eEff = GetFirstEffect(oTarget);
    if(!GetIsEnemy(oTarget)) return 0;
    while(GetIsEffectValid(eEff))
    {
         int nType = GetEffectType(eEff);
         switch(nType)
         {
         case EFFECT_TYPE_AC_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_ATTACK_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_CONCEALMENT: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_REDUCTION: score = score + 1; break;
         case EFFECT_TYPE_DAMAGE_RESISTANCE: score = score + 1; break;
         case EFFECT_TYPE_DISPELMAGICALL: score = score + 5; break;
         case EFFECT_TYPE_DISPELMAGICBEST: score = score + 5; break;
         case EFFECT_TYPE_ELEMENTALSHIELD: score = score + 1; break;
         case EFFECT_TYPE_ETHEREAL: score = score + 1; break;
         case EFFECT_TYPE_HASTE: score = score + 1; break;
         case EFFECT_TYPE_IMMUNITY: score = score + 1; break;
         case EFFECT_TYPE_IMPROVEDINVISIBILITY: score = score + 1; break;
         case EFFECT_TYPE_INVISIBILITY: score = score + 1; break;
         case EFFECT_TYPE_INVULNERABLE: score = score + 5; break;
         case EFFECT_TYPE_MOVEMENT_SPEED_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_POLYMORPH: score = score + 1; break;
         case EFFECT_TYPE_REGENERATE: score = score + 1; break;
         case EFFECT_TYPE_SANCTUARY: score = score + 2; break;
         case EFFECT_TYPE_SAVING_THROW_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_SEEINVISIBLE: score = score + 1; break;
         case EFFECT_TYPE_SPELL_IMMUNITY: score = score + 2; break;
         case EFFECT_TYPE_SPELL_RESISTANCE_INCREASE: score = score + 1; break;
         case EFFECT_TYPE_SPELLLEVELABSORPTION: score = score + 4; break;
         case EFFECT_TYPE_TRUESEEING: score = score + 1; break;
         case EFFECT_TYPE_ULTRAVISION: score = score + 1; break;
        }
        eEff = GetNextEffect(oTarget);
    }
    return score;
}

void MMPC_CastDispelMagic()
{

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        int n = MMPC_ScoreDispelMagic(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest) && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DISPEL_MAGIC,oBest,METAMAGIC_ANY,TRUE);
    }
}


void MMPC_CastLesserDispelMagic()
{

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        int n = MMPC_ScoreDispelMagic(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest) && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LESSER_DISPEL,oBest,METAMAGIC_ANY,TRUE);
    }
}

void MMPC_CastGreaterDispelMagic()
{

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        int n = MMPC_ScoreDispelMagic(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest) && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_GREATER_DISPELLING,oBest,METAMAGIC_ANY,TRUE);
    }
}


void MMPC_CastLesserSpellBreach()
{

    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;

    while(GetIsObjectValid(oTarget))
    {
        int n = MMPC_ScoreDispelMagic(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest) && GetIsEnemy(oBest) && GetCurrentHitPoints(oBest) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_LESSER_SPELL_BREACH,oBest,METAMAGIC_ANY,TRUE);
    }
}

