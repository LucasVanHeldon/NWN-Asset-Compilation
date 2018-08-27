void main()
{
    string      falseslave = GetTag(OBJECT_SELF);

    // do it once
    if (GetLocalInt(GetModule(),falseslave)==0)
    {
        SpeakOneLinerConversation("dscpt_falseslave");
        // update variable
        SetLocalInt(GetModule(),GetTag(OBJECT_SELF),1);
    }
}
