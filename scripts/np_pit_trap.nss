 //PIT SCRIPT

void main()
{
effect eDam;
object oPitvictim = GetEnteringObject(); //That's the PC who might fall
location lLoc = GetLocation(oPitvictim); //The initial place of the falling PC
object oWay = GetWaypointByTag("NW_PITFALL"); //That's where he is going to land
int rSave = ReflexSave(oPitvictim, 20, SAVING_THROW_TYPE_TRAP, OBJECT_SELF);
if (rSave==0)
    {
    ActionSpeakString ("You've fallen into a pit!!!", TALKVOLUME_TALK);
    eDam = EffectDamage(d3(2), DAMAGE_TYPE_BLUDGEONING); //The damage roll
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oPitvictim);
    AssignCommand(oPitvictim, ActionJumpToObject(oWay, FALSE));
    AssignCommand(oPitvictim,ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 2.0));
    FloatingTextStringOnCreature("ouch...", oPitvictim, FALSE);
    }
else
    {
    ActionSpeakString ("You've managed to avoid a deep pit!", TALKVOLUME_TALK);
    }
}
