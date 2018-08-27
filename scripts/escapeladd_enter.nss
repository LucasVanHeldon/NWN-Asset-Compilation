void main()
{
    string      escapeladder = GetTag(OBJECT_SELF);

    // do it once
    if (GetLocalInt(GetModule(),escapeladder)==0)
    {
        SpeakOneLinerConversation("escapeladder");
        // update variable
        SetLocalInt(GetModule(),GetTag(OBJECT_SELF),1);
    }
}
