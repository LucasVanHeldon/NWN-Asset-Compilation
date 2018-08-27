/****************************************************
** Table Top Variant ruleset
**
** Rest Zone Exit Event
** This is used by a Rest Zone Trigger, the "On Exit"
** event.
**
** This is used with the TTV Rest Code
**
** Written by Jay Barnson, 2002
**
** This script is used in conjunction with a Rest Zone
** trigger... a trigger that has this set as the on exit
** event, and ttv_restzoneenter as the On Enter event.
**
** This removes the "RestOKFlag" , signalling that the
** player is once again subject to rest restrictions.
**
**
** Change September 16, 2002:
** Fixed a bone-headed mistake and made oPC equal to
** the EXITING object instead of the entering one (D'oh!)
** Thanks to Calsar for finding this one.
**
**
****************************************************/



void main()
{
object oPC = GetExitingObject();
if (GetIsPC(oPC))
    {
    AssignCommand(oPC,SpeakString("Leaving safe rest area"));
    DeleteLocalInt(oPC,"RestOKFlag");
    }

}
