#include "NW_I0_GENERIC"
void main()
{
    // enter desired behaviour here
    int iEvent = GetUserDefinedEventNumber();
    object oPanic = GetObjectByTag("panickedman");
    object oJadale = GetObjectByTag("Jadale");

    if (iEvent == 1010) {
       SetLocalInt(OBJECT_SELF, "FreezeConvo", 1);
       DelayCommand(10.0, AssignCommand(oPanic , SpeakString("They're back!  God help us!  God help Hommlet!  They know I know!  I can feel the curse!")));
       DelayCommand(15.0, AssignCommand(oJadale , SpeakString("Slow down.  What seems to be the problem here, old one?")));
       DelayCommand(20.0, AssignCommand(oPanic , SpeakString("Tharizdun!!!!  No... no... I shouldn't have said that!")));
       DelayCommand(25.0, AssignCommand(oJadale , SpeakString("It's okay, old one.  You are safe here in the fortress.")));
       DelayCommand(30.0, AssignCommand(oPanic , SpeakString("Hahahahahaha!  Safe!  Safe she says!  You just.. don't.. know!!  No.  Noooo!!!!")));
       DelayCommand(32.0, ActionCastFakeSpellAtObject(SPELL_GHOUL_TOUCH, oPanic));
       DelayCommand(35.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE), oPanic));
       SetLocalInt(OBJECT_SELF, "FreezeConvo", 2);
       DelayCommand(37.0, AssignCommand(oJadale, ActionMoveToObject(GetObjectByTag("WP_Tharizdun2"), TRUE)));
       DelayCommand(39.0, AssignCommand(oJadale , SpeakString("This is desturbing.  What's this?  Looks like he dropped something.")));
       DelayCommand(41.0, AssignCommand(oJadale , ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW)));
    } // 1010

}
