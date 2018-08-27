/****************************************************
** Table Top Variant ruleset
**
** Rest Zone Enter Event
** This is used by a Rest Zone Trigger, the "On Enter"
** event.
**
** This is used with the TTV Rest Code
**
** Written by Jay Barnson, 2002
**
** This script is used in conjunction with a Rest Zone
** trigger... a trigger that has this set as the on enter
** event, and ttv_restzoneexit as the On Exit event.
**
** This event sets the player's "RestOKFlag", which
** means the player now doesn't have to wait for
** 10 minute intervals to rest, and gets full hitpoints
** back when they rest.
**
**
****************************************************/



void main()
{
object oPC = GetEnteringObject();
if (GetIsPC(oPC))
    {
    AssignCommand(oPC,SpeakString("Entering a safe rest area"));
    SetLocalInt(oPC,"RestOKFlag",1);
    }

}
