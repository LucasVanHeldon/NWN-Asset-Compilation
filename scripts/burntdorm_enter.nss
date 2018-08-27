void main()
{
    string      burntdorm = GetTag(OBJECT_SELF);

    // do it once
    if (GetLocalInt(GetModule(),burntdorm)==0)
    {
        SpeakOneLinerConversation("dscpt_burntdorm");
        // update variable
        SetLocalInt(GetModule(),GetTag(OBJECT_SELF),1);
    }
}
