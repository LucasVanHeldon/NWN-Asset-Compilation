void main()
{

    ActionDoCommand(ActionPlayAnimation(ACTION_REST));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);

}
