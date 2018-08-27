////////////////////////////////////////////////////////////////////////////////
// Anduin Leaf Script                                                         //
// On use, cures blindness. Effects are permanent.                            //
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

void main()
{
    int nEvent = GetUserDefinedItemEventNumber();    //Which event triggered this
    object oPC;                                                           //The player character using the item
    object oItem;                                                        //The item being used
    object oSpellOrigin;                                               //The origin of the spell
    object oSpellTarget;                                              //The target of the spell
    int iSpell;                                                             //The Spell ID number

    //Set the return value for the item event script
    // * X2_EXECUTE_SCRIPT_CONTINUE - continue calling script after executed script is done
    // * X2_EXECUTE_SCRIPT_END - end calling script after executed script is done
    int nResult = X2_EXECUTE_SCRIPT_END;

    switch (nEvent)
    {

        case X2_ITEM_EVENT_ACTIVATE:
// * This code runs when the Unique Power property of the item is used or the item
// * is activated. Note that this event fires for PCs only

            oPC   = GetItemActivator();                 // The player who activated the item
            oItem = GetItemActivated();               // The item that was activated

            //Your code goes here
        if (!GetIsPC(GetItemActivatedTarget())
        || (GetObjectType(GetItemActivatedTarget())!=OBJECT_TYPE_CREATURE)
        ){

        SendMessageToPC(GetItemActivator(), "Improper use of item!");
        return;}

        object oTarget = GetItemActivatedTarget();

        effect eEffect;
        eEffect = GetFirstEffect(oTarget);
        while (GetIsEffectValid(eEffect))
        {
        if (GetEffectType(eEffect)==EFFECT_TYPE_BLINDNESS) RemoveEffect(oTarget, eEffect);
        eEffect = GetNextEffect(oTarget);
        }
        break;
    }

    //Pass the return value back to the calling script
    SetExecutedScriptReturnValue(nResult);
}

