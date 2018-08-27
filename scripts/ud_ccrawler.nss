// Carrion Crawler
// This is a house rule, to make it possible for low level chars to beat them.
// They fear torches, fire and acid damage break morale

#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_demons"

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

void DoFear(int nDie = 1)
{
    if(!WillSave(OBJECT_SELF,18))
    {
        effect eE = EffectFrightened();
        ClearAllActions(TRUE);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eE,OBJECT_SELF,RoundsToSeconds(d4(nDie)));
    }
}

void CheckTorch()
{
    object oTarget = FindNearestEnemy(OBJECT_SELF);
    if(HasTorchInHand(oTarget))
    {
        SendMessageToPC(GetFirstPC(),"Target has a torch checking for fear");
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
