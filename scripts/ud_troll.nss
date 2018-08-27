// Authentic Monsters
// Troll
// By Weed Wizard
#include "x0_i0_spawncond"

int DoesDamage(object oWeapon)
{
    /*
    itemproperty iP = GetFirstItemProperty(oWeapon);
    object oTemp;
    object oLC = GetLastAttacker();
    if(GetWeaponRanged(oWeapon))
    {
       int base = GetBaseItemType(oWeapon);
       switch(base)
       {
       case BASE_ITEM_LIGHTCROSSBOW:
       case BASE_ITEM_HEAVYCROSSBOW:
            oTemp = GetItemInSlot(INVENTORY_SLOT_BOLTS,oLC);
            break;
       case BASE_ITEM_LONGBOW:
       case BASE_ITEM_SHORTBOW:
            oTemp = GetItemInSlot(INVENTORY_SLOT_ARROWS,oLC);
            break;
        case BASE_ITEM_SLING:
            oTemp = GetItemInSlot(INVENTORY_SLOT_BULLETS,oLC);
        }

        iP = GetFirstItemProperty(oTemp);
        while(GetIsItemPropertyValid(iP))
        {
            int iSub = GetItemPropertySubType(iP);
            if(iSub == IP_CONST_DAMAGETYPE_FIRE) return TRUE;
            if(iSub == IP_CONST_DAMAGETYPE_ACID) return TRUE;
            iP = GetNextItemProperty(oWeapon);
        }
        return FALSE;
    }
    while(GetIsItemPropertyValid(iP))
    {
        int iSub = GetItemPropertySubType(iP);
        if(iSub == IP_CONST_DAMAGETYPE_FIRE) return TRUE;
        if(iSub == IP_CONST_DAMAGETYPE_ACID) return TRUE;
        iP = GetNextItemProperty(oWeapon);
    }
    return FALSE;
    */
    return (GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 0 ||
            GetDamageDealtByType(DAMAGE_TYPE_ACID) > 0);
}

void CheckIsDead(object oC)
{
    int nDmg = GetTotalDamageDealt();

    if((GetCurrentHitPoints(oC) - nDmg) <= 0)
    {
        SetImmortal(oC,FALSE);
    }
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    effect eEffect;
    object oLastAttacker = GetLastAttacker();
    int nSpell = GetLastSpell();
    object oWeapon = GetLastWeaponUsed(oLastAttacker);
    int nDmg = GetTotalDamageDealt();
    effect eTemp = EffectTemporaryHitpoints(nDmg);
    effect eTemp2 = EffectTemporaryHitpoints(d4());
    effect eKnockDown = EffectKnockdown();

    int nDoesDamage = FALSE;
    if(GetIsObjectValid(oWeapon))
        nDoesDamage = DoesDamage(oWeapon);

    switch(nCalledBy)
    {
    case 1006:
        if(!nDoesDamage && GetIsObjectValid(oWeapon))
        {
            SendMessageToPC(GetFirstPC(),"Troll regeneration");
            DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eTemp,OBJECT_SELF));
        }
        else if(GetLocalInt(OBJECT_SELF,"nLastSpell") == 2)
        {
            SendMessageToPC(GetFirstPC(),"Troll regeneration");
            DelayCommand(1.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,eTemp,OBJECT_SELF));
        }
        else
        {
            CheckIsDead(OBJECT_SELF);
        }

        if(GetLocalInt(OBJECT_SELF,"nLastSpell") != 0)
        {
            SetLocalInt(OBJECT_SELF,"nLastSpell",0);
        }


        break;

    case 1007:
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eKnockDown,OBJECT_SELF,RoundsToSeconds(d4()));

        if(GetLocalInt(OBJECT_SELF,"nLastSpell") == 2)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eTemp2,OBJECT_SELF);
        }
        else if(!nDoesDamage)
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eTemp2,OBJECT_SELF);
        else
            DelayCommand(1.0,
                ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                                                EffectDeath(),OBJECT_SELF));

        break;

    case 1011:

        switch(nSpell)
        {
        case SPELL_FIREBALL:
        case SPELL_ACID_SPLASH:
        case SPELL_MESTILS_ACID_BREATH:
        case SPELL_ACID_FOG:
        case SPELL_BURNING_HANDS:
        case SPELL_DARKFIRE:
        case SPELL_DELAYED_BLAST_FIREBALL:
        case SPELL_EPIC_HELLBALL:
        case SPELL_FIRE_STORM:
        case SPELL_FIREBRAND:
        case SPELL_FLAME_ARROW:
        case SPELL_FLAME_WEAPON:
        case SPELL_GRENADE_ACID:
        case SPELL_GRENADE_FIRE:
        case SPELL_INCENDIARY_CLOUD:
        case SPELL_INFERNO:
        case SPELL_WALL_OF_FIRE:
            SetLocalInt(OBJECT_SELF,"nLastSpell",1);
            break;
        default:
            SetLocalInt(OBJECT_SELF,"nLastSpell",2);


        }
    }
}
