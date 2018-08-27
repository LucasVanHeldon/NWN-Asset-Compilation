void main()
{
    string      cemetery = GetTag(OBJECT_SELF);

    // do it once
    if (GetLocalInt(GetModule(),cemetery)==0)
    {
        SpeakOneLinerConversation("dscpt_cemetery");
        // update variable
        SetLocalInt(GetModule(),GetTag(OBJECT_SELF),1);
    }
}
