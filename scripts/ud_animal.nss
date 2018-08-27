// Animals fear torches
// Fire and Acid damage break morale

#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_demons"

int baseDC = 8;

int HasTorchInHand(object oC)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oC);
    if(GetBaseItemType(oItem) == BASE_ITEM_TORCH)
        return TRUE;

    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oC);
    if(GetBaseItemType(oItem) == BASE_ITEM_TORCH)
        return TRUE;

    return FALSE;
}

void DoFear(int nAmt = 1)
{
    if(!WillSave(OBJECT_SELF,baseDC-GetAbilityModifier(ABILITY_INTELLIGENCE,OBJECT_SELF)))
    {
        effect eE = EffectFrightened();
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eE,OBJECT_SELF,RoundsToSeconds(1));
    }
}

void CheckTorch()
{
    object oTarget = FindNearestEnemy(OBJECT_SELF);
    if(HasTorchInHand(oTarget))
    {
        DoFear();
    }
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();

    switch(nCalledBy)
    {
    case 1002:
    case 1003:
        CheckTorch();
        break;
    case 1006:
        if(GetDamageDealtByType(DAMAGE_TYPE_FIRE) > 0)
            DoFear(1);
        if(GetDamageDealtByType(DAMAGE_TYPE_ACID) > 0)
            DoFear(2);
        break;
    }
}
