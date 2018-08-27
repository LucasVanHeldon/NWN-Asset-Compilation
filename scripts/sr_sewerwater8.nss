void main()
{
    ActionPauseConversation();
    ActionDoCommand(ApplyEffectToObject(DURATION_TYPE_INSTANT,
        EffectVisualEffect(VFX_BEAM_HOLY), OBJECT_SELF));
    ActionResumeConversation();
}
