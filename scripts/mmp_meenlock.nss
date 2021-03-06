// Ghast special attack
// By Weed Wizard

#include "x2_inc_switches"
#include "x2_inc_itemprop"
#include "x0_i0_match"

void ABILITY_Damage(object oCreature)
{
    if(GetHasEffect(EFFECT_TYPE_PARALYZE,oCreature))
    {
        effect eA;
        eA = EffectAbilityDecrease(ABILITY_STRENGTH,1);
        eA = SupernaturalEffect(eA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eA,oCreature);
        eA = EffectAbilityDecrease(ABILITY_DEXTERITY,1);
        eA = SupernaturalEffect(eA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eA,oCreature);
        eA = EffectAbilityDecrease(ABILITY_CONSTITUTION,1);
        eA = SupernaturalEffect(eA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eA,oCreature);
        eA = EffectAbilityDecrease(ABILITY_WISDOM,1);
        eA = SupernaturalEffect(eA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eA,oCreature);
        eA = EffectAbilityDecrease(ABILITY_INTELLIGENCE,1);
        eA = SupernaturalEffect(eA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eA,oCreature);
        eA = EffectAbilityDecrease(ABILITY_CHARISMA,1);
        eA = SupernaturalEffect(eA);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eA,oCreature);

        DelayCommand(RoundsToSeconds(1),ABILITY_Damage(oCreature));
    }
}



void main()
{
    int nEvent = GetUserDefinedItemEventNumber();    //Which event triggered this
    object oPC;                                                           //The player character using the item
    object oItem;                                                        //The item being used
    object oSpellOrigin;                                               //The origin of the spell
    object oSpellTarget;                                              //The target of the spell
    int iSpell;



    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;
    int time = d6(3);
    int nDC = 15;
    switch (nEvent)
    {
        case X2_ITEM_EVENT_ONHITCAST:
            // * This code runs when the item has the 'OnHitCastSpell: Unique power' property
            // * and it hits a target(if it is a weapon) or is being hit (if it is a piece of armor)
            // * Note that this event fires for non PC creatures as well.

            oItem  =  GetSpellCastItem();               // The item triggering this spellscript
            oPC = OBJECT_SELF;                            // The player triggering it
            oSpellOrigin = OBJECT_SELF ;               // Where the spell came from
            oSpellTarget = GetSpellTargetObject();  // What the spell is aimed at

            if(!FortitudeSave(oSpellTarget,14))
            {
                effect ePar = EffectParalyze();
                effect eVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePar,oSpellTarget,RoundsToSeconds(time));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oSpellTarget,RoundsToSeconds(time));
                ABILITY_Damage(oSpellTarget);
            }

            break;

        case X2_ITEM_EVENT_ACTIVATE:
// * This code runs when the Unique Power property of the item is used or the item
// * is activated. Note that this event fires for PCs only

            oPC   = GetItemActivator();                 // The player who activated the item
            oItem = GetItemActivatedTarget();
            break;

        case X2_ITEM_EVENT_EQUIP:
            // * This code runs when the item is equipped
            // * Note that this event fires for PCs only

            oPC = GetPCItemLastEquippedBy();        // The player who equipped the item
            oItem = GetPCItemLastEquipped();         // The item that was equipped

            //Your code goes here
            break;

        case X2_ITEM_EVENT_UNEQUIP:
            // * This code runs when the item is unequipped
            // * Note that this event fires for PCs only

            oPC    = GetPCItemLastUnequippedBy();   // The player who unequipped the item
            oItem  = GetPCItemLastUnequipped();      // The item that was unequipped

            //Your code goes here
            break;

        case X2_ITEM_EVENT_ACQUIRE:
            // * This code runs when the item is acquired
            // * Note that this event fires for PCs only

            oPC = GetModuleItemAcquiredBy();        // The player who acquired the item
            oItem  = GetModuleItemAcquired();        // The item that was acquired

            //Your code goes here
            break;

        case X2_ITEM_EVENT_UNACQUIRE:

            // * This code runs when the item is unacquired
            // * Note that this event fires for PCs only

            oPC = GetModuleItemLostBy();            // The player who dropped the item
            oItem  = GetModuleItemLost();            // The item that was dropped

            //Your code goes here
            break;

       case X2_ITEM_EVENT_SPELLCAST_AT:
            //* This code runs when a PC or DM casts a spell from one of the
            //* standard spellbooks on the item

            oPC = OBJECT_SELF;                          // The player who cast the spell
            oItem  = GetSpellTargetObject();        // The item targeted by the spell
            iSpell = GetSpellId();                         // The id of the spell that was cast
                                                                    // See the list of SPELL_* constants

            //Your code goes here

            //Change the following line from X2_EXECUTE_SCRIPT_CONTINUE to
            //X2_EXECUTE_SCRIPT_END if you want to prevent the spell that was
            //cast on the item from taking effect
            nResult = X2_EXECUTE_SCRIPT_CONTINUE;
            break;
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}


