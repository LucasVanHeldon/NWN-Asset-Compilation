void main()
{
    ActionPauseConversation();
    AssignCommand(GetPCSpeaker(),
        ActionCastFakeSpellAtObject(SPELL_BLESS, GetObjectByTag("SewerWell")));
    AssignCommand(GetPCSpeaker(),
        ActionPlayAnimation(ANIMATION_LOOPING_WORSHIP, 1.0, 12.0));
    ActionResumeConversation();
}
