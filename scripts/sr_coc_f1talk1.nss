void main()
{
    object oTalk = GetObjectByTag("TalkingHead1");
    AssignCommand(oTalk, SpeakOneLinerConversation());
}
