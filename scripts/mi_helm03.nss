///////////////////////////////////////////////////////////////////////////////
// The Giving Star Script                                                     //
// 10% of casting Cure Light Wounds on caster                                 //
// and raising strength 1 point for 5 rounds                                  //
// Copyright (c) 2003 Bioware Corp.                                           //
////////////////////////////////////////////////////////////////////////////////
/*
    This is an example of how to use the
    new default module events for NWN to
    have all code concerning one item in
    a single file.

    Note that this system only works if
    the following scripts are set in your
    module events

    OnEquip      - x2_mod_def_equ   (or mi_zep_onequip)
    OnUnEquip    - x2_mod_def_unequ
    OnAcquire    - x2_mod_def_aqu
    OnUnAcqucire - x2_mod_def_unaqu
    OnActivate   - x2_mod_def_act
*/
////////////////////////////////////////////////////////////////////////////////
// Created By: Georg Zoeller                                                  //
// Created On: 2003-09-10                                                     //
// Modified By: Grimlar and Arikel Tolifen                                    //
// Modified On: July 2005                                                     //
////////////////////////////////////////////////////////////////////////////////

#include "x2_inc_switches"

#include "x2_inc_switches"
void main()
{
    int nEvent = GetUserDefinedItemEventNumber();    //Which event triggered this
    object oPC;                                                           //The player character using the item
    object oItem;                                                        //The item being used
    object oSpellOrigin;                                               //The origin of the spell
    object oSpellTarget;                                              //The target of the spell
    //Note that I've moved this declaration out of the case event
    effect eEffect;
    int iSpell;                                                             //The Spell ID number
    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;
    switch (nEvent)
    {
        case X2_ITEM_EVENT_EQUIP:
            // * This code runs when the item is equipped
            // * Note that this event fires for PCs only
            oPC = GetPCItemLastEquippedBy();        // The player who equipped the item
            oItem = GetPCItemLastEquipped();         // The item that was equipped
            //Your code goes here
            ExecuteScript("temp_hp_equip", oPC);
            break;
        case X2_ITEM_EVENT_UNEQUIP:
            // * This code runs when the item is unequipped
            // * Note that this event fires for PCs only
            oPC    = GetPCItemLastUnequippedBy();   // The player who unequipped the item
            oItem  = GetPCItemLastUnequipped();      // The item that was unequipped
            //Your code goes here
            ExecuteScript("temp_hp_unequip", oPC);
            break;
    }
    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

